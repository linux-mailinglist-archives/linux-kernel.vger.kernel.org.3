Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B224F4E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455231AbiDFAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446545AbiDEPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6A220E6;
        Tue,  5 Apr 2022 07:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A6860B0E;
        Tue,  5 Apr 2022 14:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25BEC385A6;
        Tue,  5 Apr 2022 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649168267;
        bh=MGKEOKuzG/zvLfWYpwbNWne2VYHu0gGNwDsvDh8cPyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPqroh2EK0MDuPgb5WnacCf6ssZHd95lDMSvChNGm9ZJ2nxe9+1xVISwVR1W77n7L
         cdrLs31WHH+F0ZSAp8+eDIIhyK1D+5oOwGGfYe5TuF4MbSv5lJZF2/1ezRv3TWRAal
         Qi4GZhfZai8uFU71eo9PKZPO7K5gkNmv931k48ZSHn5zD6Wci2PXCZNL4EUGuiSVHw
         Y+JugbJ6g7lkPZAVu+8LZDe50CFE/R/Cfk5jUFN0GT27J5J1pHGsm1ILDxjWhUk956
         52g791GTXf7nJry3EMVA/2dO28tDf2u6kjCfWNsjhPvsg0XsRDquQFbXWpy3k46Iw6
         NRVwdMSGty9/A==
Date:   Tue, 5 Apr 2022 15:17:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <YkxPhcgBU3/5zu/P@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8dPCbrnld0sz6d93"
Content-Disposition: inline
In-Reply-To: <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
X-Cookie: diplomacy, n:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8dPCbrnld0sz6d93
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 07:20:31PM +0530, Satya Priya wrote:

> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>

Why does the driver need machine.h?  That's usually a bug, though I
didn't spot anywhere where it's used so it's probably just an extra
header.

> +	.set_voltage_sel	= pm8008_regulator_set_voltage,
> +	.get_voltage		= pm8008_regulator_get_voltage,

You shouldn't mix and match the selector and non-selector operations,
since the device just takes a voltage you may as well just use the
non-selector version for both.

Otherwise this all looks good, just those two minor points.

--8dPCbrnld0sz6d93
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJMT4QACgkQJNaLcl1U
h9Bdqwf/cnfMmHDYBGxtxH531FkOi4AeNT824yzuUtVFoHINPdPqnSCCwvXipYpl
L30uSZNKRSR2QOZ/M9jBxvKc5z+IsAYrkke05aYIWQM/oM/EdOFLvxNR/tVufCML
wdZteUHPdYrx2NbuwHFEUvdFM/RoC3DKMvkn8FJgeSHi2831V6ubErKw7fp71AkV
12zOtGw0i0fTApbzzhdOAXQPgWuPlnxuFCcr5dnWy0TcY0v8Gf1991tsyv9hSfVj
mcHHSqNc3UjqDCNMdWRfOoJXjImyTfQ0oKi5abrw4F+A5FY3JpnOU07qJHm5QgKM
8naBiSlmOAkzS3JIMaAPDvk9tcTYbQ==
=hFPV
-----END PGP SIGNATURE-----

--8dPCbrnld0sz6d93--
