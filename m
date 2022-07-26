Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736FB580F79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiGZJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:03:06 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00229C97
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:03:04 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 2663E301247;
        Tue, 26 Jul 2022 11:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658826183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxRye85q48crwir7NWYtcq+eVvb1dxCVznVhQQ9au+0=;
        b=kyaf2s9HA9nXwxRPMH9yyVDNpWTf1cJ4DNPWbMZHh25nTIfu4PblPg3ZiHPB6mb82ejGfc
        xNVQTbm/bHaqFHtQO9ylfeOZAi742vRYys0ZVp0zSPHb5bdPLsYmZQIj23Xr7OmzJBZp2J
        De7BcJ2qKDMXZu1Mt8f3qpfsDNV5hZ0I0/79CkujFhVaKR3U0zQe36L9q99MTjJ4Emg/Yu
        f7ArBhxgRTxxAkFpjZbWxbH9CgQMAl8+6fZVstSP8/xfGXCxTN3drI41bS7KDVGytReZXG
        Rx1j2SVWMNmHwFp4ATxco1f6Hrs2Mz/MUkYIAWV296h/MDvyUUgB3DC+q6BK2g==
Message-ID: <af067c133aa410370aaa4f11e334bc910b4c21e2.camel@svanheule.net>
Subject: Re: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
From:   Sander Vanheule <sander@svanheule.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, mail@birger-koblitz.de
Date:   Tue, 26 Jul 2022 11:03:01 +0200
In-Reply-To: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, 2022-07-25 at 21:35 +0200, Martin Blumenstingl wrote:
> The code seemingly tries to clear RTL_SPI_SFCSR_LEN_MASK (before then
> setting either RTL_SPI_SFCSR_LEN1 or RTL_SPI_SFCSR_LEN4) and
> RTL_SPI_SFCSR_CS. What it actually does is only keeping these bits and
> clearing all other bits, even the ones which were just set before. Fix
> the operation to clear the bits in the selected mask and keep all other
> ones.
>=20
> Fixes: a8af5cc2ff1e80 ("spi: realtek-rtl: Add support for Realtek
> RTL838x/RTL839x SPI controllers")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> I stumbled across this while reading the driver. This patch is untested
> because I don't have any hardware with this controller.
>=20
>=20
> =C2=A0drivers/spi/spi-realtek-rtl.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.=
c
> index 866b0477dbd7..e5ad0f11996f 100644
> --- a/drivers/spi/spi-realtek-rtl.c
> +++ b/drivers/spi/spi-realtek-rtl.c
> @@ -49,7 +49,7 @@ static void set_size(struct rtspi *rtspi, int size)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 value;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D readl(REG(RTL_S=
PI_SFCSR));
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value &=3D RTL_SPI_SFCSR_LEN_M=
ASK;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value &=3D ~RTL_SPI_SFCSR_LEN_=
MASK;

Although typically a field mask has the only the bits of that field set,
RTL_SPI_SFCSR_LEN_MASK is already inverted. So LEN_MASK has all bits set,
*except* for those where LEN is stored.

This means the code currently is:
	value &=3D ~(0x3 << 28);

which is correct AFAICT, as it clears the LEN bits, but keeps all the other=
s.

While this part is currently not wrong, I wouldn't be opposed to a patch to=
 make
it less confusing by not inverting the field mask in the definition of
RTL_SPI_SFCSR_LEN_MASK.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (size =3D=3D 4)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0value |=3D RTL_SPI_SFCSR_LEN4;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (size =3D=3D 1)
> @@ -143,7 +143,7 @@ static void init_hw(struct rtspi *rtspi)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Permanently disable CS=
1, since it's never used */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value |=3D RTL_SPI_SFCSR_=
CSB1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Select CS0 for use */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value &=3D RTL_SPI_SFCSR_CS;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value &=3D ~RTL_SPI_SFCSR_CS;

This macro is not inverted, so it does clear any previously set bits, and
probably doesn't end up with RTL_SPI_SFCRS_CS set. However, is in an init c=
all
and it doesn't appear to cause any issues later on, right? Is this because =
the
SFCSR register is (unintentionally) cleared and that is actually required?

Best,
Sander

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel(value, REG(RTL_SPI=
_SFCSR));
> =C2=A0}
> =C2=A0
