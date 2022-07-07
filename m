Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4926156A1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiGGMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiGGMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:00:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0135925D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657195084; x=1688731084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y897ccQh9DniNRVq6CwkRyY6onhzd1oeECrmj1dS8v0=;
  b=PBpUDtxpZPreo5XK0FPNp58UqL0ySFG0aRLQiV/SStWqxmrtXvQ+XjPC
   cSw1UUT20t8elxZo2RJAnTJVznULekP158mRNv09FHI7pyNhEU/bSRFmZ
   aQveGGD3cvPIfqb1RWaZVMQw8/gVGrWQYCGXoUsxC3ndsGx+fLf+PGDFh
   WC2GLeDnyPv1NrsMhAE4+4OfGN7WvStxDWz5vVh9Wg0KYeMmw0e3JxEk4
   NgkXHerSXZtCdyi/BuCihfyo48l1A3FlkAm2Cu8MzqRHAzfUAah9J5W7f
   a/Pr/48alSEc8em/kGw1l5gVfRlSNfUa2hLvMn/m3T+tSrPruxAganyOZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284029853"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="284029853"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 04:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="620762106"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 04:58:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C5DCD400; Thu,  7 Jul 2022 14:58:07 +0300 (EEST)
Date:   Thu, 7 Jul 2022 14:58:07 +0300
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
Subject: Re: [PATCHv4 3/8] mm: Pass down mm_struct to untagged_addr()
Message-ID: <20220707115807.pzrj7bngm2ndcjwk@black.fi.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
 <20220622162230.83474-4-kirill.shutemov@linux.intel.com>
 <CAG_fn=WgyitSd9h2ni2xpBBvgnoGTcwZOpWyNE5QRSRn+PcC=A@mail.gmail.com>
 <20220706231349.4ghhewbfpzjln56u@black.fi.intel.com>
 <CAG_fn=Ut8OaQ40VmNvG8HtJ7Cb4M03ce3ihFPrmj+PNQB0tF3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Ut8OaQ40VmNvG8HtJ7Cb4M03ce3ihFPrmj+PNQB0tF3A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:56:53AM +0200, Alexander Potapenko wrote:
> On Thu, Jul 7, 2022 at 1:14 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Tue, Jul 05, 2022 at 05:42:21PM +0200, Alexander Potapenko wrote:
> > > Kirill,
> > >
> > >
> > > > diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> > > > index feeb935a2299..abc096a68f05 100644
> > > > --- a/lib/strnlen_user.c
> > > > +++ b/lib/strnlen_user.c
> > > > @@ -97,7 +97,7 @@ long strnlen_user(const char __user *str, long count)
> > > >                 return 0;
> > > >
> > > >         max_addr = TASK_SIZE_MAX;
> > > > -       src_addr = (unsigned long)untagged_addr(str);
> > > > +       src_addr = (unsigned long)untagged_addr(current->mm, str);
> > >
> > > In a downstream kernel with LAM disabled I'm seeing current->mm being
> > > NULL at this point, because strnlen_user() is being called by
> > > kdevtmpfs.
> > > IIUC current->mm is only guaranteed to be non-NULL in the userspace
> > > process context, whereas untagged_addr() may get called in random
> > > places.
> > >
> > > Am I missing something?
> >
> > Hm. Could you show a traceback?
> >
> > As strnlen_user() intended to be used on an user string I expected it to
> > be called from a process context. I guess I'm wrong, but I don't yet
> > understand why.
> 
> Oh, I see now. The old implementation of devtmpfsd()
> (https://elixir.bootlin.com/linux/v5.4/source/drivers/base/devtmpfs.c#L397)
> uses ksys_mount(), which assumes that the strings must be copied from
> the userspace, whereas they are actually constants in kernel .rodata
> 
> Wonder if the validity of mm->current for userspace accesses is
> actually enforced anyhow in newer kernels.

I think it is.

See 967747bbc084 and how it changes strnlen_user(). With max_addr equal to
TASK_SIZE_MAX, strnlen_user() will always fail on a kernel string.

-- 
 Kirill A. Shutemov
