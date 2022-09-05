Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA415AC8FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiIEDLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiIEDKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:10:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D38F21E15
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:10:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E35365FC5E;
        Mon,  5 Sep 2022 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662347428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lL95UP49eyMiT0mDlLezEno7T+Vwj4MaJYDWgGzY0sA=;
        b=xmxC5alWRAh1ULHhHXNiMjhEMMXtpkeatIp52qVVssXWwzJkU7M/ZIdBzEHaSwv5Un0zXj
        TptiyBqBaPxzrrnRQZw2x9fJHyMFNsdCeqwaXib8N7KavbvXZ9j2kQvUpYx8DfWAcDdCWH
        fmBancaRyYRMtSiSOx+s4R9Fk89N4Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662347428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lL95UP49eyMiT0mDlLezEno7T+Vwj4MaJYDWgGzY0sA=;
        b=EkSlzIosXJUIOOwW7wTbSAoXoNfGTbF7U9XZesYYg0WH1ZefJZUPwlIg8gHYHFi3PyYffU
        vk82KcAJ1S7UF3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26FDE139F9;
        Mon,  5 Sep 2022 03:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YErHBqRoFWMeHwAAMHmgww
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
Subject: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to print out only stacks and their counter
Date:   Mon,  5 Sep 2022 05:10:11 +0200
Message-Id: <20220905031012.4450-3-osalvador@suse.de>
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

We might be only interested in knowing about stacks <-> count
relationship, so instead of having to fiddle with page_owner
output and screen through pfns, let us add a new file called
'page_owner_stacks' that does just that.
By cating such file, we will get all the stacktraces followed by
its counter, so we can have a more global view.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  1 +
 lib/stackdepot.c           | 40 ++++++++++++++++++++++++++++++++++++++
 mm/page_owner.c            | 25 ++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 4e3a88f135ee..19d3f8295df8 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -25,6 +25,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					gfp_t gfp_flags, bool can_alloc,
 					enum stack_depot_action action);
 void stack_depot_dec_count(depot_stack_handle_t handle);
+int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos);
 
 /*
  * Every user of stack depot has to call stack_depot_init() during its own init
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index a806ef58a385..a198b2dbe3fb 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -565,3 +565,43 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
 	return __stack_depot_save(entries, nr_entries, alloc_flags, true, action);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save_action);
+
+int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
+{
+	int i = *pos, ret = 0;
+	struct stack_record **stacks, *stack;
+	static struct stack_record *last = NULL;
+	unsigned long stack_table_entries = stack_hash_mask + 1;
+
+	/* Continue from the last stack if we have one */
+	if (last) {
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
+		last = stack;
+		return ret;
+	}
+
+	i++;
+	*pos = i;
+	last = NULL;
+
+	/* Keep looking all tables for valid stacks */
+	if (i < stack_table_entries)
+		goto new_table;
+
+	return 0;
+}
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8730f377fa91..d88e6b4aefa0 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -664,6 +664,29 @@ static void init_early_allocated_pages(void)
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
+		return -ENOMEM;
+
+	ret += stack_depot_print_stacks_threshold(kbuf, count, pos);
+	if (copy_to_user(buf, kbuf, ret))
+		ret = -EFAULT;
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
@@ -677,6 +700,8 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
+	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
+			    &proc_page_owner_stacks);
 
 	return 0;
 }
-- 
2.35.3

