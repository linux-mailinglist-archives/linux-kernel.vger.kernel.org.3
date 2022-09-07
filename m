Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA25AFAEB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIGEBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIGEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:01:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46677696F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:00:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CD3B1FE78;
        Wed,  7 Sep 2022 04:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662523258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npuejNubOdyGQXlyaQnjNHAGxJEr1nLk2K2rggJlZR4=;
        b=ltPEDAeAJDZd3nBa8es43GTlO0wXsuHSOxcGJOzHlNGi3XvHv1ZXCEkSpA8/iknka32Dr5
        p7Q6g7I7Qn30Rtx/b6UsyjQWIUPcHL7YUS6TiN5tN5fyF3qg/wQNkmNr9QFW8KlbPy8r1z
        2eK0PbuSZ6TCszdQA/NrHK0nAC0P2Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662523258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npuejNubOdyGQXlyaQnjNHAGxJEr1nLk2K2rggJlZR4=;
        b=pQIHI3OCLZbMyrnl1GDcSg6pbXOkICpng01ByWrGUluvMAMN8RkBCiyLmHA0FRLz/uA8lI
        xUr/QvxgcUuJpiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A81913486;
        Wed,  7 Sep 2022 04:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u+0aH3kXGGMPMAAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 07 Sep 2022 04:00:57 +0000
Date:   Wed, 7 Sep 2022 06:00:55 +0200
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
Message-ID: <YxgXd0Z+cqRk7Y7U@localhost.localdomain>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-3-osalvador@suse.de>
 <YxXyThZanSl3wboo@elver.google.com>
 <Yxb6PiwBDVuCOp1Q@localhost.localdomain>
 <CANpmjNMNxsoyBqR4U8ybP1ZzNGfkFDcZYJfpiv73wgD=xi6TDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMNxsoyBqR4U8ybP1ZzNGfkFDcZYJfpiv73wgD=xi6TDA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:35:00AM +0200, Marco Elver wrote:
> I think it's clear from the fact we're using the stack depot that any
> printing will print stacks. To mirror the existing
> 'stack_depot_print()', I'd go with 'stack_depot_print_all_count()'.

Fair enough, I will rename it then.
 
> Moderately better, but still not great. Essentially you need 2
> cursors, but with loff_t you only get 1.
> 
> I think the loff_t parameter can be used to encode both cursors. In
> the kernel, loff_t is always 'long long', so it'll always be 64-bit.
> 
> Let's assume that collisions in the hash table are rare, so the number
> of stacks per bucket are typically small. Then you can encode the
> index into the bucket in bits 0-31 and the bucket index in bits 32-63.
> STACK_HASH_ORDER_MAX is 20, so 32 bits is plenty to encode the index.

I see, I didn't think of it to be honest.

Then, the below (completely untested) should the trick:

<----
 int stack_depot_print_all_count(char *buf, size_t size, loff_t *pos)
 {
         int ret = 0, stack_i, table_i;
         struct stack_record **stacks, *stack;
         unsigned long stack_table_entries = stack_hash_mask + 1;
 
         stack_i = (*pos & 31);
         table_i = (*pos >> 32);
 new_table:
         stacks = &stack_table[table_i];
         stack = ((struct stack_record *)stacks) + stack_i;
 
         for (; stack; stack = stack->next, stack_i++) {
                 if (!stack->size || stack->size < 0 ||
                     stack->size > size || stack->handle.valid != 1 ||
                     refcount_read(&stack->count) < 1)
                         continue;
 
                 ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
                 ret += scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
                                  refcount_read(&stack->count));
                 *pos |= stack_i;
                 *pos |= ((long long)table_i << 32);
                 return ret;
         }
 
         table_i++;
         /* Keep looking all tables for valid stacks */
         if (table_i < stack_table_entries)
                 goto new_table;
 
         return 0;
 }
---->

I will give it a go.

Thanks Marco!


-- 
Oscar Salvador
SUSE Labs
