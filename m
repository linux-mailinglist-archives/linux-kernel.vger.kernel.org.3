Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7DF550008
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiFQWiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFQWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:38:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB61443F5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655505492; x=1687041492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5N+38U0pt8pNFT2Qih+c9vIoK9kKJHt3QaF9gXIGyM0=;
  b=OOKAyrVVEo4sOvoE2rOqoZgr2n5HLqi3/DKgNAPT97Umc9t0/1AnZSah
   Ke1sE6w6UtZ6Z0olAe4S6vFwp+/RncuhySp0EL8T5agtUSvrPD3LVm2e6
   5DkniTcXGjXVqInP4t0evkoplgMuf2E6JEyRoWcCY68lE7BerQjbLBBGZ
   ggX2IkRhsNQQOvTgWWRHMXhti+ltPZuWarNKVqDc9ZzFeYbPB8AvgN+A8
   gDp0LvrJP80aQ9MW9ZGgCvb6K3Zc3vbNyI6lmXjWnqlHJ3F3OoA7hd4eK
   bmylgc0bhjOryFX47rp8JEGDB8dtq5PkKUJqRbwnqV3L02fNgTfZffV04
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262641172"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262641172"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584180487"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2022 15:38:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 61676132; Sat, 18 Jun 2022 01:38:13 +0300 (EEST)
Date:   Sat, 18 Jun 2022 01:38:13 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 3/8] mm: Pass down mm_struct to untagged_addr()
Message-ID: <20220617223813.z4aozosytagbqv3a@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-4-kirill.shutemov@linux.intel.com>
 <CAG_fn=Whre1PdfxoT=isho9auAQeBaH4ghU+orcJfgdeD30g3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Whre1PdfxoT=isho9auAQeBaH4ghU+orcJfgdeD30g3w@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 05:27:46PM +0200, Alexander Potapenko wrote:
> On Fri, Jun 10, 2022 at 4:35 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Intel Linear Address Masking (LAM) brings per-mm untagging rules. Pass
> > down mm_struct to the untagging helper. It will help to apply untagging
> > policy correctly.
> >
> > In most cases, current->mm is the one to use, but there are some
> > exceptions, such as get_user_page_remote().
> 
> Wouldn't it be easier to keep using current->mm in untagged_addr(addr)
> by default, and introduce a separate macro for the exceptions?

I don't think it is a good idea. Explicit mm forces writer to consider
what mm she wants to use in the particular case.

> > +/*
> > + * Architectures that support memory tagging (assigning tags to memory regions,
> > + * embedding these tags into addresses that point to these memory regions, and
> > + * checking that the memory and the pointer tags match on memory accesses)
> > + * redefine this macro to strip tags from pointers.
> > + * It's defined as noop for architectures that don't support memory tagging.
> > + */
> > +#ifndef untagged_addr
> > +#define untagged_addr(mm, addr) (addr)
> > +#endif
> The comment above should probably be extended to explain the effect of `mm`.

Sure, will update.

-- 
 Kirill A. Shutemov
