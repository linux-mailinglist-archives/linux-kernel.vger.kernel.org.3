Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6625760B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiGOLmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGOLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:41:59 -0400
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11187C30;
        Fri, 15 Jul 2022 04:41:56 -0700 (PDT)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 638BBC3F3EC9;
        Fri, 15 Jul 2022 13:41:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 638BBC3F3EC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1657885312; bh=6WgQL5dDQgGCkY5eOoqGlM0sZqSYnTYubq8pAl/7Hec=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bnRjuirYKpLgrdjRlDwjPz1wtIiqmTWPOo0WEvq+Z2DGevfhNxjtec9GQPpPrJAcu
         2Yse6OgcVKi22OcVj/Bg406bhRmX1vJNbE9LYZi5EiEPS6AIfRuQ0HXBMwJry4o15W
         /xA+Cbv6wxR0zJ7MFEBriw+t6tGB//nS8/sXNeHQ=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <mchehab@kernel.org>
Subject: Re: [PATCH -next] media: ar0521: fix error return code in
 ar0521_power_on()
References: <20220715085924.1881607-1-yangyingliang@huawei.com>
Sender: khalasa@piap.pl
Date:   Fri, 15 Jul 2022 13:41:52 +0200
In-Reply-To: <20220715085924.1881607-1-yangyingliang@huawei.com> (Yang
        Yingliang's message of "Fri, 15 Jul 2022 16:59:24 +0800")
Message-ID: <m3zghaeh6n.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, license restriction
X-KLMS-AntiPhishing: not scanned, license restriction
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, license restriction
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> writes:

> Return error code if ar0521_write_regs() fails in ar0521_power_on().
>
> Fixes: 852b50aeed15 ("media: On Semi AR0521 sensor driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Right, thanks.

Acked-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

> +++ b/drivers/media/i2c/ar0521.c
> @@ -757,8 +757,9 @@ static int ar0521_power_on(struct device *dev)
>  	usleep_range(4500, 5000); /* min 45000 clocks */
>=20=20
>  	for (cnt =3D 0; cnt < ARRAY_SIZE(initial_regs); cnt++)
> -		if (ar0521_write_regs(sensor, initial_regs[cnt].data,
> -				      initial_regs[cnt].count))
> +		ret =3D ar0521_write_regs(sensor, initial_regs[cnt].data,
> +					initial_regs[cnt].count);
> +		if (ret)
>  			goto off;

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
