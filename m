Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDD4CE043
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiCDWjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:39:22 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB312717;
        Fri,  4 Mar 2022 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646433506;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=G31gGYuULnnC5IvJtl2MmzT9OfKz57FNYjCVaM8fsHk=;
    b=OxNE1KlEmIfn85/pOCdgB740ksGZ1XUkOLbXUFxdQbK2L+AH5VfPTCoDKeqdGggQLY
    noKMpGTuj1jobiJWOVvWFMElIAmHdmEvym9jtd9ayKJqLpaiZpg22xJKkaQNtCm3QubS
    2qpJQlPAKZe5swe6LuK6weuh49hZkScuKph2cgcT+2XyxdUGeaXJC+BTKNqklAcsbcgv
    P90dBUK/b8/faPjZzP5gPO+6bqR6+axVI6iq+Gwwu+FJSPvgbft5UkEHFPPh0qf1W9dL
    xAuQuL+7HwKHjpUJUMMIAlQVJlyqSUIchiNscwNl45RL3fk7PFUC0HheCHKnXJHcFojH
    UC2A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8QUWw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey24McQ9DH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 4 Mar 2022 23:38:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v6 14/48] mfd: ti_am335x_tscadc: Don't search the tree for
 our clock
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20211015081506.933180-15-miquel.raynal@bootlin.com>
Date:   Fri, 4 Mar 2022 23:38:25 +0100
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7336E356-57E3-4BC5-B098-0A791C2CB360@goldelico.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
 <20211015081506.933180-15-miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,
I recently found that our BeagleBoneBlack with external touch screen =
stopped
to find it.

A git bisect revealed this patch (merged into v5.16-rc1) as the first =
bad:

> Am 15.10.2021 um 10:14 schrieb Miquel Raynal =
<miquel.raynal@bootlin.com>:
>=20
> There is a single clock available in our node, which is named
> "fck". The clock handler then points to adc_tsc_fck but no need to =
point
> directly to it and do a full tree search.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> drivers/mfd/ti_am335x_tscadc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/ti_am335x_tscadc.c =
b/drivers/mfd/ti_am335x_tscadc.c
> index e2c4416f192d..8af44c08d925 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -206,7 +206,7 @@ static	int ti_tscadc_probe(struct =
platform_device *pdev)
> 	 * This frequency is valid since TSC_ADC_SS controller design
> 	 * assumes the OCP clock is at least 6x faster than the ADC =
clock.
> 	 */
> -	clk =3D devm_clk_get(&pdev->dev, "adc_tsc_fck");
> +	clk =3D devm_clk_get(&pdev->dev, NULL);
> 	if (IS_ERR(clk)) {
> 		dev_err(&pdev->dev, "failed to get TSC fck\n");
> 		err =3D PTR_ERR(clk);
> --=20
> 2.27.0
>=20

While I understand the reasons for this change there seems to be =
something
missing now in the device tree because the clock isn't found any more.

After knowing about the problem I could also locate the log entry:

[    4.456680] ti_am3359-tscadc 44e0d000.tscadc: failed to get TSC fck

Reverting your patch makes it work again.

Is there missing a change in the am335x-boneblack or am335x DTS?

Our (private) DTS looks like this, i.e. we don't play with clocks =
inherited
from mainline tree:

#include "am335x-boneblack.dts"

...

&tscadc {
        status =3D "okay";

        tsc {
                ti,wires =3D <4>;
                ti,x-plate-resistance =3D <600>;
                ti,coordinate-readouts =3D <5>;
                ti,wire-config =3D <0x00 0x11 0x22 0x33>;
        };

        adc {
                ti,adc-channels =3D <4 5 6 7>;
        };
};

BR and thanks,
Nikolaus=
