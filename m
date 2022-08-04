Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D658A355
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiHDWlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiHDWlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:41:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A525C64
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:41:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so6308860pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vDHjZ8yszXNqAT8oVMtZut5RsvFWrYQzXv0LVo98SfY=;
        b=h42pxwa3xB/ENcIaxWfpk/OWlmx42M3Sm+YneiVTKr3d3KlVDh9gfH17Ck0Vfjo6Qw
         ZEcLOs6fdJy9jK/UVJCghT0+NAc2nXRd/HxaYMACTCeMt4GcsUJp80qtDubvo+Ywsxp7
         G2vXxCkEqgpCzPKtE8aKoZTO7vO/soj6nCz/SlBp30FPLcQzOpqaRe4L4gyJCM50MRwL
         zrj3dhivb5ssVlIWw2dKALONwjEBkuOVFyqH0DmMmNXxSmVy4VdFMxiQbDARW5Exgrik
         AoBL2Rf8OeDf+dkK7i83ozcMDccjsMgIheTVPSIj0UcugFnw4TidB0Gqy/GpdmUJN/rp
         0H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vDHjZ8yszXNqAT8oVMtZut5RsvFWrYQzXv0LVo98SfY=;
        b=6ErPjyfB5uiIFPgvrdfLorUEYMH+eFatCAzzKRiKIVtNLSaxZFsG1iggmugKn/X+XT
         CcnrRbRDGMZOioHTS8DzL/FFWvlulHWiOcilk2+I2eoYLIUVBTcil/qVe17BsgZwk0Wa
         AbtAXlI3rB6dPj7yBqUADKryhL3zbD6Ky/WOyvvEOjB388g3Qpyp6uN+JiPk6Qs87Zof
         CJvVq52CTVveH6fp97KruCSRXnDv/wa5YLZM19YbUlBB3gO836z0F0yWaga7QPlsgv7C
         2sq2kSRrlvxWPbHwqo9i2Rec9C3HRR8NZXNGy4MiXcZC4KpmpiXsMjXSpXtoIJpih1HZ
         AIWw==
X-Gm-Message-State: ACgBeo3+ZpTC5pgCIevP5V6kB6+BoZgUZgIBHLGQtsL07zD+auumaV4d
        ZRfniSK5iJrk0EmovIIA+5k=
X-Google-Smtp-Source: AA6agR62j2FHRodNlGZy4e3m/e5MAug8zgPO3TQ/EjrVhRU/nDxTyZMvLisaJp62NO28+9rrAFKtUg==
X-Received: by 2002:a17:90b:1110:b0:1f4:fc9a:be2d with SMTP id gi16-20020a17090b111000b001f4fc9abe2dmr12614588pjb.41.1659652860291;
        Thu, 04 Aug 2022 15:41:00 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id o15-20020a634e4f000000b0041bb35b9e80sm344726pgl.53.2022.08.04.15.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 15:40:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220804203952.53665-3-peterx@redhat.com>
Date:   Thu, 4 Aug 2022 15:40:57 -0700
Cc:     Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A84CB6A0-86C8-4CAB-A977-47495D877C31@gmail.com>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 4, 2022, at 1:39 PM, Peter Xu <peterx@redhat.com> wrote:

> When page migration happens, we always ignore the young/dirty bit =
settings
> in the old pgtable, and marking the page as old in the new page table =
using
> either pte_mkold() or pmd_mkold(), and keeping the pte clean.
>=20
> That's fine from functional-wise, but that's not friendly to page =
reclaim
> because the moving page can be actively accessed within the procedure. =
 Not
> to mention hardware setting the young bit can bring quite some =
overhead on
> some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the =
bit.
> The same slowdown problem to dirty bits when the memory is first =
written
> after page migration happened.
>=20
> Actually we can easily remember the A/D bit configuration and recover =
the
> information after the page is migrated.  To achieve it, define a new =
set of
> bits in the migration swap offset field to cache the A/D bits for old =
pte.
> Then when removing/recovering the migration entry, we can recover the =
A/D
> bits even if the page changed.
>=20
> One thing to mention is that here we used max_swapfile_size() to =
detect how
> many swp offset bits we have, and we'll only enable this feature if we =
know
> the swp offset can be big enough to store both the PFN value and the =
young
> bit.  Otherwise the A/D bits are dropped like before.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> include/linux/swapops.h | 91 +++++++++++++++++++++++++++++++++++++++++
> mm/huge_memory.c        | 26 +++++++++++-
> mm/migrate.c            |  6 ++-
> mm/migrate_device.c     |  4 ++
> mm/rmap.c               |  5 ++-
> 5 files changed, 128 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 1d17e4bb3d2f..34aa448ac6ee 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -8,6 +8,8 @@
>=20
> #ifdef CONFIG_MMU
>=20
> +#include <linux/swapfile.h>

