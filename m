Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88A4E99EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbiC1Om5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiC1Om4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:42:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B2C3DA75
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:41:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a1so20710329wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G6STbBOIWrl91z9Js/2xSJ69ciuixOh8p5+13N9nge4=;
        b=a5GnlrEop9sH2gZ92j/WZWs0/lNyHPeq+I2GCXEme2z5UgCQFFzPDI6Ig91l4DH3A4
         Oan/w1Fi6hLyIPREiRXoBDxX/6ikfnlrSE4YsrBrzEM2r4J5ptLu7cuabB6wMz70Tcn1
         KugpgwErr2d5lD7wXUTg4ubk4ilEFfDDscDx0dEQNFm5yTLfDa+5cB39WY7XiN8HKCLr
         x64nYBJDDE2ZgJS6qI6ooIURfhFH15B21fUuHpfofDJ60XRxTMuuekOa5oOWyG7EP7nt
         7MzLOMVTo3S/oXdJkD5JjHmws5sJvcKP2d6OfIavkY+LlrDrVORwRrmvND1PZCK4TcwA
         VQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G6STbBOIWrl91z9Js/2xSJ69ciuixOh8p5+13N9nge4=;
        b=e1XDV8Uzd4wNdccd0m6zoMD/XD8KYYrQdcKLkWk1wYB1Iw91+snpYt4A1KbfPnwrmW
         eRWyO0LyX5SvLdWABxZ6onc+1/Xa/bP9D6r1MdMXDeEFPpCx6UQTJM45/HmaiEqCILdD
         2b8yhB7DSxOgZMVruGWVFSxo3uiA2S+/MXy93mwRCjV7Cf8HsGg38XRqMixbrkusHGNs
         /gjnXm17H8FHxOPclK+QNqKfT98hT921rxan452a/vdpPHqPlV3JUQIv1v+q63pTV9jF
         mIpm22G5e0DbEnNqp/bLvRMbMk2ZXOgsReFLQvCfIa/T88e9Q7VnfsgSmcdlGqQJKP/l
         SeTw==
X-Gm-Message-State: AOAM5302DsLhWmOfwvOty4OJyzv14ywn+Fot+pQvqVNLR/3/VTfxefNT
        vcZ6hwqOj4tA2bQlBeuedkCOnA==
X-Google-Smtp-Source: ABdhPJx8cZc0l3wMABftdDemo3IkUaQ0vbWVZbivcfb5qrdC8JZo7eELfFo6ySf1YkVTWkWGgVo6AA==
X-Received: by 2002:adf:fecf:0:b0:1f0:62e0:bcd8 with SMTP id q15-20020adffecf000000b001f062e0bcd8mr24188340wrs.61.1648478473021;
        Mon, 28 Mar 2022 07:41:13 -0700 (PDT)
Received: from radium ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm13591324wmq.9.2022.03.28.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:41:12 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:41:07 +0200
From:   Fabien Parent <fparent@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: Add device-tree for MT8195
 Demo board
Message-ID: <20220328144107.ed4xwzuiezzixqrx@radium>
References: <20220327200312.3090515-1-fparent@baylibre.com>
 <20220327200312.3090515-3-fparent@baylibre.com>
 <94d231cf-ce4c-22f5-b9af-41ae68f1e659@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xajkuje6fmke6plh"
