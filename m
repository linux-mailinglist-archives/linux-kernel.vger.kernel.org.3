Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD54D98C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347116AbiCOKcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiCOKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:32:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F04EA2B;
        Tue, 15 Mar 2022 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647340293; x=1678876293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0dNmYUFs9nRuMrk1s4mw2ka06WKswNmTkimhAQ++6/g=;
  b=gGAMnLW41HpadH9Gufd7lF4pIBWUsw7H7trf2oq+rGKFLFXTg7NOBhi7
   pbuIPXs/0g0ApCvEkZCiuroRO8DSAzTmE/zal9Cikuf0NEcQEJukbxD6R
   kNlVUrhYhQG4sfc3hpM5eD+a4AUHx/q5XQXYMpVHArYuhV3etxdQiOamv
   mJy3iiqrtMN/dFPI0GBeTMB9omchDDLkrQJsWxVOKefq6Slo5RheWd6fM
   5rGH7NsyYcP+/is+qxAyvG8I+grnz4gpqSoIKmnd8gEbD0RzsTHMap72F
   xklbveSsMyrHb0zvwB2EAebUp/0vVL598/fKWWOuj/CRNZ4E3zD2w6UJK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319486285"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="319486285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:31:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="598262614"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:31:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nU4Rz-000CgM-3g;
        Tue, 15 Mar 2022 12:30:47 +0200
Date:   Tue, 15 Mar 2022 12:30:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com
Subject: Re: [PATCH v2] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <YjBq1jg9cNgEqB8T@smile.fi.intel.com>
References: <CGME20220315095129epcas5p230b94ea10517d148c9cae0669229b0fc@epcas5p2.samsung.com>
 <20220315095112.439580-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315095112.439580-1-maninder1.s@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:21:12PM +0530, Maninder Singh wrote:
> print module information when KALLSYMS is disabled.
> 
> No change for %pB, as it needs to know symbol name to adjust address
> value which can't be done without KALLSYMS.

...

> +int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
> +			    int backtrace, int symbol)
> +{
> +	if (backtrace)
> +		return __sprint_symbol(buffer, address, -1, 1, build_id);

> +	else if (symbol)
> +		return __sprint_symbol(buffer, address, 0, 1, build_id);
> +	else
> +		return __sprint_symbol(buffer, address, 0, 0, 0);

Redundant 'else' in both cases.

> +}

...

> +static int sprint_module_info(char *buf, char *end, unsigned long value,
> +			     const char *fmt, int modbuildid, int backtrace, int symbol)

fmt is not used.

> +{
> +	struct module *mod;
> +	unsigned long offset = 0;

> +	unsigned long base;

Can it be the same type as core_layout.base? Why not?

> +	char *modname;
> +	int len;
> +	const unsigned char *buildid = NULL;
> +
> +	if (is_ksym_addr(value))
> +		return 0;
> +
> +	if (backtrace || symbol)
> +		offset = 1;

I would expect here to have

	else
		offset = 0;

But see below.

> +	preempt_disable();
> +	mod = __module_address(value);
> +	if (mod) {
> +		modname = mod->name;
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +		if (modbuildid)
> +			buildid = mod->build_id;
> +#endif

> +		if (offset) {

This seems quite confusing because semantically you use offset as a boolean
flag and offset. Why not add a boolean variable with a clear name?

> +			base = (unsigned long)mod->core_layout.base;
> +			offset = value - base;
> +		}
> +	}

> +

Probably you can drop this blank line to group entire critical section,
or add a blank line above.

> +	preempt_enable();
> +	if (!mod)
> +		return 0;
> +
> +	/* address belongs to module */
> +	if (offset)
> +		len = sprintf(buf, "0x%p+0x%lx", (void *)base, offset);
> +	else

> +		len = sprintf(buf, "0x%lx", (void *)value);

What this casting is for? Don't you have a compilation warning?

> +	len += fill_name_build_id(buf, modname, modbuildid, buildid, len);
> +	return len;

	return len + ...;

?

> +}

-- 
With Best Regards,
Andy Shevchenko


