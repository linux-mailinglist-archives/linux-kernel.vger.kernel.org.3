Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066350DAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiDYH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiDYH5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:57:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203BCF5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GRc/u2VY9j2J1+X39lc63KFsRB/jvBEkfMYe0ddJlyg=; b=CiFWcvcs+5lKGEQ3/31C2xjRMq
        GU/6NvG7ToDQgZTdsEwcJdhiANFRnxUGvDD0uOkC58W8oOH6ceAqIp4nFm+agX7WyviL9YEjC6ysc
        41iRjMXAadNj9Tg3nBOA7f7yzZQr8LV3ZV3Exam11Xqz9/nmaC0LW8dNVPSUsi/NjuSuYiyXCXCbC
        ympNVeC6nMYONHt1sdHDfywIfhFp42EXzpX63e4Tu8Qei4EvyeJpTOiNc4N54uYjZ5z5GJzfInAV6
        PUZR4xUky5sP/UxyiPJ20An9L8hgAh9w5KqhZblQQ1T8nbaNg1mrSDljCSbzY4DY/mdurOz+NXC7G
        0TOchEew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitXO-008WQ7-FX; Mon, 25 Apr 2022 07:53:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1CF8986167; Mon, 25 Apr 2022 09:53:35 +0200 (CEST)
Date:   Mon, 25 Apr 2022 09:53:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH v2] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20220425075335.GZ2731@worktop.programming.kicks-ass.net>
References: <20220424122533.27590-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424122533.27590-1-feng.tang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 08:25:33PM +0800, Feng Tang wrote:

> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index d3a6f74a94bd..7b8cfe9717f2 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -225,6 +225,19 @@ config PUNIT_ATOM_DEBUG
>  	  The current power state can be read from
>  	  /sys/kernel/debug/punit_atom/dev_power_state
> 
> +config DEBUG_FORCE_DATA_SECTION_ALIGNED
> +	bool "Force all data sections to be THREAD_SIZE aligned"

s/THREAD_SIZE/PAGE_SIZE/ as that seems to be what the actual patch does.

> +	depends on EXPERT && !DYNAMIC_DEBUG
> +	help
> +	  There are cases that a commit from one kernel domain changes
> +	  data sections' alignment of other domains, as they are all
> +	  linked together compactly, and cause magic performance bump
> +	  (regression or improvement), which is hard to debug. Enable
> +	  this option will help to verify if the bump is caused by
> +	  data alignment changes.
> +
> +	  It is mainly for debug and performance tuning use.
> +
>  choice
>  	prompt "Choose kernel unwinder"
>  	default UNWINDER_ORC if X86_64
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 7fda7f27e762..6add703de45f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -155,7 +155,17 @@ SECTIONS
>  	X86_ALIGN_RODATA_END
> 
>  	/* Data */
> -	.data : AT(ADDR(.data) - LOAD_OFFSET) {
> +	.data : AT(ADDR(.data) - LOAD_OFFSET)
> +#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
> +	/*
> +	 * In theroy, THREAD_SIZE as the biggest alignment of below sections

I think the more common spelling is: 'theory' :-)

> +	 * should be picked, but since upper 'X86_ALIGN_RODATA_END' can
> +	 * ganrantees the alignment of 'INIT_TASK_DATA', PAGE_SIZE is picked
> +	 * instead to reduce size of kernel binary
> +	 */
> +	SUBALIGN(PAGE_SIZE)
> +#endif
> +	{
>  		/* Start of data section */
>  		_sdata = .;
> 
> --
> 2.27.0
> 
