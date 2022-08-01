Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A20F58622D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiHABWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHABWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:22:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3030B95BD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:22:38 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lx0h14zxHz9t0S
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:21:21 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 09:22:36 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 09:22:36 +0800
From:   Liu Chao <liuchao173@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <hewenliang4@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH v2] add miss time to CPUTIME_USER when kernel boots with highres=off
Date:   Mon, 1 Aug 2022 09:21:07 +0800
Message-ID: <20220801012107.45455-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel boots with highres=off and the cpu load isn't full, almost
every tick will account towards CPUTIME_IDLE. But in /proc/stat, idle
time is obtained from get_idle_time.
So the sum time will lose the time of user tasks.

For example:
 # stress-ng --cpu 2 --taskset 66 --timeout 600 --cpu-load 50 &
 # cat /proc/stat | grep "cpu66";sleep 10; cat /proc/stat | grep "cpu66"
 cpu66 1038 0 72 50124 75 17 1 0 0 0
 cpu66 1038 0 72 50569 75 18 2 0 0 0

the detla of sum time is 447, which should be 1000 actually. It will
casue the data in top is imprecise.

v2:
Fix build error when CONFIG_HIGH_RES_TIMERS is not set.

Signed-off-by: Liu Chao <liuchao173@huawei.com>
---
 fs/proc/stat.c          | 5 +++++
 include/linux/hrtimer.h | 2 ++
 kernel/time/hrtimer.c   | 4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 4fb8729a68d4..c5b9116e74ad 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -141,6 +141,9 @@ static int show_stat(struct seq_file *p, void *v)
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
 
+		if (hrtimer_is_hres_enabled() == 0)
+			user	+= cpustat[CPUTIME_IDLE] - get_idle_time(&kcpustat, i);
+
 		for (j = 0; j < NR_SOFTIRQS; j++) {
 			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
 
@@ -179,6 +182,8 @@ static int show_stat(struct seq_file *p, void *v)
 		steal		= cpustat[CPUTIME_STEAL];
 		guest		= cpustat[CPUTIME_GUEST];
 		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
+		if (hrtimer_is_hres_enabled() == 0)
+			user	+=  cpustat[CPUTIME_IDLE] - idle;
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..4fa1bbe86287 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -326,6 +326,8 @@ extern unsigned int hrtimer_resolution;
 
 #endif
 
+extern int hrtimer_is_hres_enabled(void);
+
 static inline ktime_t
 __hrtimer_expires_remaining_adjusted(const struct hrtimer *timer, ktime_t now)
 {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..3e038b28b8db 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -722,7 +722,7 @@ __setup("highres=", setup_hrtimer_hres);
 /*
  * hrtimer_high_res_enabled - query, if the highres mode is enabled
  */
-static inline int hrtimer_is_hres_enabled(void)
+int hrtimer_is_hres_enabled(void)
 {
 	return hrtimer_hres_enabled;
 }
@@ -751,7 +751,7 @@ static void hrtimer_switch_to_hres(void)
 
 #else
 
-static inline int hrtimer_is_hres_enabled(void) { return 0; }
+int hrtimer_is_hres_enabled(void) { return 0; }
 static inline void hrtimer_switch_to_hres(void) { }
 
 #endif /* CONFIG_HIGH_RES_TIMERS */

base-commit: e65c6a46df94c8d76ea1129eb2d4564670c6f214
prerequisite-patch-id: 3099d45f464060b03429daa159ee8d882d113edc
prerequisite-patch-id: db6e0da8d4379352a3bd819eb158f78e66abf01d
-- 
2.23.0

