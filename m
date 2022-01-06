Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57F24861A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiAFItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiAFIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:49:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42690C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 00:49:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h23so3430197wrc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nY4pcVTt6C1OfBYYq7bKgEYzMZ9c3SJrVRdzsfNxtoc=;
        b=T2EsDtKFmFLkTNp0bKgIcsr20z2haV/dtIngzpsHvMqwbEKvnEBsJUeu+IB8V/gtuX
         YcSeDGbKI93QDJ6wRfXgtXzMFa53I1g1ODEXjvQdK/FMvviStTonEH7LAbHkxzKb58LQ
         mydsxrUVU0vpEkSIw5rWcZ038ug2eSV1NOX6q83pdT4dPax3nNKDl7NOaCEFRRyNqB02
         +zbp1emsXjOhF4ffaR8rLBlI4FVJ8+agiN2zxt78Hz/pM0BGrL/sVylOk5Tn9p3Ez6Az
         xwgKz1JgHs/GoFvH+wXDgEnSiAOy13gD0YVdXMI2ElcQGiqwzeJp1S8R6o5CtHf5lsMJ
         eF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nY4pcVTt6C1OfBYYq7bKgEYzMZ9c3SJrVRdzsfNxtoc=;
        b=Vn8O+l1OPxIHV5ydjUxAydwMDEAA2cdonm6TFcpWiIy+BOgNws91nC5H5PeEbuSd4E
         6t/nJSW11RwaoHWRMQP8qM30XI8zj7e7x064nPAjQkHDuVEH3Kproq8WKOAqpsApLnWV
         7p0BjaAIcaJrz1rhkUCLpe5zCpD6mo/CLbjk5IBfCzsFhYOZ3SNj+GZ/WvANZi3Wh/9r
         QZPH3ziYNUJqVEHCyr3xot8Zqk0JceZB22Cg8L8Z+YeHqJf5bbbRVnbXXfqop9w9hnwj
         W7qwO34oqG0s5N4AUR3vBFBqi+Fb0X1xAiOf5f6niN8wupbyD1lgsCImMlaCQ9pOlDO+
         vuqg==
X-Gm-Message-State: AOAM530YiLLNIX9AVG6jvBG3NIjYo7XDW6X7/g2p1PJbZET2yTPdDkOd
        k3Mc7v3AFqr/Gd07oj8CnMRFYQ==
X-Google-Smtp-Source: ABdhPJyUR3+Mk2jA/15s+4ovyFOsOB62zACYqVptdsGlpIwmjtMb1e5b2QbWGfesWg3zVOcnMkVvQw==
X-Received: by 2002:adf:c10e:: with SMTP id r14mr50609653wre.558.1641458968749;
        Thu, 06 Jan 2022 00:49:28 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id r11sm1614797wrz.78.2022.01.06.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 00:49:28 -0800 (PST)
References: <20220106033130.37623-1-liang.yang@amlogic.com>
 <20220106091246.08ca66e0@xps13>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nand: meson: fix controller clock
Date:   Thu, 06 Jan 2022 09:43:56 +0100
In-reply-to: <20220106091246.08ca66e0@xps13>
Message-ID: <1jbl0pz1t4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 06 Jan 2022 at 09:12, Miquel Raynal <miquel.raynal@bootlin.com> wrot=
e:

> liang.yang@amlogic.com wrote on Thu, 6 Jan 2022 11:31:30 +0800:
>
>> Change-Id: I1425b491d8b95061e1ce358ef33143433fc94d24
>> ---
>>  .../bindings/mtd/amlogic,meson-nand.txt        | 18 +++---------------
>
> I forgot to mention, while you're at it, after fixing the bindings,
> could you please convert it to yaml?
>
>>  1 file changed, 3 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.tx=
t b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> index 5794ab1147c1..37f16fe4fe66 100644
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> @@ -14,11 +14,6 @@ Required properties:
>>  - clock-names: Should contain the following:
>>  	"core" - NFC module gate clock
>>  	"device" - device clock from eMMC sub clock controller

If I refer to the related driver change, this is not true anymore and
should be updated

>> -	"rx" - rx clock phase
>> -	"tx" - tx clock phase
>> -
>> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eM=
MC
>> -				controller port C
>>=20=20
>>  Optional children nodes:
>>  Children nodes represent the available nand chips.
>> @@ -28,11 +23,6 @@ see Documentation/devicetree/bindings/mtd/nand-contro=
ller.yaml for generic bindi
>>=20=20
>>  Example demonstrate on AXG SoC:
>>=20=20
>> -	sd_emmc_c_clkc: mmc@7000 {
>> -		compatible =3D "amlogic,meson-axg-mmc-clkc", "syscon";
>> -		reg =3D <0x0 0x7000 0x0 0x800>;
>> -	};
>> -
>>  	nand-controller@7800 {
>>  		compatible =3D "amlogic,meson-axg-nfc";
>>  		reg =3D <0x0 0x7800 0x0 0x100>;
>> @@ -41,11 +31,9 @@ Example demonstrate on AXG SoC:
>>  		interrupts =3D <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>>=20=20
>>  		clocks =3D <&clkc CLKID_SD_EMMC_C>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
>> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
>> -		clock-names =3D "core", "device", "rx", "tx";
>> -		amlogic,mmc-syscon =3D <&sd_emmc_c_clkc>;
>> +			<&clkc CLKID_FCLK_DIV2>;
>> +		clock-names =3D "core", "device";

If you want to re-implement the mmc clock part directly in the nand
driver, you should provide both clock inputs, like the mmc driver (in
addition to the pclk) ... Even if you plan on using only FDIV2 in the
driver, this what the HW is.

Something like:

clock-names =3D "core", "clkin0", "clkin1";
clocks =3D <&clkc CLKID_SD_EMMC_C>,
         <&clkc CLKID_SD_EMMC_C_CLK0>,
	 <&clkc CLKID_FCLK_DIV2>;

>> +		sd_emmc_c_clkc =3D <0xffe07000>;

This is not how you provide memory regions

>>=20=20
>>  		pinctrl-names =3D "default";
>>  		pinctrl-0 =3D <&nand_pins>;
>
>
> Thanks,
> Miqu=C3=A8l

