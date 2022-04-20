Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84A508B20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354652AbiDTOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354576AbiDTOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36B99FC6;
        Wed, 20 Apr 2022 07:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FECA61647;
        Wed, 20 Apr 2022 14:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C01C385A0;
        Wed, 20 Apr 2022 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650466126;
        bh=jR7Z7OXhBGt1x/0Bst0eQ/OwZ6UaH8gUyDG7/HT+C0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1nv358Co9gdjKCaPmYAh5g22Zavn9gkXi+5M5g2fqzoZdNyP0RJx0QSfXDB/nNk2o
         DWJFSkxxhhxTMj8RciVa7mW1v6b2sGgAglMZJSHKFjVgGcwc5+a/K7MY2Teb1+lg1n
         leFHAdERf4rRXy0wLHuyJ6TROcoTEsnmRCywMRoM=
Date:   Wed, 20 Apr 2022 16:48:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 1/2] serial: 8250: Fold EndRun device support
 into OxSemi Tornado code
Message-ID: <YmAdTDkZzdiQNKab@kroah.com>
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk>
 <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk>
 <Ylk3HNZqnBLMMQCm@kroah.com>
 <alpine.DEB.2.21.2204172339300.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204172339300.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:02:54AM +0100, Maciej W. Rozycki wrote:
> On Fri, 15 Apr 2022, Greg Kroah-Hartman wrote:
> 
> > > Index: linux-macro/include/linux/pci_ids.h
> > > ===================================================================
> > > --- linux-macro.orig/include/linux/pci_ids.h
> > > +++ linux-macro/include/linux/pci_ids.h
> > > @@ -2622,6 +2622,9 @@
> > >  #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
> > >  #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
> > >  
> > > +#define PCI_VENDOR_ID_ENDRUN		0x7401
> > > +#define PCI_DEVICE_ID_ENDRUN_1588	0xe100
> > 
> > As per the top of this file, this should not be needed here as you are
> > only using it in one file.  Please leave it as-is.
> 
>  I find this requirement silly, but here it's not the place to discuss it, 

You have not had to deal with merge issues in this file before.  Think
about every single PCI driver author updating this single file.  That
just does not work at the scale we run at, sorry.  I put this rule into
place 15+ years ago for that reason.

thanks,

greg k-h
