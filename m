Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE1C592BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiHOIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHOIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:38:19 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9257E1FCDE;
        Mon, 15 Aug 2022 01:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660552645; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QjKjIOY8ZDZi64qF+liI0FfzOyCkFI7H2UqqibiaeLYjXEHAgYa/yd+ALLYHRpppuI8UZK97Aqx2dTVT1LmcFU5Qw6lpiGkfebUA5AfZf2EVcIQGLuXoSruMTKRiP4c7hmOG0wbRNU+bzqJ5ricE02NI4MfKbWH/P3mLAghcvCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660552645; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=cB1XiTm87D9JbU4ykT4luhhGIBNc3+cXH36s1017BCQ=; 
        b=XevhvMHk7V0X7DGIf6x1/YZCsZop9KrVQRDuBCAhVD4WqsXWpjMYcT7nTaCUwa+71aRg7GhikTuWeWtII7gCXvSwRziRAV58x1lgKsul+BgsfXnl3eoamtOjNXaIHJzDOUzN67eP9URIktvWKFFbtsnbdFBvItDg6Sz9eGsDrN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660552645;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=cB1XiTm87D9JbU4ykT4luhhGIBNc3+cXH36s1017BCQ=;
        b=VYmgttSf1NNRcY7xj78X43FskIOAOWk4y1MMk6w9zxDZ6SqCWRKASIetSSWMwk5i
        kg9AZMpqOs24KzkY0P2c58oBqln+EqkRz94kqsWTO9Nbf5Ov/EqRxXrUOy9rQIVv/j2
        wLZjYyg1z+9VqXfd8DF6EuOLUWZDzapjbTzXd/ds=
Received: from edelgard.icenowy.me (112.94.101.156 [112.94.101.156]) by mx.zohomail.com
        with SMTPS id 1660552642448647.1957186956895; Mon, 15 Aug 2022 01:37:22 -0700 (PDT)
Message-ID: <197d58ed8b674d622e5c6a049905cd88e40659bc.camel@icenowy.me>
Subject: Re: [PATCH 2/4] nvmem: sunxi_sid: Drop the workaround on A64
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Date:   Mon, 15 Aug 2022 16:37:14 +0800
In-Reply-To: <20220814173656.11856-3-samuel@sholland.org>
References: <20220814173656.11856-1-samuel@sholland.org>
         <20220814173656.11856-3-samuel@sholland.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-08-14=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 12:36 -0500=EF=BC=
=8CSamuel Holland=E5=86=99=E9=81=93=EF=BC=9A
> Now that the SRAM readout code is fixed by using 32-bit accesses, it
> always returns the same values as register readout, so the A64
> variant
> no longer needs the workaround. This makes the D1 variant structure
> redundant, so remove it.

Is this really tested on A64?

>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
> =C2=A0drivers/nvmem/sunxi_sid.c | 8 +-------
> =C2=A01 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 92dfe4cb10e3..a970f1741cc6 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -197,15 +197,9 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.need_register_readout =
=3D true,
> =C2=A0};
> =C2=A0
> -static const struct sunxi_sid_cfg sun20i_d1_cfg =3D {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.value_offset =3D 0x200,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size =3D 0x100,
> -};
> -
> =C2=A0static const struct sunxi_sid_cfg sun50i_a64_cfg =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.value_offset =3D 0x200,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size =3D 0x100,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.need_register_readout =3D tru=
e,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct sunxi_sid_cfg sun50i_h6_cfg =3D {
> @@ -218,7 +212,7 @@ static const struct of_device_id
> sunxi_sid_of_match[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun7i-a20-sid", .data =3D
> &sun7i_a20_cfg },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun8i-a83t-sid", .data =3D
> &sun50i_a64_cfg },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun8i-h3-sid", .data =3D
> &sun8i_h3_cfg },
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwinner,s=
un20i-d1-sid", .data =3D
> &sun20i_d1_cfg },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwinner,s=
un20i-d1-sid", .data =3D
> &sun50i_a64_cfg },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun50i-a64-sid", .data =3D
> &sun50i_a64_cfg },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun50i-h5-sid", .data =3D
> &sun50i_a64_cfg },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun50i-h6-sid", .data =3D
> &sun50i_h6_cfg },


