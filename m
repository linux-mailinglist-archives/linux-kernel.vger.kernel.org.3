Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC34C1113
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiBWLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiBWLNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:13:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B9088B0F;
        Wed, 23 Feb 2022 03:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6846176E;
        Wed, 23 Feb 2022 11:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABDAC340E7;
        Wed, 23 Feb 2022 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645614790;
        bh=x4CqfBO+Ku65aP/NgFz0azng71ok8liNJQAZPFIG1AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFDOConG/Pg5NvBlGLmzk7yc8Tg7TdRy4PMwrb3fPMxhDiutZOyWRKABOCLGyxjZm
         K24P/Lx4wO53hFn/mvhKpitIQv8NIw5xm2keSqYWzRjv7D5M8rdsU/k1brf1nKuoOL
         md73SYa1S0Z4IHkhJfLOhhRBvA6Fnu4jVVKomiX8=
Date:   Wed, 23 Feb 2022 12:13:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Message-ID: <YhYWw/yEaYJFR1/y@kroah.com>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
 <Ygy7dNqFLZF9XYiH@infradead.org>
 <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
 <YhUJAl5JpCoXik7X@infradead.org>
 <YhYVl9YaoPDwAXO4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhYVl9YaoPDwAXO4@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 01:08:07PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 22, 2022 at 08:02:10AM -0800, Christoph Hellwig wrote:
> > On Tue, Feb 22, 2022 at 10:14:16AM +0100, Jiri Slaby wrote:
> > > On 16. 02. 22, 9:53, Christoph Hellwig wrote:
> > > > On Tue, Feb 15, 2022 at 03:43:59PM +0200, Andy Shevchenko wrote:
> > > > > The pci_iounmap() doesn't cover all the cases where resource should
> > > > > be unmapped. Instead of spreading it more, replace the pci_ioremap_bar()
> > > > > with pcim_iomap() which uses managed resource approach.
> > > > 
> > > > pcim_iomap requires the use of ioreadX/iowriteX and thus runtime
> > > > overhead.  So in doubt please add a pcim_ioremap_bar instead of forcing
> > > > the legacy iomap/ioread/iowrite API onto modern drivers tht can't
> > > > support legacy port I/O.
> > > 
> > > Hmm, the driver combines pci_ioremap_bar with pci_iounmap. pci_iounmap does
> > > the right thing after all, but is that correct? And this driver is not
> > > alone, this shows more:
> > > git grep -E 'pci_iounmap|pci_ioremap_bar' `git grep -l pci_iounmap \`git
> > > grep -l pci_ioremap_bar\``
> > 
> > I think it is wrong.  It is not actively harmful unlike the the
> > combination of pci_iomap and then later use of accessors from the
> > ioremap family, but still not exactly a good idea.
> > 
> > In a perfect world we'd have some different annotation from __iomem
> > for the whole iomap family of functions.
> 
> So, what would be your suggestion for a) backportable change b) cleanup for
> the current and future drivers?

Worry about getting it right first.  Only after that should you even
consider stable tree backports.  There's usually no reason you can't
just take the same change there as well.  And if not, we will work
through it :)

thanks,

greg k-h
