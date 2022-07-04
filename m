Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C93565799
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiGDNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiGDNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:43:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA126F4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656942224; x=1688478224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=52gQ5IVQcWNAJh1H9cs5/vA4Er7X9bMmjx+JOV6sGGo=;
  b=fA7S8e21rEtpCGWeigQLnh7PSHjpU+WzKzhhmj1sU5CMvCt8DfbSIc+m
   /cxzfyRBCnSuLaVYHBC20bQ/LSvgPmN95YJQiQw1HStVo+3Rt7DFs5C9G
   a3c6kwU19zEkO2oMgMMwQ7icARA66w7aMvOdPMyOlqCVy3PWco2Y6O6vX
   9rDlZ175ZTdwLsKp7QP6OJGDmQ9jRnvXsrTEGoeJB5GTlAYWd2d51/JcJ
   NqqRlfQZUvLS5Yen0+i3gcn9PI0neREnkdUpix4oXVy0dRkV7GlJIi44p
   Edwv1ONtF8oo3WqeaK5jAzovbGLN+rBYgadjUWxjge3Adp417hhmdwKHh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="262925100"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="262925100"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 06:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="592567243"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Jul 2022 06:43:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B1594136; Mon,  4 Jul 2022 16:43:46 +0300 (EEST)
Date:   Mon, 4 Jul 2022 16:43:46 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220704134346.ua37tgg2c5eff4jm@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <6cb17661-9436-afbf-38eb-58565bba1a56@kernel.org>
 <20220629005342.3thjt26e6p6znyrh@black.fi.intel.com>
 <1d765bc0-279c-4fd3-91f4-e99e6aef203c@www.fastmail.com>
 <20220701153840.7g55cazg73ukvr7l@black.fi.intel.com>
 <91ff4c04-ec26-418e-a685-f910505eec5a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ff4c04-ec26-418e-a685-f910505eec5a@www.fastmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 04:55:40PM -0700, Andy Lutomirski wrote:
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index 427ebef3f64b..cd2b03fe94c4 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -745,15 +745,16 @@ static long prctl_map_vdso(const struct 
> > vdso_image *image, unsigned long addr)
> >  static void enable_lam_func(void *mm)
> >  {
> >  	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> > +	unsigned long lam_mask;
> > 
> >  	if (loaded_mm != mm)
> >  		return;
> > 
> > -	/* Counterpart of smp_wmb() in prctl_enable_tagged_addr() */
> > -	smp_rmb();
> > +	lam_mask = READ_ONCE(loaded_mm->context.lam_cr3_mask);
> > 
> >  	/* Update CR3 to get LAM active on the CPU */
> > -	switch_mm(loaded_mm, loaded_mm, current);
> > +	write_cr3(__read_cr3() | lam_mask);
> 
> Perhaps this should also mask off the old LAM mask?

So far LAM enabling is one-way operation, so it should be fine.
But I think masking off is good idea to avoid problems in the future.

-- 
 Kirill A. Shutemov
