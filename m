Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427457B3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiGTJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiGTJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B02A73A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22420617EB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE623C3411E;
        Wed, 20 Jul 2022 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658308644;
        bh=0zBO6umFFIrPrU7UNFUykMRqo+BjUg3C8nb2Lh1VYyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4ozL+iug/6wm07GUIQUZ4Z2Awe27I83BkiycWryzvxkLp2BTN0DMSBdRZ7EzPEZH
         Ytt/0e4GJzdbQ2RDKIauTx+oJZrhV7vP4GCgY7aDqjCAjQmNRVPxOWWaRr0EkEBqJk
         gCMl4zssRtQGVIzf8FLMzeaicZHmUwKENIdQ6ZEk/iS95bJDeFTOxwrmAs52+L6GjN
         2Cc9R15r5KX07Amhh1D7KPlXEJbvVZjGEaojkIiLm9AEIA5KdrhWmKq79EpH0YPqkG
         P8ISZpVshT8s7FoUIvPrdmCK0G0U4LJU1xDdD5zCCZjWpwLemLYzSsVbUsubkUP4jI
         RZLGDyFjfRrjg==
Date:   Wed, 20 Jul 2022 10:17:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Steven Price <steven.price@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>,
        hanchuanhua <hanchuanhua@oppo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        =?utf-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>
Subject: Re: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
Message-ID: <20220720091716.GA15752@willie-the-truck>
References: <20220718090050.2261-1-21cnbao@gmail.com>
 <87mtd62apo.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4zsNNb0mbR7Sm-=Hd7+fW4rXbnivCY1cF-wyio2EeETvA@mail.gmail.com>
 <f2d6ef91-f447-ffb4-2a6e-bc95533e5167@arm.com>
 <87zgh5232o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <416a06f6-ca7d-d4a9-2cda-af0ad6e28261@arm.com>
 <CAGsJ_4y7GyL5qtrBbhz_8bLuAGGHy7Ju0ucPjHp-ZeDHjQcTcw@mail.gmail.com>
 <05639c8d-73f7-7e12-9941-cae3037e44b4@arm.com>
 <CAGsJ_4wFiQe5BZeLQDjUQNUZzDsTLR5QpHA5g9ZCUVOUFrvXTA@mail.gmail.com>
 <cc22ee37-2134-0b51-5f4d-8b2cc4688f8c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc22ee37-2134-0b51-5f4d-8b2cc4688f8c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 08:06:42AM +0530, Anshuman Khandual wrote:
> On 7/20/22 07:16, Barry Song wrote:
> > On Tue, Jul 19, 2022 at 4:04 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >> On 7/19/22 09:29, Barry Song wrote:
> >>> On Tue, Jul 19, 2022 at 3:35 PM Anshuman Khandual
> >>> <anshuman.khandual@arm.com> wrote:
> >>>> On 7/19/22 08:58, Huang, Ying wrote:
> >>>>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> >>>>>>>> How about the following?
> >>>>>>>>
> >>>>>>>> static inline bool arch_wants_thp_swap(void)
> >>>>>>>> {
> >>>>>>>>      return IS_ENABLED(ARCH_WANTS_THP_SWAP);
> >>>>>>>> }
> >>>>>>>
> >>>>>>> This looks good. then i'll need to change arm64 to
> >>>>>>>
> >>>>>>>  +static inline bool arch_thp_swp_supported(void)
> >>>>>>>  +{
> >>>>>>>  +     return IS_ENABLED(ARCH_WANTS_THP_SWAP) &&  !system_supports_mte();
> >>>>>>>  +}
> >>>>>>
> >>>>>> Why ? CONFIG_THP_SWAP depends on ARCH_WANTS_THP_SWAP. In folio_alloc_swap(),
> >>>>>> IS_ENABLED(CONFIG_THP_SWAP) enabled, will also imply ARCH_WANTS_THP_SWAP too
> >>>>>> is enabled. Hence checking for ARCH_WANTS_THP_SWAP again does not make sense
> >>>>>> either in the generic fallback stub, or in arm64 platform override. Because
> >>>>>> without ARCH_WANTS_THP_SWAP enabled, arch_thp_swp_supported() should never
> >>>>>> be called in the first place.
> >>>>>
> >>>>> For the only caller now, the checking looks redundant.  But the original
> >>>>> proposed implementation as follows,
> >>>>>
> >>>>> static inline bool arch_thp_swp_supported(void)
> >>>>> {
> >>>>>      return true;
> >>>>> }
> >>>>>
> >>>>> will return true even on architectures that don't support/want THP swap.
> >>>>
> >>>> But the function will never be called on for those platforms.
> >>>>
> >>>>> That will confuse people too.
> >>>>
> >>>> I dont see how.
> >>>>
> >>>>>
> >>>>> And the "redundant" checking has no run time overhead, because compiler
> >>>>> will do the trick.
> >>>> I understand that, but dont think this indirection is necessary.
> >>>
> >>> Hi Anshuman, Hi Ying,
> >>> Thanks for the comments of both of you. Does the below look ok?
> >>>
> >>> generic,
> >>>
> >>>  static inline bool arch_wants_thp_swap(void)
> >>>   {
> >>>       return IS_ENABLED(CONFIG_THP_SWAP);
> >>>  }
> >>>
> >>> arm64,
> >>>
> >>> static inline bool arch_thp_swp_supported(void)
> >>> {
> >>>      return IS_ENABLED(CONFIG_THP_SWAP) &&  !system_supports_mte();
> >>> }
> >>>
> >>> caller,
> >>>
> >>> folio_alloc_swap(struct folio *folio)
> >>> {
> >>>
> >>>   if (folio_test_large(folio)) {
> >>>    - if (IS_ENABLED(CONFIG_THP_SWAP))
> >>>   + if (arch_thp_swp_supported())
> >>>         get_swap_pages(1, &entry, folio_nr_pages(folio));
> >>>        goto out;
> >>>   }
> >>
> >> Current proposal in this patch LGTM, I dont see any reason for these changes.
> > 
> > OK, thanks, Anshuman. Can I collect this as a Reviewed-by?
> 
> Yes please.
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

I've lost track of exactly what the outcome here is, so Barry, please can
you send a final version of the agreed-upon patch?

Thanks,

Will
