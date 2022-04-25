Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1A50DACE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiDYIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiDYIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:04:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E7B1582E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650873689; x=1682409689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/QcU6MWYTPWZ4Kj6gQUq7qXQoT/0fHP0aO/R9fTkgkM=;
  b=f2Kovs0+xiMAdXoeeTg2xYqIJujz6xbcIBg33eCw9Gy0WQaDVZDAcjk+
   j/9E7T2MBRwAC+NfLilbCB8N12p0BDnp6Doksbpv8iGpK+6b+SF8jebRd
   BPqdPSaUGZeRnhrPt2RaN9HeNAc1i/9LcZEpz8sSw2TZPAqYqZZn4TJ+d
   CqWiPiFbsZtiDou/4ixfH1HmnMf7uTGyV1+FhPxIzJ0MIDjI5PYQhariH
   cfgvtkEMVclBSJbeL0h2+E6LHuEwKJnhYy+i12oWGnCHjY9D64QFMkxfc
   PmJC/Byk6JZwU0KlDVIfKuN1Zv1Lh3FTT9qbLsXfDS1lrXTYMSc/CD/kc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351623413"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="351623413"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 01:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="579155418"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2022 01:01:26 -0700
Date:   Mon, 25 Apr 2022 16:01:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH v2] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20220425080126.GA33905@shbuild999.sh.intel.com>
References: <20220424122533.27590-1-feng.tang@intel.com>
 <20220425075335.GZ2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425075335.GZ2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Apr 25, 2022 at 09:53:35AM +0200, Peter Zijlstra wrote:
> On Sun, Apr 24, 2022 at 08:25:33PM +0800, Feng Tang wrote:
> 
> > diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> > index d3a6f74a94bd..7b8cfe9717f2 100644
> > --- a/arch/x86/Kconfig.debug
> > +++ b/arch/x86/Kconfig.debug
> > @@ -225,6 +225,19 @@ config PUNIT_ATOM_DEBUG
> >  	  The current power state can be read from
> >  	  /sys/kernel/debug/punit_atom/dev_power_state
> > 
> > +config DEBUG_FORCE_DATA_SECTION_ALIGNED
> > +	bool "Force all data sections to be THREAD_SIZE aligned"
> 
> s/THREAD_SIZE/PAGE_SIZE/ as that seems to be what the actual patch does.

Thanks for the catch! It was changed from v1 to v2, I should reviewed 
these texts more carefully, and there is another similar typo in the
commit log.

> > +	depends on EXPERT && !DYNAMIC_DEBUG
> > +	help
> > +	  There are cases that a commit from one kernel domain changes
> > +	  data sections' alignment of other domains, as they are all
> > +	  linked together compactly, and cause magic performance bump
> > +	  (regression or improvement), which is hard to debug. Enable
> > +	  this option will help to verify if the bump is caused by
> > +	  data alignment changes.
> > +
> > +	  It is mainly for debug and performance tuning use.
> > +
> >  choice
> >  	prompt "Choose kernel unwinder"
> >  	default UNWINDER_ORC if X86_64
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index 7fda7f27e762..6add703de45f 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -155,7 +155,17 @@ SECTIONS
> >  	X86_ALIGN_RODATA_END
> > 
> >  	/* Data */
> > -	.data : AT(ADDR(.data) - LOAD_OFFSET) {
> > +	.data : AT(ADDR(.data) - LOAD_OFFSET)
> > +#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
> > +	/*
> > +	 * In theroy, THREAD_SIZE as the biggest alignment of below sections
> 
> I think the more common spelling is: 'theory' :-)

Yes, will change in the next verson.

Thanks,
Feng

> > +	 * should be picked, but since upper 'X86_ALIGN_RODATA_END' can
> > +	 * ganrantees the alignment of 'INIT_TASK_DATA', PAGE_SIZE is picked
> > +	 * instead to reduce size of kernel binary
> > +	 */
> > +	SUBALIGN(PAGE_SIZE)
> > +#endif
> > +	{
> >  		/* Start of data section */
> >  		_sdata = .;
> > 
> > --
> > 2.27.0
> > 
