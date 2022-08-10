Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5158E752
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiHJGal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiHJGaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:30:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD6A47BA3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660113038; x=1691649038;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gB7X2rsLImjBhNl6pbwqqOhUegeSwjxLluoazpjeH1E=;
  b=LNmKDIq/nmGELeP/itBbJ3FLlsoRmzhnmlIIycRsacwBZJNFyqOPGz4k
   UXTIwb9A9aiZ2koimpXRggoCHa2s4YTqTUqLB3TZVnH2tp+Vok/mKSy/4
   7hzCi9dZn8f4ocYi7pFy2dBeg7EyrAmkTKa8oc48tsUByjibFaA9Lk4to
   TdPVEJqlDSskVe3PYLr7zccjzlWP4vApa2E8V0WFATp0wadKguQwKMpBf
   ++H4jbzBSUqqCXa5NJf1x8LNKLIM+qRT90jlROcb5ODdT9EkjAAMphgkW
   KWxAUq3sSpI0recU1XdFzAyHDopZjRBo54f/uKi49s6orD2HS2nR2xfm2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291011040"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="291011040"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:30:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="673182402"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:30:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
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
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-6-peterx@redhat.com>
Date:   Wed, 10 Aug 2022 14:30:33 +0800
In-Reply-To: <20220809220100.20033-6-peterx@redhat.com> (Peter Xu's message of
        "Tue, 9 Aug 2022 18:00:58 -0400")
Message-ID: <8735e4fw52.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

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
                                                                       ~~~~~
Nitpick: A/D

> bit.  Otherwise the A/D bits are dropped like before.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/swapops.h | 99 +++++++++++++++++++++++++++++++++++++++++
>  mm/huge_memory.c        | 18 +++++++-
>  mm/migrate.c            |  6 ++-
>  mm/migrate_device.c     |  4 ++
>  mm/rmap.c               |  5 ++-
>  5 files changed, 128 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index e1accbcd1136..0e9579b90659 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -8,6 +8,10 @@
>  
>  #ifdef CONFIG_MMU
>  
> +#ifdef CONFIG_SWAP
> +#include <linux/swapfile.h>
> +#endif	/* CONFIG_SWAP */

I don't think we need the comment here.  The #ifdef is too near.  But
this isn't a big deal.

Best Regards,
Huang, Ying
