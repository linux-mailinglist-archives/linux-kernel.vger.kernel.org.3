Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7675AE16D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiIFHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIFHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:44:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C2248FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:44:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05F4B1F96B;
        Tue,  6 Sep 2022 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662450241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anGEhIPunbdYprwHmKAn9l8RRjOyN25i2V5av6YR7Xk=;
        b=HpR3wikdZt2jGNZYpD7P8n188HtnxIQ6TRZGkLwPLcy4aRP9zMkGrVxuRFQklIc4Pgu1I7
        iP4R8/tkwpr3JsW+zXqoXtpoZ1O2Ov7iQU+XN8b5yARAJWDVhqrDHm6PGjNzK/yVgBekl4
        6qd/04ZlAoQFVXURP+hNcow+jTn/ZtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662450241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anGEhIPunbdYprwHmKAn9l8RRjOyN25i2V5av6YR7Xk=;
        b=rXK6GYawgOTHs7c2VvOWVRStaOErHAKZFhNHdWE/Wol1AumJi+1yZlAyd887Q7Ifp5FF4O
        882FLtEJ5mYkfmCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66CA113A7A;
        Tue,  6 Sep 2022 07:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jyd5FkD6FmOaPAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 06 Sep 2022 07:44:00 +0000
Date:   Tue, 6 Sep 2022 09:43:58 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counter
Message-ID: <Yxb6PiwBDVuCOp1Q@localhost.localdomain>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-3-osalvador@suse.de>
 <YxXyThZanSl3wboo@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxXyThZanSl3wboo@elver.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:57:50PM +0200, Marco Elver wrote:
> On Mon, Sep 05, 2022 at 05:10AM +0200, Oscar Salvador wrote:
> [...]
> > +int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
> 
> Can you add kernel-doc comment what this does (and also update
> accordingly in 3/3 when you add 'threshold').

Yes, I guess a kernel-doc comment is due.

> From what I see it prints *all* stacks that have a non-zero count.
> Correct?

That's right.

> If so, should this be called stack_depot_print_all_count() (having
> stack(s) in the name twice doesn't make it more obvious what it does)?
> Then in the follow-up patch you add the 'threshold' arg.

I guess so. The only reason I went with the actual name is that for me
"stack_depot" was kinda the name of the module/library, and
so I wanted to make crystal clear what were we printing.

But I'm ok with renaming it if it's already self-explanatory

> > +{
> > +	int i = *pos, ret = 0;
> > +	struct stack_record **stacks, *stack;
> > +	static struct stack_record *last = NULL;
> > +	unsigned long stack_table_entries = stack_hash_mask + 1;
> > +
> > +	/* Continue from the last stack if we have one */
> > +	if (last) {
> > +		stack = last->next;
> 
> This is dead code?

No, more below.

> Either I'm missing something really obvious, but I was able to simplify
> the above function to just this (untested!):
> 
> 	int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
> 	{
> 		const unsigned long stack_table_entries = stack_hash_mask + 1;
> 
> 		/* Iterate over all tables for valid stacks. */
> 		for (; *pos < stack_table_entries; (*pos)++) {
> 			for (struct stack_record *stack = stack_table[*pos]; stack; stack = stack->next) {
> 				if (!stack->size || stack->size < 0 || stack->size > size ||
> 				    stack->handle.valid != 1 || refcount_read(&stack->count) < 1)
> 					continue;
> 
> 				return stack_trace_snprint(buf, size, stack->entries, stack->size, 0) +
> 				       scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
> 						 refcount_read(&stack->count));
> 			}
> 		}
> 
> 		return 0;

Yes, this will not work.

You have stack_table[] which is an array for struct stacks, and each struct
stack has a pointer to its next stack which walks from the beginning fo a specific
table till the end. e.g:

stack_table[0] = {stack1, stack2, stack3, ...} (each linked by ->next)
stack_table[1] = {stack1, stack2, stack3, ...} (each linked by ->next)
..
stack_table[stack_table_entries - 1] = {stack1, stack2, stack3, ...} (each linked by ->next)

*pos holds the index of stack_table[], while "last" holds the last stack within
the table we were processing.

So, when we find a valid stack to print, set "last" to that stack, and *pos to the index
of stack_table.
So, when we call stack_depot_print_stacks_threshold() again, we set "stack" to "last"->next,
and we are ready to keep looking with:

 for (; stack; stack = stack->next) {
    ...
    check if stack is valid
 }

Should not we find any more valid stacks in that stack_table, we need to check in
the next table, so we do::

    i++; (note that i was set to *pos at the beginning of the function)
	*pos = i;
	last = NULL; 
    goto new_table

and now are ready to do:

new_table:
		stacks = &stack_table[i];
		stack = (struct stack_record *)stacks;


Does this clarify it a little bit?

About using static vs non-static.
In the v1, I was using a parameter which contained last_stack:

https://patchwork.kernel.org/project/linux-mm/patch/20220901044249.4624-3-osalvador@suse.de/

Not sure if that's better? Thoughts?


-- 
Oscar Salvador
SUSE Labs
