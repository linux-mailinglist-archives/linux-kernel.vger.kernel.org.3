Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57864CF2D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiCGHqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiCGHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:46:25 -0500
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC75F8C5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:45:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6SREei_1646639125;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6SREei_1646639125)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 15:45:26 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kfence: Allow re-enabling KFENCE after system startup
Date:   Mon,  7 Mar 2022 15:45:15 +0800
Message-Id: <20220307074516.6920-2-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307074516.6920-1-dtcccc@linux.alibaba.com>
References: <20220307074516.6920-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If once KFENCE is disabled by:
echo 0 > /sys/module/kfence/parameters/sample_interval
KFENCE could never be re-enabled until next rebooting.

Allow re-enabling it by writing a positive num to sample_interval.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 mm/kfence/core.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 13128fa13062..caa4e84c8b79 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -38,14 +38,17 @@
 #define KFENCE_WARN_ON(cond)                                                   \
 	({                                                                     \
 		const bool __cond = WARN_ON(cond);                             \
-		if (unlikely(__cond))                                          \
+		if (unlikely(__cond)) {                                        \
 			WRITE_ONCE(kfence_enabled, false);                     \
+			disabled_by_warn = true;                               \
+		}                                                              \
 		__cond;                                                        \
 	})
 
 /* === Data ================================================================= */
 
 static bool kfence_enabled __read_mostly;
+static bool disabled_by_warn __read_mostly;
 
 unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
 EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
@@ -55,6 +58,7 @@ EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
 #endif
 #define MODULE_PARAM_PREFIX "kfence."
 
+static int kfence_enable_late(void);
 static int param_set_sample_interval(const char *val, const struct kernel_param *kp)
 {
 	unsigned long num;
@@ -65,10 +69,11 @@ static int param_set_sample_interval(const char *val, const struct kernel_param
 
 	if (!num) /* Using 0 to indicate KFENCE is disabled. */
 		WRITE_ONCE(kfence_enabled, false);
-	else if (!READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
-		return -EINVAL; /* Cannot (re-)enable KFENCE on-the-fly. */
 
 	*((unsigned long *)kp->arg) = num;
+
+	if (num && !READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
+		return disabled_by_warn ? -EINVAL : kfence_enable_late();
 	return 0;
 }
 
@@ -787,6 +792,16 @@ void __init kfence_init(void)
 		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
 }
 
+static int kfence_enable_late(void)
+{
+	if (!__kfence_pool)
+		return -EINVAL;
+
+	WRITE_ONCE(kfence_enabled, true);
+	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
+	return 0;
+}
+
 void kfence_shutdown_cache(struct kmem_cache *s)
 {
 	unsigned long flags;
-- 
2.27.0

