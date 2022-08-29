Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DDB5A54C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiH2Tvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiH2Tvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF267F093
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF2F60B3D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C33C433D6;
        Mon, 29 Aug 2022 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661802696;
        bh=3VYkqk3VFoG/vKpioLycubxC4ZQf50jtJOntBowpvHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h300GN4ysd1qtqvDuwLs8vadtrSoMxdUQ4dAmbqIe8JPsydXnOnUmq8tauBPf2iNm
         LyArQsObh3c3iJJ3AOQDyZuboV5ZTuAAr2jiP4tLLC+H1oHftJM+dd8r2Rxlf/WPdj
         CkfqKO7MQJjL5EDK4UC67LM9C6BMBe/3hRPi/990=
Date:   Mon, 29 Aug 2022 12:51:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm: introduce common struct mm_slot
Message-Id: <20220829125134.9b05f9b8caf5da4bec8f31e8@linux-foundation.org>
In-Reply-To: <20220829143055.41201-2-zhengqi.arch@bytedance.com>
References: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
        <20220829143055.41201-2-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 22:30:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> At present, both THP and KSM module have similar structures
> mm_slot for organizing and recording the information required
> for scanning mm, and each defines the following exactly the
> same operation functions:
> 
>  - alloc_mm_slot
>  - free_mm_slot
>  - get_mm_slot
>  - insert_to_mm_slots_hash
> 
> In order to de-duplicate these codes, this patch introduces a
> common struct mm_slot, and subsequent patches will let THP and
> KSM to use it.

Seems like a good idea.

> --- /dev/null
> +++ b/mm/mm_slot.h
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef _LINUX_MM_SLOT_H
> +#define _LINUX_MM_SLOT_H
> +
> +#include <linux/hashtable.h>
> +#include <linux/slab.h>
> +
> +/*
> + * struct mm_slot - hash lookup from mm to mm_slot
> + * @hash: link to the mm_slots hash list
> + * @mm_node: link into the mm_slots list
> + * @mm: the mm that this information is valid for
> + */
> +struct mm_slot {
> +	struct hlist_node hash;
> +	struct list_head mm_node;
> +	struct mm_struct *mm;
> +};

It appears that the presence of an mm_struct in the hash list does not
contribute to the mm_struct's refcount?  That's somewhat unexpected.

It would be helpful to add some words here describing the means by
which a user of mm_slot would prevent the mm_struct from getting freed
while on the list.  I assume "caller must maintain a reference on the
mm_struct while it remains on an mm_slot hash list"?

> +#define mm_slot_entry(ptr, type, member) \
> +	container_of(ptr, type, member)
> +
> +static inline void *alloc_mm_slot(struct kmem_cache *cache)
> +{
> +	if (!cache)	/* initialization failed */
> +		return NULL;
> +	return kmem_cache_zalloc(cache, GFP_KERNEL);
> +}
> +
> +static inline void free_mm_slot(struct kmem_cache *cache, void *objp)
> +{
> +	kmem_cache_free(cache, objp);
> +}
> +
> +#define get_mm_slot(_hashtable, _mm)					       \
> +({									       \
> +	struct mm_slot *tmp_slot, *mm_slot = NULL;			       \
> +									       \
> +	hash_for_each_possible(_hashtable, tmp_slot, hash, (unsigned long)_mm) \
> +		if (_mm == tmp_slot->mm) {				       \
> +			mm_slot = tmp_slot;				       \
> +			break;						       \
> +		}							       \
> +									       \
> +	mm_slot;							       \
> +})

Is there a reason why this must be implemented as a macro?  That's
preferable, although this may be overly large for inlining.  mm/util.c
might suit.

> +#define insert_to_mm_slots_hash(_hashtable, _mm, _mm_slot)		       \
> +({									       \
> +	_mm_slot->mm = _mm;						       \
> +	hash_add(_hashtable, &_mm_slot->hash, (unsigned long)_mm);	       \
> +})

Does this need to be a macro?


And the naming.  Can we please have

mm_slot_entry
mm_slot_alloc
mm_slot_free
mm_slot_get
mm_slot_insert

Also, "get" usually implies that a refcout is taken on the obtained
object, so mm_slot_lookup() would be more appropriate.
