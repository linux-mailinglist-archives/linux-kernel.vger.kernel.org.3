Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E3590EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiHLKNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiHLKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:12:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA337AB42A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 130so289678pfy.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Zow/Qe/P2NEQDMvwyeUd/99vAJcANYj6amOMdI5Aoqg=;
        b=Mfg+p9sl9EKee4oeLXvUpcn98hONemFjE5MlOv9aqEVL98PWkiyFxu2JleR+qqciZf
         EAEc/jMEw1qYl9MZ4fuy81YcBMj39ao2+ky+HEGNAVDEmtevdQCgY9dUEi1473EOqVtO
         Ld0dhDUYIHPwcKxxqrND4fdBLqPHyTK0mXZd0EKWVmD7UxKYZULNdG13O+ZunaHZJZaQ
         +vbaIM/okQZMyB0YLly11rIXt+EAU675o9MvODyp94OA5XRbiYXvnj0fFhV5srQ9f/hk
         uEA1qpyRGt0etlJeYq/e0nz4yKpZnFsjUo3qQhmJguu7qoIAyGn2/eTZAAoBN2FWgCLO
         mRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Zow/Qe/P2NEQDMvwyeUd/99vAJcANYj6amOMdI5Aoqg=;
        b=HMrHDn/YxfbxkgGaMx+uTSXSo2bzkmqO7OgBLa7axWWTOIqRZ+hQGYupF7SgjMLzJV
         MrxemMB5uNNrj0BKmq5CwcvyVL66cUXYcaaffBCNXpOGDR4hwoAIOZ8foP8yFka5tG5g
         9G/yi11HBW9w8guClSIdNUy6LRI/spq3QykUS6MsdmGMWi1Xydlc0R31WxQVzfWuUZJ2
         1NhfeewhYGiXn3XGO66DvB2Rkf04aXvYIAugrFUhZx99t6/1EIuHuXCzFsh1S25C8/ih
         cQkf3//uiSW1p76X0kuT/lQEQgVMGw1+FXVx7XrdDtwPvFbAOLI9Urx3Fmy6Nzm+NeBS
         hH4w==
X-Gm-Message-State: ACgBeo3C6hbEJiNweUY9AXlv+P46cUHyERkx9o9K8NhV5BPPAmtny6pd
        Twy9H/Y/oBF9CfO6tvjgZdA=
X-Google-Smtp-Source: AA6agR5skhqPaePy5qtgLQ5EWyQuWhL4KUe6VyWBMJ1w9oMX6T2nxssa3zNoHs9qCSvhfdGWBnddZw==
X-Received: by 2002:a65:4605:0:b0:41c:3d73:9385 with SMTP id v5-20020a654605000000b0041c3d739385mr2481969pgq.168.1660299137278;
        Fri, 12 Aug 2022 03:12:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 196-20020a6218cd000000b0052b94e757ecsm1203269pfy.213.2022.08.12.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:12:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin16@zte.com.cn, CGEL <cgel.zte@gmail.com>
Subject: [PATCH v2 3/5] ksm: let ksmd auto-work with memory threshold
Date:   Fri, 12 Aug 2022 10:12:12 +0000
Message-Id: <20220812101212.41587-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101102.41422-1-xu.xin16@zte.com.cn>
References: <20220812101102.41422-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
------Threshold------                  |
        |                              |
        |_____ksmd try to merge pages__|

We also add a new sysfs klob auto_threshold_percent for user to be able
to tune.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: CGEL <cgel.zte@gmail.com>
---
 mm/ksm.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f416f168a6da..c5fd4f520f4a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -296,6 +296,17 @@ static unsigned int scanning_factor = INIT_SCANNING_FACTOR;
 #define DEFAULT_MAX_SCANNING_FACTOR	16
 static unsigned int max_scanning_factor	= DEFAULT_MAX_SCANNING_FACTOR;
 
+/*
+ * Work in auto mode.
+ * Value: 0~100. Default 20 means "20%". When free memory is lower
+ * than this total memory * ksm_auto_threshold/100, auto_triggered
+ * will be set true.
+ */
+unsigned int ksm_auto_threshold = 20;
+
+/* Work in auto-mode. Whether trigger ksmd to compare and merge pages */
+static bool auto_triggered;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -2431,11 +2442,61 @@ static void ksm_do_scan(unsigned int scan_npages)
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
 
