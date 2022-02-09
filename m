Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B564AF0B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiBIMEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiBIMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E4BC050CCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:40:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B95021F390;
        Wed,  9 Feb 2022 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644406839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSWEBqCK6bEh7Ah6m9U0uBjMeOxKtyjx0Sz5afwDSAI=;
        b=vVR1kESID+CTfbU4i754xpLichQMNvB9CmRzfUBSevRAY8bDmuIU1yd8pIXLukeqhjHirV
        THI+KKSzDQHQsk1Hs4wHl/HBn6IvYm0V2G9BiwRAXsWRya3Mi1i6uYXvaFQoX8c3WlP3dv
        +A6HKj7UoQ87oHcu0KaP02Rk5HTXDvY=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09608A3B83;
        Wed,  9 Feb 2022 11:40:38 +0000 (UTC)
Date:   Wed, 9 Feb 2022 12:40:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        mbenes@suse.cz, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, Vaneet Narang <v.narang@samsung.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/1] kallsyms: print module name in %ps/S case when
 KALLSYMS is disabled
Message-ID: <20220209114038.GA8279@pathway.suse.cz>
References: <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcas5p1.samsung.com>
 <20220201040044.1528568-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201040044.1528568-1-maninder1.s@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-01 09:30:44, Maninder Singh wrote:
> original:
> With KALLSYMS
>                    %pS                               %ps
> [16.4200]  hello_init+0x0/0x24 [crash]        hello_init [crash]
> 
> Without KALLSYMS:
> [16.2200]      0xbe200040                         0xbe200040
> 
> With Patch (Without KALLSYMS:) load address + current offset [Module Name]
> 
> [13.5993]  0xbe200000+0x40 [crash]           0xbe200000+0x40 [crash]
> 
> It will help in better debugging and checking when KALLSYMS is disabled,
> user will get information about module name and load address of module.
> 
> verified for arm64:
> / # insmod /crash.ko
> 
> [   19.263556] 0xffff800000ec0000+0x38 [crash]
> 
> ..
> 
> [   19.276023] Call trace:
> [   19.276277]  0xffff800000ec0000+0x28 [crash]
> [   19.276567]  0xffff800000ec0000+0x58 [crash]
> [   19.276727]  0xffff800000ec0000+0x74 [crash]
> [   19.276866]  0xffff8000080127d0
> [   19.276978]  0xffff80000812d95c
> [   19.277085]  0xffff80000812f554

The idea is great. But the patch will need some changes, see below.

> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -163,6 +163,33 @@ static inline bool kallsyms_show_value(const struct cred *cred)
>  	return false;
>  }
>  
> +#ifdef CONFIG_MODULES
> +static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
> +{
> +	struct module *mod;
> +	unsigned long offset;
> +	int ret = 0;
> +
> +	preempt_disable();
> +	mod = __module_address(value);
> +	if (mod) {
> +		offset = value - (unsigned long)mod->core_layout.base;
> +		snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
> +				(unsigned long)mod->core_layout.base, offset, mod->name);
> +
> +		sym[size - 1] = '\0';
> +		ret = 1;
> +	}
> +
> +	preempt_enable();
> +	return ret;
> +}

It looks too big for an inlined function. Anyway, we will need
something even more complex, see below.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 61528094ec87..41c74abb1726 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1007,6 +1005,9 @@ char *symbol_string(char *buf, char *end, void *ptr,
>  
>  	return string_nocheck(buf, end, sym, spec);
>  #else
> +	if (fill_minimal_module_info(sym, KSYM_SYMBOL_LEN, value))
> +		return string_nocheck(buf, end, sym, spec);

The behavior should be different for different modifiers. Namely:

    + the offset is not printed for %ps   // lower-case 's'

    + the address must be searched with offset -1 for %pB  // on stack

    + build ID should be appended when 'b' modifier is appeanded

IMHO, we should implement a generic __sprint_symbol() that will
find the information using kallsyms_lookup_buildid() when available
and fallback to the mininalized approach when kallsyms are not available.

It might require moving the code out of kallsyms.c. It should be
co-ordinated with the other patchset that is moving these sources
into kernel/module/*, see
https://lore.kernel.org/r/20220130213214.1042497-1-atomlin@redhat.com

Adding Aaron and Luis into Cc.

Best Regards,
Petr
