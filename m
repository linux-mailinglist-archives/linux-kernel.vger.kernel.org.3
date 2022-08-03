Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5D588A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiHCKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbiHCKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:05:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB13764A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:05:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v18so15932755plo.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bANxufpLCUY+XWPiguyc6Xk+fdLhXPbcV4C2RPgI3FM=;
        b=CTgvu/TjNHKxvdz52lHLnsHWO3P5bEpln58ylmFson4kOhjVckhXarZUwPPy5FRDxZ
         Q0gr5DFAUCLSbgjz5aLllSNEp3WL7p5Of1F++OlrXMjVaPLhNqDfuOIez2sWrUilbs+s
         AymLnmzvsjgTu7EzeEts3SFZZ/VV71kIexvB+QdFaYuqj2BaK7Zk1SADeA2VMcfCQ+TI
         qN043yUVP5TVIwHSZVdvHmWMysAls8dn6s1GpYsMrX9xd7mbLRIJmD16zWyuoF6esrv1
         9nbqR3ntLvsk0ZiT03CqdsDklDBBm7wggbihqhN7qgEmp/M3EXfwkuPRuZ8/3QFpi2hS
         +lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bANxufpLCUY+XWPiguyc6Xk+fdLhXPbcV4C2RPgI3FM=;
        b=Vm1tKPgTWaBdLOEnoLI0+BxQ7RUmy0Y8R1aG9Yv0rp5PNXwNW/VMPfUNDEnH7pMLk6
         x0san8lC47iY2gcAfZzPMp54sw6Yg8AklRt57tDEvZrfFXiemnuULI5CI5DYU5ALjmyc
         B7A4e11Ot8KwKMcPN64gmhCBd70cUO8PIGGYShCDBZo5XUzviQaJiW3F/gkJMbjqsrxV
         N9/IHK83/9KyV2DBhoxD0+o1aJZsz0bUo64kvE2ffSoRn8H/2vWaRJfzuRnZHC9lqOsw
         EaekechFIJaW9Mpx6cbnNZliuMnlwCtJ37hVuS+QgDUVnpD2hDbg5ixS2b5LsZI7Cmc3
         MobQ==
X-Gm-Message-State: ACgBeo2hTBkM5KA7Qqfv2ISZAEkYf3dloqNkmU/BfbHK6Fu0BImhbzU5
        0pxD/ay34DZ7xwDXL9sCXVg=
X-Google-Smtp-Source: AA6agR6ej/DKKrC02wuJgBsr4b0OO0L2fAyintP2DPnrkyf8wCjR9D+JmfYcQs2tDO6/EciPZsS1Vg==
X-Received: by 2002:a17:90b:2c13:b0:1f3:359a:c7d5 with SMTP id rv19-20020a17090b2c1300b001f3359ac7d5mr4162524pjb.72.1659521150810;
        Wed, 03 Aug 2022 03:05:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016e808dbe55sm1499003plg.96.2022.08.03.03.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 03:05:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.con.cn
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        CGEL <cgel.zte@gmail.com>
Subject: [RFC PATCH 3/4] ksm: let ksmd work automatically with memory threshold
Date:   Wed,  3 Aug 2022 10:05:43 +0000
Message-Id: <20220803100543.1653550-1-xu.xin16@zte.con.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803100306.1653382-1-xu.xin16@zte.con.cn>
References: <20220803100306.1653382-1-xu.xin16@zte.con.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When memory is sufficient, merging pages to save memory is not very
much needed, and it also inceases delays of COW for user application.

So set a memory threshold, when free memory is lower than the threshold,
ksmd will be triggered to compare and merge pages. And to avoid ping-pong
effect due to the threshold, ksmd needs to try to merge pages until free
memory is larger than (threshold + total_memory * 1/16).

Before free memory is lower than the threshold, ksmd will still scan pages
at a very low speed, to calculate their checksum but not to compare and
merge pages.

        |
        |       ----(Threshold + total_memory/16)--------
        |                              |
------Threshold------                 |
        |                              |
        |_____ksmd try to merge pages__|

We also add a new sysfs klob auto_threshold_percent for user to be able
to tune.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: CGEL <cgel.zte@gmail.com>
---
 mm/ksm.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8acc893e4d61..78819b56efec 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -294,6 +294,17 @@ static unsigned int ksm_max_scanning_factor = 32;
  */
 static unsigned int scanning_factor = 1;
 
