Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC054C952
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiFOM7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbiFOM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:59:05 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B851542A3C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZulX1
        6YrDmQbq/rk+c6f7i3fnbH2NLUaCA7p09mqcRM=; b=mjAQGk8QH7ZjzWBlv3XjA
        oURzd2GTJJWcrSqu/vA4LlLKoQNm4QfCdpGkZts8UXaxBesZBHo0d7m5nzCADCnI
        rcWCnvYT279frK+jmXzeXxv97yhnAD+RCMk0M6I28pYVFYKm0NVIvH+DC28XT4kv
        XIe2qGnsQA9Bba1/XzyvXI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAA34vtD16liaIprDQ--.44019S2;
        Wed, 15 Jun 2022 20:57:40 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     jgg@ziepe.ca, kirill.shutemov@linux.intel.com,
        brijesh.singh@amd.com, linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] arch: x86: kernel: Add missing of_node_put() in x86_init.c
Date:   Wed, 15 Jun 2022 20:57:39 +0800
Message-Id: <20220615125739.3966617-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAA34vtD16liaIprDQ--.44019S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr18tF1UCF4rArW3uw45Wrg_yoW3Crb_WF
        18GFW8ur1rJa9aqanruw43W3WIqws7KF4rAF1xJr12y345t3WrJanIyr17t3sIgFWIv3y7
        ArZxG3yqyr47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREksgUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AUhF1pEDubBLgAAs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86_wallclock_init(), we need to use of_node_put() for the
of_find_matching_node() which returns a node pointer with refcount
incremented.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/x86/kernel/x86_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e84ee5cdbd8c..81c071080efe 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -50,6 +50,7 @@ static __init void x86_wallclock_init(void)
 	struct device_node *node = of_find_matching_node(NULL, of_cmos_match);
 
 	if (node && !of_device_is_available(node)) {
+		of_node_put(node);
 		x86_platform.get_wallclock = get_rtc_noop;
 		x86_platform.set_wallclock = set_rtc_noop;
 	}
-- 
2.25.1

