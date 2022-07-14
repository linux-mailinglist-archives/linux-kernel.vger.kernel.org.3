Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A85754B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiGNSMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiGNSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:12:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A16872E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657822372; x=1689358372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZbSgw4PiPhHiI2IkamjWGYAFK+m9rBc4mek9Q/SNdQ=;
  b=cbDJpALSG07+eDqR4XorrqSB8UJ4nDWnpSgckjBopW1/TP2/jJ81bEC/
   1mne9Ka7x5UXfLfwRRv67bfaKHe3cM1HKs7RJxvXpHM3cq9fH/NHMWtnW
   4zqvx7FyT26UUSR3CbrLrnqe8TavZkQNbk2DVvG09tn1NSskHoBCUnT2m
   xIRaXW00uyexdpdeC2eRdCelasFXZcCS4GWaYG4hrqrKUioc9NbV1TBBB
   QYSwona4msuoNmVhaejBl63I5JdHmUA0gdmx8EDpK8shamOzqFFHColGq
   WFs0kmrIZARHpVSpdPG/T3uP+XWPoVK9eJV1EumdX5gBC9yiyLT6N2lFR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349563098"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="349563098"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="923180403"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2022 11:12:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2917FF1; Thu, 14 Jul 2022 21:12:55 +0300 (EEST)
Date:   Thu, 14 Jul 2022 21:12:55 +0300
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
Subject: Re: [PATCHv4 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220714181255.7aonbyzca3avfylp@black.fi.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
 <20220622162230.83474-7-kirill.shutemov@linux.intel.com>
 <CAG_fn=Uo8E-6r3otLPC9iEfO02=A0=zROO8R8TL=8vXVZVE5Ww@mail.gmail.com>
 <20220712171445.74b46mgdxgaub3qj@black.fi.intel.com>
 <CAG_fn=VeS7eFq5w0ny2VVe0j4YU4DKyaHDL0-b_VomnYwmDYow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VeS7eFq5w0ny2VVe0j4YU4DKyaHDL0-b_VomnYwmDYow@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 04:28:36PM +0200, Alexander Potapenko wrote:
> On Tue, Jul 12, 2022 at 7:14 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Tue, Jul 12, 2022 at 03:12:01PM +0200, Alexander Potapenko wrote:
> > > On Wed, Jun 22, 2022 at 6:22 PM Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > Add a couple of arch_prctl() handles:
> > > >
> > > >  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
> > > >    of tag bits. It is rounded up to the nearest LAM mode that can
> > > >    provide it. For now only LAM_U57 is supported, with 6 tag bits.
> > > >
> > > >  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
> > > >    bits located in the address.
> > > >
> > > Am I right that the desired way to detect the presence of LAM without
> > > enabling it is to check that arch_prctl(ARCH_GET_UNTAG_MASK, ...)
> > > returns zero?
> >
> > Returns -1UL, but yes.
> 
> No, I meant the return value of arch_prctl(), but in fact neither
> seems to be true.
> 
> Right now e.g. for the 5.17 kernel arch_prctl(ARCH_GET_UNTAG_MASK,
> &bits) returns -EINVAL regardless of the underlying hardware.
> A new kernel with your patches will return 0 and set bits=-1UL on both
> non-LAM and LAM-enabled machines. How can we distinguish those?

With CPUID?

-- 
 Kirill A. Shutemov
