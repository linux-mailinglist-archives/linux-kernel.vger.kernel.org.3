Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4760558F13B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiHJRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiHJRKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6F5078BFE
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660151398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nqhyggpe6XCtIwWAg9ZL+8LA2Yq47qLEz8joLIyWGk=;
        b=AyNwEjpKyVHt7V+eoG/7x5gpNtK77Bo6N5mn4ppkj8o1Z0eiXAwhOSftccQc7oJ9L9UJn8
        TtCFkUBjdVgwjrbvEb+OADmxU2hRd+tncHG03u3rKW1Orfagq11ebnve1oz8023RCGlDws
        QLCB4ZD8VlRuH3ye1JneTSFqbNBKnJA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-jrur-WIwP_qk1fAPDTjEuA-1; Wed, 10 Aug 2022 13:09:57 -0400
X-MC-Unique: jrur-WIwP_qk1fAPDTjEuA-1
Received: by mail-il1-f197.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso10967376ilk.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/nqhyggpe6XCtIwWAg9ZL+8LA2Yq47qLEz8joLIyWGk=;
        b=MbbAAw4jreKaUJESXZmHS1aGaHXGQ9A/dS45ZYLFX9I+1wgfnlkrmWkG9/9jw6PPft
         NTsCwEGDmeJGHxfENW5XvaJNysQ9QxKhxEyURLNJnsAaW/KbgJoo+mnqcdhBhNcPVo/E
         PVs7YRmoQlHAahtgE3W+iA/O3+rMmVzsBEm17fdtfflC9Z0J3BOtyKc6uMqb8arn/tif
         5SAZeDildKil+HHjUAlWWHppFa6fLEvXxm1ghwK1LkyCpcHHLqhPZPhcCzHtvJFNjoro
         Gmw1ZsgYq3EROM1xO48sLqhAY5EapugqWiLd6hDTP14QNxyGnXOxudHO0kidRgIUdujt
         KxKQ==
X-Gm-Message-State: ACgBeo2B8EeNul41WNc4H3ie0pRnJQw3REk1pmBp8DUAJ9mRYK73Vbi5
        tZSgLoYVhDbpYpLKwJdlKKSzMKHh/VxxZKInRsaXyJthyc8TYR0PRanGT09RemC7V6h0v0Eem5p
        LfahzzWn+E5aS//1X9tisH5gQ
X-Received: by 2002:a5d:87d7:0:b0:680:651d:fd5a with SMTP id q23-20020a5d87d7000000b00680651dfd5amr12129531ios.145.1660151396671;
        Wed, 10 Aug 2022 10:09:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR79pXZsjRY8UcBeEs22hOBGTnRl2wWH/Q7ZJLepDiKnp6XFZcVzTizVMrYu/sfYtIxflRpxlA==
X-Received: by 2002:a5d:87d7:0:b0:680:651d:fd5a with SMTP id q23-20020a5d87d7000000b00680651dfd5amr12129523ios.145.1660151396413;
        Wed, 10 Aug 2022 10:09:56 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id z26-20020a056638215a00b00342847fc497sm7586643jaj.8.2022.08.10.10.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 10:09:56 -0700 (PDT)
Date:   Wed, 10 Aug 2022 13:09:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 7/7] mm/swap: Cache swap migration A/D bits support
Message-ID: <YvPmYnxmHCxNvPtH@xz-m1.local>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-8-peterx@redhat.com>
 <87tu6keh8r.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tu6keh8r.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:37:40PM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Introduce a variable swap_migration_ad_supported to cache whether the arch
