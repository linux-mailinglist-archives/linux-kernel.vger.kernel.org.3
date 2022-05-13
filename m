Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF87E525E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378756AbiEMJBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378795AbiEMJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:01:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A23B3D5;
        Fri, 13 May 2022 02:01:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so4421121wmp.3;
        Fri, 13 May 2022 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7/ABR0JH+OftaW4YTkY0tmpK1gDSHNIY1ko6aqUki0M=;
        b=Pp1Oe9yTiJutx9J9EEuOi7m/pVBAPWNmI1p8JCYruStilV9YX5Y8EywHCNEyRjitmG
         8py70cuYLtZLDYU/SOJJ5rR7JqMOoo2kH1egewHA3n5Irfdyh+HOwfYhQKuUa7DxB2c5
         SIHSYyW/WieLlQCDjzRqtDDsTBbT3beqIRJTgPjfHImELDZXptW1S5RHY6L+uNMB1v7g
         GGa1OVy/NDpKZxYSHQ4cmslT2CEbTb/Vvit4rGvc1JSAukSgRRC5lSIst4TEX+cxMlFB
         c7X+IFd0vOtfQDWDgWdmmprh/MlS7tB9yZsLHSp0YLCkfTR+2dAKuAQjUN877GrwqQwj
         Mjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7/ABR0JH+OftaW4YTkY0tmpK1gDSHNIY1ko6aqUki0M=;
        b=m3JfxBKAupI526vKLi+9kwpqy5UKEtEFlTS2x7K0B97mMe7emy0Fge1HxGjaFwQEVD
         18EQ9Sy3+qZbb/fU1WLH+J/yHOHWBDKlFqEtJ2SUMv3tRgM5hnRrfymC/xxTvdqTn/QH
         qHWXfN7aXbp7Ubw9n5FFaXAUCp8pede8lS+aW18iPXwp6DxXpREIfQQg4VnX1yERxg7L
         PMRPF1Rc+TVofyI4MTXm65rZBuR6Zbbr7ADnqyx6hXPLlUXe7pVFigO1HyhV+6DEhJyD
         76FjrgP9WmxRskzoYS4RH4AbVQpjiuCi0YOk9sBhlGxuVomydzrBt4FzHwiSidRDXiRr
         8BFA==
X-Gm-Message-State: AOAM533+3lIv58DWLCkeMLzNnunpv2AmIG4C/ibSS+sC977LNSSbbEQN
        EyiFyy5HVISOSsz5hSDjpziuWrtzuXMF6ImhNM4=
X-Google-Smtp-Source: ABdhPJyEukpM99sBa8lZeWcoLFj5zuvjf764O5p4wxqpDUbbfVhkktJ9D5x7xxDjd79HN4Y01YQrPuMBXSgIGPUpySg=
X-Received: by 2002:a7b:ce95:0:b0:393:fbe5:32a7 with SMTP id
 q21-20020a7bce95000000b00393fbe532a7mr3419390wmj.123.1652432475776; Fri, 13
 May 2022 02:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220507092953.2273879-1-gengcixi@gmail.com> <20220507092953.2273879-3-gengcixi@gmail.com>
 <YnkRHi692SJ6wlmZ@kuha.fi.intel.com>
