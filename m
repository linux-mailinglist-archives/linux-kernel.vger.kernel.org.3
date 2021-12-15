Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863EF475A35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbhLOOBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbhLOOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:01:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8889C06173E;
        Wed, 15 Dec 2021 06:01:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k9so20589567wrd.2;
        Wed, 15 Dec 2021 06:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2eD7MObQ6Tk/8+S054ZxxYiQmaPM8m76juRuVYeIAE=;
        b=qMAxqAscRmRv9RWr9myf7PEBaiC0EmtSCP8xAMsx7nUCZooLCll9q28kE3nFxyVSIS
         biFMA1aUrjiUwRFM5YiMLjl0EYI4tM0YXY+ZsoeomGWUa08547/aqN7A4dr22JloQ4SR
         wJEx/wrzU9M7xjlOlGdazgo8v2gOHPP8clfzqgOrFgHB6qI1gVxZFw3kGcHRsCKvC7FR
         gUA1QpOg4XS16NVQiEHMPY8MTFHnaRltRVCeKGl8/jbbdOYSPNpKYLc0AbyjDDtXKrI2
         cZxpbJAn6oidG8s03AZw45n62+eGk6Pfj8dGzY/eD85P45EnB9kSLuzDpfOuoSQIiRA/
         nh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2eD7MObQ6Tk/8+S054ZxxYiQmaPM8m76juRuVYeIAE=;
        b=TFPRKQFuAtqaqjNIPsi2G7sEF2NxlO8MM2JiaGsd5JuHldDAC+offNz1YSlcZI7YV8
         Rjn2OfTIzklXS7fAXYwmuLclV7gc2wvXf+9geL23EJJYAiI81GoJ0NuiYLtjwt7OWMqU
         BhHp8Sl/emjb0rI7neQDBPAmTIhb0fk+xW1ra207fBUQekJbA05hTAViSf8W0mxL26ZB
         KRXFZecz8lqXbsts5IfuSBjUMURnFEhhMkyr+3/t2SzC7sYlKGeRNyy+ufTVKKLxyU4y
         QS3Cv4dXj9v9t/BP1/r81YUcLkODDhrxmaAAl4SnUYzuUvKhWnRBtpOjfQZ63KDk8aAH
         SH1g==
X-Gm-Message-State: AOAM531VM+CFizYLkx6ntsmSoTeqQPpxDvbT8/EwqHbef8W4Hqi9TOtw
        qUcJhntJYiRP2WgXy3KPOXs=
X-Google-Smtp-Source: ABdhPJz+BRvFYybWyzVqBblhiz7DNZTzTC56ockXeKM19nWwvbuUJrPuScZy8FWuTAu/Exb1aE79xQ==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr4512753wru.97.1639576890199;
        Wed, 15 Dec 2021 06:01:30 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id c8sm2320894wmq.34.2021.12.15.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 06:01:29 -0800 (PST)
Date:   Wed, 15 Dec 2021 15:01:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/28] ARM: tegra: Add device-tree for ASUS
 Transformer Infinity TF700T
Message-ID: <Ybn1Ne2aGfsablwQ@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4QNYjcTi513a/zhS"
Content-Disposition: inline
In-Reply-To: <20211211211412.10791-12-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4QNYjcTi513a/zhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 12, 2021 at 12:13:55AM +0300, Dmitry Osipenko wrote:
[...]
> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			dsi-bridge@7 {
> +				compatible = "toshiba,tc358768";
> +				reg = <0x7>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				clocks = <&tc358768_osc>;
> +				clock-names = "refclk";
> +
> +				reset-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
> +
> +				vddc-supply = <&vdd_1v2_mipi>;
> +				vddio-supply = <&vdd_1v8_vio>;
> +				vddmipi-supply = <&vdd_1v2_mipi>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						bridge_input: endpoint {
> +							remote-endpoint = <&dpi_output>;
> +							data-lines = <24>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						bridge_output: endpoint {
> +							remote-endpoint = <&panel_input>;
> +						};
> +					};
> +				};
> +
> +				/*
> +				 * Panasonic VVX10F004B00 or HYDIS HV101WU1-1E1
> +				 * LCD SuperIPS+ Full HD panel.
> +				 */
> +				panel@1 {
> +					compatible = "panasonic,vvx10f004b00";
> +					reg = <1>;
> +
> +					power-supply = <&vdd_pnl>;
> +					backlight = <&backlight>;
> +
> +					port {
> +						panel_input: endpoint {
> +							remote-endpoint = <&bridge_output>;
> +						};
> +					};
> +				};

make dtbs_check complains about this and says that panel@1 (as well as
#address-cells and #size-cells) are not allowed here. And indeed the
binding for the Toshiba bridge doesn't mention them here.

Do we need this here or should this be moved to the top level to fix
those warnings? I guess what you're doing above is describe a DSI bus
created by the DSI bridge, which also makes sense, so another
alternative would be to fix up the binding and let it accept those
properties.

Thierry

--4QNYjcTi513a/zhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG59TIACgkQ3SOs138+
s6HD1xAAm8DaT6So1msIwtUIXskigng+5eBeQ9njOhvT4GBKLPRjs+0ihBXmOcV/
Oyd4ndaEEtIE2rRFZbNo2nq2Z1SFNu3f8p3NuKU3Co/KPhjxLRFI79lFMgbAUr1z
Dbzwb9EZZc+dUgnBpxNoqsaRzHju8g6iimZIqLqoOksXI3vHwt/g4PjIM+Y2mlsm
xIQKuDq6AkKMGIXMt1uDw+FF4lvDaZqHaWLg1KkKBpk6K0jO1ddxuAreWSWKYVZP
hsMMePHdeOVmEoAus8Kmp3VIVlF9fMsLnHnMLDF+8CCvSGi4f7xkB5WH8cVl1Bfj
8d4sG4mVZckaJjOaJB0satdnEKJ1KtrUE4RyyHm9+v3Dn2+mSP0VWQvYeneULfWZ
ycE/29J7p2QJhymlH4Z90W5q67S8JGFOLirI5I7MZvRr+sps15tBMq30tMZ4JhLV
Pn5woWxsp6YdrzmdK2iDMi+XWlm+uT733AL3jH6dnO1KKqZXJK3lwh3strGnG/V1
NjxOhOISfXuMf0eBF9OQxnKgofNgViicXsPn156Wjn8rcrgEj7JAEDR+HDluOGcl
e7ZqUzvFvT8BVu2ZK04O1DhrG1dhITln7PCx9WcMR56tgO9jzUstjoGGWKeXLtkL
jjd+l0jotMpw8p8QQTxh5ay7yp0W3Zu82mgtM3brn5NwCHSQUQ4=
=c3xm
-----END PGP SIGNATURE-----

--4QNYjcTi513a/zhS--
