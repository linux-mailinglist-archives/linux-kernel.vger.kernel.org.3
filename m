Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C79511AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiD0OyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiD0OyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:54:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D1F40933
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2482B82793
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3480C385AC;
        Wed, 27 Apr 2022 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651071048;
        bh=DWRwns8xiBwBxR6L/oHvGmhJemmgTEQP53zp86oJniA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgVAlXpy8MEVpTLFhjqYVttfew/h4xa9fUKvfpFdg3UKfi5VB/BkeOZKJBWb9/MPq
         x+RkQR1DVMrmIqWmdRq+BtZrAcdkscTHFu5w0H7Y2mVz841aIXALX6C5bdnWeZvKTT
         1ekqTW/GVFn95xqzZTxTbIqCnaPHMwugw3HhDCyU=
Date:   Wed, 27 Apr 2022 16:50:44 +0200
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
Message-ID: <YmlYRMEzonSnwZ7q@kroah.com>
References: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
 <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:29:19PM +0900, Masahiro Yamada wrote:
> On Wed, Apr 27, 2022 at 6:06 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Commit c3a6cf19e695 ("export: avoid code duplication in
> > include/linux/export.h") broke the ability for a defined string to be
> > used as a namespace value.
> 
> In hindsight, this was a bad idea.
> 
> 
> EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")
> 
>    is much much better than:
> 
> EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)

I agree, but it's really not that big of a deal.  We could change it if
you want.

> ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> 
> is also a bad idea.

That's not such a bad idea as it lets you set a namespace for a
directory and below easily.  What would you want to use instead?

> When you look at EXPORT_SYMBOL_GPL() in C files, you will not be
> aware of the presence of the namespace.

It's easy to tell when things do not link properly :)

> Anyway, it is presumably too late to fix it.

Not really, the number of in-kernel users are still small and can be
changed if you like.  External users can update when they hit the change
as well, not a big deal.

Other than using a string for the namespace definition, what would you
like to see done differently?

> >  Fix this up by using stringify to properly
> > encode the namespace name.
> >
> > Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
> > Cc: Miroslav Benes <mbenes@suse.cz>
> > Cc: Emil Velikov <emil.l.velikov@gmail.com>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Quentin Perret <qperret@google.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> This email is no longer valid.

Ah, sorry about that.

> Feel free to replace it with
> 
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Will do, thanks!

greg k-h
