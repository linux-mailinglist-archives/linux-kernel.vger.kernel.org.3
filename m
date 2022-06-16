Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252BA54E84E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350732AbiFPRFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347011AbiFPRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:05:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42024961
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655399111; x=1686935111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=14R00hyORYQkQS21lImVuriB8mbmj12+xt+1CcXGOjg=;
  b=g2rN2sQWB5fRPq5fWbLNRHTrPJg9BvvUzBD22vdt5U5d+EabYysGJrAJ
   o7/oRcnKTXYdzyekeTFpHePgxUpM/OyG1FyAE+jRGjOKQPwXD9YFU+toR
   ossHGifgLlTUnAZ/kYE15G8mw2MI/40DIUl1P6qkYptEzQP0bRdFcDpBA
   nUIb6v/J4BCx/9eBBNOyIZCw7dujRbH0bdLVMP0ngzbzhl4a3xPv9OoBy
   G4/2kqvfifZCJxbvnB9JLaZBu4clJyXlEwE4erA4on6FEli2c4MVvD1WV
   jLYNgDNnfKS5y2X9rrJf3+jSt3X/9LAXMCJ2pyS/Dv7O+ubfhLLX8DSOh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262318318"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="262318318"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 10:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="618953848"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2022 10:05:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E784A109; Thu, 16 Jun 2022 20:05:10 +0300 (EEST)
Date:   Thu, 16 Jun 2022 20:05:10 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220616170510.gpm5pjd4yzk7hfsx@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <YqdM8ZIi0/35IhzF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdM8ZIi0/35IhzF@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:42:57PM +0200, Michal Hocko wrote:
> On Fri 10-06-22 17:35:25, Kirill A. Shutemov wrote:
> [...]
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index 1962008fe743..93c8eba1a66d 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -742,6 +742,32 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
> >  }
> >  #endif
> >  
> > +static int prctl_enable_tagged_addr(unsigned long nr_bits)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +
> > +	/* Already enabled? */
> > +	if (mm->context.lam_cr3_mask)
> > +		return -EBUSY;
> > +
> > +	/* LAM has to be enabled before spawning threads */
> > +	if (get_nr_threads(current) > 1)
> > +		return -EBUSY;
> 
> This will not be sufficient in general. You can have mm shared with a
> process without CLONE_THREAD. So you would also need to check also
> MMF_MULTIPROCESS. But I do remember that general get_nr_threads is quite
> tricky to use properly. Make sure to CC Oleg Nesterov for more details.
> 
> Also how does this work when the mm is shared with a kernel thread?

It seems we need to check mm_count to exclude kernel threads that use the
mm. But I expect it to produce bunch of false-positives.

Or we can make all CPUs to do

	switch_mm(current->mm, current->mm, current);

and get LAM bits updated regardless what mm it runs. It would also remove
limitation that LAM can only be enabled when there's no threads.

But I feel that is a bad idea, but I have no clue why. :P

-- 
 Kirill A. Shutemov
