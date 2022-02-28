Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131D54C6BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiB1MHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiB1MHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:07:12 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A126517A;
        Mon, 28 Feb 2022 04:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646049993; x=1677585993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UuAla6m/V0nIds1h63OYuJUqlKC4Nbr7PiBMOfpW4x8=;
  b=jPQZeZG1dsVTfZWgsHod9odxTpBdBqz6O9VHekiv25zvOT8VgVa13iej
   koKmTZiMc83mZJHQfdGMUAqeoc91KaPghy9MryeFOwDkLVM9CbdHBynIu
   yXsRK4kmSSgEnd25DccoXSp05nVLDv15Re5yflra5VvlXtIHKLGZ9r3Jp
   ImcSpXZHP5t5dixXyMykxDoSs4NCL2LEYC+WYxJ/b30Hz6HbfZv8BZ0Gz
   eu26Tb4ZHDhGSn3/NJ7yAerOtCOJdWK0HeF/5pvjmImxhF4IAOBWbqtvQ
   AdQsu5Xvy4eCA2R9wmIW5tEyzxPV6Zv6hZlDjGjbrceVzz5dmvq7ZctQb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="313584614"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="313584614"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 04:06:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="608431456"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 04:06:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nOekU-009IH6-OV;
        Mon, 28 Feb 2022 14:03:30 +0200
Date:   Mon, 28 Feb 2022 14:03:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.or,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com
Subject: Re: [PATCH 1/1] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <Yhy6EtP/Yr03bHTl@smile.fi.intel.com>
References: <CGME20220228053457epcas5p1dac3fced39d1594f8fdfc5e64e23ac73@epcas5p1.samsung.com>
 <20220228053447.1584704-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228053447.1584704-1-maninder1.s@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:04:47AM +0530, Maninder Singh wrote:
> with commit '82b37e632513 ("kallsyms: print module name in %ps/S
> case when KALLSYMS is disabled"), module name printing was enhanced.
> 
> As per suggestion from Petr Mladek <pmladek@suse.com>, covering
> other flavours also to print build id also.
> 
> for %pB no change as it needs to know symbol name to adjust address
> value which can't be done without KALLSYMS.
> 
> original output with KALLSYMS:
> [8.842129] ps function_1 [crash]
> [8.842735] pS function_1+0x4/0x2c [crash]
> [8.842890] pSb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> [8.843175] pB function_1+0x4/0x2c [crash]
> [8.843362] pBb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> 
> original output without KALLSYMS:
> [12.487424] ps 0xffff800000eb008c
> [12.487598] pS 0xffff800000eb008c
> [12.487723] pSb 0xffff800000eb008c
> [12.487850] pB 0xffff800000eb008c
> [12.487967] pBb 0xffff800000eb008c
> 
> With patched kernel without KALLSYMS:
> [9.205207] ps 0xffff800000eb008c [crash]
> [9.205564] pS 0xffff800000eb0000+0x8c [crash]
> [9.205757] pSb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> [9.206066] pB 0xffff800000eb0000+0x8c [crash]
> [9.206257] pBb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]

...

> +static int sprint_module_info(char *buf, char *end, unsigned long value,
> +			     const char *fmt)
> +{
> +	struct module *mod;
> +	unsigned long offset = 1;
> +	unsigned long base;

> +	int ret = 0;

This is hard to find if it's not close to the first use.
Since you are using positive numbers...

> +	const char *modname;
> +	int modbuildid = 0;
> +	int len;
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +	const unsigned char *buildid = NULL;
> +#endif
> +
> +	if (is_ksym_addr(value))
> +		return 0;

> +	if (*fmt == 'B' && fmt[1] == 'b')
> +		modbuildid = 1;
> +	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))

Why not to split to two conditionals? Would be easier to get,

> +		modbuildid = 1;
> +	else if (*fmt != 's') {

These all are inconsistent, please switch to fmt[0].

> +		/*
> +		 * do nothing.
> +		 */
> +	} else
> +		offset = 0;
> +
> +	preempt_disable();
> +	mod = __module_address(value);
> +	if (mod) {
> +		ret = 1;
> +		modname = mod->name;
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +		if (modbuildid)
> +			buildid = mod->build_id;
> +#endif
> +		if (offset) {
> +			base = (unsigned long)mod->core_layout.base;
> +			offset = value - base;
> +		}
> +	}
> +
> +	preempt_enable();

> +	if (!ret)

This looks a bit strange, but okay, I'm not familiar with the function of this
code.

> +		return 0;
> +
> +	/* address belongs to module */
> +	if (offset)
> +		len = sprintf(buf, "0x%lx+0x%lx", base, offset);
> +	else
> +		len = sprintf(buf, "0x%lx", value);
> +
> +	len += sprintf(buf + len, " [%s", modname);
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +	if (modbuildid && buildid) {
> +		/* build ID should match length of sprintf */
> +		static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
> +		len += sprintf(buf + len, " %20phN", buildid);
> +	}
> +#endif
> +	len += sprintf(buf + len, "]");
> +
> +	return len;
> +}

-- 
With Best Regards,
Andy Shevchenko