+#define RIGHT_SHIFT_FOUR_BIT	4
+/* Work in auto mode, should reset auto_triggered ? */
+static bool should_stop_ksmd_to_merge(void)
+{
+	unsigned long total_ram_pages, free_pages;
+	unsigned int threshold;
+
+	total_ram_pages = totalram_pages();
+	free_pages = global_zone_page_state(NR_FREE_PAGES);
+	threshold = READ_ONCE(ksm_auto_threshold);
+
+	return free_pages > (total_ram_pages * threshold / 100) +
+		        (total_ram_pages >> RIGHT_SHIFT_FOUR_BIT);
+}
+
+/* Work in auto mode, should ksmd start to merge ? */
+static bool should_trigger_ksmd_to_merge(void)
+{
+	unsigned long total_ram_pages, free_pages;
+	unsigned int threshold;
+
+	total_ram_pages = totalram_pages();
+	free_pages = global_zone_page_state(NR_FREE_PAGES);
+	threshold = READ_ONCE(ksm_auto_threshold);
+
+	return free_pages < (total_ram_pages * threshold / 100);
+}
+
+static inline void trigger_ksmd_to_merge(void)
+{
+	if (!auto_triggered)
+		auto_triggered = true;
+}
+
+static inline void stop_ksmd_to_merge(void)
+{
+	if (auto_triggered)
+		auto_triggered = false;
+}
+
 static int ksmd_should_run(void)
 {
 	if (!list_empty(&ksm_mm_head.mm_list))
@@ -2478,6 +2539,8 @@ static unsigned int scan_enhanced_algorithm(unsigned int current_factor)
 	return next_factor;
 }
 
+#define SLOW_SCAN_PAGES	5 /* Used when ksmd is not triggered to merge*/
+
 static int ksm_scan_thread(void *nothing)
 {
 	unsigned int sleep_ms;
@@ -2490,7 +2553,10 @@ static int ksm_scan_thread(void *nothing)
 		wait_while_offlining();
 		if (ksmd_should_run()) {
 			if (ksm_run & KSM_RUN_AUTO) {
-				ksm_do_scan(ksm_thread_pages_to_scan * scanning_factor);
+				if (!auto_triggered)
+					ksm_do_scan(SLOW_SCAN_PAGES);
+				else
+					ksm_do_scan(ksm_thread_pages_to_scan * scanning_factor);
 
 				scanning_factor = scan_enhanced_algorithm(scanning_factor);
 				/*
@@ -2498,6 +2564,11 @@ static int ksm_scan_thread(void *nothing)
 				 * updating scanning_factor by scan_enhanced_algorithm.
 				 */
 				ksm_scan.new_ksmpages = 0;
+
+				if (should_trigger_ksmd_to_merge())
+					trigger_ksmd_to_merge();
+				else if (should_stop_ksmd_to_merge())
+					stop_ksmd_to_merge();
 			} else
 				ksm_do_scan(ksm_thread_pages_to_scan);
 		}
@@ -3047,6 +3118,32 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 KSM_ATTR(run);
 
+static ssize_t auto_threshold_show(struct kobject *kobj,
+						struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_auto_threshold);
+}
+
+static ssize_t auto_threshold_store(struct kobject *kobj,
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
+	ksm_auto_threshold = value;
+
+	return count;
+}
+KSM_ATTR(auto_threshold);
+
 #ifdef CONFIG_NUMA
 static ssize_t merge_across_nodes_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
@@ -3258,6 +3355,7 @@ static struct attribute *ksm_attrs[] = {
 	&pages_to_scan_attr.attr,
 	&max_scanning_factor_attr.attr,
 	&run_attr.attr,
+	&auto_threshold_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
@@ -3289,6 +3387,7 @@ static int __init ksm_init(void)
 	zero_checksum = calc_checksum(ZERO_PAGE(0));
 	/* Default to false for backwards compatibility */
 	ksm_use_zero_pages = false;
+	auto_triggered = false;
 
 	err = ksm_slab_init();
 	if (err)
-- 
2.25.1

