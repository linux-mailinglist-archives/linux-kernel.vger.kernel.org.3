Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E87526D47
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbiEMXBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiEMXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:01:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238F65DBFF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652482888; x=1684018888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MTfC/9EMbaMrK28PPc/w3328k2eO4ywXQYc/ZS6xQT4=;
  b=nuVVgWWpOj6T7dnV+vUDsqsaUr14pvYhkRKx3tEHxvTo474UM3uHFOGh
   XuZpnx11NYEGIIyWnpadhNCbrcZuOpCoPH4dK6gfnsN8gMo+OUzY4e4cw
   B3gGWr8MUtGxYxZl1qrR53z470sFCgTiiiv4xEtntTG5rRISEZa5qbUJI
   gNpZgTms43w+CklDkbYfzHIvv/Ssmxr49vGnQtAckltDD00hfF8LxpKAM
   PatfCpxYXomLe3wuf487+8aZW5KFdyLfBNCpXcZerhGzgpaI5uaCZ+7+y
   kLxBNQp3CwcQeoC1sab3A0pMGQIs8rNVUVVsoeidzd1aogXjvlCvxKFRt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250338161"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250338161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 16:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="659311031"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2022 16:01:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E0917A8; Sat, 14 May 2022 02:01:23 +0300 (EEST)
Date:   Sat, 14 May 2022 02:01:23 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Message-ID: <20220513230123.wmb4ia3r72snfpwj@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
 <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:07:43PM +0200, Alexander Potapenko wrote:
> On Thu, May 12, 2022 at 11:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 5/12/22 12:39, Thomas Gleixner wrote:
> > >> It's OK for a debugging build that runs on one kind of hardware.  But,
> > >> if we want LAM-using binaries to be portable, we have to do something
> > >> different.
> > >>
> > >> One of the stated reasons for adding LAM hardware is that folks want to
> > >> use sanitizers outside of debugging environments.  To me, that means
> > >> that LAM is something that the same binary might run with or without.
> > > On/off yes, but is there an actual use case where such a mechanism would
> > > at start time dynamically chose the number of bits?
> >
> > I'd love to hear from folks doing the userspace side of this.  Will
> > userspace be saying: "Give me all the bits you can!".  Or, will it
> > really just be looking for 6 bits only, and it doesn't care whether it
> > gets 6 or 15, it will use only 6?
> 
> (speaking more or less on behalf of the userspace folks here)
> I think it is safe to assume that in the upcoming year or two HWASan
> will be fine having just 6 bits for the tags on x86 machines.
> We are interested in running it on kernels with and without
> CONFIG_X86_5LEVEL=y, so U48 is not an option in some cases anyway.

Just to be clear: LAM_U48 works on machine with 5-level paging enabled as
long as the process doesn't map anything above 47-bit.

-- 
 Kirill A. Shutemov
