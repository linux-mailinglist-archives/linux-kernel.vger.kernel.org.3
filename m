Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5861590EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbiHLKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiHLKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:12:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FAAAB432
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f192so545264pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3RiuHL8cuPFNRdOQLrbL2ARJQLP3txMsqxB/DqBpHYo=;
        b=PO+YfNP7KvjF2zdmrmg/gzcou8Nbp4XOJlJjIiqFLzBP2VVWJK4AujsgLDH3VUlo41
         xuxdRdR1edLV2Oixgvzo/tOfW6ht3FHrXcrb0KPTEu9xVgySElv0RJzAtXuwC+DDOAIi
         21Zl59qjzNZUvkVy/dFUGG1qkbMPxjfNe++YhnttjiOdl8WZf77H3BRopKPYKfc/x7UU
         732zYyCXLdqk63zY3974mToWDa13wP/rKKl2X+hpiDCLqpHiboKmEotx26W8+146voUV
         5zm1r+XfHr1NYw7FgeOVDG701wh4B+fOu1ybyI3kKcFgKOewsk4VTJR++CKRUcVy5yFc
         tHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3RiuHL8cuPFNRdOQLrbL2ARJQLP3txMsqxB/DqBpHYo=;
        b=WRz9kgS/rdZ0IXNRYXaapEZVkFsDtTNIG/EHrLIQa315zUbHLozT8FN0+kQ3JnSVfg
         YwLIRarTblegVmxigbFlWvKM6hhcvfBIM+YGYqj0wRIgR9JNFxzSnbypk+dWyZ8lvvFn
         f3iIFKMZ6/LPp6xHfzeRzP6Sw3VWjiD4LcCicvUxxu/E2ZTj2CWUBvDUzcick/Geccp3
         grGQYuTNA849qSDd34yW8ifvppMGI6LRid4JsUL8jckUCxmpHn7SIQYqxdvRsdmNhiV+
         kq9kYle7iPhSZtbo4NIt+msGjgXB3qfP2QYZC5uDcF5fQATccilg72h5HRUuhgc2hR5S
         JvtA==
X-Gm-Message-State: ACgBeo0BBX+yso3GTUG553114lfm4UHjeQnIZZvh1E9k3OmwIN9eWlQX
        OeulI0+/q+0vo8wgTNipjpE=
X-Google-Smtp-Source: AA6agR7Fd93QkM030LuiG9mHSEbbXsNDiHX6pJcZ8w61nSyMQdFIuvFz43JGwYRt9ZJeuAcXovAWyg==
X-Received: by 2002:a05:6a00:17a8:b0:52e:6e3e:9ff with SMTP id s40-20020a056a0017a800b0052e6e3e09ffmr3217306pfg.42.1660299127293;
        Fri, 12 Aug 2022 03:12:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mp2-20020a17090b190200b001f319e9b9e5sm5134115pjb.16.2022.08.12.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:12:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin16@zte.com.cn, CGEL <cgel.zte@gmail.com>
Subject: [PATCH v2 2/5] ksm: implement scan-enhanced algorithm
Date:   Fri, 12 Aug 2022 10:12:02 +0000
Message-Id: <20220812101202.41533-1-xu.xin16@zte.com.cn>
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

Implement the scan-enhanced algorithm of auto mode. In this algorithm,
after every time of scanning, if new ksm pages are obtained, it will
double pages_to_scan for the next scanning until the general
multiplying factor is not less than max_scanning_factor. If no new ksm
pages are obtained, then reset pages_to_scan to the default value.

We add the sysfs klob of max_scanning_factor to limit scanning factor's
excessive growth.

