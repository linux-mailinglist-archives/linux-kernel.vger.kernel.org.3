Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37524C4D07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiBYR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiBYR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:57:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0323932E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:57:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D49761DF7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C27C340E7;
        Fri, 25 Feb 2022 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645811829;
        bh=7EC7CurlJ2+rojCUecIh7IA54jOvEz9qPpBDG8aDah4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfcHG60ZayCxwPSFPHvMx6XD59kwPvyIkg2o57eRI+ZzBlzhsEqj5qcr/J8I01n4v
         CZnJ2oj/OrP3l5UHBHzLFRJErZyRXQG3hO5Cd/twgzPjI68b9fzcwDTAeehmud6PNl
         HNLkTZ+e91/Rs37PZgCL0Wdh2kbbdnh8FuD95wChE+a9YhRsHD8iadegW2Ng/TIjwP
         gtpTu7k+iXYET2heYMHWFRCpwIAhykB4ByIkFPK/dvsrwmHb7qjOapXVNAbB7yWs3E
         R+AFraU4wu2MA/Wu7koQBJAJv2nmkzxccQfIc5pUmMsEQogv7oPki1xPoPv7SioaCq
         iF4a2af9JqVLA==
Date:   Fri, 25 Feb 2022 17:57:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, elver@google.com, ebiederm@xmission.com,
        seanjc@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: signal: nofpsimd: Do not allocate fp/simd context
 when not available
Message-ID: <YhkYbhxA8+IQxVcb@sirena.org.uk>
References: <20220225104008.820289-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i/KIkU1c0QvDzdkK"
Content-Disposition: inline
In-Reply-To: <20220225104008.820289-1-david.engraf@sysgo.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i/KIkU1c0QvDzdkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 25, 2022 at 11:40:08AM +0100, David Engraf wrote:
> Commit 6d502b6ba1b2 ("arm64: signal: nofpsimd: Handle fp/simd context for
> signal frames") introduced saving the fp/simd context for signal handling
> only when support is available. But setup_sigframe_layout() always
> reserves memory for fp/simd context. The additional memory is not touched
> because preserve_fpsimd_context() is not called and thus the magic is
> invalid.
>=20
> This may lead to an error when parse_user_sigframe() checks the fp/simd
> area and does not find a valid magic number.

How did you spot this - do you have a system that can reproduce this?
It'd be good to have coverage if there's testing but there's no easily
obtainable userspace that I'm aware of.

--i/KIkU1c0QvDzdkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIZGG0ACgkQJNaLcl1U
h9C3ngf/QVQUvOqEqNwrKMCVGAAA4u6ED2XJUfxIepnQgMkG6105crKMXk+fX3fx
6OHCW611IHLqi1yCvP7oP5GHQJ4tJLIwfoWnLEMWnqglm6dJ8KFRzx4KtDJTlCAt
dqLBEgPIVElQzsiQvk+Jn4GAAmje3hUSDBHya8QHpSjwKNHVr7WUWut9wsWefCTJ
gJB/3OEzFRj22lxlxKeyacYS8eXric9+SzmrzEScwgIKh+Er1XxNVaeoqMilrS2G
ivD5BseIx/kuh5X3nO+u1ugwD2WRBBIW425GY/UxWY3wuKQQDPjpbhnk3N8XwIhC
SHOtOEflhbXPtFwbXSxfSAjeq83DBA==
=fMPl
-----END PGP SIGNATURE-----

--i/KIkU1c0QvDzdkK--
