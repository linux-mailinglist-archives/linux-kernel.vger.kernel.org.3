Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2164B8544
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiBPKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:12:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiBPKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:12:20 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D86F89319
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:12:08 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id j17so618824vkd.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBY3THs16ZovTHpcFVUCQl1Qj1APJsTflKUGkjlEAXM=;
        b=N0tV0GQFGNvZVqQr5ntxToR9Wuzbgeb/td7mQdwc1jOUSZzUghWeWd0L4V5iCVEuge
         yPLmnMYCTI1t7jWs0ghEPuCyllXp5SHSXq4NHVYAIjOIgieOAbwAt6z6WsU7RwytpoiN
         S9oaEt1CSc9JtN9Q1NiRB/YuK14/q2rfC8+az1sQiZwCRVh5b9xnkgjOY5Y4ihSiqriE
         D/wCjFqbkNx6OBHNJj4l5ZjJNVGNSbl9U/bXg/ySxkjT3ZMveh2HmNr9vqteyxEf0A1+
         mheMg1lz2WYQ+kmX9s8Yp263uofmjzNbNCIheR8xaj6mca8T3FkTXPS9/aO4KbTVyMBj
         cMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBY3THs16ZovTHpcFVUCQl1Qj1APJsTflKUGkjlEAXM=;
        b=wlRPQm3n1dTwBVICBFCIi987lC3afPutJga9M4oqvN2gffW68T9NPOWEXkjReVxxGb
         Vbw1+tlH2QwNiMwysfe0hUjIUyxLSWGu12wk9iFbRBLxJ0ifMBvIIA5Z4LEuQlXUGZUS
         eAoGJ6/s4r0ZuqC3280hQOMmgwV+33OzLOdsCS1q3jrO8ovzOLd4GrQ8v7zrHhUHjRUv
         rvDKVkN8v3/vmQ6CI1SISbm+srk3PucCyv712ZfZmOOz1/rzo53Kbw1AatXSRlj7XsDP
         gd5fd5VBCZTSUeAoP8DSUO5GsPcFM9wIlAtRTT+modK8ORMv0/roydscZpLP/hcLTZQi
         r8CA==
X-Gm-Message-State: AOAM53085h1DuLgvHCmbU0EGLuvWLaky/tzR6Vmsp83He+VM+6verTJr
        yWdonqbuztFaSzc6cVv/x2mlgFAdz7KX+ga5O7HjRXtizds=
X-Google-Smtp-Source: ABdhPJyZ82GJDj6nS9xx/k7QNlxXCYHxHbMg5WyxlU6OdO38ZgcaXz4ilIgq5t7MuTcd5DN23KV5k7xM/wWgWxNGvDM=
X-Received: by 2002:a05:6122:8cf:b0:326:361c:bdd9 with SMTP id
 15-20020a05612208cf00b00326361cbdd9mr572728vkg.35.1645006327282; Wed, 16 Feb
 2022 02:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com> <20220215144241.3812052-8-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-8-Liam.Howlett@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Wed, 16 Feb 2022 10:11:54 +0000
Message-ID: <CANe_+Uh9orFkNzohmbx_jziipU9_p_ckSPEGzygPt2VknV_99Q@mail.gmail.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a few v minor comments.

On Tue, 15 Feb 2022 at 14:43, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.
>
> The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> nodes.  With the increased branching factor, it is significantly shorter than
> the rbtree so it has fewer cache misses.  The removal of the linked list
> between subsequent entries also reduces the cache misses and the need to pull
> in the previous and next VMA during many tree alterations.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Tested-by: David Howells <dhowells@redhat.com>
> ---
>  Documentation/core-api/index.rst              |    1 +
>  Documentation/core-api/maple_tree.rst         |  218 +
>  MAINTAINERS                                   |   12 +
>  include/linux/maple_tree.h                    |  683 ++
>  include/trace/events/maple_tree.h             |  123 +
>  init/main.c                                   |    2 +
>  lib/Kconfig.debug                             |   16 +
>  lib/Makefile                                  |    3 +-
>  lib/maple_tree.c                              | 6967 +++++++++++++++++
>  tools/testing/radix-tree/.gitignore           |    2 +
>  tools/testing/radix-tree/Makefile             |   13 +-
>  tools/testing/radix-tree/generated/autoconf.h |    1 +
>  tools/testing/radix-tree/linux/maple_tree.h   |    7 +
>  tools/testing/radix-tree/maple.c              |   59 +
>  .../radix-tree/trace/events/maple_tree.h      |    3 +
>  15 files changed, 8107 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/core-api/maple_tree.rst
>  create mode 100644 include/linux/maple_tree.h
>  create mode 100644 include/trace/events/maple_tree.h
>  create mode 100644 lib/maple_tree.c
>  create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
>  create mode 100644 tools/testing/radix-tree/maple.c
>  create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

