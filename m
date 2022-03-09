Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBD4D2CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiCIKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiCIKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:08:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4948E6D;
        Wed,  9 Mar 2022 02:07:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2609488;
        Wed,  9 Mar 2022 11:07:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646820461;
        bh=g3vLrPPA5u/rcUK9NuX/V/wxk9+ykodBRHZbimuQGXw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YxbKfDMpA1tIZR7zY3MN0dJ/KNpXiOtO3uv1dwyGYGTXl7AL3oifh6MaRtyRJl0Wp
         OpwhIhYWeY4ix+18iV4Owoo3PQ661TWobZ/uiLmuNRNDIRkf9s+2cs7cLylVxWYLxt
         kevgfzWOygWh0PeKAwhD8U76mTkAklmHG9YZt9Cg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220309092944.oxddlm4z7mzv63sw@fsr-ub1664-121.ea.freescale.net>
References: <20220308125549.9676-1-laurentiu.palcu@oss.nxp.com> <20220309084311.vn3awybkxzxd32i4@uno.localdomain> <20220309092944.oxddlm4z7mzv63sw@fsr-ub1664-121.ea.freescale.net>
Subject: Re: [PATCH] media: i2c: rdacm2x: properly set subdev entity function
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Date:   Wed, 09 Mar 2022 10:07:39 +0000
Message-ID: <164682045915.856468.14915078774919750707@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurentiu Palcu (2022-03-09 09:29:44)
> Hi Jacopo,
>=20
> On Wed, Mar 09, 2022 at 09:43:11AM +0100, Jacopo Mondi wrote:
> > Hi Laurentiu,
> >=20
> > On Tue, Mar 08, 2022 at 02:55:49PM +0200, Laurentiu Palcu wrote:
> > > The subdevice entity function was left unset, which produces a warning
> > > when probing the device:
> > >
> > > mxc-md bus@58000000:camera: Entity type for entity rdacm20 19-0051 was
> > > not initialized!
> > >
> > > Also, set the entity flags to MEDIA_ENT_FL_DEFAULT instead of
> > > MEDIA_ENT_F_CAM_SENSOR which will be used for entity's function inste=
ad.
> > >
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > ---
> > > Hi,
> > >
> > > Only tested the rdacm20 part but I believe rdacm21 should work as wel=
l.
> > >
> > > Cheers,
> > > laurentiu
> > >
> > >  drivers/media/i2c/rdacm20.c | 3 ++-
> > >  drivers/media/i2c/rdacm21.c | 3 ++-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> > > index 025a610de893..ea5b7d5151ee 100644
> > > --- a/drivers/media/i2c/rdacm20.c
> > > +++ b/drivers/media/i2c/rdacm20.c
> > > @@ -611,7 +611,8 @@ static int rdacm20_probe(struct i2c_client *clien=
t)
> > >             goto error_free_ctrls;
> > >
> > >     dev->pad.flags =3D MEDIA_PAD_FL_SOURCE;
> > > -   dev->sd.entity.flags |=3D MEDIA_ENT_F_CAM_SENSOR;
> > > +   dev->sd.entity.flags |=3D MEDIA_ENT_FL_DEFAULT;
> >=20
> > I'm not sure if setting the DEFAULT flag is right:
> >=20
> >  * %MEDIA_ENT_FL_DEFAULT
> >  *    indicates the default entity for a given type.
> >  *    This can be used to report the default audio and video devices or=
 the
> >  *    default camera sensor.
> >=20
> > In a typical setup there will be several RDACM2x in use, marking all
> > of them as "default" seems not right (if I understood the flag
> > description right).
>=20
> My initial thought was to not set the entity flags at all. However,
> since the old code had the flags set to MEDIA_ENT_F_CAM_SENSOR which is,
> essentially, 0x20001, setting it to MEDIA_ENT_FL_DEFAULT (1 << 0) would
> mean, basically, the same thing and would not affect existing user apps
> that might already probe that flag... Removing the flag now might
> potentially break existing apps. :/
>=20
> Are there any other opinions on this one?

I don't think it's right to add an incorrect flag, and I don't think any
application should have been relying on this.

The only place an application should check for MEDIA_ENT_F_CAM_SENSOR is
in the entity function.

--
Kieran


> >=20
> >=20
> > > +   dev->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
> >=20
> > This seems right, and it's probably worth a Fixes tag?
>=20
> I'll send a v2 with the Fixes tag which I meant to add but totally
> forgot...
>=20
> Cheers,
> Laurentiu
>=20
> >=20
> > Thanks
> >    j
> >=20
> > >     ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
> > >     if (ret < 0)
> > >             goto error_free_ctrls;
> > > diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
> > > index 12ec5467ed1e..be89bd43e88b 100644
> > > --- a/drivers/media/i2c/rdacm21.c
> > > +++ b/drivers/media/i2c/rdacm21.c
> > > @@ -583,7 +583,8 @@ static int rdacm21_probe(struct i2c_client *clien=
t)
> > >             goto error_free_ctrls;
> > >
> > >     dev->pad.flags =3D MEDIA_PAD_FL_SOURCE;
> > > -   dev->sd.entity.flags |=3D MEDIA_ENT_F_CAM_SENSOR;
> > > +   dev->sd.entity.flags |=3D MEDIA_ENT_FL_DEFAULT;
> > > +   dev->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
> > >     ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
> > >     if (ret < 0)
> > >             goto error_free_ctrls;
> > > --
> > > 2.33.0
> > >
