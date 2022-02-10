Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8554B080B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiBJIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:19:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiBJIT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:19:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BA1DA9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:19:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A7F191F391;
        Thu, 10 Feb 2022 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644481195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLBGuj3WLicY9g1Tmc3UaqmxcEws/oyehgCnWEx0g+g=;
        b=mb+aWqzk/IgwR3IwCtSKViYm9MwVDvgGZaBJlr0oUcQJC10sJppRy+/WznKA85ZZ1KNpP+
        lPNNPbNps8H/UjqRlhpL3SeO+xI5YsGKmLg+KXrrzX70rBhStLyaK3uoCvTzxeg3KKLlEI
        0BHrxwC/661wV9fdIrCTCJMey16IfBE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B7E5A3B81;
        Thu, 10 Feb 2022 08:19:55 +0000 (UTC)
Date:   Thu, 10 Feb 2022 09:19:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Vimal Agrawal <avimalin@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, mbenes@suse.cz, swboyd@chromium.org,
        ojeda@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, Vaneet Narang <v.narang@samsung.com>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH 1/1] kallsyms: print module name in %ps/S case when
 KALLSYMS is disabled
Message-ID: <YgTKqoRIwahzWyh0@alley>
References: <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcas5p1.samsung.com>
 <20220201040044.1528568-1-maninder1.s@samsung.com>
 <20220209114038.GA8279@pathway.suse.cz>
 <YgRH7hwFC2AGISdP@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgRH7hwFC2AGISdP@bombadil.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-09 15:02:06, Luis Chamberlain wrote:
> On Wed, Feb 09, 2022 at 12:40:38PM +0100, Petr Mladek wrote:
> > > --- a/include/linux/kallsyms.h
> > > +++ b/include/linux/kallsyms.h
> > > @@ -163,6 +163,33 @@ static inline bool kallsyms_show_value(const struct cred *cred)
> > >  	return false;
> > >  }
> > >  
> > > +#ifdef CONFIG_MODULES
> > > +static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
> > > +{
> > > +	struct module *mod;
> > > +	unsigned long offset;
> > > +	int ret = 0;
> > > +
> > > +	preempt_disable();
> > > +	mod = __module_address(value);
> > > +	if (mod) {
> > > +		offset = value - (unsigned long)mod->core_layout.base;
> > > +		snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
> > > +				(unsigned long)mod->core_layout.base, offset, mod->name);
> > > +
> > > +		sym[size - 1] = '\0';
> > > +		ret = 1;
> > > +	}
> > > +
> > > +	preempt_enable();
> > > +	return ret;
> > > +}
> > 
> > It looks too big for an inlined function. Anyway, we will need
> > something even more complex, see below.
> 
> Interesting, these observations might apply to Vimal's work as well [0].
> 
> [0] https://lkml.kernel.org/r/YgKyC4ZRud0JW1PF@bombadil.infradead.org

Honestly, I am not sure what is the best practice. My understanding is
that inlined functions are used primary for speed up at runtime.

Anyway, there is the huge patchset that tries to optimize kernel build
time by optimizing headers, see
https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/T/

This is from the cover letter:

<paste>
Techniques used by the fast-headers tree to reduce header size & dependencies:
[...]
 - Uninlining: there's a number of unnecessary inline functions that also
   couple otherwise unrelated headers to each other. The fast-headers tree
   contains over 100 uninlining commits.
</paste>

It is probably less important for some local includes. I am not sure how
widely is kallsyms.h included.

Best Regards,
Petr
