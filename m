Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4668C52E73C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346963AbiETIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346955AbiETIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:24:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007ED14043C;
        Fri, 20 May 2022 01:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4F73B82A59;
        Fri, 20 May 2022 08:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E35C385A9;
        Fri, 20 May 2022 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653035081;
        bh=XfKwpBP1R2jgDqmH5QbJiPNIqrfBf2dHD4BBgGABNIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D70ljEwuyeXy7X+oZ3tTPMl4azzukqqcW8zv9Rnok1uijxxVpZL9PBTub33s6isP6
         KubHy6vSUMHWfkUVhjke263LhMkXDqfXA32f/QAuzVO4Tmq39jvVGCuyS/JQUtydDm
         SHWARBdCUJ/6bwqIXv6XB4QxNUt/OhF1rJ6CiLbE=
Date:   Fri, 20 May 2022 10:24:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB / dwc3: remove the use of -ENOSYS from core.c
Message-ID: <YodQRpxKA55g5Mt+@kroah.com>
References: <HK0PR01MB280106E1D78EF51A5B8ED8BFF8CE9@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
 <YoZpcqDCwoXIvI5q@kroah.com>
 <HK0PR01MB2801E9A6A53F346BC3436845F8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR01MB2801E9A6A53F346BC3436845F8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:16:29PM +0530, Kushagra Verma wrote:
> On Thu, 2022-05-19 at 17:59 +0200, Greg KH wrote:
> > On Tue, May 17, 2022 at 08:22:00PM +0530, Kushagra Verma wrote:
> > > This patch removes the use of -ENOSYS as it is used when users try
> > > to call a
> > > syscall that doesn't exist. So, we don't need to check if 'ret == -
> > > ENOSYS'.
> > 
> > ENOSYS is also used internally in the kernel for other things.
> > 
> > > 
> > > Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
> > > ---
> > >  drivers/usb/dwc3/core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index c78205c5e19f..3c1a877d5183 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -1283,7 +1283,7 @@ static int dwc3_core_get_phy(struct dwc3
> > > *dwc)
> > >         dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> > >         if (IS_ERR(dwc->usb2_generic_phy)) {
> > >                 ret = PTR_ERR(dwc->usb2_generic_phy);
> > > -               if (ret == -ENOSYS || ret == -ENODEV)
> > > +               if (ret == -ENODEV)
> > 
> > Did you validate that no callers can ever set this to ENOSYS?
> Yes, I think no callers should ever set ret to ENOSYS unless it comes under the other things ENOSYS is used for.

Please audit the code to verify this and document it in the changelog
text when you resend this.

> > Why was this added in the first place?  What commit added it?
> This was added by commit 57303488cd37d ("usb: dwc3: adapt dwc3 core to use Generic PHY Framework").

Great, please also include that information.

thanks,

greg k-h
