Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084685113AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359517AbiD0Ipm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiD0Iph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:45:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595984ED5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0F7EB82539
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05125C385A7;
        Wed, 27 Apr 2022 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651048943;
        bh=fKFAg7yyRNNSgvuezxx6sbeGgfw2ClQ/UPWWRA3anwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5hCz4A6L3BxKUDH6/UROdADwrk0z5m42iU59prw/wC1NtIpgsjTEyurZp3wA7kSF
         bfAzj1Yh4MqYIIeJau2o7THzXLdEp/TLvKqx4fLVtXzm1Q7DbgJJcte+BdzmfUg4om
         eZMaRqGnYj5zHK7BJyvWDImPv76ybNgdaPVo2kv4=
Date:   Wed, 27 Apr 2022 10:42:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH] export: fix string handling of namespace in
 EXPORT_SYMBOL_NS
Message-ID: <YmkB7JdGPFQD+5Nt@kroah.com>
References: <20220108140415.3360088-1-gregkh@linuxfoundation.org>
 <CAK7LNASC+PBFqbsAFWbePoEjL5d21z95Nb84AHTkPjiMcWG_Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASC+PBFqbsAFWbePoEjL5d21z95Nb84AHTkPjiMcWG_Gg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 04:14:00AM +0900, Masahiro Yamada wrote:
> On Sat, Jan 8, 2022 at 11:04 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Commit c3a6cf19e695 ("export: avoid code duplication in
> > include/linux/export.h") broke the ability for a defined string to be
> > used as a namespace value.  Fix this up by adding another layer of
> > indirection to preserve the previous functionality.
> >
> > Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
> > Cc: Miroslav Benes <mbenes@suse.cz>
> > Cc: Emil Velikov <emil.l.velikov@gmail.com>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Quentin Perret <qperret@google.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Matthias Maennich <maennich@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Note, I found this while forward porting an out-of-tree Android kernel
> > patch from 5.4 to 5.10 that used module namespaces to help wall-off vfs
> > symbols from being used by non-filesystem modules.  This issue does not
> > affect any in-kernel code, so I am not so sure if it really is needed
> > here, but it does restore the previous functionality that was being used
> > in older kernels so it might be good to put back in case others want to
> > do much the same thing.
> >
> >  include/linux/export.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/export.h b/include/linux/export.h
> > index 27d848712b90..9a992809f57d 100644
> > --- a/include/linux/export.h
> > +++ b/include/linux/export.h
> > @@ -162,8 +162,10 @@ struct kernel_symbol {
> >
> >  #define EXPORT_SYMBOL(sym)             _EXPORT_SYMBOL(sym, "")
> >  #define EXPORT_SYMBOL_GPL(sym)         _EXPORT_SYMBOL(sym, "_gpl")
> > -#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "", #ns)
> > -#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl", #ns)
> > +#define _EXPORT_SYMBOL_NS(sym, ns)     __EXPORT_SYMBOL(sym, "", #ns)
> > +#define _EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL(sym, "_gpl", #ns)
> > +#define EXPORT_SYMBOL_NS(sym, ns)      _EXPORT_SYMBOL_NS(sym, ns)
> > +#define EXPORT_SYMBOL_NS_GPL(sym, ns)  _EXPORT_SYMBOL_NS_GPL(sym, ns)
> >
> >  #endif /* !__ASSEMBLY__ */
> >
> > --
> > 2.34.1
> >
> 
> I see __stringify() a few files above.
> So, you can use it here as well.
> 
> 
> Does the following code work?   (untested)
> 
> 
> 
> 
> 
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 27d848712b90..5910ccb66ca2 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_EXPORT_H
>  #define _LINUX_EXPORT_H
> 
> +#include <linux/stringify.h>
> +
>  /*
>   * Export symbols from the kernel to modules.  Forked from module.h
>   * to reduce the amount of pointless cruft we feed to gcc when only
> @@ -154,7 +156,6 @@ struct kernel_symbol {
>  #endif /* CONFIG_MODULES */
> 
>  #ifdef DEFAULT_SYMBOL_NAMESPACE
> -#include <linux/stringify.h>
>  #define _EXPORT_SYMBOL(sym, sec)       __EXPORT_SYMBOL(sym, sec,
> __stringify(DEFAULT_SYMBOL_NAMESPACE))
>  #else
>  #define _EXPORT_SYMBOL(sym, sec)       __EXPORT_SYMBOL(sym, sec, "")
> @@ -162,8 +163,8 @@ struct kernel_symbol {
> 
>  #define EXPORT_SYMBOL(sym)             _EXPORT_SYMBOL(sym, "")
>  #define EXPORT_SYMBOL_GPL(sym)         _EXPORT_SYMBOL(sym, "_gpl")
> -#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "", #ns)
> -#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl", #ns)
> +#define EXPORT_SYMBOL_NS(sym, ns)      __EXPORT_SYMBOL(sym, "",
> __stringify(ns))
> +#define EXPORT_SYMBOL_NS_GPL(sym, ns)  __EXPORT_SYMBOL(sym, "_gpl",
> __stringify(ns))
> 
>  #endif /* !__ASSEMBLY__ */

Sorry for the long delay, but yes, this does seem to resolve the issue
for me.  I'll respin this and resend, thanks!

greg k-h
