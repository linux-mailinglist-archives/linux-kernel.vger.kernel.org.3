Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D5487774
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiAGMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:09:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:33735 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbiAGMJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641557382; x=1673093382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ONVVAebltRAi6Zc1gaT7ckSeHNyIUvdQOS3c0wVuDT4=;
  b=dSvVEqF+uj1kBbQmxM47u06nfkR31p2/9oHdxTkqHR9++qPcOMllwEQh
   6WwzA6y/yPjE4na19JzwslZmHcoW5HCK2LSprdtJMN5MH7XRhIs5A/mDB
   iA20Lt8XJJFckOQSPF9JsWUVb4ztzcnCEVnuZsgLz2lZpIIFdqhdtd6Q+
   y12l6wdLNOLiBwqjzS+iu1vBZ7nMY40smhsNlHTZThOUxSFoR2y4EZeU6
   L+q3bDr+gAZGsi6LqOzSG+jI0lP+gpsuqIrZfYeJ0PC4n/MA7utOtvngc
   3MBbqY4suHmaMS9AdefsVY0HsKdSYZ/AKhgTruCK92uWIgiJCYo/NbJZQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="303602281"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="303602281"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:09:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="575081146"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:09:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n5o2g-007Ml3-Cn;
        Fri, 07 Jan 2022 14:08:22 +0200
Date:   Fri, 7 Jan 2022 14:08:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, bhe@redhat.com,
        vgoyal@redhat.com, stern@rowland.harvard.edu,
        akpm@linux-foundation.org, corbet@lwn.net, halves@canonical.com,
        kernel@gpiccoli.net
Subject: Re: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
Message-ID: <YdgtNvd68kWakErr@smile.fi.intel.com>
References: <20220106200007.112357-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106200007.112357-1-gpiccoli@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:00:07PM -0300, Guilherme G. Piccoli wrote:
> The kernel notifier infrastructure allows function callbacks to be
> added in multiple lists, which are then called in the proper time,
> like in a reboot or panic event. The panic_notifier_list specifically
> contains the callbacks that are executed during a panic event. As any
> other notifier list, the panic one has no filtering and all functions
> previously registered are executed.
> 
> The kdump infrastructure, on the other hand, enables users to set
> a crash kernel that is kexec'ed in a panic event, and vmcore/logs
> are collected in such crash kernel. When kdump is set, by default
> the panic notifiers are ignored - the kexec jumps to the crash kernel
> before the list is checked and callbacks executed.
> 
> There are some cases though in which kdump users might want to
> allow panic notifier callbacks to execute _before_ the kexec to
> the crash kernel, for a variety of reasons - for example, users
> may think kexec is very prone to fail and want to give a chance
> to kmsg dumpers to run (and save logs using pstore), or maybe
> some panic notifier is required to properly quiesce some hardware
> that must be used to the crash kernel. For these cases, we have
> the kernel parameter "crash_kexec_post_notifiers".
> 
> But there's a problem: currently it's an "all-or-nothing" situation,
> the kdump user choice is either to execute all panic notifiers or
> none of them. Given that panic notifiers may increase the risk of a
> kdump failure, this is a tough decision and may affect the debug of
> hard to reproduce bugs, if for some reason the user choice is to
> enable panic notifiers, but kdump then fails.
> 
> So, this patch aims to ease this decision: we hereby introduce a filter
> for the panic notifier list, in which users may select specifically
> which callbacks they wish to run, allowing a safer kdump. The allowlist
> should be provided using the parameter "panic_notifier_filter=a,b,..."
> where a, b are valid callback names. Invalid symbols are discarded.
> 
> Currently up to 16 symbols may be passed in this list, we consider
> that this numbers allows enough flexibility (and no matter what
> architecture is used, at most 30 panic callbacks are registered).
> In an experiment using a qemu x86 virtual machine, by default only
> six callbacks are registered in the panic notifier list.
> Once a valid callback name is provided in the list, such function
> is allowed to be registered/unregistered in the panic_notifier_list;
> all other panic callbacks are ignored. Notice that this filter is
> only for the panic notifiers and has no effect in the other notifiers.

...

> +static int __init panic_notifier_filter_setup(char *buf)
> +{
> +	char *func;
> +	unsigned long addr;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	while (buf) {
> +		func = strsep(&buf, ",");

Don't we have a parser of this format already?
Anyway, you may reduce code by

	unsigned long addr;
	char *func = buf;

	while ((func = strsep(&func, ",")) {

> +		addr = kallsyms_lookup_name(func);
> +
> +		if (!addr) {
> +			pr_info("panic_notifier_filter: invalid symbol %s\n", func);
> +			continue;
> +		}
> +
> +		if (panic_nf_count < PANIC_NF_MAX) {
> +			panic_nf_functions[panic_nf_count] = addr;
> +			panic_nf_count++;
> +			pr_debug("panic_notifier_filter: added symbol %s\n", func);
> +		} else {
> +			pr_warn("panic_notifier_filter: exceeded maximum notifiers (%d), aborting\n",
> +				PANIC_NF_MAX);
> +			panic_nf_count = 0;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +early_param("panic_notifier_filter", panic_notifier_filter_setup);

-- 
With Best Regards,
Andy Shevchenko


