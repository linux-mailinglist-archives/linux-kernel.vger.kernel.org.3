Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B2E580F53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiGZIov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGZIot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:44:49 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01527CC4;
        Tue, 26 Jul 2022 01:44:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7EA1CDF985;
        Tue, 26 Jul 2022 01:44:48 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sQd45dya_6k8; Tue, 26 Jul 2022 01:44:47 -0700 (PDT)
Message-ID: <ea2a284abf99c8015024c305c914e54eb1e8d80c.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658825087; bh=VI+Psrn6/lqx/JXqOOuObKZPj/CHv9mceM1I37Xzr90=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uQNT73Q6Sqv3QwdqWqhZ7ljFLJRetQ/z0V/qzrrw2t7twT0DO/Aemf0/IHRATScIj
         met2zqdcVGzfA4SLyh4tYf8AU71PpS8OhY/3hBgsg46qQsjqgc9+r2W3v03anndbWH
         TUAMiJWvaOQCTHcO89Q8tXqRKjq7iT2vrMg7HhUVX3DAEhjhOQGMtWGQlK4b71K+2n
         Yv0GXDzFBeAmYIbuZB5Yn4VHDxq+HMFmNMPgzkI5afw5vi8zt/RH7oJKJGxx5w8Hqa
         G8jXcECsKxq2j5bFbA2weLAdjLNC/giUfnwzWJ0+3k2EhAZF8OGooSzxAlptIMm+Sv
         iJsW9BFQ+vrFw==
Subject: Re: [PATCH v2] usb: typec: tipd: Don't block probing of consumer of
 "connector" nodes
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus.ainslie@puri.sm>
Cc:     grandmaster@al2klimov.de, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, rjw@rjwysocki.net, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Date:   Tue, 26 Jul 2022 10:44:49 +0200
In-Reply-To: <CAGETcx-rfcP9dFSstf7PKmc2W3kWRLCMRGz8uCvJxo-OpFpjgw@mail.gmail.com>
References: <20210714061807.5737-1-martin.kepplinger@puri.sm>
         <CAGETcx-rfcP9dFSstf7PKmc2W3kWRLCMRGz8uCvJxo-OpFpjgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 21.07.2022 um 16:06 -0700 schrieb Saravana Kannan:
> On Tue, Jul 13, 2021 at 11:18 PM Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> > 
> > Similar as with tcpm this patch lets fw_devlink know not to wait on
> > the
> > fwnode to be populated as a struct device.
> > 
> > Without this patch, USB functionality can be broken on some
> > previously
> > supported boards.
> > 
> > Fixes: 28ec344bb891 ("usb: typec: tcpm: Don't block probing of
> > consumers of "connector" nodes")
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> > 
> > revision history
> > ----------------
> > v2: (thank you Saravana)
> > * add a code-comment why the call is needed.
> > 
> > v1:
> > https://lore.kernel.org/linux-usb/20210713073946.102501-1-martin.kepplinger@puri.sm/
> > 
> > 
> > 
> >  drivers/usb/typec/tipd/core.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c
> > b/drivers/usb/typec/tipd/core.c
> > index 938219bc1b4b..21b3ae25c76d 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -629,6 +629,15 @@ static int tps6598x_probe(struct i2c_client
> > *client)
> >         if (!fwnode)
> >                 return -ENODEV;
> > 
> > +       /*
> > +        * This fwnode has a "compatible" property, but is never
> > populated as a
> > +        * struct device. Instead we simply parse it to read the
> > properties.
> > +        * This breaks fw_devlink=on. To maintain backward
> > compatibility
> > +        * with existing DT files, we work around this by deleting
> > any
> > +        * fwnode_links to/from this fwnode.
> > +        */
> > +       fw_devlink_purge_absent_suppliers(fwnode);
> > +
> 
> Hey Martin,
> 
> As part of a series I'm working on, I'm looking into deleting
> fw_devlink_purge_absent_suppliers() and having the driver core figure
> this out automatically.
> 
> So I was making sure all the current uses of
> fw_devlink_purge_absent_suppliers() would automatically be handled by
> driver core. But when I looked at this usage of
> fw_devlink_purge_absent_suppliers(), I didn't see any "compatible"
> property in the "connector" child node. So, I'm confused how you had
> a
> problem without this patch.
> 
> fw_devlink would have created fwnode links
> between typec_pd and usb_dwc3_0, figured out it's a cycle and have
> stopped enforcing the "remote-endpoint" dependencies.
> 
> Can you give me more details please on why you were having a problem
> without this patch?
> 
> I'm looking at arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi as
> an
> example because you listed it in your v1 patch.
> 
> -Saravana

It's downstream. I'm very sorry about that. The patch that adds the
compatible string (
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/3d887ea76158851ae50f192094d7865cc3f4da9d
) sits in our tree (
https://source.puri.sm/martin.kepplinger/linux-next/-/commits/5.19-rc7/librem5__integration
) and I'll make sure it'll be sent out after I'm back from vacations in
a few weeks.

Sorry for the confusion!

                             martin


> 
> >         tps->role_sw = fwnode_usb_role_switch_get(fwnode);
> >         if (IS_ERR(tps->role_sw)) {
> >                 ret = PTR_ERR(tps->role_sw);
> > --
> > 2.30.2
> > 


