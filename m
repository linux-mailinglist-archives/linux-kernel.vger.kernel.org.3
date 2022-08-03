Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFB588A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiHCKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiHCKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:05:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80C65E8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:05:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so14688391pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=C9VGA9sPog0r28l3bCbEGjn4o1fpHQlIN2nhYVLWw/k=;
        b=F0m9Q1ha0av70aTNZazPL/+nYhOyWG5MFlSFketERp6xdP5CSW0snaik6ZkvSq5eG0
         ASzhGNd9PIVGQkeOyDWp7E6trgcnW6YQnzCJsnm3/xp4/cnzmdVd84VJmGEcFRvQWDpz
         Ta3UeNHGrT/OOlpZzTMrvC3yq0QN4Gz6nYpd31UTk6ZF2hht6W0p+Nk2o1oezlGPAetK
         xyW1x0aBUGYc3eu0LRIoxwxtt1+ihbYAyyZA59IRajKm7mDGFOtGTtonWxbI6xA8i++7
         4N+tUoCcG83KFeLFJXYlc6vTDa6GT8Qy8XRZbdxAABre6Q42qnRXf9JfN4pH7f02ebqe
         KlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=C9VGA9sPog0r28l3bCbEGjn4o1fpHQlIN2nhYVLWw/k=;
        b=HkGPLJEb9HOnLngb0A4g32rfCp4oudqfHsXaX56TMrmZ3EOjMRaoW1++sx3OJffX1L
         VxNnEr5mDkbzUO51zBwWcXhzK5JzoZlM2K93SmmuoenyfBta/xLfEQaDs2LarXRa9H4H
         1+TC0kbDZjtiPZG/eGbLm6zkEZW0mPyWDePE20mDRRuY2v+WfB9bzeU3Qv46oOurVLEX
         noJvQEZDB+bXntw5ShV8wBJtfkIW4BLiAxsKAJAShF89dM7cyHYkQT5vV8vVK6kD3C1Z
         HF7d2Y6adorZVXjAXEzZHoV6rGBw6maWAmIJl2rQ1ljpHAl2cZbMlJrN2iktWMSemeGS
         WhVQ==
X-Gm-Message-State: ACgBeo2fZDg3qnCFxfZwPX3KHPkEtz6ynfxsIiyPBzitAihyus63spY7
        NHuxw4geQNJgYfaYlpVsZic=
