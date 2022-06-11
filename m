Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872335470DD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbiFKBMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFKBMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:12:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB81001
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654909932; x=1686445932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YkVAY5kVjUVtusvqvweHGO+n+u3CHpxTEhAo9kaMLts=;
  b=Oa3WAopZ1WAhrehEeMKkMuTv6F7OhHcwI5H0ml8EgxMsZl9UUa7AWml7
   Uf+yz8f4JiRzNkQ+RuUCX6/gTr1+vlDpHI8dv6nVvq3J1NHcwl567cQ9t
   FLA4Jt3g7PSd7Xt9i6v6J/AoW/h1D9qqoDEXjXgC6jdjC+Wibvk4RP/J+
   HrjwrScKG4rSS7+mIBx39OQx36rFerYdDcFniWyY9gzVTq1b/Lrl/rqZ6
   e+huviNLEHGVPGpP+T7w4JY9NT09USIOXI/AjteUPD/TKH4v1EajB52GH
   M9zczzNzo3mBCZUX54EKX/UlI1sbxwDvgrufchybsOg0N4ZYOZMUIoDlr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278923704"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="278923704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 18:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="610960174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Jun 2022 18:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 86459F8; Sat, 11 Jun 2022 04:12:12 +0300 (EEST)
Date:   Sat, 11 Jun 2022 04:12:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220611011212.ockffkv4h3fiwfdl@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
 <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
 <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
 <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:18:23PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 11:08 -0700, Edgecombe, Richard P wrote:
> > On Fri, 2022-06-10 at 21:06 +0300, Kirill A. Shutemov wrote:
> > > On Fri, Jun 10, 2022 at 04:16:01PM +0000, Edgecombe, Rick P wrote:
> > > > On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > > > > +static int prctl_enable_tagged_addr(unsigned long nr_bits)
> > > > > +{
> > > > > +       struct mm_struct *mm = current->mm;
> > > > > +
> > > > > +       /* Already enabled? */
> > > > > +       if (mm->context.lam_cr3_mask)
> > > > > +               return -EBUSY;
> > > > > +
> > > > > +       /* LAM has to be enabled before spawning threads */
> > > > > +       if (get_nr_threads(current) > 1)
> > > > > +               return -EBUSY;
> > > > 
> > > > Does this work for vfork()? I guess the idea is that locking is
> > > > not
> > > > needed below because there is only one thread with the MM, but
> > > > with
> > > > vfork() another task could operate on the MM, call fork(), etc.
> > > > I'm
> > > > not
> > > > sure...
> > > 
> > > I'm not sure I follow. vfork() blocks parent process until child
> > > exit
> > > or
> > > execve(). I don't see how it is a problem.
> > 
> > Oh yea, you're right.
> 
> Actually, I guess vfork() only suspends the calling thread. So what if
> you had:
> 1. Parent spawns a bunch of threads
> 2. vforks()
> 3. Child enables LAM (it only has one thread, so succeeds)
> 4. Child exits()
> 5. Parent has some threads with LAM, and some not

I think it is in "Don't do that" territory. It is very similar to cases
described in "Caveats" section of the vfork(2) man-page.

> It's some weird userspace that doesn't deserve to have things work for
> it, but I wonder if it could open up little races around untagging. As
> an example, KVM might have a super narrow race where it checks for tags
> in memslots using addr != untagged_addr(addr) before checking
> access_ok(addr, ...). See __kvm_set_memory_region(). If mm-
> >context.untag_mask got set in the middle, tagged memslots could be
> added.

Ultimately, a process which calls vfork(2) is in control of what happens
to the new process until execve(2) or exit(2). So, yes it is very creative
way to shoot yourself into leg, but I don't think it worth preventing.

And I'm not sure how the fix would look like.

-- 
 Kirill A. Shutemov
