Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15BF4A7690
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbiBBRLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbiBBRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:11:17 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7FC061714;
        Wed,  2 Feb 2022 09:11:17 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id q127so96943ljq.2;
        Wed, 02 Feb 2022 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqKwd/2MOHZ0ECfIQv/usF+F8dA1Wep+kzjnyfATWEc=;
        b=H+f1j8NGBdAi4Vuhv5AWGvxUmLoMcVXQNDqFQw+WaaV+L8VyC3iFS8xGj3XM/uopP3
         3GglxG+1/UpAZG9VZywh0vLf4g/t2GFsrowUR7BVtV6tAERsxcnzJh5gc9VhNJJdRoy4
         GJ0O5dVNo8G74zFcEOnmqQ/8PzVEWfEUdYfPAxe1IHOLPBUlPyLkCWoT5/kQ/IQfLNmE
         RU96L0szG3u86merWKh3RFTul49ffAWzTGLLq6+oswz9PMQGvkpqaDIqsrNVGxH4mgO8
         3g618UPOoFWebpAc8sbGpWEln9liXC69wJ82BITC0+Wp578Ze5jYgK1tmpQrEnrVhmzx
         JflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqKwd/2MOHZ0ECfIQv/usF+F8dA1Wep+kzjnyfATWEc=;
        b=xJdWwfOrmY6kOHWcMCmWADOAYxVEs7ny6dZTGlXZ1ouTjDeFL35Drov9Bb3TLpjMRW
         iATpAsQDPWnBUtRt0vPxhdyOs1rdrYukShp2QYTmIfUhDQooQX6Dh4kT9SFoadoGqK0B
         0pdsSG52qCaIrU4ah2K5Q8vVoI6nK55ltP3P05XmpbwzsTonbPIytQNPIETxLcArJNR/
         llMjrrfJjlJZ3q2awpPUD3sUxsq3cDqFXeD27tyc80fINLU9+CvXOFf8D1A22u70Sfyl
         3nZdMH6XD9L08/3FGUul6AFic4a/ZN97HbaNaaUYF5maK3nNhzkM2ihcIBZZAH5d7P3S
         Pziw==
X-Gm-Message-State: AOAM532WtkIr4yuCfDD+GvtSWXUDVe0z//soohDbTiZZFCjY7x48leCQ
        N1PqPXFe/VWk0s1God6preeegahUalQDILQp0jrcDKoMasQ=
X-Google-Smtp-Source: ABdhPJy2tl9AlK+4+ifHPex0O/S15bQ+r5zkiJs4Y4dKgqyygSOK20F2PJt1kyJg70k4W4lhV08ljqI0qfAPRvjW0po=
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr20127616ljq.360.1643821875121;
 Wed, 02 Feb 2022 09:11:15 -0800 (PST)
MIME-Version: 1.0
References: <1642208191-7254-1-git-send-email-u0084500@gmail.com>
 <1642208191-7254-3-git-send-email-u0084500@gmail.com> <YfezWtp2z9wvKmJQ@kuha.fi.intel.com>
 <CADiBU3_vi5ZUbU4e_LG9sQ7jnkjMTwzU3QUBbZ2E4+K0FmAnLQ@mail.gmail.com> <YfpLSnLzCIwBmAbT@kuha.fi.intel.com>
