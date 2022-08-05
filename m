Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A164258AAA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbiHEMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiHEMSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64F83E00D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659701879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOHdOlusLImHqeSrvcvuEjySBTnIFF6YxV9UFOMchZA=;
        b=hqGRPk2sc7nhXiUxtvUhdo85Vg7edmC/eaaF9N+ZqsmxLmK8lzO71mNIvQcPfB+TsdhIvP
        j7l4qt5cnN5zUVqmDCKOmiTZIJ2dfJzd4D+8ZZhkYLSxmk7Q7lU4GnZsSj23Hw3WidapBT
        HSmIOD/WG1Tk9llIaFdC2Gq302991SU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-dhpQacC9OwGGA5M0qk_6Gg-1; Fri, 05 Aug 2022 08:17:58 -0400
X-MC-Unique: dhpQacC9OwGGA5M0qk_6Gg-1
Received: by mail-wm1-f69.google.com with SMTP id h133-20020a1c218b000000b003a4f57eaeaaso1208761wmh.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kOHdOlusLImHqeSrvcvuEjySBTnIFF6YxV9UFOMchZA=;
        b=fRjVUZORFUEcdSOKiEg4GVakrAVFbttKvzTYTvX+mdBb8vn5cnojssbgLD4F65dPJW
         fQWF/JUj7TZNTAlE33a47GuIl1jOXDXFqPatP/sM0fVmPoakVQ4sYXSTZdnJqOreNf93
         XZUi0w7A5TgQwfQgI9djuGQsvcigLY6wfe0/eL7wnot1DOF4jn1PeV/hs+dlJdu1q6mI
         OYBuowB+zG9Mb1ERK+VGMIfnpme84vEcS2FKixE6E4r6WnvD17ZPbTUgvrkv8CrQbIm0
         XAdrSqwj4DmyDuK8lnsPxERdKnBhhS5e5S+zU+uMurorGHkOLFlP9iLzLnxNuZc+YFeF
         HI0A==
X-Gm-Message-State: ACgBeo0O9IMf6uxdB0IsrbJ2EQOJZjZvUW/6lDriLtgzd9MLnVMrunOB
        7ycE6H56kB3Uuppe8LjIKqt+lfopbbLZ3RRZVVpNdp4PDpqAV0t0fzE96wjRTWjFMpzPBMC9YXg
        eDMczOF7Gh2HeY+Ic6+NiU6Yn
X-Received: by 2002:a5d:6c64:0:b0:21e:f5bb:e00d with SMTP id r4-20020a5d6c64000000b0021ef5bbe00dmr3954674wrz.521.1659701876872;
        Fri, 05 Aug 2022 05:17:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR659tX52h3jfMegC9JVmztcb3U2Z0AFJbAbn5HDCgNOYs4FSFOHSrD0DFs1CDg4sqPcqMp8kA==
X-Received: by 2002:a5d:6c64:0:b0:21e:f5bb:e00d with SMTP id r4-20020a5d6c64000000b0021ef5bbe00dmr3954657wrz.521.1659701876558;
        Fri, 05 Aug 2022 05:17:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003a2cf1535aasm4644811wmb.17.2022.08.05.05.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 05:17:56 -0700 (PDT)
Message-ID: <62d52657-12d2-8563-4ead-027480065d9f@redhat.com>
Date:   Fri, 5 Aug 2022 14:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220804203952.53665-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.22 22:39, Peter Xu wrote:
> When page migration happens, we always ignore the young/dirty bit settings
> in the old pgtable, and marking the page as old in the new page table using
> either pte_mkold() or pmd_mkold(), and keeping the pte clean.
> 
> That's fine from functional-wise, but that's not friendly to page reclaim
> because the moving page can be actively accessed within the procedure.  Not
> to mention hardware setting the young bit can bring quite some overhead on
> some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
> The same slowdown problem to dirty bits when the memory is first written
> after page migration happened.
> 
> Actually we can easily remember the A/D bit configuration and recover the
> information after the page is migrated.  To achieve it, define a new set of
> bits in the migration swap offset field to cache the A/D bits for old pte.
> Then when removing/recovering the migration entry, we can recover the A/D
> bits even if the page changed.
> 
> One thing to mention is that here we used max_swapfile_size() to detect how
> many swp offset bits we have, and we'll only enable this feature if we know
> the swp offset can be big enough to store both the PFN value and the young
> bit.  Otherwise the A/D bits are dropped like before.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/swapops.h | 91 +++++++++++++++++++++++++++++++++++++++++
>  mm/huge_memory.c        | 26 +++++++++++-
>  mm/migrate.c            |  6 ++-
>  mm/migrate_device.c     |  4 ++
>  mm/rmap.c               |  5 ++-
>  5 files changed, 128 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 1d17e4bb3d2f..34aa448ac6ee 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -8,6 +8,8 @@
>  
>  #ifdef CONFIG_MMU
>  
> +#include <linux/swapfile.h>
> +
>  /*
>   * swapcache pages are stored in the swapper_space radix tree.  We want to
>   * get good packing density in that tree, so the index should be dense in
> @@ -35,6 +37,24 @@
>  #endif
>  #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
>  
> +/**
> + * Migration swap entry specific bitfield definitions.
> + *
> + * @SWP_MIG_YOUNG_BIT: Whether the page used to have young bit set
> + * @SWP_MIG_DIRTY_BIT: Whether the page used to have dirty bit set
> + *
> + * Note: these bits will be stored in migration entries iff there're enough
> + * free bits in arch specific swp offset.  By default we'll ignore A/D bits
> + * when migrating a page.  Please refer to migration_entry_supports_ad()
> + * for more information.
> + */
> +#define SWP_MIG_YOUNG_BIT		(SWP_PFN_BITS)
> +#define SWP_MIG_DIRTY_BIT		(SWP_PFN_BITS + 1)
> +#define SWP_MIG_TOTAL_BITS		(SWP_PFN_BITS + 2)
> +
> +#define SWP_MIG_YOUNG			(1UL << SWP_MIG_YOUNG_BIT)
> +#define SWP_MIG_DIRTY			(1UL << SWP_MIG_DIRTY_BIT)
> +
>  static inline bool is_pfn_swap_entry(swp_entry_t entry);
>  
>  /* Clear all flags but only keep swp_entry_t related information */
> @@ -265,6 +285,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>  	return swp_entry(SWP_MIGRATION_WRITE, offset);
>  }
>  
> +/*
> + * Returns whether the host has large enough swap offset field to support
> + * carrying over pgtable A/D bits for page migrations.  The result is
> + * pretty much arch specific.
> + */
> +static inline bool migration_entry_supports_ad(void)
> +{
> +	/*
> +	 * max_swapfile_size() returns the max supported swp-offset plus 1.
> +	 * We can support the migration A/D bits iff the pfn swap entry has
> +	 * the offset large enough to cover all of them (PFN, A & D bits).
> +	 */
> +#ifdef CONFIG_SWAP
> +	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
> +#else
> +	return false;
> +#endif
> +}


This looks much cleaner to me. It might be helpful to draw an ascii
picture where exatcly these bits reside isnide the offset.

> +
> +static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
> +{
> +	if (migration_entry_supports_ad())

Do we maybe want to turn that into a static key and enable it once and
for all? As Nadav says, the repeated max_swapfile_size() calls/checks
might be worth optimizing out.

[...]


-- 
Thanks,

David / dhildenb

