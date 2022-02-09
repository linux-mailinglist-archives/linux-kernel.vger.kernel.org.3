Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1880D4B00E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiBIXCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:02:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiBIXCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:02:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71982C0302D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EhkMnswuaL4sL/SMOM6zzAjgMyXYRzGf0cCGaPp86to=; b=ZP4VvJJyFFRdDuI4A20xKjwyK9
        oNK2RILfVvVTJJFPVmsMlGxKVz5Npyns1O1VqFKTyZQb5SiBufHOKWKlMK0dN+mthGrjQqtt+rsde
        Eg7RruNFjq3flRI7HSrDkBkO942InE8BitV91uoNATJYS2mJv9QOaJsiwzA0Nbess1hdiSZzxAGsv
        PWolH3gONGAtKMhYngHOtTGQ+a07WMT+9EJQGQ0FpR/hVlhm/WYAYaDQliIL4bxwcxijA2XbhS4r/
        BU9RsrNTeFw8MbjkSgI5HejXoWClKAVlRyjvWBZzTWEkgZKeEUYBCcURbyx2G9c6Bs6zNm5Dg+J/r
        f4/rZ1oA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvyQ-00212U-Ny; Wed, 09 Feb 2022 23:02:06 +0000
Date:   Wed, 9 Feb 2022 15:02:06 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>, Vimal Agrawal <avimalin@gmail.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, mbenes@suse.cz, swboyd@chromium.org,
        ojeda@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, Vaneet Narang <v.narang@samsung.com>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH 1/1] kallsyms: print module name in %ps/S case when
 KALLSYMS is disabled
Message-ID: <YgRH7hwFC2AGISdP@bombadil.infradead.org>
References: <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcas5p1.samsung.com>
 <20220201040044.1528568-1-maninder1.s@samsung.com>
 <20220209114038.GA8279@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209114038.GA8279@pathway.suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 12:40:38PM +0100, Petr Mladek wrote:
> > --- a/include/linux/kallsyms.h
> > +++ b/include/linux/kallsyms.h
> > @@ -163,6 +163,33 @@ static inline bool kallsyms_show_value(const struct cred *cred)
> >  	return false;
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> > +static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
> > +{
> > +	struct module *mod;
> > +	unsigned long offset;
> > +	int ret = 0;
> > +
> > +	preempt_disable();
> > +	mod = __module_address(value);
> > +	if (mod) {
> > +		offset = value - (unsigned long)mod->core_layout.base;
> > +		snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
> > +				(unsigned long)mod->core_layout.base, offset, mod->name);
> > +
> > +		sym[size - 1] = '\0';
> > +		ret = 1;
> > +	}
> > +
> > +	preempt_enable();
> > +	return ret;
> > +}
> 
> It looks too big for an inlined function. Anyway, we will need
> something even more complex, see below.

Interesting, these observations might apply to Vimal's work as well [0].

[0] https://lkml.kernel.org/r/YgKyC4ZRud0JW1PF@bombadil.infradead.org

  Luis
