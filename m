Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC54B1B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346906AbiBKBho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:37:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346823AbiBKBhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:37:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0961558E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RpduqcaMhZKLCDjE8PG5uh0tA5u/80+FbxboARzzqGg=; b=BDQwdSWakCszYDEreP6D31+6f0
        uk3LvofeQyFhvpckTO70aiWBzfJxyr/n86wkyg29AlOmUTl9M+/k6RkSgexZ0Jcd67IVY8NLMWznV
        /asfun8rFhKA19Nu+xhJ9sQoTlvwoV8WkoQhPiTF/FI7mBk3AaTCBGIGZuZMPrLqG10w02VePAxOQ
        K0Z2ANhDTJnk/Hg7O82klqHOy18Kr1rLmpYdZMS3k3sK6BRDwbFf2E4pWGi8Kg3YdxDJJIX/FYRU4
        4BD6wsfqx28GUCsdJFhfzIHx1ceDEKso+2Do4bPUa3GRk4GxFlV4Ta2Jnf/yADf4kDE2r5MGz45+X
        cTZ1IXwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIKsB-005Qsi-Jf; Fri, 11 Feb 2022 01:37:19 +0000
Date:   Thu, 10 Feb 2022 17:37:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Petr Mladek <pmladek@suse.com>, Vimal Agrawal <avimalin@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH 1/1] kallsyms: print module name in %ps/S case when
 KALLSYMS is disabled
Message-ID: <YgW9z0ncrzrzwndP@bombadil.infradead.org>
References: <YgTKqoRIwahzWyh0@alley>
 <20220201040044.1528568-1-maninder1.s@samsung.com>
 <20220209114038.GA8279@pathway.suse.cz>
 <YgRH7hwFC2AGISdP@bombadil.infradead.org>
 <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcms5p4>
 <436367503.2691559.1644482903367@mail-kr5-0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436367503.2691559.1644482903367@mail-kr5-0>
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

On Thu, Feb 10, 2022 at 02:18:23PM +0530, Maninder Singh wrote:
> Hi All,
> 
> Thanks for your inputs.
> 
> > On Wed 2022-02-09 15:02:06, Luis Chamberlain wrote:
> > > On Wed, Feb 09, 2022 at 12:40:38PM +0100, Petr Mladek wrote:
> > > > > --- a/include/linux/kallsyms.h
> > > > > +++ b/include/linux/kallsyms.h
> > > > > @@ -163,6 +163,33 @@ static inline bool kallsyms_show_value(const struct cred *cred)
> > > > >          return false;
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_MODULES
> > > > > +static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
> > > > > +{
> > > > > +        struct module *mod;
> > > > > +        unsigned long offset;
> > > > > +        int ret = 0;
> > > > > +
> > > > > +        preempt_disable();
> > > > > +        mod = __module_address(value);
> > > > > +        if (mod) {
> > > > > +                offset = value - (unsigned long)mod->core_layout.base;
> > > > > +                snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
> > > > > +                                (unsigned long)mod->core_layout.base, offset, mod->name);
> > > > > +
> > > > > +                sym[size - 1] = '\0';
> > > > > +                ret = 1;
> > > > > +        }
> > > > > +
> > > > > +        preempt_enable();
> > > > > +        return ret;
> > > > > +}
> > > > 
> > > > It looks too big for an inlined function. Anyway, we will need
> > > > something even more complex, see below.
> > > 
> > > Interesting, these observations might apply to Vimal's work as well [0].
> > > 
> > > [0] https://lkml.kernel.org/r/YgKyC4ZRud0JW1PF@bombadil.infradead.org
> >  
> > Honestly, I am not sure what is the best practice. My understanding is
> > that inlined functions are used primary for speed up at runtime.
> >  
> 
> Main reason of making it inline was:
> (1) kallsysm.c was not getting compiled(with disabled config), so could not add defination there.
> (2) lib/vsnprintf.c was not correct place to define new function of kallsyms(fill_minimal_module_info)
> (3) I thought static int will be part of each .c file which includes kallsyms.h and compiler can make noise for unused functions,
> and also increase code size, where as static inline will be added only if some code is calling that function otherwise will be discarded.
> 
> But as peter said better version will be to make a new defination of __sprint_symbol (probably in kernel/module.c)
> to handle all cases of %ps/S/B/b when KALLSYSMS is disabled.
> 
> I will try to prepare changes and share V2 patch.

If you do please Cc me and Vimal, and Aaron.

  Luis
