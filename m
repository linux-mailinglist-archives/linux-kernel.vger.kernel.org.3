Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4CF53B4E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiFBIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiFBIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:22:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB8565AE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B42C1B81EE5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CDCC385A5;
        Thu,  2 Jun 2022 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654158175;
        bh=ZpIOdxZnOly6RZsL7QR5L4vfkBeqynInUaysfvgG8WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zb12ayniOU+izs1rKvzmzUueVt6ofuHMPWNB5EzzPTF477EQLHuA5hEgLRqzPuWPI
         jl5CTdq97StJpyjNTiC+Ggudx1AB0MSTqtkMthN8YOw+WEmTCjGiF97X//U7p58kBA
         rY4ZJlkZYBMea06lmVsnVAmjFunhtcOMhvIsX5p8U8Gev3Gwnt17ub6inHzff+iaGS
         LLiafqXaRWJc3/L5QOFXA/hrLhH8JbwKZPuC88Y5BazwfIoyAT2cnRtbGvkIYz03Oe
         Wt8QDi+aadim2fKQN6JYuBZAYvs4SfMWx69YmB97/TDgdwtStbnpO/v7MsM3hRHG/m
         oJbi6RZRr7Lnw==
Date:   Thu, 2 Jun 2022 10:22:52 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/arm64/kernel/fpsimd.c:1944:55: sparse: sparse: dereference
 of noderef expression
Message-ID: <YphzXEcBKARluNVM@sirena.org.uk>
References: <202205280635.XKlMkfKD-lkp@intel.com>
 <YpZJBoxqvaCLRQfX@arm.com>
 <YpcaTwI4SvV3IrwF@sirena.org.uk>
 <YpeZ0M5we/0yzxVC@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PeXLahpez0u4U49V"
Content-Disposition: inline
In-Reply-To: <YpeZ0M5we/0yzxVC@arm.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PeXLahpez0u4U49V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2022 at 05:54:40PM +0100, Catalin Marinas wrote:
> On Wed, Jun 01, 2022 at 09:50:39AM +0200, Mark Brown wrote:
> > On Tue, May 31, 2022 at 05:57:42PM +0100, Catalin Marinas wrote:

> > Yes, that looks right - feel free to add my Reviewed-by or I'll
> > do that when I see the patch sent properly.

> I'm no longer convinced that's the right fix. In __efi_fpsimd_begin(),
> ffr is true if either !system_supports_fa64() or SVCR.SM is set. The FFR
> state would be saved in this case.

That's the wrong way round - we should only save FFR if we have
FA64 or SVCR.SM is *not* set.  Checking again efi_fpsimd_begin()
is wrong.

> In __efi_fpsimd_end(), shouldn't we just restore the FFR state if
> efi_sm_state, irrespective of system_supports_fa64() (as it was checked
> in the beginning). Something like:

No, we should restore it only if we saved it.  The below should
resolve things but it's completely untested:

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 819979398127..3c66a061ff6f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1916,10 +1916,11 @@ void __efi_fpsimd_begin(void)
 			if (system_supports_sme()) {
 				svcr =3D read_sysreg_s(SYS_SVCR);
=20
-				if (!system_supports_fa64())
-					ffr =3D svcr & SVCR_SM_MASK;
+				__this_cpu_write(efi_sm_state,
+						 svcr & SVCR_SM_MASK);
=20
-				__this_cpu_write(efi_sm_state, ffr);
+				if (!system_supports_fa64())
+					ffr =3D !(svcr & SVCR_SM_MASK);
 			}
=20
 			sve_save_state(sve_state + sve_ffr_offset(sve_max_vl()),
@@ -1965,7 +1966,7 @@ void __efi_fpsimd_end(void)
 							   0,
 							   SVCR_SM_MASK);
 					if (!system_supports_fa64())
-						ffr =3D efi_sm_state;
+						ffr =3D false;
 				}
 			}
=20

--PeXLahpez0u4U49V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKYc1wACgkQJNaLcl1U
h9C2UQf+J0ClE8Vhx0jAbXXsz7P/saaEv/Mcp7gLzO4V4ATcXH8gQox+kztlh7tJ
pGRdvskRugJ6Tg54xr9tdGKSlwFJW8nH0KLEAIev9Qgj0z1u77otapePtwRdunZZ
uvFFOjqmHMJMyZnRXbbAqe6+wma3on89TmE7PCTfjBIQqytronG2YOBUI2n4l3Rk
JJJBqWdoYbU/idvoujgon+AnFxRZDkHmzf+U5FGWW6aSu9WOddSxPCDVttyVOrj9
hYsmXu60aPEh2gzjg+WJH35nzUyAGPX4VDT3IrHBYAMcpmP4XUJj/2yQP4TpMHOd
rY9ZwRBwgbiUAD+MaQoLa6L0OfcQ5g==
=Phwp
-----END PGP SIGNATURE-----

--PeXLahpez0u4U49V--
