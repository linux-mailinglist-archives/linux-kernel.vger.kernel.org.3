Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF445825F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiG0L5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiG0L5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F727CC7;
        Wed, 27 Jul 2022 04:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5974F6186D;
        Wed, 27 Jul 2022 11:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F3CC433D6;
        Wed, 27 Jul 2022 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658923062;
        bh=OEoVs/MhSXgR4IWqrhVfbtNjizq9Kvd/Pib0wQFyWH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRDXzn1tXMPuTUSTgVRhPAFjh3z1U1OcjCyjiTNw0vat+ApVqVFWoV7rbsOGIGbnY
         6NyQR6rH1xQmGrxMJE+nrudPqOqH3jp08fYn5S5OHPMDHcJTBqZhzPt38m3GkjAnXP
         a9xslA49t4Sp5G1gpZNwIQDyB8xsJuEK/dLRU5hr1vJXNv/CnK3VsFq+pClIu2jawv
         yiU+4UvE5+dqHPlfg3/ifSaNmcv8PBNWnDoc/uKFGCB0UovyacXlsGFcsWbqyEH69a
         CN9eQjKDMGSYLJJVVyv5RtH7busZBmkWbsY+qUjtv9LdjhkqbWAn+iG09N+z8FyyWj
         JP3bCVOdKcRNw==
Date:   Wed, 27 Jul 2022 12:57:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/5] regulator: qcom_spmi: Add support for new
 regulator types
Message-ID: <YuEoLteLBgd+b8sg@sirena.org.uk>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-4-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c8wmvTBeVsGJsd6K"
Content-Disposition: inline
In-Reply-To: <20220726181133.3262695-4-iskren.chernev@gmail.com>
X-Cookie: No motorized vehicles allowed.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c8wmvTBeVsGJsd6K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2022 at 09:11:31PM +0300, Iskren Chernev wrote:

> Add support for some regulator types that are missing in this driver, all
> belonging to the FTSMPS426 register layout.  This is done in preparation
> for adding support for the PM6125 PMIC.

> +	.set_mode		= spmi_regulator_ftsmps3_set_mode,
> +	.get_mode		= spmi_regulator_ftsmps426_get_mode,

Why are set and get asymmetric?

> @@ -1473,7 +1557,7 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
>  	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
>  	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
>  	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
> -	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
> +	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),

The changelog said we were adding support for new types but this looks
like changing an existing type.

--c8wmvTBeVsGJsd6K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLhKC0ACgkQJNaLcl1U
h9Byawf/SgzRmAePGy24aoL5THi5Xf0CjThrfjmk/FuY4MGwem/ClESAYTdf0o2m
9Php3xEMaCevtBlamg0SBQ0wcS+n5xVJRdTrsa1w2WmOVX5yWTXcAHrhbZF4zw9n
T24wbt0fVKQf++QgZV+CvyKGcF6WwT8QUV+XZVUnLNAYXCzi48K1TBK6kLovF6Wm
qiJyXOC2uSzSRcsw/pFYjDTV5RDMtdw83G2pVPW3KKWxgvfk/7fOk+uHm2i8WJQd
MB9VqRs1glNuTVqWvjQd/4KSoNZqr/O+J4bJ5i51Naof9XyCv4XtEc2AK6QBzZkJ
H9KnHQgCubqerwbYSrENJftdUGYn8A==
=gE9t
-----END PGP SIGNATURE-----

--c8wmvTBeVsGJsd6K--
