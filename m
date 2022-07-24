Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7B57F570
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiGXOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGXOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:16:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E199627D;
        Sun, 24 Jul 2022 07:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0972CE0B1E;
        Sun, 24 Jul 2022 14:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A080FC3411E;
        Sun, 24 Jul 2022 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658672158;
        bh=Z81hIs8cdbSbSj3eyFpQt8NRpRerp6ca5j7+Cp23M4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0TYVlUme59HZ9ym8UHlNLkJp/uEm3smK7iExjAAJ3H03BW8JkkUFE4+0KzXLhQUz
         TiJpzlry4KbaBIQUwVIm6KzyRzPFjiSK+ZOSUF0LK+uVFv3Yb715zt+ZkKYv70gQuJ
         zxC5hyxtK8n86sZ9in6lWL/NNZdPyYDU8b+i6SjQ=
Date:   Sun, 24 Jul 2022 16:15:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: usb_wwan: replace DTR/RTS magic numbers
 with macros
Message-ID: <Yt1UG058Qjsngps6@kroah.com>
References: <20220722085040.704885-1-sdlyyxy@bupt.edu.cn>
 <Yt0MfqQQTwe4ztuN@hovoldconsulting.com>
 <Yt1OPKNlWZuMrZv4@kroah.com>
 <Yt1SFXlwbW1JCohE@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt1SFXlwbW1JCohE@hovoldconsulting.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 04:07:17PM +0200, Johan Hovold wrote:
> On Sun, Jul 24, 2022 at 03:50:52PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Jul 24, 2022 at 11:10:22AM +0200, Johan Hovold wrote:
> > > On Fri, Jul 22, 2022 at 04:50:40PM +0800, Yan Xinyu wrote:
> > > > The usb_wwan_send_setup function generates DTR/RTS signals in compliance
> > > > with CDC ACM standard. This patch changes magic numbers in this function
> > > > to equivalent macros.
> > > > 
> > > > Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> > > > ---
> > > > v1->v2:
> > > >  * Fix Signed-off-by name.
> > > > v2->v3:
> > > >  * Use already defined ACM_CTRL_DTR and ACM_CTRL_RTS in drivers/usb/class/cdc-acm.h
> > > > ---
> > > >  drivers/usb/serial/usb_wwan.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
> > > > index dab38b63eaf7..5c8303bd3676 100644
> > > > --- a/drivers/usb/serial/usb_wwan.c
> > > > +++ b/drivers/usb/serial/usb_wwan.c
> > > > @@ -29,8 +29,10 @@
> > > >  #include <linux/bitops.h>
> > > >  #include <linux/uaccess.h>
> > > >  #include <linux/usb.h>
> > > > +#include <linux/usb/cdc.h>
> > > >  #include <linux/usb/serial.h>
> > > >  #include <linux/serial.h>
> > > > +#include "../class/cdc-acm.h"
> > > 
> > > If we are to use common defines, these would need to be added to
> > > linux/usb/cdc.h first (parts of which are exposed to user space).
> > > 
> > > Note that we already have at least three copies of these defines in the
> > > tree.
> > > 
> > > I'm fine with adding another copy for now and not have to deal with with
> > > naming and cross driver updates. What do you think, Greg?
> > 
> > I think Yan should write a patch series to unify these and make it
> > right, instead of just papering over it all.
> 
> Ok, I just fear it will be more work for us since that involves
> decisions like whether it should be added to the uapi header, and then
> we get into naming, etc. But we're in no rush.
> 
> > Also this "../" stuff in a
> > #include directive is not ok, I wouldn't recommend this change be taken
> > as-is.
> 
> That was never an option, but I'd be ok with taking the v2 which added
> defines for the constants directly in the driver.

These are global defines, in a public spec, and they should all just be
in one place in the kernel.  What's wrong with include/uapi/linux/cdc.h
which is where the other ACM defined values are at?

thanks,

greg k-h
