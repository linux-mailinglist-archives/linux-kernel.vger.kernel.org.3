Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673595A60DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiH3Kfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH3Kfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D657A00C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40CA5B81618
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7FDC433C1;
        Tue, 30 Aug 2022 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661855750;
        bh=h/p8CkP/aG4Pv++LhDc39jGaCuRXKYaNdFRD1e3IZJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTnXbVttAd9rtjC8u2D0G4KV6uEFDQQhlof1H/QvCSVGcFnfniKh8Eb1dxUdn8WLC
         cRGABJI0L5+CmvfpoKT691/symjxyFl8ICh3NiahqlnB0nCTncH1ol2U6BLBJMWSrF
         L6qSyFjwupR6GfCupmC2/DgSvmQqB3Zc2qezXLh0nC2rbM/q1dZUMEQVbC86wtGgZG
         /Iro9lq+KhxGscfp1pO+KQY/Utr9eeK2eey1rysqkllUe7AdHwjdHLYxCCi3ZPHYsW
         KQOsJN8gYNej2Xsrs/MPSGvypk8QOU6MX41iVAmp6eiuG88jptN3aKDNCPWmUeUmNA
         oh1uDnPvGQZwQ==
Date:   Tue, 30 Aug 2022 11:35:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: allow compile testing without MFD drivers
Message-ID: <Yw3oA6pVp3PMxfA3@sirena.org.uk>
References: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
 <YwkSi1IIRsW2Hc/u@sirena.org.uk>
 <a5266af6-af19-48f9-8bc6-94c171ba6d0c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mBZ+6BGhESv0Y/ua"
Content-Disposition: inline
In-Reply-To: <a5266af6-af19-48f9-8bc6-94c171ba6d0c@linaro.org>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mBZ+6BGhESv0Y/ua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 27, 2022 at 12:02:39PM +0300, Krzysztof Kozlowski wrote:

> True, it's not the same build coverage need as subsystem/interface
> dependencies, but still:
> 1. Drivers can be built independently, so why not?
> 2. There is no drawback in allowing to building them independently
> (compile test).
> 3. The parent MFD device could also depend on something (RK817 and
> MFD_LOCHNAGAR depends on I2C and OF; CPCAP on SPI), so it's not always
> the case of just enabling parent. IOW, you can compile test codecs
> without I2C and SPI which is valuable itself.

> I find the last reason actually quite valid and applicable here. If you
> wish I can add it to the commit msg.

You've already found one case where there's a dependency being
pulled in by the parent, I suspect there's more.  There's a
tradeoff between getting coverage and having to deal with the
noise from randconfigs.

--mBZ+6BGhESv0Y/ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMN6AMACgkQJNaLcl1U
h9Cu8Qf/ZIDsPUO4BiHjYSp+ClqV+hhegdcVQ+lZLxJPXQI+cdlRk/+WefY14xrp
x+giaFBvwkBStjyhOkUatiMFejftkHGHNDrFyzm1j+ZNIxMGfDOpxNWGPO5HN0sB
JphtJtLaDsAN/iZ+9YLJDMdMT4WdjQOKgZIOs0NTki05iZgPK0UaFdP39P53Oqba
ZhQ3s2Iamv+DrcqU3OwfNGHKXRsWItnKiwR/xoCyLzm1TKkjaLTFj5yQhDLymhJp
1wlkCNpHxwbkrT5GCz/ovqhmY8uqd1ZZF1lhqWOLJjhpqwd6GY4DTeJ4pS28drNh
BlSE1qT6x6zWT+BIOyqco3CCoTNPXg==
=t+iH
-----END PGP SIGNATURE-----

--mBZ+6BGhESv0Y/ua--
