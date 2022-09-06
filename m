Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9362E5AE2ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiIFIhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbiIFIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:37:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019877E95
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:35:44 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e126so8952904ybh.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YdNM7Ik2NWgFFzggAJTVBKjWtAKl429n8iXk5rBHK48=;
        b=cStlk6Dfg5rJdWkIE1JyNVlW48yWwGOmCCJyLxIcoW8xFNmnH4HpvqKYHbufn2BCv7
         ZA+6/hNDAVW5/pitBUGS2jZ+ueCvhvHUlgYgBp6AQG+M2WzNreCFQmfc/4RUJzfvIrF5
         MdYBZFgiQvDO3eou+ZVuT5sH9/gKrIGms+M8l+Oc8eu/4A1+0+iVrSL5D/V9dkKQQsOH
         TUtxGBytlVOqxzb0Jml3EJCM+rXLCvXufKhMz4cZOsubKT8vuJA6m2Z+XR2Zy2hryp8B
         xCmgAklrZg39/ia0/nRUsTRJMCJl5JXH8EYkbL3meOmvWrP4LNjjhF4NAxudb/lLFMAS
         7gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YdNM7Ik2NWgFFzggAJTVBKjWtAKl429n8iXk5rBHK48=;
        b=Y1URLAcH+BAIoTPDJPj5sQhH+Vc26cRuNECqeYp31mGKqAKY0Obk5BoMzqEihFYns9
         NpLIqg8BMTey2mcPwpQg63UMXR+FfPVoIti0Y5uV690roFb6COIUFNoNo9plWl4Pk8tb
         zj2/HZOVOBmBS3rPjUnT4rO6ryIipBnhYrw3Cz2qrP1B67TNH3Orlo1ajEYf3j+iMhhG
         T+T0K3gdTrHGvoNHnRqcrEpbMlzpxbBugoR1vC7fvqU6DM36v1RMzu66zJdGIpbJrGkE
         nSA3ADlH3Exlmo+eaEdFwZk6yeFxthRXXdtNm7fKpAYfqGRxiJP6gGeiZ71QeQQ6xFWk
         Y+tQ==
X-Gm-Message-State: ACgBeo1oJUKd1k7oGcPzNBvpJmzBqUOahO2IArnqntWQFvpmSx5rSjrZ
        omQfFTGUoZQl0CsXS4wnWeWno+KlEP2Dmmt/rQybVQ==
X-Google-Smtp-Source: AA6agR4nQtf5fsDxIb/7RKHfhElIpoTm60GSIpKdNdi+EgERf+B1HxnUyQZ3K/I2h7ChibvcPuzzXKWM+rdEDzVX2K8=
X-Received: by 2002:a25:9f85:0:b0:693:614:cb2a with SMTP id
 u5-20020a259f85000000b006930614cb2amr34489719ybq.143.1662453336501; Tue, 06
 Sep 2022 01:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220905031012.4450-1-osalvador@suse.de> <20220905031012.4450-3-osalvador@suse.de>
 <YxXyThZanSl3wboo@elver.google.com> <Yxb6PiwBDVuCOp1Q@localhost.localdomain>
