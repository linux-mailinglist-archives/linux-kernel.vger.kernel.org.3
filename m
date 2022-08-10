Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4AE58ED0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiHJNXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiHJNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4495F2BB01
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660137798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHiMxplfNJQ6RhacgZ+xBSTgZSfx+YMHv5xB6BH8Lo8=;
        b=bnfUjL5GWi+ATacUETn7sKzkNjke2FwhB3DXnYtbJ/ByjJEDXtwL5gJiym4ZjwMzHsgNsr
        +WLyzwSltFWRJFDJoyrMUQgKCytRgV5s5E+B01MatY7DvAyRMFsEaBzAD1pVVML1g8NW0M
        bXOxKX659bVLa76T07c0reWR6p9knVI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-jz-fbHO4NhKxyM2h8yew9w-1; Wed, 10 Aug 2022 09:23:17 -0400
X-MC-Unique: jz-fbHO4NhKxyM2h8yew9w-1
Received: by mail-io1-f69.google.com with SMTP id o23-20020a056602225700b0068002601976so8003723ioo.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UHiMxplfNJQ6RhacgZ+xBSTgZSfx+YMHv5xB6BH8Lo8=;
        b=yoZOi+iFlEEmb3dpDMs70FXqUBuK5uW3C49e+w8nKNRZ5md9AA1LE6+8D/9sJLqXPG
         7Dm2VMHus8CgWJAMW9TJxDNoHdV4Er4sz0xDyB/Dcf37Eq2/ANhaDOmO34hmwrBTs5zT
         CHz4cz3r/XH7kmsykxsGNgBNyIkFG2YlqtIDdN6+dJ5QtRe/KWhBgdr/XbbbuvoMxuYv
         gjQeXoc3/rE5KvsxtKPVJ/SPav6RnWM4aEI+mSl/XGdm8Pb0rmmPepSvI5RStKXK1nps
         cjk6jkS3hnED7M2gTigr6pQbj/5F3fMbojSgcElJ5Ko+yq9kw2aQ3V/zS9Jlv6ViqCaK
         gJtg==
X-Gm-Message-State: ACgBeo3MpHL8ar04VJJ8a0eigW4UiL1jNuEf8SVO3lmvEE50gHYJR6Rz
        65+pXUri7CcP/MeiOMeexCgDAr6MEiyZNlMn5VqLdtrDa/wp4K8ZSN1zmk7+CYvLNZYHatg/Y0O
        CafSgMcTjGMe/Sci7PbPy/EF4
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr12270743ilm.310.1660137796529;
        Wed, 10 Aug 2022 06:23:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4CFc0fNM1RWLMb7NxUuoRwLTkzJPTVqhqiOzuypVus+LgkAyKMstesr/EDCaOwx4Fr4WdnaA==
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr12270727ilm.310.1660137796239;
        Wed, 10 Aug 2022 06:23:16 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id o16-20020a0566022e1000b0067bcb28e036sm2314721iow.49.2022.08.10.06.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:23:15 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:23:14 -0400
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
Subject: Re: [PATCH v3 6/7] mm/swap: Cache maximum swapfile size when init
 swap
Message-ID: <YvOxQgf6oqxq66Ob@xz-m1.local>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-7-peterx@redhat.com>
 <87y1vwehgh.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1vwehgh.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:33:02PM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > We used to have swapfile_maximum_size() fetching a maximum value of
> > swapfile size per-arch.
> >
> > As the caller of max_swapfile_size() grows, this patch introduce a variable
> > "swapfile_maximum_size" and cache the value of old max_swapfile_size(), so
> > that we don't need to calculate the value every time.
> >
> > Caching the value in swapfile_init() is safe because when reaching the
> > phase we should have initialized all the relevant information.  Here the
> > major arch to look after is x86, which defines the max size based on L1TF
> > mitigation.
> >
> > Here both X86_BUG_L1TF or l1tf_mitigation should have been setup properly
> > when reaching swapfile_init(). As a reference, the code path looks like
> > this for x86:
> >
> > - start_kernel
> >   - setup_arch
> >     - early_cpu_init
> >       - early_identify_cpu --> setup X86_BUG_L1TF
> >   - parse_early_param
> >     - l1tf_cmdline --> set l1tf_mitigation
> >   - check_bugs
> >     - l1tf_select_mitigation --> set l1tf_mitigation
> >   - arch_call_rest_init
> >     - rest_init
> >       - kernel_init
> >         - kernel_init_freeable
> >           - do_basic_setup
> >             - do_initcalls --> calls swapfile_init() (initcall level 4)
> >
> > The swapfile size only depends on swp pte format on non-x86 archs, so
> > caching it is safe too.
> >
> > Since at it, rename max_swapfile_size() to arch_max_swapfile_size() because
> > arch can define its own function, so it's more straightforward to have
> > "arch_" as its prefix.  At the meantime, keep the swapfile_maximum_size()
> > function to fetch the value from the cache initialized in swapfile_init().
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/x86/mm/init.c |  2 +-
> >  mm/swapfile.c      | 10 +++++++++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index 82a042c03824..9121bc1b9453 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -1054,7 +1054,7 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
> >  }
> >  
> >  #ifdef CONFIG_SWAP
> > -unsigned long max_swapfile_size(void)
> > +unsigned long arch_max_swapfile_size(void)
> >  {
> >  	unsigned long pages;
> >  
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 1fdccd2f1422..794fa37bd0c3 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -63,6 +63,7 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
> >  /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
> >  long total_swap_pages;
> >  static int least_priority = -1;
> > +static unsigned long swapfile_maximum_size;
> >  
> >  static const char Bad_file[] = "Bad swap file entry ";
> >  static const char Unused_file[] = "Unused swap file entry ";
> > @@ -2816,11 +2817,16 @@ unsigned long generic_max_swapfile_size(void)
> >  }
> >  
> >  /* Can be overridden by an architecture for additional checks. */
> > -__weak unsigned long max_swapfile_size(void)
> > +__weak unsigned long arch_max_swapfile_size(void)
> >  {
> >  	return generic_max_swapfile_size();
> >  }
> >  
> > +unsigned long max_swapfile_size(void)
> > +{
> > +	return swapfile_maximum_size;
> > +}
> > +
> 
> It appears unnecessary to hide a variable with a function.  Why not just
> use the variable directly.

Sure.

-- 
Peter Xu

