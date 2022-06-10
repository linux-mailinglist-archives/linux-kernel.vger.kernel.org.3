Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A266A546C27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347559AbiFJSGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347484AbiFJSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:06:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7EC5F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654884396; x=1686420396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IFRrzvN2oP18xaw+PepMuRmspRZRLwDxgXN4BczW7yk=;
  b=hgm8ufY7LFGJRQwF9LidnHhqbTyaDitslzYkem3a2oggGeivwEBgGcEb
   j458DbuMY58M+XOtswukuGt1iGcJb2HTUDegQN+gX+2op25al2YeVpevl
   ndnNc1eLCm/ErHi9ukbVzB//2pf+JA2GDi4d6ybNBHogtoROHFvscITFV
   vCUk/jgEyq+IZvukqZjsHkHAamvqFAu6lS78xYX60GBF03KLaXpunsx2O
   TJiSI1xesfJzNJEg2To2/q2qQz+JNSN0RaWC1MuP1S39Axz3c6JAB8zXI
   lTy3Sb6/TLllbfbND6Rr18XB3H+yo9U6hTtVJLGhLx0402l1NjVsQlhUT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278837355"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="278837355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 11:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="760612596"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2022 11:06:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B4787F8; Fri, 10 Jun 2022 21:06:35 +0300 (EEST)
Date:   Fri, 10 Jun 2022 21:06:35 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:16:01PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > +static int prctl_enable_tagged_addr(unsigned long nr_bits)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +
> > +       /* Already enabled? */
> > +       if (mm->context.lam_cr3_mask)
> > +               return -EBUSY;
> > +
> > +       /* LAM has to be enabled before spawning threads */
> > +       if (get_nr_threads(current) > 1)
> > +               return -EBUSY;
> 
> Does this work for vfork()? I guess the idea is that locking is not
> needed below because there is only one thread with the MM, but with
> vfork() another task could operate on the MM, call fork(), etc. I'm not
> sure...

I'm not sure I follow. vfork() blocks parent process until child exit or
execve(). I don't see how it is a problem.

-- 
 Kirill A. Shutemov