In-Reply-To: <YnkRHi692SJ6wlmZ@kuha.fi.intel.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Fri, 13 May 2022 17:00:39 +0800
Message-ID: <CAF12kFtPUGTqpCxVWzF4nkN2KH8SEvBZ=gi-2kYpdJR8UKa2sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: typec: sprd: Support the SC27CC typec port controller
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-usb@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=889=E6=97=A5=E5=91=A8=E4=B8=80 21:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Sat, May 07, 2022 at 05:29:53PM +0800, Cixi Geng wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > The Spreadtrum PMIC SC27xx integrated typec port controller.
> > Add a typec class driver for it.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/usb/typec/Kconfig        |  10 +
> >  drivers/usb/typec/Makefile       |   1 +
> >  drivers/usb/typec/sc27xx-typec.c | 554 +++++++++++++++++++++++++++++++
> >  3 files changed, 565 insertions(+)
> >  create mode 100644 drivers/usb/typec/sc27xx-typec.c
> >
> > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > index ba24847fb245..3058e3a971ce 100644
> > --- a/drivers/usb/typec/Kconfig
> > +++ b/drivers/usb/typec/Kconfig
> > @@ -111,6 +111,16 @@ config TYPEC_WUSB3801
> >         If you choose to build this driver as a dynamically linked modu=
le, the
> >         module will be called wusb3801.ko.
> >
> > +config TYPEC_SC27XX
> > +     tristate "Unisoc SC27XX Serials PMICs Type-C controller driver"
> > +     depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > +     help
> > +       Say Y or M here if system has the Type-C port controller of PMI=
C
> > +       SC27XX serials.
> > +
> > +       If you choose to build this driver as a dynamically linked modu=
le, the
> > +       module will be called sx27xx-typec.ko.
> > +
> >  source "drivers/usb/typec/mux/Kconfig"
> >
> >  source "drivers/usb/typec/altmodes/Kconfig"
> > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> > index 43626acc0aaf..1df88570e10a 100644
> > --- a/drivers/usb/typec/Makefile
> > +++ b/drivers/usb/typec/Makefile
> > @@ -11,4 +11,5 @@ obj-$(CONFIG_TYPEC_QCOM_PMIC)       +=3D qcom-pmic-ty=
pec.o
> >  obj-$(CONFIG_TYPEC_STUSB160X)        +=3D stusb160x.o
> >  obj-$(CONFIG_TYPEC_RT1719)   +=3D rt1719.o
> >  obj-$(CONFIG_TYPEC_WUSB3801) +=3D wusb3801.o
> > +obj-$(CONFIG_TYPEC_SC27XX)   +=3D sc27xx-typec.o
> >  obj-$(CONFIG_TYPEC)          +=3D mux/
> > diff --git a/drivers/usb/typec/sc27xx-typec.c b/drivers/usb/typec/sc27x=
x-typec.c
> > new file mode 100644
> > index 000000000000..6305dd9fed18
> > --- /dev/null
> > +++ b/drivers/usb/typec/sc27xx-typec.c
> > @@ -0,0 +1,554 @@
> > +// SPDX-License-Identifier: GPL
> > +/*
> > + * Driver for Spreadtrum SC27XX USB Type-C
> > + *
> > + * Copyright (C) 2022 Unisoc Inc.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/usb/typec.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/extcon.h>
> > +#include <linux/kernel.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/extcon-provider.h>
> > +
> > +/* registers definitions for controller REGS_TYPEC */
> > +#define SC27XX_EN                    0x00
> > +#define SC27XX_MODE                  0x04
> > +#define SC27XX_INT_EN                        0x0c
> > +#define SC27XX_INT_CLR                       0x10
> > +#define SC27XX_INT_RAW                       0x14
> > +#define SC27XX_INT_MASK                      0x18
> > +#define SC27XX_STATUS                        0x1c
> > +#define SC27XX_TCCDE_CNT             0x20
> > +#define SC27XX_RTRIM                 0x3c
> > +
> > +/* SC27XX_TYPEC_EN */
> > +#define SC27XX_TYPEC_USB20_ONLY              BIT(4)
> > +
> > +/* SC27XX_TYPEC MODE */
> > +#define SC27XX_MODE_SNK                      0
> > +#define SC27XX_MODE_SRC                      1
> > +#define SC27XX_MODE_DRP                      2
> > +#define SC27XX_MODE_MASK             3
> > +
> > +/* SC27XX_INT_EN */
> > +#define SC27XX_ATTACH_INT_EN         BIT(0)
> > +#define SC27XX_DETACH_INT_EN         BIT(1)
> > +
> > +/* SC27XX_INT_CLR */
> > +#define SC27XX_ATTACH_INT_CLR                BIT(0)
> > +#define SC27XX_DETACH_INT_CLR                BIT(1)
> > +
> > +/* SC27XX_INT_MASK */
> > +#define SC27XX_ATTACH_INT            BIT(0)
> > +#define SC27XX_DETACH_INT            BIT(1)
> > +
> > +#define SC27XX_STATE_MASK            GENMASK(4, 0)
> > +#define SC27XX_EVENT_MASK            GENMASK(9, 0)
> > +
> > +#define SC2730_EFUSE_CC1_SHIFT               5
> > +#define SC2730_EFUSE_CC2_SHIFT               0
> > +#define SC2721_EFUSE_CC1_SHIFT               11
> > +#define SC2721_EFUSE_CC2_SHIFT               6
> > +#define UMP9620_EFUSE_CC1_SHIFT              1
> > +#define UMP9620_EFUSE_CC2_SHIFT              11
> > +
> > +#define SC27XX_CC1_MASK(n)           GENMASK((n) + 9, (n) + 5)
> > +#define SC27XX_CC2_MASK(n)           GENMASK((n) + 4, (n))
> > +#define SC27XX_CC_SHIFT(n)           (n)
> > +
> > +/* sc2721 registers definitions for controller REGS_TYPEC */
> > +#define SC2721_EN                    0x00
> > +#define SC2721_CLR                   0x04
> > +#define SC2721_MODE                  0x08
> > +
> > +/* SC2721_INT_EN */
> > +#define SC2721_ATTACH_INT_EN         BIT(5)
> > +#define SC2721_DETACH_INT_EN         BIT(6)
> > +
> > +#define SC2721_STATE_MASK            GENMASK(3, 0)
> > +#define SC2721_EVENT_MASK            GENMASK(6, 0)
> > +
> > +/* modify sc2730 tcc debunce */
> > +#define SC27XX_TCC_DEBOUNCE_CNT              0xc7f
> > +
> > +/* sc2730 registers definitions for controller REGS_TYPEC */
> > +#define SC2730_TYPEC_PD_CFG          0x08
> > +/* SC2730_TYPEC_PD_CFG */
> > +#define SC27XX_VCONN_LDO_EN          BIT(13)
> > +#define SC27XX_VCONN_LDO_RDY         BIT(12)
> > +
> > +enum sc27xx_typec_connection_state {
> > +     SC27XX_DETACHED_SNK,
> > +     SC27XX_ATTACHWAIT_SNK,
> > +     SC27XX_ATTACHED_SNK,
> > +     SC27XX_DETACHED_SRC,
> > +     SC27XX_ATTACHWAIT_SRC,
> > +     SC27XX_ATTACHED_SRC,
> > +     SC27XX_POWERED_CABLE,
> > +     SC27XX_AUDIO_CABLE,
> > +     SC27XX_DEBUG_CABLE,
> > +     SC27XX_TOGGLE_SLEEP,
> > +     SC27XX_ERR_RECOV,
> > +     SC27XX_DISABLED,
> > +     SC27XX_TRY_SNK,
> > +     SC27XX_TRY_WAIT_SRC,
> > +     SC27XX_TRY_SRC,
> > +     SC27XX_TRY_WAIT_SNK,
> > +     SC27XX_UNSUPOORT_ACC,
> > +     SC27XX_ORIENTED_DEBUG,
> > +};
> > +
> > +struct sprd_typec_variant_data {
> > +     u32 efuse_cc1_shift;
> > +     u32 efuse_cc2_shift;
> > +     u32 int_en;
> > +     u32 int_clr;
> > +     u32 mode;
> > +     u32 attach_en;
> > +     u32 detach_en;
> > +     u32 state_mask;
> > +     u32 event_mask;
> > +};
> > +
> > +static const struct sprd_typec_variant_data sc2730_data =3D {
> > +     .efuse_cc1_shift =3D SC2730_EFUSE_CC1_SHIFT,
> > +     .efuse_cc2_shift =3D SC2730_EFUSE_CC2_SHIFT,
> > +     .int_en =3D SC27XX_INT_EN,
> > +     .int_clr =3D SC27XX_INT_CLR,
> > +     .mode =3D SC27XX_MODE,
> > +     .attach_en =3D SC27XX_ATTACH_INT_EN,
> > +     .detach_en =3D SC27XX_DETACH_INT_EN,
> > +     .state_mask =3D SC27XX_STATE_MASK,
> > +     .event_mask =3D SC27XX_EVENT_MASK,
> > +};
> > +
> > +static const struct sprd_typec_variant_data sc2721_data =3D {
> > +     .efuse_cc1_shift =3D SC2721_EFUSE_CC1_SHIFT,
> > +     .efuse_cc2_shift =3D SC2721_EFUSE_CC2_SHIFT,
> > +     .int_en =3D SC2721_EN,
> > +     .int_clr =3D SC2721_CLR,
> > +     .mode =3D SC2721_MODE,
> > +     .attach_en =3D SC2721_ATTACH_INT_EN,
> > +     .detach_en =3D SC2721_DETACH_INT_EN,
> > +     .state_mask =3D SC2721_STATE_MASK,
> > +     .event_mask =3D SC2721_EVENT_MASK,
> > +};
> > +
> > +static const struct sprd_typec_variant_data ump9620_data =3D {
> > +     .efuse_cc1_shift =3D UMP9620_EFUSE_CC1_SHIFT,
> > +     .efuse_cc2_shift =3D UMP9620_EFUSE_CC2_SHIFT,
> > +     .int_en =3D SC27XX_INT_EN,
> > +     .int_clr =3D SC27XX_INT_CLR,
> > +     .mode =3D SC27XX_MODE,
> > +     .attach_en =3D SC27XX_ATTACH_INT_EN,
> > +     .detach_en =3D SC27XX_DETACH_INT_EN,
> > +     .state_mask =3D SC27XX_STATE_MASK,
> > +     .event_mask =3D SC27XX_EVENT_MASK,
> > +};
> > +
> > +struct sc27xx_typec {
> > +     struct device *dev;
> > +     struct regmap *regmap;
> > +     u32 base;
> > +     int irq;
> > +     struct extcon_dev *edev;
> > +     bool usb20_only;
> > +
> > +     enum sc27xx_typec_connection_state state;
> > +     enum sc27xx_typec_connection_state pre_state;
> > +     struct typec_port *port;
> > +     struct typec_partner *partner;
> > +     struct typec_capability typec_cap;
> > +     const struct sprd_typec_variant_data *var_data;
> > +};
> > +
> > +static int sc27xx_typec_connect(struct sc27xx_typec *sc, u32 status)
> > +{
> > +     enum typec_data_role data_role =3D TYPEC_DEVICE;
> > +     enum typec_role power_role =3D TYPEC_SOURCE;
> > +     enum typec_role vconn_role =3D TYPEC_SOURCE;
> > +     struct typec_partner_desc desc;
> > +
> > +     if (sc->partner)
> > +             return 0;
> > +
> > +     switch (sc->state) {
> > +     case SC27XX_ATTACHED_SNK:
> > +     case SC27XX_DEBUG_CABLE:
> > +             power_role =3D TYPEC_SINK;
> > +             data_role =3D TYPEC_DEVICE;
> > +             vconn_role =3D TYPEC_SINK;
> > +             break;
> > +     case SC27XX_ATTACHED_SRC:
> > +     case SC27XX_AUDIO_CABLE:
> > +             power_role =3D TYPEC_SOURCE;
> > +             data_role =3D TYPEC_HOST;
> > +             vconn_role =3D TYPEC_SOURCE;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     desc.usb_pd =3D 0;
> > +     desc.accessory =3D TYPEC_ACCESSORY_NONE;
> > +     desc.identity =3D NULL;
> > +
> > +     sc->partner =3D typec_register_partner(sc->port, &desc);
> > +     if (!sc->partner)
> > +             return -ENODEV;
> > +
> > +     typec_set_pwr_opmode(sc->port, TYPEC_PWR_MODE_USB);
> > +     typec_set_pwr_role(sc->port, power_role);
> > +     typec_set_data_role(sc->port, data_role);
> > +     typec_set_vconn_role(sc->port, vconn_role);
> > +
> > +     switch (sc->state) {
> > +     case SC27XX_ATTACHED_SNK:
> > +     case SC27XX_DEBUG_CABLE:
>
> You need to inform the connector class that the partner is a Debug
> Accessory:
>
>         desc.accessory =3D TYPEC_ACCESSORY_DEBUG;
>
> Is there some reason why are you doing all this only after you have
> registered the partner?
Hi Heikki:
Some usb data cables are connected to the PC, do not report SINK events,
only report DEBUG CABLE, usb needs to be a device to handled this situation
as SINK connection. which is a workaround for the spec designed the detecte=
d
 the hardware identification status. the function of debug Accessory
is not supported.
>
> > +             sc->pre_state =3D SC27XX_ATTACHED_SNK;
> > +             extcon_set_state_sync(sc->edev, EXTCON_USB, true);
> > +             break;
> > +     case SC27XX_ATTACHED_SRC:
> > +             sc->pre_state =3D SC27XX_ATTACHED_SRC;
> > +             extcon_set_state_sync(sc->edev, EXTCON_USB_HOST, true);
> > +             break;
> > +     case SC27XX_AUDIO_CABLE:
>
> And here it's Audio Accessory:
>
>         desc.accessory =3D TYPEC_ACCESSORY_AUDIO;
>
> > +             sc->pre_state =3D SC27XX_AUDIO_CABLE;
> > +             extcon_set_state_sync(sc->edev, EXTCON_JACK_HEADPHONE, tr=
ue);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void sc27xx_typec_disconnect(struct sc27xx_typec *sc, u32 statu=
s)
> > +{
> > +     typec_unregister_partner(sc->partner);
> > +     sc->partner =3D NULL;
> > +     typec_set_pwr_opmode(sc->port, TYPEC_PWR_MODE_USB);
> > +     typec_set_pwr_role(sc->port, TYPEC_SINK);
> > +     typec_set_data_role(sc->port, TYPEC_DEVICE);
> > +     typec_set_vconn_role(sc->port, TYPEC_SINK);
> > +
> > +     switch (sc->pre_state) {
> > +     case SC27XX_ATTACHED_SNK:
> > +     case SC27XX_DEBUG_CABLE:
> > +             extcon_set_state_sync(sc->edev, EXTCON_USB, false);
> > +             break;
> > +     case SC27XX_ATTACHED_SRC:
> > +             extcon_set_state_sync(sc->edev, EXTCON_USB_HOST, false);
> > +             break;
> > +     case SC27XX_AUDIO_CABLE:
> > +             extcon_set_state_sync(sc->edev, EXTCON_JACK_HEADPHONE, fa=
lse);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +}
> > +
> > +static irqreturn_t sc27xx_typec_interrupt(int irq, void *data)
> > +{
> > +     struct sc27xx_typec *sc =3D data;
> > +     u32 event;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(sc->regmap, sc->base + SC27XX_INT_MASK, &even=
t);
> > +     if (ret)
> > +             return ret;
> > +
> > +     event &=3D sc->var_data->event_mask;
> > +
> > +     ret =3D regmap_read(sc->regmap, sc->base + SC27XX_STATUS, &sc->st=
ate);
> > +     if (ret)
> > +             goto clear_ints;
> > +
> > +     sc->state &=3D sc->var_data->state_mask;
> > +
> > +     if (event & SC27XX_ATTACH_INT) {
> > +             ret =3D sc27xx_typec_connect(sc, sc->state);
> > +             if (ret)
> > +                     dev_warn(sc->dev, "failed to register partner\n")=
;
> > +     } else if (event & SC27XX_DETACH_INT) {
> > +             sc27xx_typec_disconnect(sc, sc->state);
> > +     }
> > +
> > +clear_ints:
> > +     regmap_write(sc->regmap, sc->base + sc->var_data->int_clr, event)=
;
> > +
> > +     dev_info(sc->dev, "now works as DRP and is in %d state, event %d\=
n",
> > +             sc->state, event);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int sc27xx_typec_enable(struct sc27xx_typec *sc)
> > +{
> > +     int ret;
> > +     u32 val;
> > +
> > +     /* Set typec mode */
> > +     ret =3D regmap_read(sc->regmap, sc->base + sc->var_data->mode, &v=
al);
> > +     if (ret)
> > +             return ret;
> > +
> > +     val &=3D ~SC27XX_MODE_MASK;
> > +     switch (sc->typec_cap.type) {
> > +     case TYPEC_PORT_DFP:
> > +             val |=3D SC27XX_MODE_SRC;
> > +             break;
> > +     case TYPEC_PORT_UFP:
> > +             val |=3D SC27XX_MODE_SNK;
> > +             break;
> > +     case TYPEC_PORT_DRP:
> > +             val |=3D SC27XX_MODE_DRP;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D regmap_write(sc->regmap, sc->base + sc->var_data->mode, v=
al);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* typec USB20 only flag, only work in snk mode */
> > +     if (sc->typec_cap.data =3D=3D TYPEC_PORT_UFP && sc->usb20_only) {
> > +             ret =3D regmap_update_bits(sc->regmap, sc->base + SC27XX_=
EN,
> > +                                      SC27XX_TYPEC_USB20_ONLY,
> > +                                      SC27XX_TYPEC_USB20_ONLY);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     /* modify sc2730 tcc debounce to 100ms while PD signal occur at 1=
50ms
> > +      * and effect tccde reginize.Reason is hardware signal and clk no=
t
> > +      * accurate.
> > +      */
> > +     if (sc->var_data->efuse_cc2_shift =3D=3D SC2730_EFUSE_CC2_SHIFT) =
{
> > +             ret =3D regmap_write(sc->regmap, sc->base + SC27XX_TCCDE_=
CNT,
> > +                             SC27XX_TCC_DEBOUNCE_CNT);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     /* Enable typec interrupt and enable typec */
> > +     ret =3D regmap_read(sc->regmap, sc->base + sc->var_data->int_en, =
&val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     val |=3D sc->var_data->attach_en | sc->var_data->detach_en;
> > +     return regmap_write(sc->regmap, sc->base + sc->var_data->int_en, =
val);
> > +}
> > +
> > +static const u32 sc27xx_typec_cable[] =3D {
> > +     EXTCON_USB,
> > +     EXTCON_USB_HOST,
> > +     EXTCON_JACK_HEADPHONE,
> > +     EXTCON_NONE,
> > +};
>
> Please note that USB role you will need to handle with a dedicated USB
> role switch (USB role device class) - I'll show you below.
>
> The reason why that is, is because we can not use extcon with the USB
> role on every type of platform that there is (the extcon component for
> the role may be the "provider" but it may also be the "consumer"
> depending on the platform, and that was not acceptable), but we still
> need to have a single way of handling it. That is why we had to
> introduce the USB Role Class in the first place.
>
> So you can only use extcon to expose information to the user space,
> and only for legacy purposes. All the information will be exposed to
> the user space in any case. There is a dedicated "accessory" sysfs
> attribute file for every USB Type-C partner device, and the role you
> can read from the port's "data_role" sysfs attribute file.
>
> So I'm wondering, do you need the extcon device at all?
Our platform PMIC connects to different devices to report different events.
It requires extcon to notify different hardware connection statuses to modu=
les
such as pd/audio/usb/phy. The module is then processed accordingly=E3=80=82
So just the usb_role_switch_get and usb_role_switch_set are not enough,
they can only be used when  Usb data role swap is performed later.
>
> > +static int sc27xx_typec_get_cc1_efuse(struct sc27xx_typec *sc)
> > +{
> > +     struct nvmem_cell *cell;
> > +     u32 calib_data =3D 0;
> > +     void *buf;
> > +     size_t len;
> > +
> > +     cell =3D nvmem_cell_get(sc->dev, "typec_cc1_cal");
> > +     if (IS_ERR(cell))
> > +             return PTR_ERR(cell);
> > +
> > +     buf =3D nvmem_cell_read(cell, &len);
> > +     nvmem_cell_put(cell);
> > +
> > +     if (IS_ERR(buf))
> > +             return PTR_ERR(buf);
> > +
> > +     memcpy(&calib_data, buf, min(len, sizeof(u32)));
> > +     calib_data =3D (calib_data & SC27XX_CC1_MASK(sc->var_data->efuse_=
cc1_shift))
> > +                     >> SC27XX_CC_SHIFT(sc->var_data->efuse_cc1_shift)=
;
> > +     kfree(buf);
> > +
> > +     return calib_data;
> > +}
> > +
> > +static int sc27xx_typec_get_cc2_efuse(struct sc27xx_typec *sc)
> > +{
> > +     struct nvmem_cell *cell;
> > +     u32 calib_data =3D 0;
> > +     void *buf;
> > +     size_t len =3D 0;
> > +
> > +     cell =3D nvmem_cell_get(sc->dev, "typec_cc2_cal");
> > +     if (IS_ERR(cell))
> > +             return PTR_ERR(cell);
> > +
> > +     buf =3D nvmem_cell_read(cell, &len);
> > +     nvmem_cell_put(cell);
> > +
> > +     if (IS_ERR(buf))
> > +             return PTR_ERR(buf);
> > +
> > +     memcpy(&calib_data, buf, min(len, sizeof(u32)));
> > +     calib_data =3D (calib_data & SC27XX_CC2_MASK(sc->var_data->efuse_=
cc2_shift))
> > +                     >> SC27XX_CC_SHIFT(sc->var_data->efuse_cc2_shift)=
;
> > +     kfree(buf);
> > +
> > +     return calib_data;
> > +}
> > +
> > +static int typec_set_rtrim(struct sc27xx_typec *sc)
> > +{
> > +     int calib_cc1;
> > +     int calib_cc2;
> > +     u32 rtrim;
> > +
> > +     calib_cc1 =3D sc27xx_typec_get_cc1_efuse(sc);
> > +     if (calib_cc1 < 0)
> > +             return calib_cc1;
> > +     calib_cc2 =3D sc27xx_typec_get_cc2_efuse(sc);
> > +     if (calib_cc2 < 0)
> > +             return calib_cc2;
> > +
> > +     rtrim =3D calib_cc1 | calib_cc2<<5;
> > +
> > +     return regmap_write(sc->regmap, sc->base + SC27XX_RTRIM, rtrim);
> > +}
> > +
> > +static int sc27xx_typec_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_node *node =3D pdev->dev.of_node;
> > +     struct sc27xx_typec *sc;
> > +     const struct sprd_typec_variant_data *pdata;
> > +     int mode, ret;
> > +
> > +     pdata =3D of_device_get_match_data(dev);
> > +     if (!pdata) {
> > +             dev_err(&pdev->dev, "No matching driver data found\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     sc =3D devm_kzalloc(&pdev->dev, sizeof(*sc), GFP_KERNEL);
> > +     if (!sc)
> > +             return -ENOMEM;
> > +
> > +     sc->edev =3D devm_extcon_dev_allocate(&pdev->dev, sc27xx_typec_ca=
ble);
> > +     if (IS_ERR(sc->edev)) {
> > +             dev_err(&pdev->dev, "failed to allocate extcon device\n")=
;
> > +             return PTR_ERR(sc->edev);
> > +     }
> > +
> > +     ret =3D devm_extcon_dev_register(&pdev->dev, sc->edev);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "can't register extcon device: %d\n",=
 ret);
> > +             return ret;
> > +     }
>
> For the USB role switch you'll need to add struct usb_role_switch
> pointer to struct sc27xx_typec. After that:
>
>         sc->sw =3D usb_role_switch_get(&pdev->dev);
>         if (IS_ERR(sc->sw)) {
>                 ...
>         }
>
> Then when you detect the role (in sc27xx_typec_connect() I guess),
> you can set it to the switch with usb_role_switch_set_role().
>
> The bindings for the usb-role-switch I believe are described here:
> Documentation/devicetree/bindings/usb/usb-drd.yaml
>
> > +     sc->dev =3D &pdev->dev;
> > +     sc->irq =3D platform_get_irq(pdev, 0);
> > +     if (sc->irq < 0) {
> > +             dev_err(sc->dev, "failed to get typec interrupt.\n");
> > +             return sc->irq;
> > +     }
> > +
> > +     sc->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!sc->regmap) {
> > +             dev_err(sc->dev, "failed to get regmap.\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D of_property_read_u32(node, "reg", &sc->base);
> > +     if (ret) {
> > +             dev_err(dev, "failed to get reg offset!\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D of_property_read_u32(node, "sprd,mode", &mode);
> > +     if (ret) {
> > +             dev_err(dev, "failed to get typec port mode type\n");
> > +             return ret;
> > +     }
> > +
> > +     if (mode < TYPEC_PORT_DFP || mode > TYPEC_PORT_DRP
> > +         || mode =3D=3D TYPEC_PORT_UFP) {
> > +             mode =3D TYPEC_PORT_UFP;
> > +             sc->usb20_only =3D true;
> > +             dev_info(dev, "usb 2.0 only is enabled\n");
> > +     }
> > +
> > +     sc->var_data =3D pdata;
> > +     sc->typec_cap.type =3D mode;
> > +     sc->typec_cap.data =3D TYPEC_PORT_DRD;
> > +     sc->typec_cap.revision =3D USB_TYPEC_REV_1_2;
> > +     sc->typec_cap.prefer_role =3D TYPEC_NO_PREFERRED_ROLE;
> > +     sc->port =3D typec_register_port(&pdev->dev, &sc->typec_cap);
> > +     if (!sc->port) {
> > +             dev_err(sc->dev, "failed to register port!\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D typec_set_rtrim(sc);
> > +     if (ret < 0) {
> > +             dev_err(sc->dev, "failed to set typec rtrim %d\n", ret);
> > +             goto error;
> > +     }
> > +
> > +     ret =3D devm_request_threaded_irq(sc->dev, sc->irq, NULL,
> > +                                     sc27xx_typec_interrupt,
> > +                                     IRQF_EARLY_RESUME | IRQF_ONESHOT,
> > +                                     dev_name(sc->dev), sc);
> > +     if (ret) {
> > +             dev_err(sc->dev, "failed to request irq %d\n", ret);
> > +             goto error;
> > +     }
> > +
> > +     ret =3D sc27xx_typec_enable(sc);
> > +     if (ret)
> > +             goto error;
> > +
> > +     platform_set_drvdata(pdev, sc);
> > +     return 0;
> > +
> > +error:
> > +     typec_unregister_port(sc->port);
> > +     return ret;
> > +}
> > +
> > +static int sc27xx_typec_remove(struct platform_device *pdev)
> > +{
> > +     struct sc27xx_typec *sc =3D platform_get_drvdata(pdev);
> > +
> > +     sc27xx_typec_disconnect(sc, 0);
> > +     typec_unregister_port(sc->port);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id typec_sprd_match[] =3D {
> > +     {.compatible =3D "sprd,sc2730-typec", .data =3D &sc2730_data},
> > +     {.compatible =3D "sprd,sc2721-typec", .data =3D &sc2721_data},
> > +     {.compatible =3D "sprd,ump96xx-typec", .data =3D &ump9620_data},
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, typec_sprd_match);
> > +
> > +static struct platform_driver sc27xx_typec_driver =3D {
> > +     .probe =3D sc27xx_typec_probe,
> > +     .remove =3D sc27xx_typec_remove,
> > +     .driver =3D {
> > +             .name =3D "sc27xx-typec",
> > +             .of_match_table =3D typec_sprd_match,
> > +     },
> > +};
> > +module_platform_driver(sc27xx_typec_driver);
> > +MODULE_LICENSE("GPL");
> > +
> > --
> > 2.25.1
>
> --
> heikki
