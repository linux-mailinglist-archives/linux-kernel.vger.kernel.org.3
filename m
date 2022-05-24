Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA965324F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiEXIMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEXIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB677F05
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC4BE6153B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6688CC34100;
        Tue, 24 May 2022 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653379856;
        bh=1pXU7dNC7bX9AWRfd+w7BvqrhPzA7UmgXBZTtGD4zJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkc/oeMogx27rxZOfKmWSd9LGFHj1jYn6Smj1Yk473uYgYFnXr9Tl+z3yYh15QU9O
         GyRLOStdMKIAjCG6s0Kazx/X8+XbaADHKbo9E23lRtPfa4HAEEdyvbp5a30FDR7uwK
         flYDJPwCEyWEFPt01K91D2wSkKgBEYWO//ZsNUUM=
Date:   Tue, 24 May 2022 10:10:52 +0200
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
Message-ID: <YoyTDCbELrpCZ3eC@kroah.com>
References: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
 <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com>
 <YmlYRMEzonSnwZ7q@kroah.com>
 <CAK7LNARUUOSd0-Q=bopr5q9J6xbtRAJsUKRGacf+vpuu8KJdxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARUUOSd0-Q=bopr5q9J6xbtRAJsUKRGacf+vpuu8KJdxw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 03:31:59AM +0900, Masahiro Yamada wrote:
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
> >
> > > When you look at EXPORT_SYMBOL_GPL() in C files, you will not be
> > > aware of the presence of the namespace.
> >
> > It's easy to tell when things do not link properly :)
> >
> > > Anyway, it is presumably too late to fix it.
> >
> > Not really, the number of in-kernel users are still small and can be
> > changed if you like.  External users can update when they hit the change
> > as well, not a big deal.
> 
> 
> If I send a patch for global conversion,
> will you be happy to pick it up?
> 
> 
> I think this should be applied at the very last moment
> of the MW.

Make up a patch right after -rc1 to get into -rc2 as that's usually the
best time for tree-wide changes like this.

> I can convert tree-wide by sed.
> 
> 
> Example of conversion:
> 
> EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)
>    -->
> EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")

Ah, but then this breaks my use case where I did in the Android tree:

	EXPORT_SYMBOL_NS_GPL(symbol_name, ANDROID_GKI_VFS_EXPORT_ONLY);

and then in the makefile I did:
	subdir-ccflags-y += -DANDROID_GKI_VFS_EXPORT_ONLY=VFS_internal_I_am_really_a_filesystem_and_am_NOT_a_driver

That saved me typing a lot of "VFS_internal_I_am..." in the .c files.

I know out-of-tree stuff does not matter, but a simple way to make this
work would be nice.

I could just do:
	#define ANDROID_GKI_VFS_EXPORT_ONLY	"VFS_internal_I_am..."
in a .c file which would handle this, right?

Ok, so maybe that isn't an issue, nevermind...

But, if we have a string here, what happens if someone puts a space in
it:
	EXPORT_SYMBOL_NS_GPL(symbol_name, "MY DRIVER NAMESPACE");
that will not break the build but will cause the tools to really
complain, right?  Or do the wrong thing and put them in the "MY"
namespace?

thanks,

greg k-h
