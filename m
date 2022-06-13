Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8A354993C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiFMQoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbiFMQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:43:53 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0171E44C7;
        Mon, 13 Jun 2022 07:33:30 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 70B73240012;
        Mon, 13 Jun 2022 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655130805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgOZd2Vfi/HOg/3HSQWoHmC0I40OMrwKOFV6lIb9Er8=;
        b=hmpaT1nlbdsUsiDbvJJ5b8jKhvR0VWiONZKXcYKwV/z4P2/qqrPITPWpwH0Q6BYB7ZrvyQ
        dtKjBYlUL0itD3g5yMn5SgZe6KlVJEhDvQpHyiU1dGsqbSoIpgDwUsdIiw7xiO+2e8s+sh
        8ubboH3yegNVQRlhprAWMI+KeS5osYC9sNH+gG/qfRI9eIJg8zgz5dU8bPW71avfKFkRNv
        vVmrm5Q/u8FZMx/dPC2GqSa7I1PVw8yI2Kcdr4SiFFr/wkhv7HZKxPEnqo5lBSbq/2o4kI
        +kvAK5PRFOet6Y8LLfyf7DtGdfaUKozXAsm9sLiYxXS16mbgYU/wSUXi6H1xWA==
Date:   Mon, 13 Jun 2022 16:33:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/2] mtd: allow getting MTD device associated with a
 specific DT node
Message-ID: <20220613163321.6c3ccb5e@xps-13>
In-Reply-To: <ad084c13-55fc-8506-f768-49a0c6ae4f7f@gmail.com>
References: <20220611204651.19947-1-zajec5@gmail.com>
        <20220613160411.48b07515@xps-13>
        <ad084c13-55fc-8506-f768-49a0c6ae4f7f@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Mon, 13 Jun 2022 16:15:34 +0200:

> On 13.06.2022 16:04, Miquel Raynal wrote:
> >> @@ -1154,6 +1154,34 @@ int __get_mtd_device(struct mtd_info *mtd)
> >>   }
> >>   EXPORT_SYMBOL_GPL(__get_mtd_device); =20
> >>   >> +/** =20
> >> + * of_get_mtd_device_by_node - obtain an MTD device associated with a=
 given node
> >> + *
> >> + * @np: device tree node
> >> + */
> >> +struct mtd_info *of_get_mtd_device_by_node(struct device_node *np) =20
> >=20
> > Shall we try to use a more of-agnostic syntax or is it too complex here=
? =20
>=20
> I need some extra hint, please. This is how many similar functions look
> like:

I know most implementation today use of_ functions directly but it
seems like there is a global move towards fwnodes now, and I was
wondering if using those instead (which might also apply to other types
of "nodes" than DT ones) could be possible.

But looking into existing implementations, I came across the pwm implem
which features:
- of_pwm_get()
- acpi_pwm_get()

And finally a fwnode_pwm_get() which does:

	if (is_of_node())
		of_pwm_get():
	else if (is_acpi_node())
		acpi_pwm_get();

So actually my suggestion is meaningless. I'm fine with the current
approach.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


>=20
> $ grep -E -r "(get|find).*_by_node" ./include/*
> ./include/drm/drm_mipi_dsi.h:struct mipi_dsi_host *of_find_mipi_dsi_host_=
by_node(struct device_node *node);
> ./include/drm/drm_mipi_dsi.h:struct mipi_dsi_device *of_find_mipi_dsi_dev=
ice_by_node(struct device_node *np);
> ./include/linux/usb/phy.h:extern struct usb_phy *devm_usb_get_phy_by_node=
(struct device *dev,
> ./include/linux/usb/phy.h:static inline struct usb_phy *devm_usb_get_phy_=
by_node(struct device *dev,
> ./include/linux/extcon.h:struct extcon_dev *extcon_find_edev_by_node(stru=
ct device_node *node);
> ./include/linux/extcon.h:static inline struct extcon_dev *extcon_find_ede=
v_by_node(struct device_node *node)
> ./include/linux/of_net.h:extern struct net_device *of_find_net_device_by_=
node(struct device_node *np);
> ./include/linux/of_net.h:static inline struct net_device *of_find_net_dev=
ice_by_node(struct device_node *np)
> ./include/linux/devfreq.h:struct devfreq *devfreq_get_devfreq_by_node(str=
uct device_node *node);
> ./include/linux/devfreq.h:static inline struct devfreq *devfreq_get_devfr=
eq_by_node(struct device_node *node)
> ./include/linux/of_platform.h:extern struct platform_device *of_find_devi=
ce_by_node(struct device_node *np);
> ./include/linux/of_platform.h:static inline struct platform_device *of_fi=
nd_device_by_node(struct device_node *np)
> ./include/linux/backlight.h:struct backlight_device *of_find_backlight_by=
_node(struct device_node *node);
> ./include/linux/backlight.h:of_find_backlight_by_node(struct device_node =
*node)
> ./include/linux/i2c.h:struct i2c_client *of_find_i2c_device_by_node(struc=
t device_node *node);
> ./include/linux/i2c.h:struct i2c_adapter *of_find_i2c_adapter_by_node(str=
uct device_node *node);
> ./include/linux/i2c.h:struct i2c_adapter *of_get_i2c_adapter_by_node(stru=
ct device_node *node);
> ./include/linux/i2c.h:static inline struct i2c_client *of_find_i2c_device=
_by_node(struct device_node *node)
> ./include/linux/i2c.h:static inline struct i2c_adapter *of_find_i2c_adapt=
er_by_node(struct device_node *node)
> ./include/linux/i2c.h:static inline struct i2c_adapter *of_get_i2c_adapte=
r_by_node(struct device_node *node)
>=20
>=20
> >> +{
> >> +	struct mtd_info *mtd =3D NULL;
> >> +	struct mtd_info *tmp;
> >> +	int err;
> >> +
> >> +	mutex_lock(&mtd_table_mutex);
> >> +
> >> +	err =3D -ENODEV;
> >> +	mtd_for_each_device(tmp) {
> >> +		if (mtd_get_of_node(tmp) =3D=3D np) {
> >> +			mtd =3D tmp;
> >> +			err =3D __get_mtd_device(mtd);
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	mutex_unlock(&mtd_table_mutex);
> >> +
> >> +	return err ? ERR_PTR(err) : mtd;
> >> +}
> >> +EXPORT_SYMBOL_GPL(of_get_mtd_device_by_node);
> >> +
> >>   /**
> >>    *	get_mtd_device_nm - obtain a validated handle for an MTD device by
> >>    *	device name =20
>=20


Thanks,
Miqu=C3=A8l