Shouldn=E2=80=99t the ifdef go into linux/swapfile.h if that=E2=80=99s =
the right thing to do
to prevent others from mistakenly including it?

> +
> /*
>  * swapcache pages are stored in the swapper_space radix tree.  We =
want to
>  * get good packing density in that tree, so the index should be dense =
in
> @@ -35,6 +37,24 @@
> #endif
> #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
>=20
> +/**
> + * Migration swap entry specific bitfield definitions.
> + *
> + * @SWP_MIG_YOUNG_BIT: Whether the page used to have young bit set
> + * @SWP_MIG_DIRTY_BIT: Whether the page used to have dirty bit set
> + *
> + * Note: these bits will be stored in migration entries iff there're =
enough
> + * free bits in arch specific swp offset.  By default we'll ignore =
A/D bits
> + * when migrating a page.  Please refer to =
migration_entry_supports_ad()
> + * for more information.
> + */
> +#define SWP_MIG_YOUNG_BIT		(SWP_PFN_BITS)
> +#define SWP_MIG_DIRTY_BIT		(SWP_PFN_BITS + 1)
> +#define SWP_MIG_TOTAL_BITS		(SWP_PFN_BITS + 2)
> +
> +#define SWP_MIG_YOUNG			(1UL << =
SWP_MIG_YOUNG_BIT)
> +#define SWP_MIG_DIRTY			(1UL << =
SWP_MIG_DIRTY_BIT)

Any reason not to use BIT(x) ?

> +
> static inline bool is_pfn_swap_entry(swp_entry_t entry);
>=20
> /* Clear all flags but only keep swp_entry_t related information */
> @@ -265,6 +285,57 @@ static inline swp_entry_t =
make_writable_migration_entry(pgoff_t offset)
> 	return swp_entry(SWP_MIGRATION_WRITE, offset);
> }
>=20
> +/*
> + * Returns whether the host has large enough swap offset field to =
support
> + * carrying over pgtable A/D bits for page migrations.  The result is
> + * pretty much arch specific.
> + */
> +static inline bool migration_entry_supports_ad(void)
> +{
> +	/*
> +	 * max_swapfile_size() returns the max supported swp-offset plus =
1.
> +	 * We can support the migration A/D bits iff the pfn swap entry =
has
> +	 * the offset large enough to cover all of them (PFN, A & D =
bits).
> +	 */
> +#ifdef CONFIG_SWAP
> +	return max_swapfile_size() >=3D (1UL << SWP_MIG_TOTAL_BITS);

This is an actual a function call (unless LTO has some trick). A bit of =
a
shame it cannot be at least memoized.

Or at least mark max_swapfile_size() as __attribute_const__ so it would =
not
be called twice for make_migration_entry_young() and
make_migration_entry_dirty().

> +#else
> +	return false;
> +#endif
> +}
> +
> +static inline swp_entry_t make_migration_entry_young(swp_entry_t =
entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_entry(swp_type(entry),
> +				 swp_offset(entry) | SWP_MIG_YOUNG);
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_young(swp_entry_t entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_offset(entry) & SWP_MIG_YOUNG;
> +	/* Keep the old behavior of aging page after migration */
> +	return false;
> +}
> +
> +static inline swp_entry_t make_migration_entry_dirty(swp_entry_t =
entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_entry(swp_type(entry),
> +				 swp_offset(entry) | SWP_MIG_DIRTY);
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_dirty(swp_entry_t entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_offset(entry) & SWP_MIG_YOUNG_BIT;

Shouldn=E2=80=99t it be SWP_MIG_DIRTY ?

> +	/* Keep the old behavior of clean page after migration */
> +	return false;
> +}
> +
> extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> 					spinlock_t *ptl);
> extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
> @@ -311,6 +382,26 @@ static inline int =
is_readable_migration_entry(swp_entry_t entry)
> 	return 0;
> }
>=20
> +static inline swp_entry_t make_migration_entry_young(swp_entry_t =
entry)
> +{
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_young(swp_entry_t entry)
> +{
> +	return false;
> +}
> +
> +static inline swp_entry_t make_migration_entry_dirty(swp_entry_t =
entry)
> +{
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_dirty(swp_entry_t entry)
> +{
> +	return false;
> +}
> +
> #endif

While at it, can you change to:

#endif /* CONFIG_MIGRATION */

[ these ifdefs burn my eyes ]

Other than that looks good.

Thanks,
Nadav


