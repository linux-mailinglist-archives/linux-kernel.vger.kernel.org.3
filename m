Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9128525320
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356789AbiELRBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356771AbiELRAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:00:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E812E9D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652374842; x=1683910842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=apo30zA37N3jdlCWH2sDbDBKNYM+43W8+OjQdalfpgs=;
  b=TkhwrMBe1efd5vcgmKGRzOBG4HJUs1Sl2n5rlPB8ZQaPxaIKR6P4wB73
   AAvfANYYQgdRUkSVRw0iKfy+4n1q24cUmahvhJ2QN+7+1XBKuu2Ydz1tO
   tcqcyr/RRp2QUEXz30cXgpXS+JAhSivYiiftgG21FPwv8E6Ar63MkOD3N
   n5F5JjSpIvGVKnb0oU764naTJJm3MHkI7EK95edTY/K2aXqfKcMLofh6R
   ewLm3tH1RONy1KMmZOro/awBJ5STpTqkRmf3526SkoDYXsbEI5+v16ZMh
   oobrQjorhj66q9mB1QgUu6onlb3Pnvm1EOUBoeJEQCaCBdROCK43ylXdi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250588890"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="250588890"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 09:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="895869323"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2022 09:56:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 54ED0CE; Thu, 12 May 2022 19:56:12 +0300 (EEST)
Date:   Thu, 12 May 2022 19:56:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Message-ID: <20220512165612.gizedzgtpzbi7jbl@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <87pmkivjst.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmkivjst.ffs@tglx>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 05:42:58PM +0200, Thomas Gleixner wrote:
> On Wed, May 11 2022 at 08:49, Peter Zijlstra wrote:
> > On Wed, May 11, 2022 at 05:27:40AM +0300, Kirill A. Shutemov wrote:
> >> Hi all. Here's long overdue update on LAM enabling.
> >> 
> >> # Description #
> >> 
> >> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> >> 64-bit linear addresses, allowing software to use of the untranslated
> >> address bits for metadata.
> >> 
> >> The patchset brings support for LAM for userspace addresses.
> >> 
> >> The most sensitive part of enabling is change in tlb.c, where CR3 flags
> >> get set. Please take a look that what I'm doing makes sense.
> >> 
> >> The feature competes for bits with 5-level paging: LAM_U48 makes it
> >> impossible to map anything about 47-bits. The patchset made these
> >> capability mutually exclusive: whatever used first wins. LAM_U57 can be
> >> combined with mappings above 47-bits.
> >
> > So aren't we creating a problem with LAM_U48 where programs relying on
> > it are of limited sustainability?
> >
> > Any such program simply *cannot* run on 5 level pagetables. Why do we
> > want to do this?
> 
> More bits are better :)
> 
> Seriously, I agree that restricting it to LAM57, which gives us 6 bits,
> makes a lot of sense _and_ makes the whole thing way simpler.
> 
> So supporting both needs a truly good justification and a real world use
> case.

I asked the question before[1]. Basically, more bits more better:

	For HWASAN #bits == detection probability.
	For MarkUS #bits == exponential cost reduction

I would really like to have only LAM_U57, but IIUC 6 bits is not always
enough.

Dmitry, could you elaborate?

[1] https://mobile.twitter.com/dvyukov/status/1342019823400837120
-- 
 Kirill A. Shutemov
