Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D95AC8F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbiIEDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiIEDKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:10:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A45E21E18
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:10:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0A4D38628;
        Mon,  5 Sep 2022 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662347429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=caEWLfqDu+y+boYO54sxVXmuA4zEki6s/GhDf6KoI7g=;
        b=qerU60J2ja+QkuOEQnOHj7VzwgxB+GreeesUoWr3/T3n2ts0tRYlNWte1CAesoX15Kgiop
        rIDJ61BB0UpW62TKmlgIPBtMeOCHLFr+u0Uxs0Nfn0nZmc4x7lye0Rrc24Y1lsMe2PoBK5
        ZrZb6uoWSWsA8xBm7CmzgYjGFsEUPMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662347429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=caEWLfqDu+y+boYO54sxVXmuA4zEki6s/GhDf6KoI7g=;
        b=DHBa2kCPOTm3cEetEvm35ruFVo5yC5vvClo9Bhbdo0+Bzta7ytYXzl3gqtOtbQGk8Ew9il
        9aqOs/1A9aTXFkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA7CF139F9;
        Mon,  5 Sep 2022 03:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEGCNqRoFWMeHwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 05 Sep 2022 03:10:28 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Mon,  5 Sep 2022 05:10:12 +0200
Message-Id: <20220905031012.4450-4-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905031012.4450-1-osalvador@suse.de>
References: <20220905031012.4450-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to filter out the output on a threshold basis,
in this way we can get rid of a lot of noise and focus only on those
stacks which have an allegedly high counter.

We can control the threshold value by a new file called
'page_owner_threshold', which is 0 by default.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  3 ++-
 lib/stackdepot.c           |  6 +++--
 mm/page_owner.c            | 51 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 19d3f8295df8..742038216cd0 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -25,7 +25,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					gfp_t gfp_flags, bool can_alloc,
 					enum stack_depot_action action);
 void stack_depot_dec_count(depot_stack_handle_t handle);
-int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos);
+int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
+				       unsigned long threshold);
 
 /*
  * Every user of stack depot has to call stack_depot_init() during its own init
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index a198b2dbe3fb..a31e882853ab 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -566,7 +566,8 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_depot_save_action);
 
-int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
+int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
+				       unsigned long threshold)
 {
 	int i = *pos, ret = 0;
 	struct stack_record **stacks, *stack;
@@ -585,7 +586,8 @@ int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
 	for (; stack; stack = stack->next) {
 		if (!stack->size || stack->size < 0 ||
 		    stack->size > size || stack->handle.valid != 1 ||
-		    refcount_read(&stack->count) < 1)
+		    refcount_read(&stack->count) < 1 ||
+		    refcount_read(&stack->count) < threshold)
 			continue;
 
 		ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d88e6b4aefa0..5b895d347c5f 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -43,6 +43,8 @@ static depot_stack_handle_t early_handle;
 
 static void init_early_allocated_pages(void);
 
+static unsigned long threshold;
+
 static int __init early_page_owner_param(char *buf)
 {
 	int ret = kstrtobool(buf, &page_owner_enabled);
@@ -675,7 +677,7 @@ static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	ret += stack_depot_print_stacks_threshold(kbuf, count, pos);
+	ret += stack_depot_print_stacks_threshold(kbuf, count, pos, threshold);
 	if (copy_to_user(buf, kbuf, ret))
 		ret = -EFAULT;
 
@@ -683,6 +685,51 @@ static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
 	return ret;
 }
 
+static int page_owner_threshold_show(struct seq_file *p, void *v)
+{
+	 seq_printf(p, "%lu\n", threshold);
+	return 0;
+}
+
+static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
+					  size_t count, loff_t *pos)
+{
+	char *kbuf;
+	int ret = 0;
+
+	count = min_t(size_t, count, PAGE_SIZE);
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	if (copy_from_user(kbuf, buf, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	kbuf[count - 1] = '\0';
+
+	ret = kstrtoul(kbuf, 10, &threshold);
+
+out:
+	kfree(kbuf);
+	return ret ? ret : count;
+}
+
+static int open_page_owner_threshold(struct inode *inode, struct file *file)
+{
+	return single_open(file, page_owner_threshold_show, NULL);
+}
+
+
+static const struct file_operations proc_page_owner_threshold = {
+	.open = open_page_owner_threshold,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.write = write_page_owner_threshold,
+	.release = single_release,
+};
+
 static const struct file_operations proc_page_owner_stacks = {
 	.read = read_page_owner_stacks,
 };
@@ -702,6 +749,8 @@ static int __init pageowner_init(void)
 			    &proc_page_owner_operations);
 	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
 			    &proc_page_owner_stacks);
+	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
+			     &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.35.3

