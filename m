Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC645754F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiGNS1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbiGNS1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:27:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976926A9E4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EE63B82873
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6EBC34114;
        Thu, 14 Jul 2022 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657823254;
        bh=/FT9UKBc14rKByDW3P20U7+I62iSoTx8/22Gm2XZG8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWvc3rZLaZuzA1c5G6rFDx8Tcva7QpqCynUMvdvvELC8UN3xAMCXJL+FEFmZcJbth
         F/W4MgYB8FHuAcWCfgdjrEni4i2OHOo/CJEiyoMOYaCn8JA1DlZJ7RVIVKEu19WXrZ
         BNAupWpn+P8eqvhTrCevRuvLCQ9d1nG1thaqh2bTQt9cwCpkOEfDlsJRW9FR86lIZe
         qE1doLtHgBA2Jg0uzlhfluGPKrJzXUZ3hD49dK6RpsqkZTOI775lqs570Ki9l55lbM
         6s9zCBu1woHEzBQ53D+Kyt0f5UVmKDYTyCMF9XwSgEdXKd8lI8gpK0JnrZtoLbmFM+
         kRCZEcSfu8APw==
Date:   Thu, 14 Jul 2022 19:27:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question: regmap_field_write() - why using update?
Message-ID: <YtBgEreCVZyD0kwb@sirena.org.uk>
References: <e759045a-bc01-c194-35ad-42b534ccaa01@linaro.org>
 <YtAxK1lIooDmdVBP@sirena.org.uk>
 <14b0e150-511c-867a-281a-1d13e7e318e8@linaro.org>
 <277e0484-60bd-7405-4cd1-acf0a03ef195@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EStyfRuxHjle2/5z"
Content-Disposition: inline
In-Reply-To: <277e0484-60bd-7405-4cd1-acf0a03ef195@linaro.org>
X-Cookie: The devil finds work for idle glands.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EStyfRuxHjle2/5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 05:15:34PM +0200, Krzysztof Kozlowski wrote:
> On 14/07/2022 17:13, Krzysztof Kozlowski wrote:

> > Indeed, I forgot about bits in a field... So it has to be like this or I
> > need to use regmap_write(). I find the regmap field API very useful for
> > devices with different register layouts, but the actual "fields" part is
> > not really needed in my case.

> ... and few registers (like "clear" registers) actually do not allow to
> read.

The write only registers are a good point - we could handle them through
special casing, that'd avoid any overhead from reading or issues if a
physical read happens to return something unfortunate for some reason.
Now I think about it there's also the fun case of registers which don't
have symmetric read and write, though at some point regmap_field does
stop being useful and those might well be pushing it.

--EStyfRuxHjle2/5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQYBIACgkQJNaLcl1U
h9D3dAf/U2nW5o1TYKSt+WggFtbxNJ3QrUk9GAuP1buYCuMq5KTQb1luQQllcvni
gBk+IAYAshJMemH3V0VMwSRoUFToQ8dzrIgGWrXzee1Jj2DjmUdLaOY+lvxecOUt
Q7IEvx+UhNi/4P4gmkfA4wgAhN9gJPx98OkXUQQM2j+LtA/ex31Jfng7VDxxFS0o
zcgp6kyWYtZNJNPOPxsPjr4ygFRaZUs71tkqCOgCSJULWANZmoGSFq1dsSdls6iW
FYTxUL+y/Ec5exMbMlI0dhTstaKaP+ZdWuXBpTm0LizXZCVIWziPK3N6iyCgHfyU
PtInJT3WHFGp1K6A2+EKd81IHYfZTw==
=j5aG
-----END PGP SIGNATURE-----

--EStyfRuxHjle2/5z--
