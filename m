Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC44C7239
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiB1RLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiB1RLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:11:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EFE7486F;
        Mon, 28 Feb 2022 09:10:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B991C219A4;
        Mon, 28 Feb 2022 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646068227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Se4zhHEaPU9V1yfCSSf057AkUax+xeAkyFZTtecsvOk=;
        b=PnNjZmmzjdTC81o0wLPptLX10/+Iqzu9UE7f1fYDvqrY9DjWKwDYuchbuOlnzNHqKiz7i/
        VgsVDpACPfAOiCFoQgHhtieQhBQ0PYUePRxXsQo74Sgh7/dwKZjhxAc2xZ1jOwHdFlpCAB
        kGthl5H97S97NGMn34uqJdlHcSsP4fg=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B3B8FA3B81;
        Mon, 28 Feb 2022 17:10:26 +0000 (UTC)
Date:   Mon, 28 Feb 2022 18:10:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>, mcgrof@kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, v.narang@samsung.com,
        swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <YhzywNowPiQm3IN4@alley>
References: <CGME20220228053457epcas5p1dac3fced39d1594f8fdfc5e64e23ac73@epcas5p1.samsung.com>
 <20220228053447.1584704-1-maninder1.s@samsung.com>
 <Yhy6EtP/Yr03bHTl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhy6EtP/Yr03bHTl@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Kees into Cc. This patch allows to see non-hashed base
address of the module and eventually of vmlinux, see below.

On Mon 2022-02-28 14:03:30, Andy Shevchenko wrote:
> On Mon, Feb 28, 2022 at 11:04:47AM +0530, Maninder Singh wrote:
> > with commit '82b37e632513 ("kallsyms: print module name in %ps/S
> > case when KALLSYMS is disabled"), module name printing was enhanced.

The commit does not exist.

Note that linux-next is regularly rebased. Commit IDs might still be
stable when they are merged from a maintainer git tree. But Andrew's
-mm tree is imported from quilt and the patches always get new
commit ID.

The best solution is to handle the changes in a single patchset.

> > As per suggestion from Petr Mladek <pmladek@suse.com>, covering
> > other flavours also to print build id also.
> > 
> > for %pB no change as it needs to know symbol name to adjust address
> > value which can't be done without KALLSYMS.
> > 
> > original output with KALLSYMS:
> > [8.842129] ps function_1 [crash]
> > [8.842735] pS function_1+0x4/0x2c [crash]
> > [8.842890] pSb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> > [8.843175] pB function_1+0x4/0x2c [crash]
> > [8.843362] pBb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> > 
> > original output without KALLSYMS:
> > [12.487424] ps 0xffff800000eb008c
> > [12.487598] pS 0xffff800000eb008c
> > [12.487723] pSb 0xffff800000eb008c
> > [12.487850] pB 0xffff800000eb008c
> > [12.487967] pBb 0xffff800000eb008c
> > 
> > With patched kernel without KALLSYMS:
> > [9.205207] ps 0xffff800000eb008c [crash]
> > [9.205564] pS 0xffff800000eb0000+0x8c [crash]
> > [9.205757] pSb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> > [9.206066] pB 0xffff800000eb0000+0x8c [crash]
> > [9.206257] pBb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> 
> ...
> 
> > +static int sprint_module_info(char *buf, char *end, unsigned long value,
> > +			     const char *fmt)
> > +{
> > +	struct module *mod;
> > +	unsigned long offset = 1;
> > +	unsigned long base;
> 
> > +	int ret = 0;
> 
> This is hard to find if it's not close to the first use.
> Since you are using positive numbers...

The name of the variable is misleading. It is not a return value.
It is set when:

	if (mod) {
		ret = 1;

and used:

	if (!ret)
		return 0;


In fact, we do not need the value at all. It is enough to do:

	if (!mod)
		return 0;


> > +	const char *modname;
> > +	int modbuildid = 0;
> > +	int len;
> > +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> > +	const unsigned char *buildid = NULL;
> > +#endif
> > +
> > +	if (is_ksym_addr(value))
> > +		return 0;
> 
> > +	if (*fmt == 'B' && fmt[1] == 'b')
> > +		modbuildid = 1;
> > +	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
> 
> Why not to split to two conditionals? Would be easier to get,

This is copy&paste from symbol_string().

> > +		modbuildid = 1;
> > +	else if (*fmt != 's') {
> 
> These all are inconsistent, please switch to fmt[0].
> 
> > +		/*
> > +		 * do nothing.
> > +		 */
> > +	} else
> > +		offset = 0;
> > +
> > +	preempt_disable();
> > +	mod = __module_address(value);
> > +	if (mod) {
> > +		ret = 1;
> > +		modname = mod->name;
> > +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> > +		if (modbuildid)
> > +			buildid = mod->build_id;
> > +#endif
> > +		if (offset) {
> > +			base = (unsigned long)mod->core_layout.base;
> > +			offset = value - base;
> > +		}
> > +	}
> > +
> > +	preempt_enable();
> 
> > +	if (!ret)
> 
> This looks a bit strange, but okay, I'm not familiar with the function of this
> code.

Yes, this can be replaced by

	/* We handle offset only against module base. */
	if (!mod)
		return 0;

Hmm, why don't we compute offset against vmlinux base when the symbol
is from vmlinux?

Wait, this would show base address of vmlinux. It would be security
hole.

Wait, if the base address of vmlinux is security hole then the base
address of module is security hole as well.

IMHO, we must hash the base address when the hashing is not disabled!


> > +		return 0;
> > +
> > +	/* address belongs to module */
> > +	if (offset)
> > +		len = sprintf(buf, "0x%lx+0x%lx", base, offset);
> > +	else
> > +		len = sprintf(buf, "0x%lx", value);
> > +
> > +	len += sprintf(buf + len, " [%s", modname);
> > +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> > +	if (modbuildid && buildid) {
> > +		/* build ID should match length of sprintf */
> > +		static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
> > +		len += sprintf(buf + len, " %20phN", buildid);
> > +	}
> > +#endif
> > +	len += sprintf(buf + len, "]");

And all these sprint() calls are copy&pasted from __sprint_symbol().

We really should reduce the cut&pasting.

> > +
> > +	return len;
> > +}

Best Regards,
Petr