In-Reply-To: <YfpLSnLzCIwBmAbT@kuha.fi.intel.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 3 Feb 2022 01:11:03 +0800
Message-ID: <CADiBU39kNFJcM_RxRozw4xe9dVPvL6rksfETqkLL=Bsw=W-h2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: typec: rt1719: Add support for Richtek RT1719
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2022=E5=B9=B42=
=E6=9C=882=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:13=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Tue, Feb 01, 2022 at 11:27:38PM +0800, ChiYuan Huang wrote:
> > Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2022=E5=B9=
=B41=E6=9C=8831=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:01=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > On Sat, Jan 15, 2022 at 08:56:31AM +0800, cy_huang wrote:
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > Richtek RT1719 is a sink-only Type-C PD controller it complies with
> > > > latest USB Type-C and PD standards. It integrates the physical laye=
r of
> > > > USB power delivery protocol to allow up to 100W of power.
> > > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > This looked OK to me, but one nitpick. Don't return ENOTSUPP, use
> > > EOPNOTSUPP instead.
> > >
> > OK. I.ll use EOPNOTSUPP to replace all ENOTSUPPs.
>
> Related to this, before you resend, there is still one thing that I
> think needs clarification below...
>
> I also found something else that you could improve.
>
> > > I'm pretty sure that scripts/checkpatch.pl will also tell you to do
> > > so, so please run that script and fix all the errors and warnings tha=
t
> > > it finds while at it.
> > >
> > > thanks,
> > >
> > Yap, Thanks. I also find there's still one consistent space error need
> > to be fixed.
> > Ack in next.
> > > > ---
> > > >  drivers/usb/typec/Kconfig  |  12 +
> > > >  drivers/usb/typec/Makefile |   1 +
> > > >  drivers/usb/typec/rt1719.c | 976 +++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 989 insertions(+)
> > > >  create mode 100644 drivers/usb/typec/rt1719.c
> > > >
> > > > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > > > index ab480f3..bc918ca 100644
> > > > --- a/drivers/usb/typec/Kconfig
> > > > +++ b/drivers/usb/typec/Kconfig
> > > > @@ -52,6 +52,18 @@ source "drivers/usb/typec/ucsi/Kconfig"
> > > >
> > > >  source "drivers/usb/typec/tipd/Kconfig"
> > > >
> > > > +config TYPEC_RT1719
> > > > +     tristate "Richtek RT1719 Sink Only Type-C controller driver"
> > > > +     depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> > > > +     depends on I2C
> > > > +     select REGMAP_I2C
> > > > +     help
> > > > +       Say Y or M here if your system has Richtek RT1719 sink only
> > > > +       Type-C port controller driver.
> > > > +
> > > > +       If you choose to build this driver as a dynamically linked =
module, the
> > > > +       module will be called rt1719.ko
> > > > +
> > > >  config TYPEC_HD3SS3220
> > > >       tristate "TI HD3SS3220 Type-C DRP Port controller driver"
> > > >       depends on I2C
> > > > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefil=
e
> > > > index 57870a2..441dd6c 100644
> > > > --- a/drivers/usb/typec/Makefile
> > > > +++ b/drivers/usb/typec/Makefile
> > > > @@ -9,4 +9,5 @@ obj-$(CONFIG_TYPEC_TPS6598X)  +=3D tipd/
> > > >  obj-$(CONFIG_TYPEC_HD3SS3220)        +=3D hd3ss3220.o
> > > >  obj-$(CONFIG_TYPEC_QCOM_PMIC)        +=3D qcom-pmic-typec.o
> > > >  obj-$(CONFIG_TYPEC_STUSB160X)        +=3D stusb160x.o
> > > > +obj-$(CONFIG_TYPEC_RT1719)   +=3D rt1719.o
> > > >  obj-$(CONFIG_TYPEC)          +=3D mux/
> > > > diff --git a/drivers/usb/typec/rt1719.c b/drivers/usb/typec/rt1719.=
c
> > > > new file mode 100644
> > > > index 00000000..9da65ee
> > > > --- /dev/null
> > > > +++ b/drivers/usb/typec/rt1719.c
> > > > @@ -0,0 +1,976 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/completion.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/power_supply.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/usb/pd.h>
> > > > +#include <linux/usb/role.h>
> > > > +#include <linux/usb/typec.h>
> > > > +
> > > > +#define RT1719_REG_TXCTRL1   0x03
> > > > +#define RT1719_REG_TXCTRL2   0x04
> > > > +#define RT1719_REG_POLICYINFO        0x0E
> > > > +#define RT1719_REG_SRCPDO1   0x11
> > > > +#define RT1719_REG_MASKS     0x2D
> > > > +#define RT1719_REG_EVENTS    0x33
> > > > +#define RT1719_REG_STATS     0x37
> > > > +#define RT1719_REG_PSELINFO  0x3C
> > > > +#define RT1719_REG_USBSETINFO        0x3E
> > > > +#define RT1719_REG_VENID     0x82
> > > > +
> > > > +#define RT1719_UNIQUE_PID    0x1719
> > > > +#define RT1719_REQDRSWAP_MASK        BIT(7)
> > > > +#define RT1719_EVALMODE_MASK BIT(4)
> > > > +#define RT1719_REQSRCPDO_MASK        GENMASK(2, 0)
> > > > +#define RT1719_TXSPDOREQ_MASK        BIT(7)
> > > > +#define RT1719_INT_DRSW_ACCEPT       BIT(23)
> > > > +#define RT1719_INT_RX_SRCCAP BIT(21)
> > > > +#define RT1719_INT_VBUS_DCT  BIT(6)
> > > > +#define RT1719_INT_VBUS_PRESENT      BIT(5)
> > > > +#define RT1719_INT_PE_SNK_RDY        BIT(2)
> > > > +#define RT1719_CC1_STAT              GENMASK(9, 8)
> > > > +#define RT1719_CC2_STAT              GENMASK(11, 10)
> > > > +#define RT1719_POLARITY_MASK BIT(23)
> > > > +#define RT1719_DATAROLE_MASK BIT(22)
> > > > +#define RT1719_PDSPECREV_MASK        GENMASK(21, 20)
> > > > +#define RT1719_SPDOSEL_MASK  GENMASK(18, 16)
> > > > +#define RT1719_SPDONUM_MASK  GENMASK(15, 13)
> > > > +#define RT1719_ATTACH_VBUS   BIT(12)
> > > > +#define RT1719_ATTACH_DBG    BIT(10)
> > > > +#define RT1719_ATTACH_SNK    BIT(9)
> > > > +#define RT1719_ATTACHDEV_MASK        (RT1719_ATTACH_VBUS | RT1719_=
ATTACH_DBG | \
> > > > +                              RT1719_ATTACH_SNK)
> > > > +#define RT1719_PE_EXP_CONTRACT       BIT(2)
> > > > +#define RT1719_PSEL_SUPPORT  BIT(15)
> > > > +#define RT1719_TBLSEL_MASK   BIT(6)
> > > > +#define RT1719_LATPSEL_MASK  GENMASK(5, 0)
> > > > +#define RT1719_USBINFO_MASK  GENMASK(1, 0)
> > > > +#define RT1719_USB_DFPUFP    3
> > > > +#define RT1719_MAX_SRCPDO    7
> > > > +
> > > > +enum {
> > > > +     SNK_PWR_OPEN =3D 0,
> > > > +     SNK_PWR_DEF,
> > > > +     SNK_PWR_1P5A,
> > > > +     SNK_PWR_3A
> > > > +};
> > > > +
> > > > +enum {
> > > > +     USBPD_SPECREV_1_0 =3D 0,
> > > > +     USBPD_SPECREV_2_0,
> > > > +     USBPD_SPECREV_3_0
> > > > +};
> > > > +
> > > > +enum rt1719_snkcap {
> > > > +     RT1719_SNKCAP_5V =3D 0,
> > > > +     RT1719_SNKCAP_9V,
> > > > +     RT1719_SNKCAP_12V,
> > > > +     RT1719_SNKCAP_15V,
> > > > +     RT1719_SNKCAP_20V,
> > > > +     RT1719_MAX_SNKCAP
> > > > +};
> > > > +
> > > > +struct rt1719_psel_cap {
> > > > +     u8 lomask;
> > > > +     u8 himask;
> > > > +     u32 milliwatt;
> > > > +     u32 milliamp;
> > > > +};
> > > > +
> > > > +struct rt1719_data {
> > > > +     struct device *dev;
> > > > +     struct regmap *regmap;
> > > > +     struct typec_port *port;
> > > > +     struct usb_role_switch *role_sw;
> > > > +     struct power_supply *psy;
> > > > +     struct typec_partner *partner;
> > > > +     struct power_supply_desc psy_desc;
> > > > +     struct usb_pd_identity partner_ident;
> > > > +     struct typec_partner_desc partner_desc;
> > > > +     struct completion req_completion;
> > > > +     enum power_supply_usb_type usb_type;
> > > > +     bool attached;
> > > > +     bool pd_capable;
> > > > +     bool drswap_support;
> > > > +     u32 voltage;
> > > > +     u32 req_voltage;
> > > > +     u32 max_current;
> > > > +     u32 op_current;
> > > > +     u32 spdos[RT1719_MAX_SRCPDO];
> > > > +     u16 snkcaps[RT1719_MAX_SNKCAP];
> > > > +     int spdo_num;
> > > > +     int spdo_sel;
> > > > +     u32 conn_info;
> > > > +     u16 conn_stat;
> > > > +};
> > > > +
> > > > +static const enum power_supply_usb_type rt1719_psy_usb_types[] =3D=
 {
> > > > +     POWER_SUPPLY_USB_TYPE_C,
> > > > +     POWER_SUPPLY_USB_TYPE_PD,
> > > > +     POWER_SUPPLY_USB_TYPE_PD_PPS
> > > > +};
> > > > +
> > > > +static const enum power_supply_property rt1719_psy_properties[] =
=3D {
> > > > +     POWER_SUPPLY_PROP_ONLINE,
> > > > +     POWER_SUPPLY_PROP_USB_TYPE,
> > > > +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > > > +     POWER_SUPPLY_PROP_CURRENT_MAX,
> > > > +     POWER_SUPPLY_PROP_CURRENT_NOW
> > > > +};
> > > > +
> > > > +static int rt1719_read16(struct rt1719_data *data, unsigned int re=
g, u16 *val)
> > > > +{
> > > > +     __le16 regval;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D regmap_raw_read(data->regmap, reg, &regval, sizeof(re=
gval));
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     *val =3D le16_to_cpu(regval);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int rt1719_read32(struct rt1719_data *data, unsigned int re=
g, u32 *val)
> > > > +{
> > > > +     __le32 regval;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D regmap_raw_read(data->regmap, reg, &regval, sizeof(re=
gval));
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     *val =3D le32_to_cpu(regval);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int rt1719_write32(struct rt1719_data *data, unsigned int r=
eg, u32 val)
> > > > +{
> > > > +     __le32 regval =3D cpu_to_le32(val);
> > > > +
> > > > +     return regmap_raw_write(data->regmap, reg, &regval, sizeof(re=
gval));
> > > > +}
> > > > +
> > > > +static enum typec_pwr_opmode rt1719_get_pwr_opmode(u32 conn, u16 s=
tat)
> > > > +{
> > > > +     u16 cc1, cc2, cc_stat;
> > > > +
> > > > +     cc1 =3D FIELD_GET(RT1719_CC1_STAT, stat);
> > > > +     cc2 =3D FIELD_GET(RT1719_CC2_STAT, stat);
> > > > +
> > > > +     if (conn & RT1719_ATTACH_SNK) {
> > > > +             if (conn & RT1719_POLARITY_MASK)
> > > > +                     cc_stat =3D cc2;
> > > > +             else
> > > > +                     cc_stat =3D cc1;
> > > > +
> > > > +             switch (cc_stat) {
> > > > +             case SNK_PWR_3A:
> > > > +                     return TYPEC_PWR_MODE_3_0A;
> > > > +             case SNK_PWR_1P5A:
> > > > +                     return TYPEC_PWR_MODE_1_5A;
> > > > +             }
> > > > +     } else if (conn & RT1719_ATTACH_DBG) {
> > > > +             if ((cc1 =3D=3D SNK_PWR_1P5A && cc2 =3D=3D SNK_PWR_DE=
F) ||
> > > > +                 (cc1 =3D=3D SNK_PWR_DEF && cc2 =3D=3D SNK_PWR_1P5=
A))
> > > > +                     return TYPEC_PWR_MODE_1_5A;
> > > > +             else if ((cc1 =3D=3D SNK_PWR_3A && cc2 =3D=3D SNK_PWR=
_DEF) ||
> > > > +                      (cc1 =3D=3D SNK_PWR_DEF && cc2 =3D=3D SNK_PW=
R_3A))
> > > > +                     return TYPEC_PWR_MODE_3_0A;
> > > > +     }
> > > > +
> > > > +     return TYPEC_PWR_MODE_USB;
> > > > +}
> > > > +
> > > > +static enum typec_data_role rt1719_get_data_role(u32 conn)
> > > > +{
> > > > +     if (conn & RT1719_DATAROLE_MASK)
> > > > +             return TYPEC_HOST;
> > > > +     return TYPEC_DEVICE;
> > > > +}
> > > > +
> > > > +static void rt1719_set_data_role(struct rt1719_data *data,
> > > > +                              enum typec_data_role data_role,
> > > > +                              bool attached)
> > > > +{
> > > > +     enum usb_role usb_role =3D USB_ROLE_NONE;
> > > > +
> > > > +     if (attached) {
> > > > +             if (data_role =3D=3D TYPEC_HOST)
> > > > +                     usb_role =3D USB_ROLE_HOST;
> > > > +             else
> > > > +                     usb_role =3D USB_ROLE_DEVICE;
> > > > +     }
> > > > +
> > > > +     usb_role_switch_set_role(data->role_sw, usb_role);
> > > > +     typec_set_data_role(data->port, data_role);
> > > > +}
> > > > +
> > > > +static void rt1719_update_data_role(struct rt1719_data *data)
> > > > +{
> > > > +     if (!data->attached)
> > > > +             return;
> > > > +
> > > > +     rt1719_set_data_role(data, rt1719_get_data_role(data->conn_in=
fo), true);
> > > > +}
> > > > +
> > > > +static void rt1719_register_partner(struct rt1719_data *data)
> > > > +{
> > > > +     u16 spec_rev =3D 0;
> > > > +
> > > > +     if (data->pd_capable) {
> > > > +             u32 rev;
> > > > +
> > > > +             rev =3D FIELD_GET(RT1719_PDSPECREV_MASK, data->conn_i=
nfo);
> > > > +             switch (rev) {
> > > > +             case USBPD_SPECREV_3_0:
> > > > +                     spec_rev =3D 0x0300;
> > > > +                     break;
> > > > +             case USBPD_SPECREV_2_0:
> > > > +                     spec_rev =3D 0x0200;
> > > > +                     break;
> > > > +             default:
> > > > +                     spec_rev =3D 0x0100;
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     /* Just to prevent multiple times attach */
> > > > +     if (data->partner)
> > > > +             typec_unregister_partner(data->partner);
> > > > +
> > > > +     memset(&data->partner_ident, 0, sizeof(data->partner_ident));
> > > > +     data->partner_desc.usb_pd =3D data->pd_capable;
> > > > +     data->partner_desc.pd_revision =3D spec_rev;
> > > > +
> > > > +     if (data->conn_info & RT1719_ATTACH_DBG)
> > > > +             data->partner_desc.accessory =3D TYPEC_ACCESSORY_DEBU=
G;
> > > > +     else
> > > > +             data->partner_desc.accessory =3D TYPEC_ACCESSORY_NONE=
;
> > > > +
> > > > +     data->partner =3D typec_register_partner(data->port, &data->p=
artner_desc);
> > > > +}
> > > > +
> > > > +static void rt1719_attach(struct rt1719_data *data)
> > > > +{
> > > > +     enum typec_pwr_opmode pwr_opmode;
> > > > +     enum typec_data_role data_role;
> > > > +     u32 volt =3D 5000, curr =3D 500;
> > > > +
> > > > +     if (!(data->conn_info & RT1719_ATTACHDEV_MASK))
> > > > +             return;
> > > > +
> > > > +     pwr_opmode =3D rt1719_get_pwr_opmode(data->conn_info, data->c=
onn_stat);
> > > > +     data_role =3D rt1719_get_data_role(data->conn_info);
> > > > +
> > > > +     typec_set_pwr_opmode(data->port, pwr_opmode);
> > > > +     rt1719_set_data_role(data, data_role, true);
> > > > +
> > > > +     if (data->conn_info & RT1719_ATTACH_SNK)
> > > > +             rt1719_register_partner(data);
> > > > +
> > > > +     if (pwr_opmode =3D=3D TYPEC_PWR_MODE_3_0A)
> > > > +             curr =3D 3000;
> > > > +     else if (pwr_opmode =3D=3D TYPEC_PWR_MODE_1_5A)
> > > > +             curr =3D 1500;
> > > > +
> > > > +     data->voltage =3D volt * 1000;
> > > > +     data->max_current =3D data->op_current =3D curr * 1000;
> > > > +     data->attached =3D true;
> > > > +
> > > > +     power_supply_changed(data->psy);
> > > > +}
> > > > +
> > > > +static void rt1719_detach(struct rt1719_data *data)
> > > > +{
> > > > +     if (!data->attached || (data->conn_info & RT1719_ATTACHDEV_MA=
SK))
> > > > +             return;
> > > > +
> > > > +     typec_unregister_partner(data->partner);
> > > > +     data->partner =3D NULL;
> > > > +
> > > > +     typec_set_pwr_opmode(data->port, TYPEC_PWR_MODE_USB);
> > > > +     rt1719_set_data_role(data, TYPEC_DEVICE, false);
> > > > +
> > > > +     memset32(data->spdos, 0, RT1719_MAX_SRCPDO);
> > > > +     data->spdo_num =3D 0;
> > > > +     data->voltage =3D data->max_current =3D data->op_current =3D =
0;
> > > > +     data->attached =3D data->pd_capable =3D false;
> > > > +
> > > > +     data->usb_type =3D POWER_SUPPLY_USB_TYPE_C;
> > > > +
> > > > +     power_supply_changed(data->psy);
> > > > +}
> > > > +
> > > > +static void rt1719_update_operating_status(struct rt1719_data *dat=
a)
> > > > +{
> > > > +     enum power_supply_usb_type usb_type =3D POWER_SUPPLY_USB_TYPE=
_PD;
> > > > +     u32 voltage, max_current, op_current;
> > > > +     int i, snk_sel;
> > > > +
> > > > +     for (i =3D 0; i < data->spdo_num; i++) {
> > > > +             u32 pdo =3D data->spdos[i];
> > > > +             enum pd_pdo_type type =3D pdo_type(pdo);
> > > > +
> > > > +             if (type =3D=3D PDO_TYPE_APDO) {
> > > > +                     usb_type =3D POWER_SUPPLY_USB_TYPE_PD_PPS;
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     data->spdo_sel =3D FIELD_GET(RT1719_SPDOSEL_MASK, data->conn_=
info);
> > > > +     if (data->spdo_sel <=3D 0)
> > > > +             return;
> > > > +
> > > > +     data->usb_type =3D usb_type;
> > > > +
> > > > +     voltage =3D pdo_fixed_voltage(data->spdos[data->spdo_sel -1])=
;
> > > > +     max_current =3D pdo_max_current(data->spdos[data->spdo_sel - =
1]);
> > > > +
> > > > +     switch (voltage) {
> > > > +     case 5000:
> > > > +             snk_sel =3D RT1719_SNKCAP_5V;
> > > > +             break;
> > > > +     case 9000:
> > > > +             snk_sel =3D RT1719_SNKCAP_9V;
> > > > +             break;
> > > > +     case 12000:
> > > > +             snk_sel =3D RT1719_SNKCAP_12V;
> > > > +             break;
> > > > +     case 15000:
> > > > +             snk_sel =3D RT1719_SNKCAP_15V;
> > > > +             break;
> > > > +     case 20000:
> > > > +             snk_sel =3D RT1719_SNKCAP_20V;
> > > > +             break;
> > > > +     default:
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     op_current =3D min(max_current, pdo_max_current(data->snkcaps=
[snk_sel]));
> > > > +
> > > > +     /* covert mV/mA to uV/uA */
> > > > +     data->voltage =3D voltage * 1000;
> > > > +     data->max_current =3D max_current * 1000;
> > > > +     data->op_current =3D op_current * 1000;
> > > > +
> > > > +     power_supply_changed(data->psy);
> > > > +}
> > > > +
> > > > +static void rt1719_update_pwr_opmode(struct rt1719_data *data)
> > > > +{
> > > > +     if (!data->attached)
> > > > +             return;
> > > > +
> > > > +     if (!data->pd_capable) {
> > > > +             data->pd_capable =3D true;
> > > > +
> > > > +             typec_set_pwr_opmode(data->port, TYPEC_PWR_MODE_PD);
> > > > +             rt1719_register_partner(data);
> > > > +     }
> > > > +
> > > > +     rt1719_update_operating_status(data);
> > > > +}
> > > > +
> > > > +static void rt1719_update_source_pdos(struct rt1719_data *data)
> > > > +{
> > > > +     int spdo_num =3D FIELD_GET(RT1719_SPDONUM_MASK, data->conn_in=
fo);
> > > > +     __le32 src_pdos[RT1719_MAX_SRCPDO] =3D { };
> > > > +     int i, ret;
> > > > +
> > > > +     if (!data->attached)
> > > > +             return;
> > > > +
> > > > +     ret =3D regmap_raw_read(data->regmap, RT1719_REG_SRCPDO1, src=
_pdos,
> > > > +                           sizeof(__le32) * spdo_num);
> > > > +     if (ret)
> > > > +             return;
> > > > +
> > > > +     data->spdo_num =3D spdo_num;
> > > > +     for (i =3D 0; i < spdo_num; i++)
> > > > +             data->spdos[i] =3D le32_to_cpu(src_pdos[i]);
> > > > +}
> > > > +
> > > > +static int rt1719_dr_set(struct typec_port *port, enum typec_data_=
role role)
> > > > +{
> > > > +     struct rt1719_data *data =3D typec_get_drvdata(port);
> > > > +     enum typec_data_role cur_role;
> > > > +     int ret;
> > > > +
> > > > +     if (!data->attached || !data->pd_capable || !data->drswap_sup=
port)
> > > > +             return -EINVAL;
How about the below one?
-               return -EINVAL;
+               return -EOPNOTSUPP;
> > > > +
> > > > +     if (data->spdo_num > 0 && !(data->spdos[0] & PDO_FIXED_DATA_S=
WAP))
> > > > +             return -EINVAL;
> > > > +
> > > > +     cur_role =3D rt1719_get_data_role(data->conn_info);
> > > > +     if (cur_role =3D=3D role)
> > > > +             return 0;
> > > > +
> > > > +     ret =3D regmap_update_bits(data->regmap, RT1719_REG_TXCTRL1,
> > > > +                              RT1719_REQDRSWAP_MASK, RT1719_REQDRS=
WAP_MASK);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     reinit_completion(&data->req_completion);
> > > > +     ret =3D wait_for_completion_timeout(&data->req_completion,
> > > > +                                       msecs_to_jiffies(400));
> > > > +     if (ret =3D=3D 0)
> > > > +             return -ETIMEDOUT;
> > > > +
> > > > +     cur_role =3D rt1719_get_data_role(data->conn_info);
> > > > +     if (cur_role !=3D role)
> > > > +             return -ENOTSUPP;
>
Change it to Fault  here. Is it more suitable here?
-               return -ENOTSUPP;
+               return -EFAULT;
> In this case the operation just failed, right? If so, then you should
> not claim that the operation is not supported. You need to return some
> other, more appropriate error code in that case.
>
> And, in case drswap_support or pd_capable flag is not set, then you
> actually should return -EOPNOTSUPP, right?
>
Change as the above one.
> > > > +     rt1719_set_data_role(data, role, true);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct typec_operations rt1719_port_ops =3D {
> > > > +     .dr_set =3D rt1719_dr_set,
> > > > +};
> > > > +
> > > > +static int rt1719_usbpd_request_voltage(struct rt1719_data *data)
> > > > +{
> > > > +     u32 src_voltage;
> > > > +     int snk_sel, src_sel =3D -1;
> > > > +     int i, ret;
> > > > +
> > > > +     if (!data->attached || !data->pd_capable || data->spdo_sel <=
=3D 0)
> > > > +             return -EINVAL;
> > > > +
> > > > +     src_voltage =3D pdo_fixed_voltage(data->spdos[data->spdo_sel =
- 1]);
> > > > +     if (src_voltage =3D=3D data->req_voltage)
> > > > +             return 0;
> > > > +
> > > > +     switch (data->req_voltage) {
> > > > +     case 5000:
> > > > +             snk_sel =3D RT1719_SNKCAP_5V;
> > > > +             break;
> > > > +     case 9000:
> > > > +             snk_sel =3D RT1719_SNKCAP_9V;
> > > > +             break;
> > > > +     case 12000:
> > > > +             snk_sel =3D RT1719_SNKCAP_12V;
> > > > +             break;
> > > > +     case 15000:
> > > > +             snk_sel =3D RT1719_SNKCAP_15V;
> > > > +             break;
> > > > +     case 20000:
> > > > +             snk_sel =3D RT1719_SNKCAP_20V;
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     if (!(data->snkcaps[snk_sel] & RT1719_PSEL_SUPPORT))
> > > > +             return -EINVAL;
> > > > +
> > > > +     for (i =3D 0; i < data->spdo_num; i++) {
> > > > +             enum pd_pdo_type type =3D pdo_type(data->spdos[i]);
> > > > +
> > > > +             if (type !=3D PDO_TYPE_FIXED)
> > > > +                     continue;
> > > > +
> > > > +             src_voltage =3D pdo_fixed_voltage(data->spdos[i]);
> > > > +             if (src_voltage =3D=3D data->req_voltage) {
> > > > +                     src_sel =3D i;
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     if (src_sel =3D=3D -1)
> > > > +             return -ENOTSUPP;
> > > > +
> > > > +     ret =3D regmap_update_bits(data->regmap, RT1719_REG_TXCTRL1,
> > > > +                              RT1719_EVALMODE_MASK | RT1719_REQSRC=
PDO_MASK,
> > > > +                              RT1719_EVALMODE_MASK | (src_sel + 1)=
);
> > > > +     ret |=3D regmap_update_bits(data->regmap, RT1719_REG_TXCTRL2,
> > > > +                               RT1719_TXSPDOREQ_MASK, RT1719_TXSPD=
OREQ_MASK);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     reinit_completion(&data->req_completion);
> > > > +     ret =3D wait_for_completion_timeout(&data->req_completion,
> > > > +                                       msecs_to_jiffies(400));
> > > > +     if (!ret)
> > > > +             return -ETIMEDOUT;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int rt1719_psy_set_property(struct power_supply *psy,
> > > > +                                enum power_supply_property psp,
> > > > +                                const union power_supply_propval *=
val)
> > > > +{
> > > > +     struct rt1719_data *data =3D power_supply_get_drvdata(psy);
> > > > +     int ret =3D -ENOTSUPP;
>
> I'm actually not sure that claiming that the operation is not
> supported here is the correct error either... What do the other
> drivers return in this case?
>
> > > > +     if (psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_NOW) {
> > > > +             data->req_voltage =3D val->intval / 1000;
> > > > +             ret =3D rt1719_usbpd_request_voltage(data);
> > > > +     }
> > > > +
> > > > +     return ret;

How about to change it like as below
-       int ret =3D -ENOTSUPP;

        if (psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_NOW) {
                data->req_voltage =3D val->intval / 1000;
-               ret =3D rt1719_usbpd_request_voltage(data);
+               return rt1719_usbpd_request_voltage(data);
        }

-       return ret;
+       return -EINVAL;

> > > > +}
> > > > +
> > > > +static int rt1719_psy_get_property(struct power_supply *psy,
> > > > +                                enum power_supply_property psp,
> > > > +                                union power_supply_propval *val)
> > > > +{
> > > > +     struct rt1719_data *data =3D power_supply_get_drvdata(psy);
> > > > +     int ret =3D 0;
> > > > +
> > > > +     switch (psp) {
> > > > +     case POWER_SUPPLY_PROP_ONLINE:
> > > > +             val->intval =3D data->attached ? 1 : 0;
> > > > +             break;
> > > > +     case POWER_SUPPLY_PROP_USB_TYPE:
> > > > +             val->intval =3D data->usb_type;
> > > > +             break;
> > > > +     case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > > > +             val->intval =3D data->voltage;
> > > > +             break;
> > > > +     case POWER_SUPPLY_PROP_CURRENT_MAX:
> > > > +             val->intval =3D data->max_current;
> > > > +             break;
> > > > +     case POWER_SUPPLY_PROP_CURRENT_NOW:
> > > > +             val->intval =3D data->op_current;
> > > > +             break;
> > > > +     default:
> > > > +             ret =3D -EINVAL;
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int rt1719_psy_property_is_writeable(struct power_supply *p=
sy,
> > > > +                                         enum power_supply_propert=
y psp)
> > > > +{
> > > > +     if (psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_NOW)
> > > > +             return 1;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int devm_rt1719_psy_register(struct rt1719_data *data)
> > > > +{
> > > > +     static const char *rt1719_psy_name_prefix =3D "rt1719-source-=
psy-";
> > > > +     const char *port_dev_name =3D dev_name(data->dev);
> > > > +     struct power_supply_config psy_cfg =3D { };
> > > > +     size_t psy_name_len =3D strlen(rt1719_psy_name_prefix) +
> > > > +                                    strlen(port_dev_name) + 1;
> > > > +     char *psy_name;
> > > > +
> > > > +     psy_cfg.fwnode =3D dev_fwnode(data->dev);
> > > > +     psy_cfg.drv_data =3D data;
> > > > +
> > > > +     psy_name =3D devm_kzalloc(data->dev, psy_name_len, GFP_KERNEL=
);
> > > > +     if (!psy_name)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     snprintf(psy_name, psy_name_len, "%s%s", rt1719_psy_name_pref=
ix,
> > > > +              port_dev_name);
>
> psy_name =3D devm_kasprintf(data->dev, GFP_KERNEL, "rt1719-source-psy-%s"=
,
>                           dev_name(data->dev));
> if (!psy_name)
>         return -ENOMEM;
>
It's more simple.
Ack in next.
> > > > +     data->psy_desc.name =3D psy_name;
> > > > +     data->psy_desc.type =3D POWER_SUPPLY_TYPE_USB;
> > > > +     data->psy_desc.usb_types =3D rt1719_psy_usb_types;
> > > > +     data->psy_desc.num_usb_types =3D ARRAY_SIZE(rt1719_psy_usb_ty=
pes);
> > > > +     data->psy_desc.properties =3D rt1719_psy_properties;
> > > > +     data->psy_desc.num_properties =3D ARRAY_SIZE(rt1719_psy_prope=
rties);
> > > > +     data->psy_desc.get_property =3D rt1719_psy_get_property;
> > > > +     data->psy_desc.set_property =3D rt1719_psy_set_property;
> > > > +     data->psy_desc.property_is_writeable =3D rt1719_psy_property_=
is_writeable;
> > > > +
> > > > +     data->usb_type =3D POWER_SUPPLY_USB_TYPE_C;
> > > > +
> > > > +     data->psy =3D devm_power_supply_register(data->dev, &data->ps=
y_desc,
> > > > +                                            &psy_cfg);
> > > > +
> > > > +     return PTR_ERR_OR_ZERO(data->psy);
> > > > +}
> > > > +
> > > > +static irqreturn_t rt1719_irq_handler(int irq, void *priv)
> > > > +{
> > > > +     struct rt1719_data *data =3D priv;
> > > > +     u32 events, conn_info;
> > > > +     u16 conn_stat;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D rt1719_read32(data, RT1719_REG_EVENTS, &events);
> > > > +     ret |=3D rt1719_read32(data, RT1719_REG_POLICYINFO, &conn_inf=
o);
> > > > +     ret |=3D rt1719_read16(data, RT1719_REG_STATS, &conn_stat);
> > > > +     if (ret)
> > > > +             return IRQ_NONE;
> > > > +
> > > > +     data->conn_info =3D conn_info;
> > > > +     data->conn_stat =3D conn_stat;
> > > > +
> > > > +     events &=3D (RT1719_INT_DRSW_ACCEPT | RT1719_INT_RX_SRCCAP |
> > > > +                RT1719_INT_VBUS_PRESENT | RT1719_INT_VBUS_DCT |
> > > > +                RT1719_INT_PE_SNK_RDY);
> > > > +
> > > > +     if (events & RT1719_INT_DRSW_ACCEPT)
> > > > +             rt1719_update_data_role(data);
> > > > +
> > > > +     if (events & RT1719_INT_VBUS_PRESENT)
> > > > +             rt1719_attach(data);
> > > > +
> > > > +     if (events & RT1719_INT_VBUS_DCT)
> > > > +             rt1719_detach(data);
> > > > +
> > > > +     if (events & RT1719_INT_RX_SRCCAP)
> > > > +             rt1719_update_source_pdos(data);
> > > > +
> > > > +     if (events & RT1719_INT_PE_SNK_RDY) {
> > > > +             complete(&data->req_completion);
> > > > +             rt1719_update_pwr_opmode(data);
> > > > +     }
> > > > +
> > > > +     /* Write 1 to clear already handled events */
> > > > +     rt1719_write32(data, RT1719_REG_EVENTS, events);
> > > > +
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +static int rt1719_irq_init(struct rt1719_data *data)
> > > > +{
> > > > +     struct i2c_client *i2c =3D to_i2c_client(data->dev);
> > > > +     u32 irq_enable;
> > > > +     int ret;
> > > > +
> > > > +     irq_enable =3D RT1719_INT_DRSW_ACCEPT | RT1719_INT_RX_SRCCAP =
|
> > > > +                  RT1719_INT_VBUS_DCT | RT1719_INT_VBUS_PRESENT |
> > > > +                  RT1719_INT_PE_SNK_RDY;
> > > > +
> > > > +     ret =3D rt1719_write32(data, RT1719_REG_MASKS, irq_enable);
> > > > +     if (ret) {
> > > > +             dev_err(&i2c->dev, "Failed to config irq enable\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     return devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
> > > > +                                      rt1719_irq_handler, IRQF_ONE=
SHOT,
> > > > +                                      dev_name(&i2c->dev), data);
> > > > +}
> > > > +
> > > > +static int rt1719_init_attach_state(struct rt1719_data *data)
> > > > +{
> > > > +     u32 conn_info, irq_clear;
> > > > +     u16 conn_stat;
> > > > +     int ret;
> > > > +
> > > > +     irq_clear =3D RT1719_INT_DRSW_ACCEPT | RT1719_INT_RX_SRCCAP |
> > > > +                 RT1719_INT_VBUS_DCT | RT1719_INT_VBUS_PRESENT |
> > > > +                 RT1719_INT_PE_SNK_RDY;
> > > > +
> > > > +     ret =3D rt1719_read32(data, RT1719_REG_POLICYINFO, &conn_info=
);
> > > > +     ret |=3D rt1719_read16(data, RT1719_REG_STATS, &conn_stat);
> > > > +     ret |=3D rt1719_write32(data, RT1719_REG_EVENTS, irq_clear);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     data->conn_info =3D conn_info;
> > > > +     data->conn_stat =3D conn_stat;
> > > > +
> > > > +     if (conn_info & RT1719_ATTACHDEV_MASK)
> > > > +             rt1719_attach(data);
> > > > +
> > > > +     if (conn_info & RT1719_PE_EXP_CONTRACT) {
> > > > +             rt1719_update_source_pdos(data);
> > > > +             rt1719_update_pwr_opmode(data);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +#define RT1719_PSEL_CAPINFO(_lomask, _milliwatt, _himask, _milliam=
p) { \
> > > > +     .lomask         =3D _lomask, \
> > > > +     .milliwatt      =3D _milliwatt, \
> > > > +     .himask         =3D _himask, \
> > > > +     .milliamp       =3D _milliamp, \
> > > > +}
> > > > +
> > > > +static const struct rt1719_psel_cap rt1719_psel_caps[] =3D {
> > > > +     RT1719_PSEL_CAPINFO(0x18, 75000, 0x10, 5000),
> > > > +     RT1719_PSEL_CAPINFO(0x18, 60000, 0x10, 4500),
> > > > +     RT1719_PSEL_CAPINFO(0x18, 45000, 0x10, 4000),
> > > > +     RT1719_PSEL_CAPINFO(0x18, 30000, 0x10, 3500),
> > > > +     RT1719_PSEL_CAPINFO(0x18, 25000, 0x10, 3000),
> > > > +     RT1719_PSEL_CAPINFO(0x18, 20000, 0x10, 2500),
> > > > +     RT1719_PSEL_CAPINFO(0x18, 15000, 0x10, 2000),
> > > > +     RT1719_PSEL_CAPINFO(0x18, 10000, 0x10, 1000),
> > > > +     RT1719_PSEL_CAPINFO(0x1C, 60000, 0x1F, 5000),
> > > > +     RT1719_PSEL_CAPINFO(0x1C, 45000, 0x1F, 4500),
> > > > +     RT1719_PSEL_CAPINFO(0x1C, 30000, 0x1F, 4000),
> > > > +     RT1719_PSEL_CAPINFO(0x1C, 24000, 0x1F, 3500),
> > > > +     RT1719_PSEL_CAPINFO(0x1C, 15000, 0x1F, 3000),
> > > > +     RT1719_PSEL_CAPINFO(0x1C, 10000, 0x1F, 2500),
> > > > +     RT1719_PSEL_CAPINFO(0x0C, 60000, 0x1F, 2000),
> > > > +     RT1719_PSEL_CAPINFO(0x0C, 45000, 0x1F, 1000),
> > > > +     RT1719_PSEL_CAPINFO(0x0C, 36000, 0x08, 5000),
> > > > +     RT1719_PSEL_CAPINFO(0x0C, 30000, 0x08, 4500),
> > > > +     RT1719_PSEL_CAPINFO(0x0C, 24000, 0x08, 4000),
> > > > +     RT1719_PSEL_CAPINFO(0x0C, 15000, 0x08, 3500),
> > > > +     RT1719_PSEL_CAPINFO(0x0C, 10000, 0x08, 3000),
> > > > +     RT1719_PSEL_CAPINFO(0x1E, 45000, 0x08, 2500),
> > > > +     RT1719_PSEL_CAPINFO(0x1E, 36000, 0x08, 2000),
> > > > +     RT1719_PSEL_CAPINFO(0x1E, 27000, 0x08, 1500),
> > > > +     RT1719_PSEL_CAPINFO(0x1E, 20000, 0x08, 1000),
> > > > +     RT1719_PSEL_CAPINFO(0x1E, 15000, 0x0F, 5000),
> > > > +     RT1719_PSEL_CAPINFO(0x1E, 9000, 0x0F, 4500),
> > > > +     RT1719_PSEL_CAPINFO(0x0E, 45000, 0x0F, 4000),
> > > > +     RT1719_PSEL_CAPINFO(0x0E, 36000, 0x0F, 3500),
> > > > +     RT1719_PSEL_CAPINFO(0x0E, 27000, 0x0F, 3000),
> > > > +     RT1719_PSEL_CAPINFO(0x0E, 20000, 0x0F, 2500),
> > > > +     RT1719_PSEL_CAPINFO(0x0E, 15000, 0x0F, 2000),
> > > > +     RT1719_PSEL_CAPINFO(0x0E, 9000, 0x0F, 1500),
> > > > +     RT1719_PSEL_CAPINFO(0x06, 45000, 0x0F, 1000),
> > > > +     RT1719_PSEL_CAPINFO(0x06, 36000, 0x0F, 500),
> > > > +     RT1719_PSEL_CAPINFO(0x06, 27000, 0x04, 5000),
> > > > +     RT1719_PSEL_CAPINFO(0x06, 24000, 0x04, 4500),
> > > > +     RT1719_PSEL_CAPINFO(0x06, 18000, 0x04, 4000),
> > > > +     RT1719_PSEL_CAPINFO(0x06, 12000, 0x04, 3500),
> > > > +     RT1719_PSEL_CAPINFO(0x06, 9000, 0x04, 3000),
> > > > +     RT1719_PSEL_CAPINFO(0x1F, 25000, 0x04, 2500),
> > > > +     RT1719_PSEL_CAPINFO(0x1F, 20000, 0x04, 2000),
> > > > +     RT1719_PSEL_CAPINFO(0x1F, 15000, 0x04, 1500),
> > > > +     RT1719_PSEL_CAPINFO(0x1F, 10000, 0x04, 1000),
> > > > +     RT1719_PSEL_CAPINFO(0x1F, 7500, 0x07, 5000),
> > > > +     RT1719_PSEL_CAPINFO(0x0F, 25000, 0x07, 4500),
> > > > +     RT1719_PSEL_CAPINFO(0x0F, 20000, 0x07, 4000),
> > > > +     RT1719_PSEL_CAPINFO(0x0F, 15000, 0x07, 3500),
> > > > +     RT1719_PSEL_CAPINFO(0x0F, 10000, 0x07, 3000),
> > > > +     RT1719_PSEL_CAPINFO(0x0F, 7500, 0x07, 2500),
> > > > +     RT1719_PSEL_CAPINFO(0x07, 25000, 0x07, 2000),
> > > > +     RT1719_PSEL_CAPINFO(0x07, 20000, 0x07, 1500),
> > > > +     RT1719_PSEL_CAPINFO(0x07, 15000, 0x07, 1000),
> > > > +     RT1719_PSEL_CAPINFO(0x07, 10000, 0x07, 500),
> > > > +     RT1719_PSEL_CAPINFO(0x07, 7500, 0x03, 5000),
> > > > +     RT1719_PSEL_CAPINFO(0x03, 25000, 0x03, 4500),
> > > > +     RT1719_PSEL_CAPINFO(0x03, 20000, 0x03, 4000),
> > > > +     RT1719_PSEL_CAPINFO(0x03, 15000, 0x03, 3500),
> > > > +     RT1719_PSEL_CAPINFO(0x03, 10000, 0x03, 3000),
> > > > +     RT1719_PSEL_CAPINFO(0x03, 7500, 0x03, 2500),
> > > > +     RT1719_PSEL_CAPINFO(0x01, 15000, 0x03, 2000),
> > > > +     RT1719_PSEL_CAPINFO(0x01, 10000, 0x03, 1500),
> > > > +     RT1719_PSEL_CAPINFO(0x01, 7500, 0x03, 1000),
> > > > +     RT1719_PSEL_CAPINFO(0x01, 2500, 0x03, 500)
> > > > +};
> > > > +
> > > > +static u16 rt1719_gen_snkcap_by_current(const struct rt1719_psel_c=
ap *psel_cap,
> > > > +                                     enum rt1719_snkcap capsel)
> > > > +{
> > > > +     u16 cap =3D RT1719_PSEL_SUPPORT;
> > > > +
> > > > +     if (!(psel_cap->himask & BIT(capsel)))
> > > > +             return 0;
> > > > +
> > > > +     cap |=3D psel_cap->milliamp / 10;
> > > > +     return cap;
> > > > +}
> > > > +
> > > > +static u16 rt1719_gen_snkcap_by_watt(const struct rt1719_psel_cap =
*psel_cap,
> > > > +                                  enum rt1719_snkcap capsel)
> > > > +{
> > > > +     u32 volt_div[RT1719_MAX_SNKCAP] =3D { 5, 9, 12, 15, 20 };
> > > > +     u16 cap =3D RT1719_PSEL_SUPPORT;
> > > > +
> > > > +     if (!(psel_cap->lomask & BIT(capsel)))
> > > > +             return 0;
> > > > +
> > > > +     cap |=3D min(psel_cap->milliwatt / volt_div[capsel], (u32)500=
0) / 10;
> > > > +     return cap;
> > > > +}
> > > > +
> > > > +static u16 rt1719_gen_snkcap(unsigned int pselinfo, enum rt1719_sn=
kcap capsel)
> > > > +{
> > > > +     int psel =3D FIELD_GET(RT1719_LATPSEL_MASK, pselinfo);
> > > > +     const struct rt1719_psel_cap *psel_cap;
> > > > +     bool by_current =3D false;
> > > > +
> > > > +     if (pselinfo & RT1719_TBLSEL_MASK)
> > > > +             by_current =3D true;
> > > > +
> > > > +     psel_cap =3D rt1719_psel_caps + psel;
> > > > +     if (by_current)
> > > > +             return rt1719_gen_snkcap_by_current(psel_cap, capsel)=
;
> > > > +
> > > > +     return rt1719_gen_snkcap_by_watt(psel_cap, capsel);
> > > > +}
> > > > +
> > > > +static int rt1719_get_caps(struct rt1719_data *data)
> > > > +{
> > > > +     unsigned int pselinfo, usbinfo;
> > > > +     int i, ret;
> > > > +
> > > > +     ret =3D regmap_read(data->regmap, RT1719_REG_PSELINFO, &pseli=
nfo);
> > > > +     ret |=3D regmap_read(data->regmap, RT1719_REG_USBSETINFO, &us=
binfo);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     for (i =3D 0; i < RT1719_MAX_SNKCAP; i++)
> > > > +             data->snkcaps[i] =3D rt1719_gen_snkcap(pselinfo, i);
> > > > +
> > > > +     usbinfo =3D FIELD_GET(RT1719_USBINFO_MASK, usbinfo);
> > > > +     if (usbinfo =3D=3D RT1719_USB_DFPUFP)
> > > > +             data->drswap_support =3D true;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int rt1719_check_exist(struct rt1719_data *data)
> > > > +{
> > > > +     u16 pid;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D rt1719_read16(data, RT1719_REG_VENID, &pid);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     if (pid !=3D RT1719_UNIQUE_PID) {
> > > > +             dev_err(data->dev, "Incorrect PID 0x%04x\n", pid);
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct regmap_config rt1719_regmap_config =3D {
> > > > +     .reg_bits =3D 8,
> > > > +     .val_bits =3D 8,
> > > > +     .max_register =3D 0xff,
> > > > +};
> > > > +
> > > > +static int rt1719_probe(struct i2c_client *i2c)
> > > > +{
> > > > +     struct rt1719_data *data;
> > > > +     struct fwnode_handle *fwnode;
> > > > +     struct typec_capability typec_cap =3D { };
> > > > +     int ret;
> > > > +
> > > > +     data =3D devm_kzalloc(&i2c->dev, sizeof(*data), GFP_KERNEL);
> > > > +     if (!data)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     data->dev =3D &i2c->dev;
> > > > +     init_completion(&data->req_completion);
> > > > +
> > > > +     data->regmap =3D devm_regmap_init_i2c(i2c, &rt1719_regmap_con=
fig);
> > > > +     if (IS_ERR(data->regmap)) {
> > > > +             ret =3D PTR_ERR(data->regmap);
> > > > +             dev_err(&i2c->dev, "Failed to init regmap (%d)\n", re=
t);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     ret =3D rt1719_check_exist(data);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D rt1719_get_caps(data);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     /*
> > > > +      * This fwnode has a "compatible" property, but is never popu=
lated as a
> > > > +      * struct device. Instead we simply parse it to read the prop=
erties.
> > > > +      * This it breaks fw_devlink=3Don. To maintain backward compa=
tibility
> > > > +      * with existing DT files, we work around this by deleting an=
y
> > > > +      * fwnode_links to/from this fwnode.
> > > > +      */
> > > > +     fwnode =3D device_get_named_child_node(&i2c->dev, "connector"=
);
> > > > +     if (!fwnode)
> > > > +             return -ENODEV;
> > > > +
> > > > +     fw_devlink_purge_absent_suppliers(fwnode);
> > > > +
> > > > +     data->role_sw =3D fwnode_usb_role_switch_get(fwnode);
> > > > +     if (IS_ERR(data->role_sw)) {
> > > > +             ret =3D PTR_ERR(data->role_sw);
> > > > +             dev_err(&i2c->dev, "Failed to get usb role switch (%d=
)\n", ret);
> > > > +             goto err_fwnode_put;
> > > > +     }
> > > > +
> > > > +     ret =3D devm_rt1719_psy_register(data);
> > > > +     if (ret) {
> > > > +             dev_err(&i2c->dev, "Failed to register psy (%d)\n", r=
et);
> > > > +             goto err_role_put;
> > > > +     }
> > > > +
> > > > +     typec_cap.revision =3D USB_TYPEC_REV_1_2;
> > > > +     typec_cap.pd_revision =3D 0x300;  /* USB-PD spec release 3.0 =
*/
> > > > +     typec_cap.type =3D TYPEC_PORT_SNK;
> > > > +     typec_cap.data =3D TYPEC_PORT_DRD;
> > > > +     typec_cap.ops =3D &rt1719_port_ops;
> > > > +     typec_cap.fwnode =3D fwnode;
> > > > +     typec_cap.driver_data =3D data;
> > > > +     typec_cap.accessory[0] =3D TYPEC_ACCESSORY_DEBUG;
> > > > +
> > > > +     data->partner_desc.identity =3D &data->partner_ident;
> > > > +
> > > > +     data->port =3D typec_register_port(&i2c->dev, &typec_cap);
> > > > +     if (IS_ERR(data->port)) {
> > > > +             ret =3D PTR_ERR(data->port);
> > > > +             dev_err(&i2c->dev, "Failed to register typec port (%d=
)\n", ret);
> > > > +             goto err_role_put;
> > > > +     }
> > > > +
> > > > +     ret =3D rt1719_init_attach_state(data);
> > > > +     if (ret) {
> > > > +             dev_err(&i2c->dev, "Failed to init attach state (%d)\=
n", ret);
> > > > +             goto err_role_put;
> > > > +     }
> > > > +
> > > > +     ret =3D rt1719_irq_init(data);
> > > > +     if (ret) {
> > > > +             dev_err(&i2c->dev, "Failed to init irq\n");
> > > > +             goto err_role_put;
> > > > +     }
> > > > +
> > > > +     fwnode_handle_put(fwnode);
> > > > +
> > > > +     i2c_set_clientdata(i2c, data);
> > > > +
> > > > +     return 0;
> > > > +
> > > > +err_role_put:
> > > > +     usb_role_switch_put(data->role_sw);
> > > > +err_fwnode_put:
> > > > +     fwnode_handle_put(fwnode);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int rt1719_remove(struct i2c_client *i2c)
> > > > +{
> > > > +     struct rt1719_data *data =3D i2c_get_clientdata(i2c);
> > > > +
> > > > +     typec_unregister_port(data->port);
> > > > +     usb_role_switch_put(data->role_sw);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id __maybe_unused rt1719_device_tabl=
e[] =3D {
> > > > +     { .compatible =3D "richtek,rt1719", },
> > > > +     { }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, rt1719_device_table);
> > > > +
> > > > +static struct i2c_driver rt1719_driver =3D {
> > > > +     .driver =3D {
> > > > +             .name =3D "rt1719",
> > > > +             .of_match_table =3D rt1719_device_table,
> > > > +     },
> > > > +     .probe_new =3D rt1719_probe,
> > > > +     .remove =3D rt1719_remove,
> > > > +};
> > > > +module_i2c_driver(rt1719_driver);
> > > > +
> > > > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > > > +MODULE_DESCRIPTION("Richtek RT1719 Sink Only USBPD Controller Driv=
er");
> > > > +MODULE_LICENSE("GPL v2");
>
> thanks,
>
> --
> heikki