In-Reply-To: <Yxb6PiwBDVuCOp1Q@localhost.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Tue, 6 Sep 2022 10:35:00 +0200
Message-ID: <CANpmjNMNxsoyBqR4U8ybP1ZzNGfkFDcZYJfpiv73wgD=xi6TDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counter
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 09:44, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Sep 05, 2022 at 02:57:50PM +0200, Marco Elver wrote:
> > On Mon, Sep 05, 2022 at 05:10AM +0200, Oscar Salvador wrote:
> > [...]
> > > +int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
> >
> > Can you add kernel-doc comment what this does (and also update
> > accordingly in 3/3 when you add 'threshold').
>
> Yes, I guess a kernel-doc comment is due.
>
> > From what I see it prints *all* stacks that have a non-zero count.
> > Correct?
>
> That's right.
>
> > If so, should this be called stack_depot_print_all_count() (having
> > stack(s) in the name twice doesn't make it more obvious what it does)?
> > Then in the follow-up patch you add the 'threshold' arg.
>
> I guess so. The only reason I went with the actual name is that for me
> "stack_depot" was kinda the name of the module/library, and
> so I wanted to make crystal clear what were we printing.
>
> But I'm ok with renaming it if it's already self-explanatory

I think it's clear from the fact we're using the stack depot that any
printing will print stacks. To mirror the existing
'stack_depot_print()', I'd go with 'stack_depot_print_all_count()'.


> > > +{
> > > +   int i = *pos, ret = 0;
> > > +   struct stack_record **stacks, *stack;
> > > +   static struct stack_record *last = NULL;
> > > +   unsigned long stack_table_entries = stack_hash_mask + 1;
> > > +
> > > +   /* Continue from the last stack if we have one */
> > > +   if (last) {
> > > +           stack = last->next;
> >
> > This is dead code?
>
> No, more below.
>
> > Either I'm missing something really obvious, but I was able to simplify
> > the above function to just this (untested!):
> >
> >       int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
> >       {
> >               const unsigned long stack_table_entries = stack_hash_mask + 1;
> >
> >               /* Iterate over all tables for valid stacks. */
> >               for (; *pos < stack_table_entries; (*pos)++) {
> >                       for (struct stack_record *stack = stack_table[*pos]; stack; stack = stack->next) {
> >                               if (!stack->size || stack->size < 0 || stack->size > size ||
> >                                   stack->handle.valid != 1 || refcount_read(&stack->count) < 1)
> >                                       continue;
> >
> >                               return stack_trace_snprint(buf, size, stack->entries, stack->size, 0) +
> >                                      scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
> >                                                refcount_read(&stack->count));
> >                       }
> >               }
> >
> >               return 0;
>
> Yes, this will not work.
>
> You have stack_table[] which is an array for struct stacks, and each struct
> stack has a pointer to its next stack which walks from the beginning fo a specific
> table till the end. e.g:
>
> stack_table[0] = {stack1, stack2, stack3, ...} (each linked by ->next)
> stack_table[1] = {stack1, stack2, stack3, ...} (each linked by ->next)
> ..
> stack_table[stack_table_entries - 1] = {stack1, stack2, stack3, ...} (each linked by ->next)
>
> *pos holds the index of stack_table[], while "last" holds the last stack within
> the table we were processing.
>
> So, when we find a valid stack to print, set "last" to that stack, and *pos to the index
> of stack_table.
> So, when we call stack_depot_print_stacks_threshold() again, we set "stack" to "last"->next,
> and we are ready to keep looking with:
>
>  for (; stack; stack = stack->next) {
>     ...
>     check if stack is valid
>  }
>
> Should not we find any more valid stacks in that stack_table, we need to check in
> the next table, so we do::
>
>     i++; (note that i was set to *pos at the beginning of the function)
>         *pos = i;
>         last = NULL;
>     goto new_table
>
> and now are ready to do:
>
> new_table:
>                 stacks = &stack_table[i];
>                 stack = (struct stack_record *)stacks;
>
>
> Does this clarify it a little bit?
>
> About using static vs non-static.
> In the v1, I was using a parameter which contained last_stack:
>
> https://patchwork.kernel.org/project/linux-mm/patch/20220901044249.4624-3-osalvador@suse.de/
>
> Not sure if that's better? Thoughts?

Moderately better, but still not great. Essentially you need 2
cursors, but with loff_t you only get 1.

I think the loff_t parameter can be used to encode both cursors. In
the kernel, loff_t is always 'long long', so it'll always be 64-bit.

Let's assume that collisions in the hash table are rare, so the number
of stacks per bucket are typically small. Then you can encode the
index into the bucket in bits 0-31 and the bucket index in bits 32-63.
STACK_HASH_ORDER_MAX is 20, so 32 bits is plenty to encode the index.