Signed-off-by: CGEL <cgel.zte@gmail.com>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c80d908221a4..f416f168a6da 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -131,6 +131,10 @@ struct mm_slot {
  * @address: the next address inside that to be scanned
  * @rmap_list: link to the next rmap to be scanned in the rmap_list
  * @seqnr: count of completed full scans (needed when removing unstable node)
+ * @new_ksmpages: count of the new merged KSM pages in the current scanning
+ *	              of mm_lists (cleared after every turn of ksm_do_scan() ends)
+ * @prev_ksmpages: the record of the new merged KSM pages in the last turn of
+ *	               scanning by ksm_do_scan().
  *
  * There is only the one ksm_scan instance of this cursor structure.
  */
@@ -139,6 +143,8 @@ struct ksm_scan {
 	unsigned long address;
 	struct rmap_item **rmap_list;
 	unsigned long seqnr;
+	unsigned long new_ksmpages;
+	unsigned long prev_ksmpages;
 };
 
 /**
@@ -277,6 +283,19 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
+/*
+ * Work in auto-mode.
+ * The multiplicative factor of pages_to_scan.
+ * Real pages to scan equals to the product of scanning_factor
+ * and pages_to_scan
+ */
+#define INIT_SCANNING_FACTOR	1
+static unsigned int scanning_factor = INIT_SCANNING_FACTOR;
+
+/* The upper limit of scanning_factor */
+#define DEFAULT_MAX_SCANNING_FACTOR	16
+static unsigned int max_scanning_factor	= DEFAULT_MAX_SCANNING_FACTOR;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -2031,6 +2050,8 @@ static void stable_tree_append(struct rmap_item *rmap_item,
 	rmap_item->address |= STABLE_FLAG;
 	hlist_add_head(&rmap_item->hlist, &stable_node->hlist);
 
+	ksm_scan.new_ksmpages++;
+
 	if (rmap_item->hlist.next)
 		ksm_pages_sharing++;
 	else
@@ -2422,6 +2443,41 @@ static int ksmd_should_run(void)
 	return 0;
 }
 
+/*
+ * Work in auto mode, the scan-enhanced algorithm.
+ * current_factor: the current scanning_factor.
+ * return: the scanning_factor caculated by scan-enhanced algorithm.
+ */
+static unsigned int scan_enhanced_algorithm(unsigned int current_factor)
+{
+	unsigned int next_factor;
+	unsigned int max, min;
+
+	/*
+	 * The calculation is divied into three cases as follows:
+	 *
+	 * Case 1: when new_ksmpages > prev_ksmpages * 1/2, get the
+	 *         next factor by double the current factor.
+	 * Case 2: when 0 < new_ksmpages < prev_ksmpages * 1/2, keep
+	 *         the factor unchanged.
+	 * Case 3: when new_ksmpages equals 0, then get the next
+	 *         factor by halfing the current factor.
+	 */
+	max = READ_ONCE(max_scanning_factor);
+	min = INIT_SCANNING_FACTOR;
+	if (ksm_scan.new_ksmpages * 2 > ksm_scan.prev_ksmpages) {
+		next_factor = current_factor << 1; /* Doubling */
+		if (next_factor > max)
+			next_factor = max;
+	} else if (ksm_scan.new_ksmpages == 0) {
+		next_factor = current_factor >> 1; /* Halfing */
+		next_factor = next_factor < min ? min : next_factor;
+	} else
+		next_factor = current_factor;
+
+	return next_factor;
+}
+
 static int ksm_scan_thread(void *nothing)
 {
 	unsigned int sleep_ms;
@@ -2432,8 +2488,19 @@ static int ksm_scan_thread(void *nothing)
 	while (!kthread_should_stop()) {
 		mutex_lock(&ksm_thread_mutex);
 		wait_while_offlining();
-		if (ksmd_should_run())
-			ksm_do_scan(ksm_thread_pages_to_scan);
+		if (ksmd_should_run()) {
+			if (ksm_run & KSM_RUN_AUTO) {
+				ksm_do_scan(ksm_thread_pages_to_scan * scanning_factor);
+
+				scanning_factor = scan_enhanced_algorithm(scanning_factor);
+				/*
+				 * Reset ksm_scan.new_ksmpages after
+				 * updating scanning_factor by scan_enhanced_algorithm.
+				 */
+				ksm_scan.new_ksmpages = 0;
+			} else
+				ksm_do_scan(ksm_thread_pages_to_scan);
+		}
 		mutex_unlock(&ksm_thread_mutex);
 
 		try_to_freeze();
@@ -2904,6 +2971,34 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
 }
 KSM_ATTR(pages_to_scan);
 
+static ssize_t max_scanning_factor_show(struct kobject *kobj,
+						struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", max_scanning_factor);
+}
+
+static ssize_t max_scanning_factor_store(struct kobject *kobj,
+								struct kobj_attribute *attr,
+								const char *buf, size_t count)
+{
+		unsigned int value, max;
+		int err;
+
+		err = kstrtouint(buf, 10, &value);
+		if (err)
+			return -EINVAL;
+
+		max = totalram_pages() / ksm_thread_pages_to_scan;
+
+		if (value < 1 && value > max)
+			return -EINVAL;
+
+		max_scanning_factor = value;
+
+		return count;
+}
+KSM_ATTR(max_scanning_factor);
+
 static ssize_t run_show(struct kobject *kobj, struct kobj_attribute *attr,
 			char *buf)
 {
@@ -3161,6 +3256,7 @@ KSM_ATTR_RO(full_scans);
 static struct attribute *ksm_attrs[] = {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
+	&max_scanning_factor_attr.attr,
 	&run_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
-- 
2.25.1

