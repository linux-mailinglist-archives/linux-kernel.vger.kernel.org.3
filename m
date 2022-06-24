Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D56559E50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFXQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiFXQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:08:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CCD39142;
        Fri, 24 Jun 2022 09:08:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g18so3714462wrb.10;
        Fri, 24 Jun 2022 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5QCcsp/oxE/4aK5lzsCff9T90roPIhhHgQz79caNMm0=;
        b=nywWrqoT7S5Iyyh6SqrQzlKQY3X52hZhoqeseTw4TA8PjHqSWGls0lr1Z1GG45wc7T
         ilRYO5/HwDZbE3W/0rSQIrNNlj+oN1rP8X4SqejxGw27dcv/kU6HKNpa0sbhyDb7/8kg
         SltLregODjAMirVz2CHXo5xeU+fk8TxpNFGj9NeBNA9NoOXPZNla98xGKAsb1A+9VQn3
         Rcrrjtl1mKTGLGzE8udQvPqy2tO5FEq6SPVaWmSzqGHfR9kwdd5il1OoaNUf4sI0i4DY
         D7pzczpeRNXkRhtf5bQp/ZWyQhIOUoePOl9kHicutao1JEibogxhZjlK3drqv7GMbpi/
         jM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5QCcsp/oxE/4aK5lzsCff9T90roPIhhHgQz79caNMm0=;
        b=IyR5DCKY3GhMugIBSir19auy5hkOxDHlr1bNbpqSPh6peh58RORFOE6TEnuaw/asK/
         k2672go6P27dBwEJIBoBVTb4Uvdot6//RdUE+CxB8/tIcgmGr+txE4n1bF1J2Yoa7/15
         8RaIYVao9Du/8WIBrBkQjYHs51kJhtGRT+Yg0Vo4mSZAGExh0BS6ftB4peRc0lpy6Msl
         xH6dV8ANxWLv5WF+Uqu8XpFJq+N/qW5ow+GZto+x5i+pjgjlBIxP/rVYOKgdXVXxaWsy
         woOBcPQl/uZE5XGnq89R7Fwcr+F4hIgCf3LGJIQ2aJpEmBGfrvIl5LWfudLxAULDbDIL
         X2Kw==
X-Gm-Message-State: AJIora/8R/nHCZPe896blXAVg3E++DdfA2skhk6D+0REJREVknCTuB/7
        msSBaOFN+gtofEcQRvAs2Kk=
X-Google-Smtp-Source: AGRyM1v8XWD6eMjxLPwbRD8oLlGN4gejnKJChEge19xr58Opj+b/4OXgyBk18OXlqG5Rd2aDHkMkjQ==
X-Received: by 2002:adf:eb88:0:b0:219:b9dd:af57 with SMTP id t8-20020adfeb88000000b00219b9ddaf57mr14093882wrn.7.1656086897824;
        Fri, 24 Jun 2022 09:08:17 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b003a03be22f9fsm2460104wms.18.2022.06.24.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:08:17 -0700 (PDT)
Date:   Fri, 24 Jun 2022 18:08:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/40] arm64: dts: tegra: align gpio-key node names
 with dtschema
Message-ID: <YrXhb5izGPNXEmMK@orome>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-19-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IyLVWPIxofCPGlpx"
Content-Disposition: inline
In-Reply-To: <20220616005333.18491-19-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IyLVWPIxofCPGlpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 05:53:12PM -0700, Krzysztof Kozlowski wrote:
[...]
> diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/=
boot/dts/nvidia/tegra132-norrin.dts
> index f16acb4cabaa..62d58221ad3c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> @@ -1030,7 +1030,7 @@ clk32k_in: clock-32k {
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> =20
> -		lid {
> +		switch-lid {
>  			label =3D "Lid";
>  			gpios =3D <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_LOW>;
>  			linux,input-type =3D <5>;
> @@ -1039,7 +1039,7 @@ lid {
>  			wakeup-source;
>  		};
> =20
> -		power {
> +		switch-power {

This one is actually a key.

[...]
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/b=
oot/dts/nvidia/tegra210-smaug.dts
> index a263d51882ee..8494c7b2961b 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
[...]
> @@ -1772,7 +1772,7 @@ lid {
>  			wakeup-source;
>  		};
> =20
> -		tablet_mode {
> +		key-tablet-mode {
>  			label =3D "Tablet Mode";
>  			gpios =3D <&gpio TEGRA_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
>  			linux,input-type =3D <EV_SW>;

And this one more like a switch since it's triggered by a magnet, as far
as I understand.

No need to resend, I can fix these up when I apply. Just let me know if
you have any objections to me making those changes.

Thierry

--IyLVWPIxofCPGlpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmK14W8ACgkQ3SOs138+
s6GuoRAAs/Bh3zBxhYqqU+0xHTMaroNOhMkFFFzlQ+JOw+7Wg4AybDOEUQZCU5gP
YFxNy1JsHoPso+15Y32LoJ3NVwQ82HW3+KBPyPUFHmsuoj8BbNhTJEsc2yht8JV+
sUbVDThkZu7Tth7i+jrX20VfUPuUK4WveSvRrC3/WY6tzkwWbsEk/lSbP+m5Dir1
e59WpNyCa41llMSQZzGyOwY2cZ6Y9e64wrqORHrOQxyboVmmeYvtoQADR3a/geF4
boqK/shRCZDo/ysmfdMfZLjc1XOs5pMYAaOV+xw9VWAhAL8Z7CuOI6sPjHgzBx6q
SrbW0PVm7fMhWu5YDDUXoKNC2zVmdpWR18AE7zXOUc4aVlVfpWZR02/o9z1/CkYM
3wpV7DjQWjFWnlUB0Tm0m9mvBLRoH8mjNYcwtPH8g0C4xtPOWrzgl6bFne+cUqBG
QLNqbqPv+EEvcFOUT2QTO5xEbQaUO9YaF4kNj3dqO0ERT6FFU2z8j/lqmrP5JIuS
+da5kfHfnMQPYVy/OiWmzCjk+GqQ4apF0DllkRFMFkCqjhiV3QsOF4oX/mUuU4UJ
gg6DMIE2rF9RikECb/TSspTQHhtFv+0bsb1yYxj7qks8cZAezxSreVnUwWJimEpW
aspfZ6S6xv3QuBOBP8UyFcWhhgwrBbGgMkQvtNt3KrSnr2C7TUA=
=ykpI
-----END PGP SIGNATURE-----

--IyLVWPIxofCPGlpx--