> > supports swap migration A/D bits.
> >
> > Here one thing to mention is that SWP_MIG_TOTAL_BITS will internally
> > reference the other macro MAX_PHYSMEM_BITS, which is a function call on
> > x86 (constant on all the rest of archs).
> >
> > It's safe to reference it in swapfile_init() because when reaching here
> > we're already during initcalls level 4 so we must have initialized 5-level
> > pgtable for x86_64 (right after early_identify_cpu() finishes).
> >
> > - start_kernel
> >   - setup_arch
> >     - early_cpu_init
> >       - get_cpu_cap --> fetch from CPUID (including X86_FEATURE_LA57)
> >       - early_identify_cpu --> clear X86_FEATURE_LA57 (if early lvl5 not enabled (USE_EARLY_PGTABLE_L5))
> >   - arch_call_rest_init
> >     - rest_init
> >       - kernel_init
> >         - kernel_init_freeable
> >           - do_basic_setup
> >             - do_initcalls --> calls swapfile_init() (initcall level 4)
> >
> > This should slightly speed up the migration swap entry handlings.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/swapfile.h | 1 +
> >  include/linux/swapops.h  | 7 +------
> >  mm/swapfile.c            | 8 ++++++++
> >  3 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
> > index 54078542134c..87ec5e2cdb02 100644
> > --- a/include/linux/swapfile.h
> > +++ b/include/linux/swapfile.h
> > @@ -9,5 +9,6 @@
> >  extern struct swap_info_struct *swap_info[];
> >  extern unsigned long generic_max_swapfile_size(void);
> >  extern unsigned long max_swapfile_size(void);
> > +extern bool swap_migration_ad_supported;
> >  
> >  #endif /* _LINUX_SWAPFILE_H */
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index 0e9579b90659..e6afc77c51ad 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -301,13 +301,8 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
> >   */
> >  static inline bool migration_entry_supports_ad(void)
> >  {
> > -	/*
> > -	 * max_swapfile_size() returns the max supported swp-offset plus 1.
> > -	 * We can support the migration A/D bits iff the pfn swap entry has
> > -	 * the offset large enough to cover all of them (PFN, A & D bits).
> > -	 */
> >  #ifdef CONFIG_SWAP
> > -	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
> > +	return swap_migration_ad_supported;
> >  #else  /* CONFIG_SWAP */
> >  	return false;
> >  #endif	/* CONFIG_SWAP */
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 794fa37bd0c3..c49cf25f0d08 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -64,6 +64,9 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
> >  long total_swap_pages;
> >  static int least_priority = -1;
> >  static unsigned long swapfile_maximum_size;
> > +#ifdef CONFIG_MIGRATION
> > +bool swap_migration_ad_supported;
> > +#endif	/* CONFIG_MIGRATION */
> >  
> >  static const char Bad_file[] = "Bad swap file entry ";
> >  static const char Unused_file[] = "Unused swap file entry ";
> > @@ -3685,6 +3688,11 @@ static int __init swapfile_init(void)
> >  
> >  	swapfile_maximum_size = arch_max_swapfile_size();
> >  
> > +#ifdef CONFIG_MIGRATION
> > +	if (swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS))
> > +		swap_migration_ad_supported = true;
> > +#endif	/* CONFIG_MIGRATION */
> > +
> >  	return 0;
> >  }
> >  subsys_initcall(swapfile_init);
> 
> I don't think it's necessary to add a variable for such a simple
> function and it's not a super hot path.  But I don't have strong
> opinions here.

Logically referencing SWP_MIG_TOTAL_BITS needs to go check
MAX_PHYSMEM_BITS, which should further go with:

# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)

Then since swapfile.c doesn't have USE_EARLY_PGTABLE_L5 defined..

#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)

Then,

#define cpu_feature_enabled(bit)	\
	(__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))

I think LA57 shouldn't be in DISABLED_MASK_BIT_SET() at all, in our case
the relevant disable mask is:

#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
			 DISABLE_ENQCMD)

Here we should have:

#ifdef CONFIG_X86_5LEVEL
# define DISABLE_LA57	0
#else
# define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
#endif

So DISABLE_LA57 should be 0 when 5level enabled (true in my case).  Then we
really should land at static_cpu_has().

I checked up the code generated and surprisingly it's fairly fast indeed:

   (after fetching swapfile_maximum_size() and put into %rax, I'll change
    that into a variable soon..)
   0xffffffff83932e41 <+185>:   mov    $0x1,%edx
   0xffffffff83932e46 <+190>:   shl    $0x24,%rdx
   0xffffffff83932e4a <+194>:   xor    %r8d,%r8d
   0xffffffff83932e4d <+197>:   cmp    %rdx,%rax
   0xffffffff83932e50 <+200>:   jb     0xffffffff83932e59 <swapfile_init+209>
   0xffffffff83932e52 <+202>:   movb   $0x1,0xeab897(%rip)        # 0xffffffff847de6f0 <swap_migration_ad_supported>
   0xffffffff83932e59 <+209>:   mov    %r8d,%eax

Obviously on my testing host SWP_MIG_TOTAL_BITS is directly set as $0x24
(which reflects a 4-level pgtable) but frankly I cannot tell how it did
that without checking boot cpu x86_capabilities flags..  I'm pretty sure my
kernel config has CONFIG_X86_5LEVEL=y.

It'll be great if anyone already notices why it can be optimized into a
constant, but even if so I'm not confident that'll be a constant for all
the hosts and whether static_cpu_has() will still consume some insns.

Since the change is fairly simple after previous patch, I think it'll be
nice to keep it too.

Thanks,

-- 
Peter Xu

