Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8943557AB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiGTA7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiGTA7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:59:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F97B4AD7C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658278788; x=1689814788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nuzHil18hQah8mRqKkYQFzAMHFmMEuGVD8GiUEVxl4A=;
  b=TlAnzINUafLtO5BrdEktdQ0F5TYxqSDu1WWbrjd3Me2pWaxmqEPblHKY
   4E7Smv6eBVGlvuKQDvwwLANSSjFjfLD9i3Zk1C15C+AYrlN/p8xD55kiI
   /FPM5UL0y11sjtUjRsolrPbB8cS8JKCmqPNoWvcqLmgSHfh9nk6pBpfje
   lxzBx6ftb4xlZL+ObbgUQJBazgMuvfoK2WTD1EaMGRKq+3/8zwjnmgvsd
   Cs/RztAIib5C2W2ffGpN6YGrs7As5/hULWgSmpSKdOZxyZmOk4tQAlQ/1
   7K1MTZkmuJinKwXVI81e4Ui0BhyRtMjDu7Y0lEEJ4e3zL6OP3tihjZrrb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269673652"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="269673652"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 17:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="687325851"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2022 17:59:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C14F9136; Wed, 20 Jul 2022 03:59:50 +0300 (EEST)
Date:   Wed, 20 Jul 2022 03:59:50 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5 00/13] Linear Address Masking enabling
Message-ID: <20220720005950.fonulr4kkwbh6kbz@black.fi.intel.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <CAG_fn=WR3s3UMh76+bibN0nUpZk9AS_M18=oxP+pc_vtqKt34A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WR3s3UMh76+bibN0nUpZk9AS_M18=oxP+pc_vtqKt34A@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 07:39:22PM +0200, Alexander Potapenko wrote:
> On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > 64-bit linear addresses, allowing software to use of the untranslated
> > address bits for metadata.
> >
> > The patchset brings support for LAM for userspace addresses.
> >
> > LAM_U48 enabling is controversial since it competes for bits with
> > 5-level paging. Its enabling isolated into an optional last patch that
> > can be applied at maintainer's discretion.
> 
> I believe having optional patches will put unnecessary burden on
> distro maintainers.
> Soon after landing U48 support other changes will start piling on top
> of it, and it will be impossible to maintain a kernel with this patch
> removed.
> It also won't make any difference for the upstream, where this patch
> will be always present.
> 
> We'd better decide now whether we need U48 or not, and either keep it
> or delete it.

Dave, Andy, any position on this?

I wrote LAM_U48 support to prove that interface is flexible enough, but I
see why it can be a problem if a distro will pick them up ahead of
upstream.

-- 
 Kirill A. Shutemov
