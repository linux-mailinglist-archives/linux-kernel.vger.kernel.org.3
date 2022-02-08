Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA02D4ADBFB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379271AbiBHPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbiBHPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:07:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB952C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:06:59 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FAFC1EC053F;
        Tue,  8 Feb 2022 16:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644332814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5V6+rg82A+DxmAE3VHbsHmncej+Msw8/hA8dgQcVZxY=;
        b=Dhvify1MdlhJ+iqcxF4MX3g/0VrwJReO5RpAXNinVkhjY4Y1uc/0MKVgl13vnYUp+3J9qh
        YzgUEG4+PsugGIKrUqs9rh9yiZFVCyWYBVDJyYl5iRy+VnIcsfDDENFQvuL0oPA5znIS0P
        xS+P9VFkFzJEvcv+6yuAfAW+jEOTS5Q=
Date:   Tue, 8 Feb 2022 16:06:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 3/6] x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
Message-ID: <YgKHDBvQFVJhTBzN@zn.tnic>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-4-bp@alien8.de>
 <202202071405.FB72C07@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202202071405.FB72C07@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:07:27PM -0800, Kees Cook wrote:
> On Thu, Jan 27, 2022 at 12:56:23PM +0100, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Those were added as part of the SMAP enablement but SMAP is currently
> > an integral part of kernel proper and there's no need to disable it
> > anymore.
> > 
> > Rip out that functionality.
> > 
> > If still needed - clearcpuid=smap.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  2 +-
> >  Documentation/x86/cpuinfo.rst                 |  5 ++--
> >  arch/x86/Kconfig                              | 11 ---------
> >  arch/x86/include/asm/disabled-features.h      |  8 +------
> >  arch/x86/include/asm/smap.h                   | 24 -------------------
> >  arch/x86/kernel/cpu/common.c                  | 15 +-----------
> >  scripts/Makefile.build                        |  1 -
> >  scripts/link-vmlinux.sh                       |  3 ---
> >  .../arch/x86/include/asm/disabled-features.h  |  8 +------
> >  9 files changed, 6 insertions(+), 71 deletions(-)
> > [...]
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index a4b89b757287..9b37902607ed 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -233,7 +233,6 @@ objtool_args =								\
> >  	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
> >  	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
> >  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
> > -	$(if $(CONFIG_X86_SMAP), --uaccess)				\
> >  	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
> >  	$(if $(CONFIG_SLS), --sls)
> >  
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 666f7bbc13eb..8547aaa1a630 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -140,9 +140,6 @@ objtool_link()
> >  		if is_enabled CONFIG_RETPOLINE; then
> >  			objtoolopt="${objtoolopt} --retpoline"
> >  		fi
> > -		if is_enabled CONFIG_X86_SMAP; then
> > -			objtoolopt="${objtoolopt} --uaccess"
> > -		fi
> >  		if is_enabled CONFIG_SLS; then
> >  			objtoolopt="${objtoolopt} --sls"
> >  		fi
> 
> I was expecting to see --uaccess unconditionally added to objtool
> arguments. I think that needs to happen?

Hmm, I think you're right.

Mr. Z?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
