Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90F052ECB7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349638AbiETMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiETMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:54:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6481C6A054;
        Fri, 20 May 2022 05:54:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L4RVx72tRz4xD9;
        Fri, 20 May 2022 22:54:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653051242;
        bh=xX70sbq84o7TSNzvXVmq0pVAVoppAgjs373K3Ng4Xtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Akb2B4+uVCG0ySD1cWoOIlz+8DrVRJeaODOwNJI08oYO7ouM8FwBasUJ77rIj97fq
         Y0xZmTDl8djQdiSPlYBDS++o4Knlow/SWs95UcW6zqunRoyR4IjzKwzIeCvTVQUtD5
         TsbKnIzxbMQYZI2yEwznTEpJdFI9tlC6CssvFNfjllLvtMvRTb1+oYwG6o3hQLYLxF
         6QJ6OaExOlg0+CjHPcowyihAXBgi8qCLf1G0bPwD4wvHUO6E/+erj8+HRMhF4yUeAg
         iuXgZqLFOBVH63aftfntBU6Kdun0SyMlG+noTpHOOTZM9Q2vGl3h45qukBuk7RtXnV
         gNZ1RCvcxOHlw==
Date:   Fri, 20 May 2022 22:54:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the ext4 tree
Message-ID: <20220520225400.089f9d4a@canb.auug.org.au>
In-Reply-To: <20220520110313.48a824c4@canb.auug.org.au>
References: <20220520110313.48a824c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Edo9hu13=AH5BRA7qYadgR/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Edo9hu13=AH5BRA7qYadgR/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 20 May 2022 11:03:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:

>=20
> After merging the ext4 tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>=20
> fs/ext4/super.c: In function 'ext4_check_test_dummy_encryption':
> fs/ext4/super.c:2677:36: warning: unused variable 'sbi' [-Wunused-variabl=
e]
>  2677 |         const struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>       |                                    ^~~
>=20
> Introduced by commit
>=20
>   0df27ddf69f3 ("ext4: only allow test_dummy_encryption when supported")

This becomes an error in an i386 defconfig build, so I have applied the
following hack for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 May 2022 22:48:55 +1000
Subject: [PATCH] hack fixup for "ext4: only allow test_dummy_encryption whe=
n supported"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/ext4/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5168d894c41e..f9a3ad683b4a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2674,7 +2674,6 @@ static int ext4_check_test_dummy_encryption(const str=
uct fs_context *fc,
 					    struct super_block *sb)
 {
 	const struct ext4_fs_context *ctx =3D fc->fs_private;
-	const struct ext4_sb_info *sbi =3D EXT4_SB(sb);
=20
 	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION) ||
 	    !(ctx->spec & EXT4_SPEC_DUMMY_ENCRYPTION))
@@ -2692,7 +2691,7 @@ static int ext4_check_test_dummy_encryption(const str=
uct fs_context *fc,
 	 * it to be specified during remount, but only if there is no change.
 	 */
 	if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE &&
-	    !DUMMY_ENCRYPTION_ENABLED(sbi)) {
+	    !DUMMY_ENCRYPTION_ENABLED(EXT4_SB(sb))) {
 		ext4_msg(NULL, KERN_WARNING,
 			 "Can't set test_dummy_encryption on remount");
 		return -EINVAL;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Edo9hu13=AH5BRA7qYadgR/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKHj2gACgkQAVBC80lX
0Gz8ZQgAmJnoasBrbyUJWu4kvv6hp5S4O6dWa3JgP1z43NzkdNK7MaCuVT01is1G
+s5bIo/ZcGZtb7V3PYI3SK69YLFdOKjpCeC81NEdRZ3NuZD1HESrRlv6lrt2rgce
WkQCr6wq2j2i196bvmrkHwJSpvWPvh0qw/F+1qTk3t0GhAAn9OVWdGwcdg+RCV1O
PkiFtI4QLhAomots8CybnlLnhncqXI9uAGfIFq+pG2CeiXmnF4S51tXjHau1nAmO
QGCU9y7sfZrUHL6DChfz3IrgHCq8BRfd8JRkmszd2yQp1VJ+OlVkKV3OexwQgt4+
q9cA5LTrZIu0O940UAygcx1WK4og7A==
=Exi2
-----END PGP SIGNATURE-----

--Sig_/Edo9hu13=AH5BRA7qYadgR/--
