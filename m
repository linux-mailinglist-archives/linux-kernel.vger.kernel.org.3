Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24824F3BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382072AbiDEMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiDEIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:16:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B970CD3;
        Tue,  5 Apr 2022 01:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3C7B81B90;
        Tue,  5 Apr 2022 08:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE3C385A9;
        Tue,  5 Apr 2022 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649145849;
        bh=qsQljiMucqRqUd4z9Wprhd8esh75p1YRIbEPGlFNo3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tH4wksIOmH925t36apUo4rEAwz/Kw5BXVljl8CZcdvTQHmZK4pXSqxJn7aWRy3ago
         hgb6L0aVPRUdzTeVnwPDSqXF8v4Ubbrgal+OGCCSJxuagKU2zxkmJFYmlJsGl3o3ZE
         UNptV5Gw5TUTftVFX/KUs+BSuNKTtjtqtU2qAdKkJmgyO6ahfnMam4xHfBdL7NpMeC
         LExnO4naFkC6fFTHBM0Dy4BzfLHTcOsbseIVpL9Txm/xlJuCwn8k5I12MAR2Dmx6ta
         Ror/O5sMJS+FqWH03vZnwylCiXanCpmD8zS0XSZgb11WfLJ2ZRiT9An6qPiV6+M7IP
         XcPuBvxBNZhPg==
Date:   Tue, 5 Apr 2022 09:04:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: document the boot requirements for MTE
Message-ID: <Ykv39KMpKXb2Mr6p@sirena.org.uk>
References: <20220404211858.968452-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U4yPShB2sk24Ez1L"
Content-Disposition: inline
In-Reply-To: <20220404211858.968452-1-pcc@google.com>
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


--U4yPShB2sk24Ez1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 04, 2022 at 02:18:58PM -0700, Peter Collingbourne wrote:

> +  For CPUs with the Memory Tagging Extension feature:
> +
> +  - If EL3 is present:
> +
> +    - SCR_EL3.ATA (bit 26) must be initialised to 0b1.
> +
> +  - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - HCR_EL2.ATA (bit 56) must be initialised to 0b1.

Very nitpicky but this is only required for FEAT_MTE2 and above, plain
FEAT_MTE doesn't have these traps.  I don't know that this is a thing
that anyone's actually implemented and from v8.7 on it's not permitted
but the above isn't strictly true if someone did for some reason have
the most basic version.

Otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--U4yPShB2sk24Ez1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJL9/AACgkQJNaLcl1U
h9Advgf+IuZZugXrsq2QTXupthCBNsC0BjU8HXkBBUqx6xRi96h59EIv/TR0K9Tv
o/Ku1OZjykNhby0S0ts/PhxEWP79+z4mpA+kN13hYiTUp9HytXg4hppOtikWnNE5
qVieJHkjEL5QLmqaxEOd3zf9MPotutz9n+AXI4UC+Av6p3cYamCKwpalZKcenm66
1k6/2iJooTZa+U2jEcZE18tokuwbTMC3lkqjyKoNAEXmSq3DkOHbaxblDFm9eXgf
UeYeYH8GPAU5EO7WASyDs5zYVMouxfO9yFpafW0JoK7HuI/AqlFycD98lwbHvufv
6rlXx8H0HRoghHMSO92joqBVQymltA==
=78rB
-----END PGP SIGNATURE-----

--U4yPShB2sk24Ez1L--
