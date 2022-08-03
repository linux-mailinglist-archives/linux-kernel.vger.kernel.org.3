Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF453588EE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiHCOtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiHCOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:49:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57AF5FAA;
        Wed,  3 Aug 2022 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659538176; x=1691074176;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Faqqo9HzJfxgdrGCas4xFN7qzs/Hy63rrU1AKfXxIXk=;
  b=AiBuY1cQJM94eFRkPaVPf4ilNH8w1IUeacqMax2nnrlcmTV+KQZgCGNq
   Kymz/myNWFift8c0Ina36KPV3ll9cBy7Ez+3IHzZowwP4BoA0oWwnTGV4
   j0jxINiJjL4TNMwWA6fmGEaH3DIEmhbwsbOb9sDmCCHS4rf1MR2nkEHFS
   QKv2BXKmc9GoAQwrqESY88SzVPk/L5JrqERBVw8rP8Imj7eXsoGQ2sM3p
   +t3UYIFBhzF4/bJzQSi2taew4mDtyKUdp70S+2nuyfwfFwQJYiPnGhKYv
   3yaG4NGlNb0o1dK9dAnqzkZPkDNPJpioFMh+ZcUC0wU3NOVJmIA+nWTbb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="353690230"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="353690230"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:49:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631175430"
Received: from buichris-mobl.amr.corp.intel.com (HELO [10.209.124.150]) ([10.209.124.150])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:49:34 -0700
Message-ID: <61ce1a14-7bac-fea8-b065-83a1c0704258@intel.com>
Date:   Wed, 3 Aug 2022 07:49:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86,mm: print likely CPU at segfault time
Content-Language: en-US
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     x86@vger.kernel.org, kernel-team@fb.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20220802160900.7a68909b@imladris.surriel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220802160900.7a68909b@imladris.surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 13:09, Rik van Riel wrote:
> Add a printk to show_signal_msg() to print the CPU, core, and socket

Nit:     ^ printk(), please

> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -782,6 +782,12 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>  
>  	print_vma_addr(KERN_CONT " in ", regs->ip);
>  
> +	printk(KERN_CONT " on CPU %d (core %d, socket %d)",
> +	       raw_smp_processor_id(),
> +	       topology_core_id(raw_smp_processor_id()),
> +	       topology_physical_package_id(raw_smp_processor_id()));

This seems totally sane to me.  I have found myself looking through
customer-provided *oopses* more than once trying to figure out if the
same CPU cores were at fault.  This extends that to userspace crashes
too.  I've also found myself trying to map back from logical CPU numbers
to core and package.

One nit: Preempt is enabled here, right?  I understand that this thing
is fundamentally racy, but if we did:

	int cpu = READ_ONCE(raw_smp_processor_id());

it would make it internally *consistent*.  Without that, we could
theoretically get three different raw_smp_processor_id()'s.  It might
even make the code look a wee bit nicer.

The changelog here is great, but  couple of comments would also be nice:

	/* This is a racy snapshot, but is better than nothing: */
	int cpu = READ_ONCE(raw_smp_processor_id());
...
	/*
	 * Dump the likely CPU where the fatal segfault happened.  This
	 * can help help identify buggy pieces of hardware.
	 */
	printk(KERN_CONT " on CPU %d (core %d, socket %d)", cpu,
	       topology_core_id(cpu),
	       topology_physical_package_id(cpu));

If you want to wait a bit and see if you get any other comments, this
seems like something we can suck in after the merge window.
