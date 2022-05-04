Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0B51A014
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350103AbiEDM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349930AbiEDM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCA3B558;
        Wed,  4 May 2022 05:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0B38B8239E;
        Wed,  4 May 2022 12:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B761DC385A8;
        Wed,  4 May 2022 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651668958;
        bh=kTceZKaSae8dEs+i0l1pReBP7AnGtYSXSHGjRB5sBmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiRoDcjCnjPMOR+OupvzqaEVdo+3p1ITb84GN+/B5EkRtVzdE40dsqPiMrDEXdz7P
         nkJgkk7rZ5dKw2PH1lN6vuU2ctPLb4371XlSLJcurETAY6957q9WThOe/qtKDXKtq1
         ANQSWjwp5+rf07iyjEC+TA0P8hpvjyuFtNvZEJS6X6Phivw9Cj+fxU1IynE02dAeVS
         jTK14uGFUP2xlM5bGK7XI2oYaSx8/1L3AGVy3N6YzwKp0ImPO/KsF77UVt7m/dnwUE
         +ho1ZXbFL7L8LSK2N1csXgBRX2uZfMoMbD+TAYZXXftTK9jH8nQ/bTG/OR7naGFDNZ
         9t241WyWfuNxA==
Date:   Wed, 4 May 2022 13:55:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/6] dt-bindings: regulator: Add reg-external-output
 binding
Message-ID: <YnJ32bG4IkSrRtHV@sirena.org.uk>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
 <20220504065252.6955-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OeS2mizHPjpFFiLa"
Content-Disposition: inline
In-Reply-To: <20220504065252.6955-2-zev@bewilderbeest.net>
X-Cookie: Mother is the invention of necessity.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OeS2mizHPjpFFiLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2022 at 11:52:48PM -0700, Zev Weiss wrote:
> This describes an external output supplied by a regulator, such as a
> power outlet on a power distribution unit (PDU).

OK, so this is that represnetation of the connection - which raises the
question about why the regulator needs a property?

> +description: |
> +  This describes an external output supplied by a regulator, such as
> +  a power outlet on a power distribution unit (PDU).
> +
> +properties:
> +  compatible:
> +    const: reg-external-output
> +
> +  vout-supply:
> +    description:
> +      Phandle of the regulator supplying the output, which should have
> +      the regulator-external-output property.
> +
> +required:

I think at a minimum anything like this would need some sort of
representation of how the output physically appears so that people can
work out how outputs are mapped to the hardware they see.  However we
already have a subsystem for external connectors - extcon.  Perhaps this
should be a regulator client in the extcon API?  It's common for
connectors to include some sort of power provision so it seems like this
would fit right in.

--OeS2mizHPjpFFiLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJyd9gACgkQJNaLcl1U
h9AKZwf+Kv5LJYapRQXolMBLWWzK2Nn85PgabLCHlDg312x1LS4BqxJGYDX9mRTF
UAYoRIgM8itBAMqd/p2ia6jbpfynvjQ4R+hMx1rIKcPl3qIPV8X7MsLnutU9fjvg
StTLlWzLW/at2L1yGq3ca3PAqJZh/jZOaxU1EPdZNiuXUT0xet0lfvhxt4dGWiHP
ZoGd+muGLfNDflUHBs5jR87rD0WmL4c5/daPJoK47ZFXk2S2wJ0fBa/5l1kPLDkq
QfRmtNC5zFFAj3f5tZfJFt54ozljaCEPuaj7Jt4LVU8/DJDnkioYB5QiYe767X4P
uSBZMYJvEyIzr0gXgk9WJrVRthK1zA==
=VA9P
-----END PGP SIGNATURE-----

--OeS2mizHPjpFFiLa--
