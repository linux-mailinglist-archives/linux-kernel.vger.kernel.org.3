Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3C5A8CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiIAEn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiIAEn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:43:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A9ED01C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 21:43:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2024221EE;
        Thu,  1 Sep 2022 04:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662007377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8DWylbFwSCb/px9RHGyLSh+EhBiVeZp3bgNDtmW9IA=;
        b=S7u1rvndnGXFGe9gpIQARWw/22R+6XqNKcNzRqacOvUWansQ9BHdjWh8iRcKXrqgqLuOV2
        v6DNKPXLbjMM5RWzIlyGrePp8e4xf2+G40n99CDJxSnS5QOyKG04Sjxj+U0/vhXgjzyXUW
        RP6Cdu7Ae7QcP7PhwIku/EEFbAb/KXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662007377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8DWylbFwSCb/px9RHGyLSh+EhBiVeZp3bgNDtmW9IA=;
        b=BPF/tSxXMQDSvEmbgyPhuBR9rysuTMAjY41Rxsu8/nW5dEMdII4hStCGu0uptmYWj17dRU
        oJeH7qfBX4uymWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32E2C139C4;
        Thu,  1 Sep 2022 04:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WKusCVE4EGPheAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 01 Sep 2022 04:42:57 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Thu,  1 Sep 2022 06:42:49 +0200
Message-Id: <20220901044249.4624-4-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901044249.4624-1-osalvador@suse.de>
References: <20220901044249.4624-1-osalvador@suse.de>
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
 include/linux/stackdepot.h |  3 +-
 lib/stackdepot.c           |  6 ++--
 mm/page_owner.c            | 61 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 20f62039f23a..ee66be40a152 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -26,7 +26,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					stack_action_t action);
 void stack_depot_dec_count(depot_stack_handle_t handle);
 int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
-				       unsigned long *last_stack);
+				       unsigned long *last_stack,
+				       unsigned long threshold);
 
 /*
  * Every user of stack depot has to call stack_depot_init() during its own init
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 3090ae0f3958..b4a04f09a7b7 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -528,7 +528,8 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 EXPORT_SYMBOL_GPL(stack_depot_save_action);
 
 int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
-				       unsigned long *last_stack)
+				       unsigned long *last_stack,
+				       unsigned long threshold)
 {
 	struct stack_record *stack = NULL, *last;
 	struct stack_record **stacks;
@@ -547,7 +548,8 @@ int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
 	for (; stack; stack = stack->next) {
 		if (!stack->size || stack->size < 0 ||
 		    stack->size > size || stack->handle.valid != 1 ||
-		    refcount_read(&stack->count) < 1)
+		    refcount_read(&stack->count) < 1 ||
+		    refcount_read(&stack->count) < threshold)
 			continue;
 
 		ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8c67c7eb2451..ef10cf44aaec 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -44,6 +44,7 @@ static depot_stack_handle_t early_handle;
 static void init_early_allocated_pages(void);
 
 static unsigned long last_stack = 0;
+static unsigned long threshold_count = 0;
 
 static int __init early_page_owner_param(char *buf)
 {
@@ -676,7 +677,8 @@ static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
 	if (!kbuf)
 		return ENOMEM;
 
-	ret += stack_depot_print_stacks_threshold(kbuf, count, pos, &last_stack);
+	ret += stack_depot_print_stacks_threshold(kbuf, count, pos, &last_stack,
+						  threshold_count);
 	if (copy_to_user(buf, kbuf, ret))
 		ret = -EFAULT;
 
@@ -687,6 +689,61 @@ static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
 	return ret;
 }
 
+static ssize_t read_page_owner_threshold(struct file *file, char __user *buf,
+					 size_t count, loff_t *pos)
+{
+	char *kbuf;
+	int ret = 0;
+
+	count = min_t(size_t, count, PAGE_SIZE);
+
+	if (*pos >= count)
+		return 0;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return ENOMEM;
+
+	ret = scnprintf(kbuf, count, "%lu\n", threshold_count);
+	if (copy_to_user(buf, kbuf, ret))
+		ret = -EFAULT;
+
+	*pos += count;
+	kfree(kbuf);
+
+	return ret;
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
+	ret = kstrtoul(kbuf, 10, &threshold_count);
+
+out:
+	kfree(kbuf);
+	return ret ? ret : count;
+}
+
+static const struct file_operations proc_page_owner_threshold = {
+	.read = read_page_owner_threshold,
+	.write = write_page_owner_threshold,
+};
+
 static const struct file_operations proc_page_owner_stacks = {
 	.read = read_page_owner_stacks,
 };
@@ -706,6 +763,8 @@ static int __init pageowner_init(void)
 			    &proc_page_owner_operations);
 	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
 			    &proc_page_owner_stacks);
+	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
+			     &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.35.3

