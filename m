Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113A1512003
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243104AbiD0Q2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242471AbiD0Q1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE63A5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7781761D73
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD61C385A7;
        Wed, 27 Apr 2022 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651076514;
        bh=NCQz/cItdvzI928NKVHeYCqXxxe530d87deKgvE5cRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHKOmHxtzi+3V/XsGaUnDgXUB5uPSnXt3nPEEwr4HhQzftCVVgUYP063mBfNCgsXA
         vkQamAw5Z6JsMDUudjScGaiaTukB4gRoW88R/LfvFCs8htOVFdRBAVdKuhOAXv4YXv
         qvpBJVou+6hDp7zv24erzIMa2Sijg9aC7PJLLsZE=
Date:   Wed, 27 Apr 2022 18:21:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH v2] export: fix string handling of namespace in
 EXPORT_SYMBOL_NS
Message-ID: <Ymltn72chRkV4P83@kroah.com>
References: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
 <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com>
 <YmlYRMEzonSnwZ7q@kroah.com>
 <CAK7LNAT_YdE_nHL=KzXDydrzJ3gxEgTc14RFQfgxm9pjdC0pug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT_YdE_nHL=KzXDydrzJ3gxEgTc14RFQfgxm9pjdC0pug@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:11:13AM +0900, Masahiro Yamada wrote:
> On Wed, Apr 27, 2022 at 11:50 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 11:29:19PM +0900, Masahiro Yamada wrote:
> > > On Wed, Apr 27, 2022 at 6:06 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Commit c3a6cf19e695 ("export: avoid code duplication in
> > > > include/linux/export.h") broke the ability for a defined string to be
> > > > used as a namespace value.
> > >
> > > In hindsight, this was a bad idea.
> > >
> > >
> > > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")
> > >
> > >    is much much better than:
> > >
> > > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)
> >
> > I agree, but it's really not that big of a deal.  We could change it if
> > you want.
> >
> > > ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> > >
> > > is also a bad idea.
> >
> > That's not such a bad idea as it lets you set a namespace for a
> > directory and below easily.  What would you want to use instead?
> 
> I like "explicit" better than "implicit".
> 
> With  EXPORT_SYMBOL_GPL(usb_stor_resume);
> you need to check Makefile to know whether it is global
> or is in a specific namespace.
> 
> EXPORT_SYMBOL_NS_GPL(usb_stor_resume, "USB_STORAGE");
> will clarify the namespace at a glance.

I agree, but currently I use the makefile change in a big out-of-tree
project to do "all exported symbols in this directory and lower are now
in this namespace".  That's a huge help and makes for a 2 line change
vs. a hundreds-of-lines change.

> > > When you look at EXPORT_SYMBOL_GPL() in C files, you will not be
> > > aware of the presence of the namespace.
> >
> > It's easy to tell when things do not link properly :)
> 
> Right, modpost will tell you that once you compile it.

And that's the best thing, 'make nsdeps' will then even generate a patch
to fix things up.

> > > Anyway, it is presumably too late to fix it.
> >
> > Not really, the number of in-kernel users are still small and can be
> > changed if you like.  External users can update when they hit the change
> > as well, not a big deal.
> >
> > Other than using a string for the namespace definition, what would you
> > like to see done differently?
> 
> Nothing else.
> 
> (but I am not a big fan of the module namespace itself.)

I think more subsystems need to start using them as it instantly shows
where some drivers are doing things that maybe they shouldn't be doing.
It was insightful when the dma-buf code moved to a module namespace as
it found places the maintainers were not even aware of.

Anyway, it's on my long-term todo list...

thanks,

greg k-h
