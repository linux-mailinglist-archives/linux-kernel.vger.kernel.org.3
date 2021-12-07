Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374E046B61A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhLGIjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLGIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:39:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2AC061746;
        Tue,  7 Dec 2021 00:36:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so27873394wrn.6;
        Tue, 07 Dec 2021 00:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=txpKJCB9flJSZc0QKUGWSrqXp0fivPRRoZMs5h9rIy4=;
        b=ONpPyzBbBYmCy/jEi6THaHeMomOw87qLzvC9Tn3SIZeXT+AcjKJzYp0R9mUkq1G9SH
         Z0BwYt6LSejwIh6sd+2TgWdeYtqC1+nY/lr+RjypnIYD+0j8WELgL56ANu3/nYJxFHTN
         pIDrjeIiPvbV+NIn6FMbEXwqeJZiZqLty+dD1wih5vvEMLQDMRmU+aSQCF2uaLzD7Nta
         y2rSpYqq9K7/Qo4DuRPrvq8cX7j6pgRJi/WKrny0JzgyKUGFY+yDwEZIWcYAzb4UiyvS
         x0LUWKbOSkY3PZGAvzBlG32hVvvLERBAw3t1djsXBcV3nkptL/byeF6ngOZIhfGN3p4Z
         1ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txpKJCB9flJSZc0QKUGWSrqXp0fivPRRoZMs5h9rIy4=;
        b=BiScGzmF8Z4z4QNeUAFYVCkvLzqBmH6NbPv55pv4tPsyFBATBYQ5lxfU1KjhljQ2HC
         MIBayxaRTLXkc/l1vIHKMyNSpOd4AKj9z4SOs55/PnMD+uRWgkwoCRw+td67+fQrgEOM
         bYSyegiQpAedp3z3AS7fkVyBdXqBX4Q1yYZwlTvZBjrhd3/1/hAxMj1VDZd+/2fWHI2z
         yANpnZt0W8JSsKuCBKkNx4F3gB0NHb3D5Shpb9eYji8cNaNryvwVtRMt3wF5TLtnDaHA
         ICx/pU9oJNajFx0hbUw0vqiXmCoz0Pe+j7cxFlG1YBgzZYWJAM0e0PU9cjXhSAA39/Jy
         Wa2g==
X-Gm-Message-State: AOAM532ZyaoIVCYJBlRbGfjoYoB/7aWv/A5QjG3EpAx6zMRLEOLJAG+C
        kMdlESzEDaGFKxsAduDcST8=
X-Google-Smtp-Source: ABdhPJznedDUqS8jUQ+Ryu0I+xJoYdixLr+0Cztf872wx/CqkKNyE+ViGHLrl9WkD57LKsRp6LCx7Q==
X-Received: by 2002:adf:fb86:: with SMTP id a6mr49712690wrr.35.1638866178321;
        Tue, 07 Dec 2021 00:36:18 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id s8sm13724585wro.19.2021.12.07.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:36:17 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:36:13 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: Add missing properties used in examples
