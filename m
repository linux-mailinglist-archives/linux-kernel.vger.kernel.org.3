Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF454D19F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiCHOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiCHOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:05:23 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330EA4739C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:04:26 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 467F240009;
        Tue,  8 Mar 2022 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646748264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yuYwohkIYiGH/9okVyXKYblvtBex44dmao1aksjVe+k=;
        b=cJlZk9OPgQphu+B04jgaVO5ECdl+6BhXYtB6vd9FuBFEqEdyL3gwwGOh1jdGHPUdiwPt43
        l6h8PuvmJoSRcPREHvpV9WH4eWq9BmJ7naf4g9Or4SyAUnzREp1LuNAYBnF1JSFxdkeDA0
        ETv5G6Y+hYv3mPt9ddi3urhD2DGaWlIz04ShPFKh8ojR1y6suIi1jf15ZlhFcWop3GyKrX
        DvwVCTNnFSwmsOfOM90tD0Dy8Y2rG76uCBViTymOVyUl3QXsa37+Nsn4bx3rwmv27Gatha
        OD7M2nKENoiK85jfxXntqVgjo6Op3BcXglIfcJWYEUY+sNllkXmB0mMioDwQzQ==
Date:   Tue, 8 Mar 2022 15:03:00 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <linux@armlinux.org.uk>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/2] ARM: at91: pm: add support for sama5d2 secure
 suspend
Message-ID: <20220308150300.099696a6@fixe.home>
In-Reply-To: <2177abd0-f25d-c82a-ec5a-7f2654352d25@microchip.com>
References: <20220307101550.95538-1-clement.leger@bootlin.com>
        <20220307101550.95538-3-clement.leger@bootlin.com>
        <2177abd0-f25d-c82a-ec5a-7f2654352d25@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 8 Mar 2022 08:21:01 +0000,
<Claudiu.Beznea@microchip.com> a =C3=A9crit :
[...]

> >  static const struct of_device_id atmel_shdwc_ids[] =3D {
> >         { .compatible =3D "atmel,sama5d2-shdwc" },
> >         { .compatible =3D "microchip,sam9x60-shdwc" },
> > @@ -1188,6 +1218,11 @@ void __init sama5d2_pm_init(void)
> >         if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
> >                 return;
> >=20
> > +       if (IS_ENABLED(CONFIG_ATMEL_SECURE_PM)) {
> > +               at91_pm_secure_init();
> > +               return;
> > +       }
> > +
> >         at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
> >         at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
> >         ret =3D at91_dt_ramc(false);
> > @@ -1262,6 +1297,9 @@ static int __init at91_pm_modes_select(char *str)
> >         soc_pm.data.standby_mode =3D standby;
> >         soc_pm.data.suspend_mode =3D suspend;
> >=20
> > +       if (IS_ENABLED(CONFIG_ATMEL_SECURE_PM))
> > +               pr_warn("AT91: Secure PM: ignoring standby mode\n"); =20
>=20
> What happens with soc_pm.data.standby_mode? Can Linux still suspend to it?

Unfortunately, no. PSCI suspend support only allows one mode
(SUSPEND_MEM, cf psci_suspend_ops) which should be the deepest suspend
mode supported by the platform. Since the sama5 family support more
than one suspend mode, we added this mechanism to keep the existing
support for atmel,pm_modes support.

We could potentially add a suspend support for sama5d2 that call the
SMC to set the suspend mode and then enters PSCI system suspend by
calling psci_system_suspend_enter(). But I'm not sure it is the idea
behind the PSCI system suspend call.

> If that's the case then the proper data for standby mode is not initializ=
ed
> as sama5d2_pm_init() returns if CONFIG_ATMEL_SECURE_PM is enabled, thus
> system may hang in such a case. Is this intended?

Since the platform_suspend_ops won't be registered, there should be no
call to enter sama5d2 suspend (either mem or standby) from this code.

>=20
> Otherwise, maybe this pr_warn() could be moved in sama5d2_pm_init() as
> sama5d2 is the only user at the moment.

Ok, I will move the print.

Thanks,

Cl=C3=A9ment

>=20
> Thank you,
> Claudiu Beznea
>=20
> > +
> >         return 0;
> >  }
> >  early_param("atmel.pm_modes", at91_pm_modes_select);
> > diff --git a/arch/arm/mach-at91/sam_secure.h b/arch/arm/mach-at91/sam_s=
ecure.h
> > index 360036672f52..1e7d8b20ba1e 100644
> > --- a/arch/arm/mach-at91/sam_secure.h
> > +++ b/arch/arm/mach-at91/sam_secure.h
> > @@ -8,6 +8,10 @@
> >=20
> >  #include <linux/arm-smccc.h>
> >=20
> > +/* Secure Monitor mode APIs */
> > +#define SAMA5_SMC_SIP_SET_SUSPEND_MODE 0x400
> > +#define SAMA5_SMC_SIP_GET_SUSPEND_MODE 0x401
> > +
> >  void __init sam_secure_init(void);
> >  struct arm_smccc_res sam_smccc_call(u32 fn, u32 arg0, u32 arg1);
> >=20
> > --
> > 2.34.1
> >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel =20
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
