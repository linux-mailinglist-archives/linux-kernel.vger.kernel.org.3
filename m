Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25C6518DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiECUEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:04:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8513E1901C;
        Tue,  3 May 2022 13:00:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g6so35482420ejw.1;
        Tue, 03 May 2022 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxaT5a9mxFo9vHNrfWPQOIvrWpFwZ29kzFdHY5abTLk=;
        b=SudvmlcWADSJQkKpoHHqF0lk+miCNeKd36HwnL4xED11ceBjqenq4OyQD8FJDOEqda
         piJ3iYeVFonfKEFWO8oI7GvHW4+KhKI+AgzGJD44ArTrmuNV6jiyzKw1n+WVlz3DmdFK
         3db6plX+sCWyJffcuwUzfEKxBZWtdwKtd8NgI/OeDqNmxli/usCnWEdloXZBPeJJHD9Z
         CsyUabIpRY5DQvfzEVjxrpL7dJh1Tguk+xFr3V2hHS4tqGShmljvUiIAJXRObJo1lW6H
         txq8sDJei57ibuqbrE03/ru9Mel3b1He3kMyuvUw/rSWJA94uGl9Yzrp+rTRMZs6eKDx
         bz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxaT5a9mxFo9vHNrfWPQOIvrWpFwZ29kzFdHY5abTLk=;
        b=oSOhz0xztg6L9l+SBx3DNYYgGWp2ROVpE1R6w3FAIu39UMI5CVKFqvp0xn4dv0rOx2
         jV4suyYYtwm+b0CB3fNpG0LhIrpcrc+aKr046RQ9m0+k4HU0reqUb+lN1YNqPdb/IGzL
         L1L2o/jiRfMQ9Xo6MgJ449ppAAUTgdo1KXYuMPeLFnBl8+tJdn4TTvzLG31CNSPlOc1M
         W/QNTWL8TeIU4Adbvp7cY+FMRPMY+etC1cTzTc/idMRsnA/+z7vaFjWZ9Qq5RS7gtGVx
         lTG+nW8ZkgLUgo3XWmbK6DnFjfaoDgHFl5Awlqo1w91AKyIWDmr/T6Oh5yKG88M7Xp3J
         ilJw==
X-Gm-Message-State: AOAM530csYcnA67eGIPcvjtkEVXVdIgeOtdXuBXhZGBM7pqsAZ4IBlIv
        RczpyZW4Gqo6Nrya4CHZZbYVjFOdx9VvMQ==
X-Google-Smtp-Source: ABdhPJzfrMrzIlChURZtsBvey/f1dntHqFDytb5e+YSbS0KU0oan+7WxNSX9HDWcYqkPKf3yjCYFOg==
X-Received: by 2002:a17:906:99c4:b0:6f4:56d2:4bbd with SMTP id s4-20020a17090699c400b006f456d24bbdmr10109597ejn.754.1651608046101;
        Tue, 03 May 2022 13:00:46 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id hz12-20020a1709072cec00b006f3ef214dcbsm4945057ejc.49.2022.05.03.13.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:00:45 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: Re: [PATCH] arm64: dts: allwinner: define USB3 Ethernet on NanoPi R1S H5
Date:   Tue, 03 May 2022 22:00:44 +0200
Message-ID: <1818121.CQOukoFCf9@kista>
In-Reply-To: <4393725.LvFx2qVVIh@kista>
References: <20220502144009.44575-1-amadeus@jmu.edu.cn> <4393725.LvFx2qVVIh@kista>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 03. maj 2022 ob 19:54:34 CEST je Jernej =C5=A0krabec napisal(a):
> Dne ponedeljek, 02. maj 2022 ob 16:40:09 CEST je Chukun Pan napisal(a):
> > The NanoPi R1S H5 has a Realtek RTL8153B USB 3.0 Ethernet chip
> > connected to the USB 2.0 port of the Allwinner H5 SoC.
> >=20
> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts =
b/
> arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> > index 55b369534a08..dd655a491549 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> > @@ -21,7 +21,8 @@ / {
> > =20
> >  	aliases {
> >  		ethernet0 =3D &emac;
> > -		ethernet1 =3D &rtl8189etv;
> > +		ethernet1 =3D &rtl8153;
> > +		ethernet2 =3D &rtl8189etv;

Additionally, it's not a good idea to change order of ethernet nodes. It ca=
n=20
affect mac address assigning procedure in bootloader.

Best regards,
Jernej

> >  		serial0 =3D &uart0;
> >  	};
> > =20
> > @@ -116,6 +117,11 @@ &cpu0 {
> > =20
> >  &ehci1 {
> >  	status =3D "okay";
>=20
> You need to add #address-cells and #size-cells properties, otherwise "mak=
e=20
> dtbs_check W=3D1" generates warnings.
>=20
> Best regards,
> Jernej
>=20
> > +
> > +	rtl8153: device@1 {
> > +		compatible =3D "usbbda,8153";
> > +		reg =3D <1>;
> > +	};
> >  };
> > =20
> >  &ehci2 {
> > --=20
> > 2.25.1
> >=20
> >=20
>=20
>=20
>=20