X-Google-Smtp-Source: AA6agR6kGDhUSD4pprsK8/LMWUFqIDLfXb2kskwuuEFcf+pw4VJ649BtqcFgbC/w1Qh3CAiRFsQpqA==
X-Received: by 2002:a05:6a00:1f8b:b0:52d:5b9e:3ecf with SMTP id bg11-20020a056a001f8b00b0052d5b9e3ecfmr14659525pfb.48.1659521135990;
        Wed, 03 Aug 2022 03:05:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0016dd667d511sm1452653plk.252.2022.08.03.03.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 03:05:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.con.cn
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        CGEL <cgel.zte@gmail.com>
Subject: [RFC PATCH 2/4] ksm: implement scan-enhanced algorithm of auto mode
Date:   Wed,  3 Aug 2022 10:05:30 +0000
Message-Id: <20220803100530.1653496-1-xu.xin16@zte.con.cn>
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
 mm/ksm.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c80d908221a4..8acc893e4d61 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -131,6 +131,8 @@ struct mm_slot {
  * @address: the next address inside that to be scanned
  * @rmap_list: link to the next rmap to be scanned in the rmap_list
  * @seqnr: count of completed full scans (needed when removing unstable node)
+ * @new_ksmpages_of_this_scanning: count of the new merged KSM pages in the
+ *		current scanning of mm_lists (cleared after ksm_do_scan() ends)
  *
  * There is only the one ksm_scan instance of this cursor structure.
  */
@@ -139,6 +141,7 @@ struct ksm_scan {
 	unsigned long address;
 	struct rmap_item **rmap_list;
 	unsigned long seqnr;
+	unsigned long new_ksmpages_of_this_scanning;
 };
 
 /**
@@ -277,6 +280,20 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
+/*
+ * Work in auto-mode.
+ * Maximum number of multiplicative factor of pages_to_scan.
+ */
+static unsigned int ksm_max_scanning_factor = 32;
+
+/*
+ * Work in auto-mode.
+ * The multiplicative factor of pages_to_scan.
+ * Real pages to scan equals to the product of scanning_factor
+ * and pages_to_scan
+ */
+static unsigned int scanning_factor = 1;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -2031,6 +2048,8 @@ static void stable_tree_append(struct rmap_item *rmap_item,
 	rmap_item->address |= STABLE_FLAG;
 	hlist_add_head(&rmap_item->hlist, &stable_node->hlist);
 
+	ksm_scan.new_ksmpages_of_this_scanning++;
+
 	if (rmap_item->hlist.next)
 		ksm_pages_sharing++;
 	else
@@ -2396,6 +2415,23 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 	return NULL;
 }
 
+/*
+ * enhance_scanning_factor():
+ * double the values of scanning_factor, but not more than
+ * ksm_max_scanning_factor.
+ */
+static inline void enhance_scanning_factor(void)
+{
+	scanning_factor = scanning_factor << 1;
+	if (scanning_factor > ksm_max_scanning_factor)
+		scanning_factor = ksm_max_scanning_factor;
+}
+
+static inline void reset_scanning_factor(void)
+{
+	scanning_factor = 1;
+}
+
 /**
  * ksm_do_scan  - the ksm scanner main worker function.
  * @scan_npages:  number of pages we want to scan before we return.
@@ -2432,10 +2468,31 @@ static int ksm_scan_thread(void *nothing)
 	while (!kthread_should_stop()) {
 		mutex_lock(&ksm_thread_mutex);
 		wait_while_offlining();
-		if (ksmd_should_run())
-			ksm_do_scan(ksm_thread_pages_to_scan);
+		if (ksmd_should_run()) {
+			if (ksm_run & KSM_RUN_AUTO)
+				ksm_do_scan(ksm_thread_pages_to_scan * scanning_factor);
+			else
+				ksm_do_scan(ksm_thread_pages_to_scan);
+		}
 		mutex_unlock(&ksm_thread_mutex);
 
+		/*
+		 * If there are new ksm pages after scanning, then we
+		 * can enhance scanning_factor to improve ksm_thread's
+		 * pages_to_scan to speed up scanning. Otherwaise, we
+		 * reset scanning_factor to be one, so that to recover
+		 * the normal state because there is greater probability
+		 * of getting no new KsmPages in the next scanning.
+		 */
+		if (ksm_run & KSM_RUN_AUTO) {
+			if (ksm_scan.new_ksmpages_of_this_scanning > 0)
+				enhance_scanning_factor();
+			else
+				reset_scanning_factor();
+
+			ksm_scan.new_ksmpages_of_this_scanning = 0;
+		}
+
 		try_to_freeze();
 
 		if (ksmd_should_run()) {
@@ -2952,6 +3009,32 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 KSM_ATTR(run);
 
+static ssize_t max_scanning_factor_show(struct kobject *kobj,
+						struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_max_scanning_factor);
+}
+
+static ssize_t max_scanning_factor_store(struct kobject *kobj,
+								struct kobj_attribute *attr,
+								const char *buf, size_t count)
+{
+		unsigned int value;
+		int err;
+
+		err = kstrtouint(buf, 10, &value);
+		if (err)
+			return -EINVAL;
+
+		if (value < 1)
+			return -EINVAL;
+
+		ksm_max_scanning_factor = value;
+
+		return count;
+}
+KSM_ATTR(max_scanning_factor);
+
 #ifdef CONFIG_NUMA
 static ssize_t merge_across_nodes_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
@@ -3162,6 +3245,7 @@ static struct attribute *ksm_attrs[] = {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
+	&max_scanning_factor_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
-- 
2.25.1

