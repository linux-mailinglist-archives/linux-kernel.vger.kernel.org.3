Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DBA512079
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbiD0PP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbiD0PP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:15:57 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430AEB3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:12:45 -0700 (PDT)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 23RFCGxH029250
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:12:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 23RFCGxH029250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651072337;
        bh=sprTPFBkb1nYd+tUQxE6AKqqHG1iIpxB+xGl18i2D7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RvlRrV3Y3VSrBcSgLqZhOIGXUkhKx8/dWtaaCfTvEEjGCXdEge0kdep53FPJ548nh
         q9GI1w5xvTTd+va2wLyb8S/DG8NVgGaYis2/uxQnuvALd4bHg2iY4KNtwNDKGMOGKg
         Lw2cVSAZJ70kgVmEG4ElkeRxtEgds0v3SKmu1hX7j0VE/nHeql2AB4XbCsD4lZW9nk
         KPKI9+Eob1gfpgIwkuJdaWfTro3gQ1M8V6XMrbelUSs9iyGZan9Qm6KwJH8aKPXOWD
         JGCzRN9kH3HtZGl32KgNt9i+Khw3c3LD9+s/2TRvdSTPJX+jyk1mf6Q6AqwgUWhBGW
         0YDDyM8JGnyMw==
X-Nifty-SrcIP: [209.85.214.169]
Received: by mail-pl1-f169.google.com with SMTP id k4so1795591plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:12:17 -0700 (PDT)
X-Gm-Message-State: AOAM5318rASTKq4ez5fiC8uXsL05pUGWwV+hp0I8oE6/8KgcN2SMdSlB
        UxgCTeiXv3ypwP4kGEPRieicxV3YVFDO3gPsfTs=
X-Google-Smtp-Source: ABdhPJynIT/kz5FbCTzQpfqOdAN87jJfw885KNlMjS5rs5EFVchRgh/7eqAGFG5OYq8+ZpRchnds51zuFvgIu/MGGWg=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr33040934pjy.77.1651072336140; Wed, 27
 Apr 2022 08:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
 <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com> <YmlYRMEzonSnwZ7q@kroah.com>
In-Reply-To: <YmlYRMEzonSnwZ7q@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 28 Apr 2022 00:11:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_YdE_nHL=KzXDydrzJ3gxEgTc14RFQfgxm9pjdC0pug@mail.gmail.com>
Message-ID: <CAK7LNAT_YdE_nHL=KzXDydrzJ3gxEgTc14RFQfgxm9pjdC0pug@mail.gmail.com>
Subject: Re: [PATCH v2] export: fix string handling of namespace in EXPORT_SYMBOL_NS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:50 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 27, 2022 at 11:29:19PM +0900, Masahiro Yamada wrote:
> > On Wed, Apr 27, 2022 at 6:06 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Commit c3a6cf19e695 ("export: avoid code duplication in
> > > include/linux/export.h") broke the ability for a defined string to be
> > > used as a namespace value.
> >
> > In hindsight, this was a bad idea.
> >
> >
> > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")
> >
> >    is much much better than:
> >
> > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)
>
> I agree, but it's really not that big of a deal.  We could change it if
> you want.
>
> > ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> >
> > is also a bad idea.
>
> That's not such a bad idea as it lets you set a namespace for a
> directory and below easily.  What would you want to use instead?

I like "explicit" better than "implicit".


With  EXPORT_SYMBOL_GPL(usb_stor_resume);
you need to check Makefile to know whether it is global
or is in a specific namespace.




EXPORT_SYMBOL_NS_GPL(usb_stor_resume, "USB_STORAGE");
will clarify the namespace at a glance.






> > When you look at EXPORT_SYMBOL_GPL() in C files, you will not be
> > aware of the presence of the namespace.
>
> It's easy to tell when things do not link properly :)

Right, modpost will tell you that once you compile it.


>
> > Anyway, it is presumably too late to fix it.
>
> Not really, the number of in-kernel users are still small and can be
> changed if you like.  External users can update when they hit the change
> as well, not a big deal.
>
> Other than using a string for the namespace definition, what would you
> like to see done differently?

Nothing else.

(but I am not a big fan of the module namespace itself.)



>
> > >  Fix this up by using stringify to properly
> > > encode the namespace name.
> > >
> > > Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
> > > Cc: Miroslav Benes <mbenes@suse.cz>
> > > Cc: Emil Velikov <emil.l.velikov@gmail.com>
> > > Cc: Jessica Yu <jeyu@kernel.org>
> > > Cc: Quentin Perret <qperret@google.com>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > This email is no longer valid.
>
> Ah, sorry about that.
>
> > Feel free to replace it with
> >
> > Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Will do, thanks!
>
> greg k-h



-- 
Best Regards
Masahiro Yamada
