Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABF50BE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiDVR17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiDVR1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:27:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5941D3736;
        Fri, 22 Apr 2022 10:24:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e2so5741079wrh.7;
        Fri, 22 Apr 2022 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xC6xYScRzKyY7Ku7pzr1NBkMX7NLxc7XsF8pApyXIHo=;
        b=Q/218R6ozACViKCGt+eAOz9Nu+opl7iFUgLKn4+wewBSXlOtlcoIN3LwFbOmga/pt1
         AluPoFH5YPAm9a/mkHBL/dtTYz4Yc5372KomAUsiTaKf9o8dtoE6/nEPKBrhl31QomuP
         OHYO9Wq2i+DotLTvdgXsPLC+mcI7Zesjd9SGTqzJbK2570Td7a7r+QQf5efolrdM5/4D
         tuS0dapolc2LPxUAEgCWKhB/ePXF6R0EW7tw3Mwkl2GH+CZsldOQLU3fGDKyl7tn9tWk
         fVDevpCAg7G0N8glWr3gVD00PComT+I5oVdSR7YiPPdwsF2uWwm9vGMrTlAyaWN5TT0k
         3NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xC6xYScRzKyY7Ku7pzr1NBkMX7NLxc7XsF8pApyXIHo=;
        b=mbmuhB43VzrR1j2QIzeh5iqG1wMr9QrEw6c2ydxVQXjeSmQxWwOgihPQXfjk24qXVw
         6NKX1NbFMtzXr5wyATsfcAqzgz0im5qcz8yRCgnpupywY6/jYr/dnEzx7U8IO9D83rpY
         bSOQ0ozxNnZX1J3jUGH0yurvP8olAjA1mCJRO3jOm6s4KkVcCa7egv6EgfqHtzfJuJey
         anTHjZzIkpTTU62KQgsBWfa7Sl82L506UKgotJJ/6u+vcwzPEPe/FJKdf5tqTZrRvzJj
         zlzWi3v0MBeNuGOQy6hw7fciZyaugbQhJMLKsnZ7OYTfoNjrWfnGmuy44KGb9PalAwsl
         RpfQ==
X-Gm-Message-State: AOAM5301GrEUybiOU80k3VFc1Q7QvsHxpone5fyD0UoclBYFksDfOEPq
        xpDuXyFB7drnZhWTaQl7rjg=
X-Google-Smtp-Source: ABdhPJxk/X2jJZ6pOgPFkXfKeLM7Dg+F1l4m6NjKP1MkbsgCOJcSawdzNQyN8OCtg0xRhwFrMYSAuQ==
X-Received: by 2002:adf:bd91:0:b0:209:19ac:7159 with SMTP id l17-20020adfbd91000000b0020919ac7159mr4440144wrh.3.1650648209602;
        Fri, 22 Apr 2022 10:23:29 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m1-20020a1ca301000000b003929c4bf250sm5048975wme.13.2022.04.22.10.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:23:28 -0700 (PDT)
Date:   Fri, 22 Apr 2022 19:23:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, hammer.hsieh@sunplus.com
Subject: Re: [PATCH v4 0/2] Add PWM driver for Suplus SP7021 SoC
Message-ID: <YmLkjriZCm+juYEP@orome>
References: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PDxV6ewWHonbNhBw"
Content-Disposition: inline
In-Reply-To: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PDxV6ewWHonbNhBw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 22, 2022 at 06:42:59PM +0800, Hammer Hsieh wrote:
> This is a patch series for PWM driver for Suplus SP7021 SoC.
>=20
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
> etc.) into a single chip. It is designed for industrial control.

I just noticed as I was trying to do test builds that ARCH_SUNPLUS
doesn't exist yet. Are there any plans to add those in the near future?

I can always use COMPILE_TEST to do test build, but I like to also do
proper builds because they sometimes flag things that COMPILE_TEST
misses (like this one).

Thierry

--PDxV6ewWHonbNhBw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi5I4ACgkQ3SOs138+
s6GIyBAAufn0SqDugjZ/SHA57bfeqkXYHC9QHBnh6YoNb4KViSPCGPaDTz0UeOEQ
kTs9D5IKBhCsU1eD9lsiFgp2xkKFZ0jA8f3KG3m11rVrd2fuQA9tNU9h0zJm4mYl
fU35TZYrVKWZwviSj2hgcyDHIS7uCsQczRIzzcAeSpisMICYJvjCM1jdEu6mKLwA
sJxXQQL10ck7zxskTiyA7qDKlyVsPyJUzm998+D+v2hDqWh4BgvUBQhjYckNTwy2
F76EVk/L5GmQNV5Ta9vI0xJo76BMUUrDISdsCG79FM0A0AXHs63nHGL9b4vaLScb
OTh8QwnxtDkWKbRpECU/u56zM3eRRG+CVdogjnIKGSvJeEIW9ewHr6Dk5U+aLeld
Y/NhVwV0mClXmMHmjlcTH96jslxbZJlg4V9flyP56Va7gv1+0FbdxYKiYrFB0A4z
dT6XSG0hLaGKOvWT2Fw3ZOtwHn40ViHeO0+tMFxSToPeAtdkmX4bRqLO/2Ief4kO
DRqdZz+sV8i0D4vAi69c9N5fKpzBPlXBoblFwFgWb/spI+dLXNV1CQ/xdxeHhZew
AGQQZeZPZgPH1HL0jEJI0tjJEJ7XCH7m4bSu5nfeUMzpBDl4Z7ZncAGF6dwG4ozf
c86uiEQ3MUvI46sItRsd79FBF3E9LJUYHWbLC5iExuZwNKEnVo8=
=/3J5
-----END PGP SIGNATURE-----

--PDxV6ewWHonbNhBw--