+/*
+ * Work in auto-mode.
+ * Default ksm_auto_threshold_percent: 20, means 20%. When free memory
+ * is lower than total memory * ksm_auto_threshold_percent/100, ksmd will
+ * be triggered to compare and merge pages.
+ */
+unsigned int ksm_auto_threshold_percent = 20;
+
+/* Work in auto-mode. Whether trigger ksmd to compare and merge pages */
+static bool auto_triggered;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -2446,11 +2457,46 @@ static void ksm_do_scan(unsigned int scan_npages)
 		rmap_item = scan_get_next_rmap_item(&page);
 		if (!rmap_item)
 			return;
-		cmp_and_merge_page(page, rmap_item);
+		if (ksm_run & KSM_RUN_AUTO  && !auto_triggered) {
+			/*
+			 * This should happens only when ksm_run is KSM_RUN_AUTO
+			 * and free memory threshold still not reached.
+			 * The reason to calculate it's checksum is to reduce the
+			 * waiting time the rmap_item is added to unstable tree.
+			 */
+			rmap_item->oldchecksum = calc_checksum(page);
+		} else
+			cmp_and_merge_page(page, rmap_item);
+
 		put_page(page);
 	}
 }
 
+/* Work in auto mode, should reset auto_triggered ? */
+static bool should_untrigger_ksmd_to_merge(void)
+{
+	unsigned long total_ram_pages, free_pages;
+
+	total_ram_pages = totalram_pages();
+	free_pages = global_zone_page_state(NR_FREE_PAGES);
+
+	return free_pages > (total_ram_pages *
+						ksm_auto_threshold_percent / 100) +
+						(total_ram_pages >> 4);
+}
+
+/* Work in auto mode, should ksmd start to merge ? */
+static bool should_trigger_ksmd_to_merge(void)
+{
+	unsigned long total_ram_pages, free_pages;
+
+	total_ram_pages = totalram_pages();
+	free_pages = global_zone_page_state(NR_FREE_PAGES);
+
+	return free_pages < (total_ram_pages *
+						ksm_auto_threshold_percent / 100);
+}
+
 static int ksmd_should_run(void)
 {
 	if (!list_empty(&ksm_mm_head.mm_list))
@@ -2469,8 +2515,18 @@ static int ksm_scan_thread(void *nothing)
 		mutex_lock(&ksm_thread_mutex);
 		wait_while_offlining();
 		if (ksmd_should_run()) {
-			if (ksm_run & KSM_RUN_AUTO)
-				ksm_do_scan(ksm_thread_pages_to_scan * scanning_factor);
+			if (ksm_run & KSM_RUN_AUTO) {
+				/*
+				 * If free memory is not lower than threshold, we only scan
+				 * 5 pages and just calculate pages' checksum and not compare
+				 * and merge them. Otherwise, do real scanning and merging as
+				 * scanning-enhanced algorithm.
+				 */
+				if (!auto_triggered)
+					ksm_do_scan(5);
+				else
+					ksm_do_scan(ksm_thread_pages_to_scan * scanning_factor);
+			}
 			else
 				ksm_do_scan(ksm_thread_pages_to_scan);
 		}
@@ -2491,6 +2547,11 @@ static int ksm_scan_thread(void *nothing)
 				reset_scanning_factor();
 
 			ksm_scan.new_ksmpages_of_this_scanning = 0;
+
+			if (should_trigger_ksmd_to_merge())
+				auto_triggered = true;
+			else if (should_untrigger_ksmd_to_merge())
+				auto_triggered = false;
 		}
 
 		try_to_freeze();
@@ -3035,6 +3096,32 @@ static ssize_t max_scanning_factor_store(struct kobject *kobj,
 }
 KSM_ATTR(max_scanning_factor);
 
+static ssize_t auto_threshold_percent_show(struct kobject *kobj,
+						struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_auto_threshold_percent);
+}
+
+static ssize_t auto_threshold_percent_store(struct kobject *kobj,
+								struct kobj_attribute *attr,
+								const char *buf, size_t count)
+{
+	unsigned int value;
+	int err;
+
+	err = kstrtouint(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	if (value > 100)
+		return -EINVAL;
+
+	ksm_auto_threshold_percent = value;
+
+	return count;
+}
+KSM_ATTR(auto_threshold_percent);
+
 #ifdef CONFIG_NUMA
 static ssize_t merge_across_nodes_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
@@ -3246,6 +3333,7 @@ static struct attribute *ksm_attrs[] = {
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
 	&max_scanning_factor_attr.attr,
+	&auto_threshold_percent_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
@@ -3277,6 +3365,7 @@ static int __init ksm_init(void)
 	zero_checksum = calc_checksum(ZERO_PAGE(0));
 	/* Default to false for backwards compatibility */
 	ksm_use_zero_pages = false;
+	auto_triggered = false;
 
 	err = ksm_slab_init();
 	if (err)
-- 
2.25.1