Message-ID: <Ya8c/YjZswNcykLW@orome.fritz.box>
References: <20211206174201.2297265-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RkZB72i537OSCdj2"
Content-Disposition: inline
In-Reply-To: <20211206174201.2297265-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RkZB72i537OSCdj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:42:00AM -0600, Rob Herring wrote:
> When 'unevaluatedProperties' support is enabled, the following warnings
> are generated in the mmc bindings:
>=20
> Documentation/devicetree/bindings/mmc/mtk-sd.example.dt.yaml: mmc@1123000=
0: Unevaluated properties are not allowed ('reg', 'interrupts' were unexpec=
ted)
> Documentation/devicetree/bindings/mmc/sdhci-am654.example.dt.yaml: mmc@4f=
80000: Unevaluated properties are not allowed ('sdhci-caps-mask' was unexpe=
cted)
> Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.example.dt.ya=
ml: mmc@5a400000: Unevaluated properties are not allowed ('dma-names', 'dma=
s' were unexpected)
> Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@8012=
6000: Unevaluated properties are not allowed ('dmas', 'dma-names' were unex=
pected)
> Documentation/devicetree/bindings/mmc/arasan,sdhci.example.dt.yaml: mmc@8=
0420000: Unevaluated properties are not allowed ('resets' was unexpected)
> Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5200=
7000: Unevaluated properties are not allowed ('interrupt-names' was unexpec=
ted)
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc=
@5b010000: Unevaluated properties are not allowed ('power-domains' was unex=
pected)
>=20
> Add the missing properties as necessary. For pl18x, drop interrupt-names
> as there isn't any use of it when there are 2 interrupts.
>=20
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wenbin Mei <wenbin.mei@mediatek.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml  | 3 +++
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml     | 9 ++++++++-
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 +++
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml        | 6 ++++++
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml   | 2 ++
>  .../devicetree/bindings/mmc/socionext,uniphier-sd.yaml   | 6 ++++++
>  6 files changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Do=
cumentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index de6f076e0ece..83be9e93d221 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -118,6 +118,9 @@ properties:
>    phy-names:
>      const: phy_arasan
> =20
> +  resets:
> +    maxItems: 1
> +
>    arasan,soc-ctl-syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Docum=
entation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 47595cb483be..fbc866d9bb2f 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -60,6 +60,14 @@ properties:
>      minItems: 1
>      maxItems: 2
> =20
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
>    power-domains: true
> =20
>    resets:
> @@ -213,7 +221,6 @@ examples:
>        arm,primecell-periphid =3D <0x10153180>;
>        reg =3D <0x52007000 0x1000>;
>        interrupts =3D <49>;
> -      interrupt-names =3D "cmd_irq";
>        clocks =3D <&rcc 0>;
>        clock-names =3D "apb_pclk";
>        resets =3D <&rcc 1>;
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/D=
ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 19621a2f8beb..8d5cef0d3039 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -116,6 +116,9 @@ properties:
>        - const: ahb
>        - const: per
> =20
> +  power-domains:
> +    maxItems: 1
> +
>    pinctrl-names:
>      oneOf:
>        - minItems: 3
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Document=
ation/devicetree/bindings/mmc/mtk-sd.yaml
> index 82768a807294..faf89b0c918f 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -36,6 +36,9 @@ properties:
>            - const: mediatek,mt8195-mmc
>            - const: mediatek,mt8183-mmc
> =20
> +  reg:
> +    maxItems: 1
> +
>    clocks:
>      description:
>        Should contain phandle for the clock feeding the MMC controller.
> @@ -62,6 +65,9 @@ properties:
>        - const: axi_cg
>        - const: ahb_cg
> =20
> +  interrupts:
> +    maxItems: 1
> +
>    pinctrl-names:
>      items:
>        - const: default
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Doc=
umentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 224303f5b913..9fbf16b3bc8d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -48,6 +48,8 @@ properties:
>        - const: clk_ahb
>        - const: clk_xin
> =20
> +  sdhci-caps-mask: true

I can take a stab at converting sdhci.txt if you don't have a patch for
that yet. That way we can reference this one rather than blindly passing
validation for it.

Otherwise looks good:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--RkZB72i537OSCdj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvHP0ACgkQ3SOs138+
s6GdPxAAoiiXF6jcILeyfyeQa6e86k5/6ZroZA28WrPOsubkr4xVzr1RuuHC9MUs
kgO7jaOsRmnLNvRivQDvs97Sc2FKEJC6rqx9T1J9p3RSRAq4aGEMlx7tVhjdrEny
iTO1QKmRnvgxrEWV6tNaqG4kkCN9ITvIekQWDf6Kko2rD2Xo4dV2dndMXvbDxTse
AqDtuA6bprz2L2fAQLSt3O06+QGQLCxo0+tZcs1vzxnF6Nk7WU1PpKNpMEw+Bhe0
/8gV6GDmty1zvKko3PfaEtDj2F9eiNjReJVbA9LF5iC4GwObpzL7qwm37Qv4466f
aAeVluxwNn67u+LOr+oBV8CidIvFn7tooJxFmj/u08jmKuE9PL7JJOMDI23IlKn8
cIzf7UAy7KR30FIbb3yyL//RW9I3ZSV3J92Bp63rDS+yG3Pe5RgKqW1dvzuMS2iv
THlqohHmZ1n5JJPSHgD+oG/4RzTZdYNsPjN0AcC+ERsQauU5+aCLATD+ja2hkVA+
PL1Aadx8XpqUhqbEP3mIPUv1qH9EMg0CRGs5wQYjCddZgRI2q06jI3SoMIlAO82Z
RGOM2I1/GY+gM6W6Es4m817F+z03ahzZEcRz+92K3opjBHT64c2c3YOcW45ubo13
iTG4CPi1UKE1673mqe1e0BfkTvB1j90AmBSmFkTDbQiH0Bc+o4k=
=soAZ
-----END PGP SIGNATURE-----

--RkZB72i537OSCdj2--
