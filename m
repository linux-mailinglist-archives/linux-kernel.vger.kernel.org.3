Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54CC5A8CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiIAEoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiIAEne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:43:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80359111AFA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 21:43:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20776221E2;
        Thu,  1 Sep 2022 04:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662007377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+9op6+s45dBeDDz0hB6cxjRW0r3Pje/FesTmSW2Zek=;
        b=NAIeqLSDDSE+P9kHg5Syu0+cXWEM5KdAOu1En/FPsEPWos0BsZE1cBPGZR5MRySX53IHfn
        wTIcA1u8waN9m0Rh3w/lLxoexge/vWQvCv0TcjSze3peDkowN5nJZecsg+6TI/P3K5tBGs
        5iCdzLF5xUjKZuBqvi542DvQpNR+D64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662007377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+9op6+s45dBeDDz0hB6cxjRW0r3Pje/FesTmSW2Zek=;
        b=0oalvhcOoaYu6EzaGL2RxZ5vSihBQFyAzeJIJ+GbTXuKLQnsKZUIv00y4F5pN+YHdBNWQo
        Nqe/TXfpazjOnrCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C293139C4;
        Thu,  1 Sep 2022 04:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IMKAH1A4EGPheAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 01 Sep 2022 04:42:56 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/3] mm, page_owner: Add page_owner_stacks file to print out only stacks and their counter
Date:   Thu,  1 Sep 2022 06:42:48 +0200
Message-Id: <20220901044249.4624-3-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901044249.4624-1-osalvador@suse.de>
References: <20220901044249.4624-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We might be only interested in knowing about stacks <-> count
relationship, so instead of having to fiddle with page_owner
output and screen through pfns, let us add a new file called
'page_owner_stacks' that does just that.
By cating such file, we will get all the stacktraces followed by
its counter (allocated - freed times), so we can have a more specific
overview.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  2 ++
 lib/stackdepot.c           | 40 ++++++++++++++++++++++++++++++++++++++
 mm/page_owner.c            | 30 ++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 5ee0cf5be88f..20f62039f23a 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -25,6 +25,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					gfp_t gfp_flags, bool can_alloc,
 					stack_action_t action);
 void stack_depot_dec_count(depot_stack_handle_t handle);
+int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
+				       unsigned long *last_stack);
 
 /*
  * Every user of stack depot has to call stack_depot_init() during its own init
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index aeb59d3557e2..3090ae0f3958 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -526,3 +526,43 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 	return __stack_depot_save(entries, nr_entries, alloc_flags, true, action);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save_action);
+
+int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
+				       unsigned long *last_stack)
+{
+	struct stack_record *stack = NULL, *last;
+	struct stack_record **stacks;
+	int i = *pos, ret = 0;
+
+	/* Continue from the last week if we have one */
+	if (*last_stack) {
+		last = (struct stack_record *)*last_stack;
+		stack = last->next;
+	} else {
+new_table:
+		stacks = &stack_table[i];
+		stack = (struct stack_record *)stacks;
+	}
+
+	for (; stack; stack = stack->next) {
+		if (!stack->size || stack->size < 0 ||
+		    stack->size > size || stack->handle.valid != 1 ||
+		    refcount_read(&stack->count) < 1)
+			continue;
+
+		ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
+		ret += scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
+				 refcount_read(&stack->count));
+		*last_stack = (unsigned long)stack;
+		return ret;
+	}
+
+	i++;
+	*pos = i;
+
+	/* Keep looking all tables for valid stacks */
+	if (i < STACK_HASH_SIZE)
+		goto new_table;
+
+	return 0;
+}
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 794f346d7520..8c67c7eb2451 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -43,6 +43,8 @@ static depot_stack_handle_t early_handle;
 
 static void init_early_allocated_pages(void);
 
+static unsigned long last_stack = 0;
+
 static int __init early_page_owner_param(char *buf)
 {
 	int ret = kstrtobool(buf, &page_owner_enabled);
@@ -663,6 +665,32 @@ static void init_early_allocated_pages(void)
 		init_zones_in_node(pgdat);
 }
 
+static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
+				      size_t count, loff_t *pos)
+{
+	char *kbuf;
+	int ret = 0;
+
+	count = min_t(size_t, count, PAGE_SIZE);
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return ENOMEM;
+
+	ret += stack_depot_print_stacks_threshold(kbuf, count, pos, &last_stack);
+	if (copy_to_user(buf, kbuf, ret))
+		ret = -EFAULT;
+
+	if (!ret)
+		last_stack = 0;
+
+	kfree(kbuf);
+	return ret;
+}
+
+static const struct file_operations proc_page_owner_stacks = {
+	.read = read_page_owner_stacks,
+};
+
 static const struct file_operations proc_page_owner_operations = {
 	.read		= read_page_owner,
 };
@@ -676,6 +704,8 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
+	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
+			    &proc_page_owner_stacks);
 
 	return 0;
 }
-- 
2.35.3