Content-Disposition: inline
In-Reply-To: <94d231cf-ce4c-22f5-b9af-41ae68f1e659@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xajkuje6fmke6plh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2022 at 03:47:09PM +0200, AngeloGioacchino Del Regno wrote:
> Il 27/03/22 22:03, Fabien Parent ha scritto:
> > Add basic device-tree for the MT8195 Demo board. The
> > Demo board is made by MediaTek and has a MT8195 SoC,
> > associated with the MT6359 and MT6360 PMICs, and
> > the MT7921 connectivity chip.
> >=20
> > The IOs available on that board are:
> > * 1 USB Type-C connector with DP aux mode support
> > * 1 USB Type-A connector
> > * 1 full size HDMI RX and 1 full size HDMI TX connector
> > * 1 uSD slot
> > * 40 pins header
> > * SPI interface header
> > * 1 M.2 slot
> > * 1 audio jack
> > * 1 micro-USB port for serial debug
> > * 2 connectors for DSI displays
> > * 3 connectors for CSI cameras
> > * 1 connector for a eDP panel
> > * 1 MMC storage
> >=20
> > This commit adds basic support in order to be able to boot.
> >=20
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> > v2:
> >   * remove empty i2c nodes
> >   * remove empty spi node
> >   * remove unused pcie pinctrls
> >   * fixup node nodes to not contains underscore
> >   * rename mt6360 pmic node
> >   * move mmc1 node right after mmc0 node
> >   * use generic node name for gpio-keys
> >   * uniformize pinctrl node names
> >=20
> >   arch/arm64/boot/dts/mediatek/Makefile        |   1 +
> >   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 447 +++++++++++++++++++
> >   2 files changed, 448 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> >=20
>=20
> ..snip..
>=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/=
boot/dts/mediatek/mt8195-demo.dts
> > new file mode 100644
> > index 000000000000..d94b4e01159a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > @@ -0,0 +1,447 @@
>=20
> ..snip..
>=20
> > +
> > +	gpio-keys {
> > +		compatible =3D "gpio-keys";
> > +		input-name =3D "gpio-keys";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&gpio_keys_pins>;
> > +
> > +		key-0 {
>=20
> key-volup is more descriptive, can you please change that?

Which review should I follow, yours or the one from Krzysztof? Because both=
 reviews are contradictory

>=20
> > +			gpios =3D <&pio 106 GPIO_ACTIVE_LOW>;
> > +			label =3D "volume_up";
> > +			linux,code =3D <KEY_VOLUMEUP>;
> > +			wakeup-source;
> > +			debounce-interval =3D <15>;
> > +		};
> > +	};
> > +};
> > +
>=20
> ..snip..
>=20
> > +
> > +&pmic {
> > +	interrupt-parent =3D <&pio>;
> > +	interrupts =3D <222 IRQ_TYPE_LEVEL_HIGH>;
>=20
> I would instead use interrupts-extended here:
>=20
> 	interrupts-extended =3D <&pio 222 IRQ_TYPE_LEVEL_HIGH>;

Thanks, it will be fixed in v3.

>=20
> > +};
> > +
> > +&i2c6 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-0 =3D <&i2c6_pins>;
> > +	pinctrl-names =3D "default";
> > +	status =3D "okay";
> > +
> > +	mt6360: pmic@34 {
> > +		compatible =3D "mediatek,mt6360";
> > +		reg =3D <0x34>;
> > +		interrupt-controller;
> > +		interrupt-parent =3D <&pio>;
> > +		interrupts =3D <101 IRQ_TYPE_EDGE_FALLING>;
>=20
> Same here

Thanks, it will be fixed in v3.

>=20
> > +		interrupt-names =3D "IRQB";
> > +
>=20
> ...snip...
>=20
> > +
> > +&pio {
> > +	mmc0_default_pins: mmc0-default-pins {
> > +		pins-cmd-dat {
> > +			pinmux =3D <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> > +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> > +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> > +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> > +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> > +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> > +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> > +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> > +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> > +			input-enable;
> > +			drive-strength =3D <MTK_DRIVE_6mA>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +
> > +		pin-clk {
>=20
> This is supposed to be "pins-clk", not "pin-clk"... same for all the other
> instances of the "pin-".

There is only one pin in that node, so it should be singular, no?

>=20
> Before pushing patches upstream, please run dtbs_check, as these are all
> mistakes that will be pointed out by that.
>=20
> Regards,
> Angelo
>=20

--xajkuje6fmke6plh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQyJHfU3UNW7IG61XVJKc6g3CeAAFAmJByQIACgkQVJKc6g3C
eABNUg/7Befzz/j+X7NeVFnAtAEQJXYJp//BfXgdGIobco+gZfUKhfUWfETWso/X
W/XkRDtA5Fslnw0dUDo4mxP8uLWNZmqgxcx+4ScM4bEqFqxk4gv1BHSxpQxHIkaJ
OPraNE72+uQneXV3ZaXFI7R6DxZWZPxi1r6aQ7mdxb27/JAKUEnc7IqxSfdcWOVi
3qidD/W8f0dtZy68C1M/6+Pok0O0RO6Z1yO2/BHKLEgSFxWfM6xUId6fKhKu2IIl
EKy+Hc/O50lBp3HrU00ux7G7jYwud/c4jxXUH9m2J5k1acb/MTCilKAUoAIJSvwz
qpI71IarL2V6gEettEGEQ2GpKoTYLRQ7Hu6YCoN05EtKh8MH9l/qECwUIRJ2pgKp
Q8ptn8Qa4ScEcZyKeITwapWIlUmli81sVbo3OUXXYcJneFd8b3mlI+zFAxnBkiqb
wOatUg4tEdc1cTfv0UzZXQ8u2NPMvggLBQNWlPfMX+mn4RkQSfXPDkQu/MvF7ePd
NbWZ9jW7CE1YJ9R9VdpazWOKf3h9Pq2QahjrR3fINW9p2NyIpLz7STd5/I4yj/Dh
7zSqzaQlKew9+xRY7aOK6eOfXsxbHuSY994xLmN87gNY5qWhdNUuJLTGgfjZyW8/
eRcqNr9lhZZdqi8p8xE4lIFSonBzdUPRFGlBjorMc00EcQKCoX8=
=tvKe
-----END PGP SIGNATURE-----

--xajkuje6fmke6plh--