...
> +++ b/include/linux/maple_tree.h
...
> +/*
> + * The Maple Tree squeezes various bits in at various points which aren't
> + * necessarily obvious.  Usually, this is done by observing that pointers are
> + * N-byte aligned and thus the bottom log_2(N) bits are available for use.  We
> + * don't use the high bits of pointers to store additional information because
> + * we don't know what bits are unused on any given architecture.
> + *
> + * Nodes are 256 bytes in size and are also aligned to 256 bytes, giving us 8
> + * low bits for our own purposes.  Nodes are currently of 4 types:

Is it worth adding the compile-time check;
    static_assert(sizeof(struct maple_tree) == 256);
?
...

> +struct ma_wr_state {
> +       struct ma_state *mas;
> +       struct maple_node *node;
> +       enum maple_type type;
> +       unsigned long r_min;
> +       unsigned long r_max;
> +       unsigned char offset_end;
> +       unsigned char node_end;
> +       unsigned long *pivots;
> +       unsigned long end_piv;
> +       void __rcu **slots;
> +       void *entry;
> +       void *content;
> +};

Minor: Moving the member 'type' to below 'r_max', means it will remove
the need for padding (reducing size from 88 to 80 byes).  Does this
matter?  I doubt it.  Better/worse for h/w cache?  Suspect no
difference.
...

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> @@ -827,6 +834,7 @@ config DEBUG_VM_RB
>
>           If unsure, say N.
>
> +
>  config DEBUG_VM_PGFLAGS
>         bool "Debug page-flags operations"
>         depends on DEBUG_VM

Stray blank line.
...

> +++ b/lib/maple_tree.c

> + * Note types:
> + *  0x??1 = Root
> + *  0x?00 = 16 bit nodes
> + *  0x010 = 32 bit nodes
> + *  0x110 = 64 bit nodes
> + *
> + * Slot size and alignment
> + *  0x??1 : Root
> + *  0x?00 : 16 bit values, type in 0-1, slot in 2-6
> + *  0x010 : 32 bit values, type in 0-2, slot in 3-6
> + *  0x110 : 64 bit values, type in 0-2, slit in 3-6
> + */

s/slit/slot/

> +
> +#define MAPLE_PARENT_ROOT              0x01
...

> +/*
> + * ma_meta_gap() - Get the largest gap location of a node from the metadat

s/metadat/metadata/
...

> +/*
> + * mast_rebalace_prev() - Rebalance against the previous node

s/mast_rebalace_prev/mast_rebalance_prev/


> + * @mast: The maple subtree state
> + * @old_l: The encoded maple node to the left (previous node)
> + */
> +static inline void mast_rebalance_prev(struct maple_subtree_state *mast,
> +                                      struct maple_enode *old_l)
...

> +static inline void *mas_state_walk(struct ma_state *mas)
> +{
> +       void *entry;
> +
> +       entry = mas_start(mas);
> +       if (mas_is_none(mas))
> +               return NULL;
> +
> +       if (mas_is_ptr(mas))
> +               return entry;
> +
> +       return mtree_range_walk(mas);
> +}

A blank line after this mas_state_walk() function would help the formatting.

> +/*
> + * mtree_lookup_walk() - Internal quick lookup that does not keep maple state up
> + * to date.
> + *
> + * @mas: The maple state.
> + *
> + * Note: Leaves mas in undesirable state.
> + * Return: The entry for @mas->index or %NULL on dead node.
> + */
> +static inline void *mtree_lookup_walk(struct ma_state *mas)
...

> +/**
> + * mt_prev() - get the previous value in the maple tree
> + * @mt: The maple tree
> + * @index: The start index
> + * @min: The minumum index to check

s/minumum/minimum/
...

> +/**
> + * mas_nomem() - Check if there was an error allocating and do the allocation
> + * if necessary If there are allocations, then free them.
> + * @mas: The maple state
> + * @gfp: The GFP_FALGS to use for allocations

s/GFP_FALGS/GFP_FLAGS/
...

> +/**
> + * mtree_insert_range() - Insert an entry at a give range if there is no value.
> + * @mt: The maple tree
> + * @first: The start of the range
> + * @last: The end of the range
> + * @entry: The entry to store
> + * @gfp: The FGP_FLAGS to use for allocations.

s/FGP_FLAGS/GFP_FLAGS/
...

Cheers,
Mark
