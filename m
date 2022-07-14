Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49975575632
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiGNULj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:11:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5140BFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:11:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70730343FF;
        Thu, 14 Jul 2022 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657829493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIDt4rkHsUXMqTwG/QaCdabF1B+zDGKtR9vTg+yf6Z8=;
        b=fFOAPTetuEG+gGwMqjs0Ri17Qwpb8DHaOyKa6lTwxS3ChJ0rNoI6c9yYHM2np8Z92fTqli
        Lu2dMhSOsiqsgqp6iL1fwufsS9/VsX0Ivdg5SYskjYOI0hkkbz/PJtGQwXyvqf0493vyXe
        wrbGW0opEpfAxJ5qWnMD3mGHFNUZrxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657829493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIDt4rkHsUXMqTwG/QaCdabF1B+zDGKtR9vTg+yf6Z8=;
        b=cTgCTSb5FcLPyIYjmgvz1nhf0+SCQV/1tEbZ8zppQQuxQfU2eYvwqQxoRCyFO2ftSJkCeJ
        NHWYkw7YlQe3SuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C85913A61;
        Thu, 14 Jul 2022 20:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8h4eDnV40GIaMwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Jul 2022 20:11:33 +0000
Message-ID: <45906408-34ce-4b79-fbe4-768335ffbf96@suse.cz>
Date:   Thu, 14 Jul 2022 22:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <41763154-f923-ae99-55c0-0f3717636779@suse.cz>
 <20220713073642.GA69088@shbuild999.sh.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220713073642.GA69088@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 09:36, Feng Tang wrote:
> Hi Vlastimil,
> 
> On Mon, Jul 11, 2022 at 10:15:21AM +0200, Vlastimil Babka wrote:
>> On 7/1/22 15:59, Feng Tang wrote:
>> > kmalloc's API family is critical for mm, with one shortcoming that
>> > its object size is fixed to be power of 2. When user requests memory
>> > for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
>> > in worst case, there is around 50% memory space waste.
>> > 
>> > We've met a kernel boot OOM panic (v5.10), and from the dumped slab info:
>> > 
>> >     [   26.062145] kmalloc-2k            814056KB     814056KB
>> > 
>> > From debug we found there are huge number of 'struct iova_magazine',
>> > whose size is 1032 bytes (1024 + 8), so each allocation will waste
>> > 1016 bytes. Though the issue was solved by giving the right (bigger)
>> > size of RAM, it is still nice to optimize the size (either use a
>> > kmalloc friendly size or create a dedicated slab for it).
> [...]
>> 
>> Hi and thanks.
>> I would suggest some improvements to consider:
>> 
>> - don't use the struct track to store orig_size, although it's an obvious
>> first choice. It's unused waste for the free_track, and also for any
>> non-kmalloc caches. I'd carve out an extra int next to the struct tracks.
>> Only for kmalloc caches (probably a new kmem cache flag set on creation will
>> be needed to easily distinguish them).
>> Besides the saved space, you can then set the field from ___slab_alloc()
>> directly and not need to pass the orig_size also to alloc_debug_processing()
>> etc.
>  
> Here is a draft patch fowlling your suggestion, please check if I missed
> anything? (Quick test showed it achived similar effect as v1 patch). Thanks!

Thanks, overal it looks at first glance!

> ---
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0fefdf528e0d..d3dacb0f013f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -29,6 +29,8 @@
>  #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
>  /* DEBUG: Poison objects */
>  #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
> +/* Indicate a slab of kmalloc */

"Indicate a kmalloc cache" would be more precise.

> +#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
>  /* Align objs on cache lines */
>  #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
>  /* Use GFP_DMA memory */
> diff --git a/mm/slub.c b/mm/slub.c
> index 26b00951aad1..3b0f80927817 100644

<snip>

> 
>> - the knowledge of actual size could be used to improve poisoning checks as
>> well, detect cases when there's buffer overrun over the orig_size but not
>> cache's size. e.g. if you kmalloc(48) and overrun up to 64 we won't detect
>> it now, but with orig_size stored we could?
> 
> The above patch doesn't touch this. As I have a question, for the
> [orib_size, object_size) area, shall we fill it with POISON_XXX no matter
> REDZONE flag is set or not?

Ah, looks like we use redzoning, not poisoning, for padding from
s->object_size to word boundary. So it would be more consistent to use the
redzone pattern (RED_ACTIVE) and check with the dynamic orig_size. Probably
no change for RED_INACTIVE handling is needed though.

> Thanks,
> Feng
> 
>> Thanks!
>> Vlastimil

