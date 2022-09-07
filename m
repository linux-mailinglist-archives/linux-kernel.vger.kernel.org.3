Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475F45AFD3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIGHPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGHPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:15:13 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81612AC69
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:15:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-345528ceb87so60901547b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OmUSwa/mYLk9frSI3Ci/hO94fZOgJznoYBMXxqpBXFg=;
        b=WfmaH9qowdYFia3pdj+mLnLLgbNONrD37xKKUHjBYpLQFKSBGCbfBpnYcNcCaKXGn6
         HZKPfXdqkGsxb9qiTuQll8nsk3chATfr5IAUHPQD8Tbv39VEvRrKGgFmhfFMIzYItkaF
         M7OCtsxaTpIrpzPtd60pDPgSawXHEHuGpNoYXbKCR/5vJju28fPxa/0dVdqx/GhBw6ok
         baSAbCKWLbrodu6EvYah+2+mu/AvzY+6rrDTkGIH6eeTTHpMmnbK8brbqfVj7vYQ82c3
         r/t3Re1kxq2R7+oYslQ6iYw001SuiX7n0vkH8rHZ7XfwBAXoxql9kI6b3xtkZSFzpfeV
         zPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OmUSwa/mYLk9frSI3Ci/hO94fZOgJznoYBMXxqpBXFg=;
        b=6a134YfXxBifV0r4amBSr83igmwLjP6ruUckV4eCO5MKQXeDEZ+HsNmtdxtpx1J/J1
         XB2u685X15pDB1NF4XnBdYQ6z9hONgS3pZsoGjhBWHD4/wsB0jbODVuRauqZJ2U6url7
         RW0PSluUtR6iz/WKs5OLd14siMN/TG2pPgsjSPAjpfp4BVHXA9ycJZgQCmfcRq8h7f6y
         iPmkRk39HVm+D/DhxBQ2lSPwWfLE7pGtBQJlGyjuXEee9CTvtxZs5OHb+9svwU80Hw7Y
         fjtits0msBc/wdkiS9BUyqGGIYJ4FFlijrHmACqRH6NkBDHXp+rjSnegwFy9Ml8JuDuF
         RyDg==
X-Gm-Message-State: ACgBeo0xGIAIyhQ7fpqiiGmiqlExV9ga03uqaBdVUlfOVBwdH6nt61kF
        C89HLQv6eisTMibgHQsugVz3N8cI1vslwSdaWbKzlQ==
X-Google-Smtp-Source: AA6agR7Br17REgcXmW+wFleLtGpNAN6RYdhFOGLv/Eyg+5io2AhocmRFtyvXUP4hKAtUWwF99s8mcgifCYWUtJbMLS8=
X-Received: by 2002:a81:a16:0:b0:345:afa:5961 with SMTP id 22-20020a810a16000000b003450afa5961mr1898089ywk.11.1662534911778;
 Wed, 07 Sep 2022 00:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220905031012.4450-1-osalvador@suse.de> <20220905031012.4450-3-osalvador@suse.de>
 <YxXyThZanSl3wboo@elver.google.com> <Yxb6PiwBDVuCOp1Q@localhost.localdomain>
 <CANpmjNMNxsoyBqR4U8ybP1ZzNGfkFDcZYJfpiv73wgD=xi6TDA@mail.gmail.com> <YxgXd0Z+cqRk7Y7U@localhost.localdomain>
In-Reply-To: <YxgXd0Z+cqRk7Y7U@localhost.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Wed, 7 Sep 2022 09:14:35 +0200
Message-ID: <CANpmjNNn0cSpszRJyeF9_ogER9m859MYh745bqOr1DLEp7kibQ@mail.gmail.com>
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

On Wed, 7 Sept 2022 at 06:00, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Sep 06, 2022 at 10:35:00AM +0200, Marco Elver wrote:
> > I think it's clear from the fact we're using the stack depot that any
> > printing will print stacks. To mirror the existing
> > 'stack_depot_print()', I'd go with 'stack_depot_print_all_count()'.
>
> Fair enough, I will rename it then.
>
> > Moderately better, but still not great. Essentially you need 2
> > cursors, but with loff_t you only get 1.
> >
> > I think the loff_t parameter can be used to encode both cursors. In
> > the kernel, loff_t is always 'long long', so it'll always be 64-bit.
> >
> > Let's assume that collisions in the hash table are rare, so the number
> > of stacks per bucket are typically small. Then you can encode the
> > index into the bucket in bits 0-31 and the bucket index in bits 32-63.
> > STACK_HASH_ORDER_MAX is 20, so 32 bits is plenty to encode the index.
>
> I see, I didn't think of it to be honest.
>
> Then, the below (completely untested) should the trick:
>
> <----
>  int stack_depot_print_all_count(char *buf, size_t size, loff_t *pos)
>  {
>          int ret = 0, stack_i, table_i;
>          struct stack_record **stacks, *stack;
>          unsigned long stack_table_entries = stack_hash_mask + 1;
>
>          stack_i = (*pos & 31);
>          table_i = (*pos >> 32);
>  new_table:
>          stacks = &stack_table[table_i];
>          stack = ((struct stack_record *)stacks) + stack_i;

Why are you casting a stack_record** to a stack_record*? stack_table
is already appropriately typed, and there should be no need to cast
things around.

'stacks' is supposed to be the bucket? In which case you need to
dereference it to get the first entry in the bucket: bucket =
stack_table[table_i];

stack_i cannot be used to index into the bucket, because the elements
in it are a linked list and not necessarily adjacent in memory. You
have to traverse the linked list stack_i elements to get to the start:

  for (int i = 0; stack && i < stack_i; stack = stack->next, ++i);

then you can proceed with the below code.

>          for (; stack; stack = stack->next, stack_i++) {
>                  if (!stack->size || stack->size < 0 ||
>                      stack->size > size || stack->handle.valid != 1 ||
>                      refcount_read(&stack->count) < 1)
>                          continue;
>
>                  ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
>                  ret += scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
>                                   refcount_read(&stack->count));
>                  *pos |= stack_i;
>                  *pos |= ((long long)table_i << 32);
>                  return ret;
>          }
>
>          table_i++;
>          /* Keep looking all tables for valid stacks */
>          if (table_i < stack_table_entries)
>                  goto new_table;

While you're at it, could you try to come up with a version that
avoids the goto?

>          return 0;
>  }
> ---->
>
> I will give it a go.
>
> Thanks Marco!
>
>
> --
> Oscar Salvador
> SUSE Labs
