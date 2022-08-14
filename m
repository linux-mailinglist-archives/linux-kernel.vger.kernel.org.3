Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDE45926E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 01:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiHNXF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 19:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 19:05:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B74DF1;
        Sun, 14 Aug 2022 16:05:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M5Y0S72x7z4x1G;
        Mon, 15 Aug 2022 09:05:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660518313;
        bh=1Sa4mWFQEDxd8hQqHgDOoUF/H5e9qr+gyg8EiZjPs3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IKUUJuTROZJO1A+c3K10m1R/X9iiLlWyaTAQb1fdb4hcLkCpmZKy0PpuoI+xda8SE
         toi3WKMIEyc+JcY0VkJZkc2zDzFL2gDtI1H2FU98lvf+iU8LXXn12CzQgTt2NonquR
         CQJhnw3GDXUagiDP9H3CPqTDZSXUHCryOTNjv+/SmsiYphiKHd1u0H681GdKzkACyz
         ZenEVOfHJB4Pf3DsU1h7xz5MWWBs9Q+7tGC+TMB+xHJQFRkGSQiwxiHpeBtFvY9Kn4
         /ER4ZwwFbatwuE0SWPNiAi7A6lQc+MfhdUPqT3flJTNbs7Gi+sS77GTyZz6W3CIBdt
         asm1T1+aTj7Dg==
Date:   Mon, 15 Aug 2022 09:04:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the loongarch tree with the
 irqchip-fixes tree
Message-ID: <20220815090435.09409f18@canb.auug.org.au>
In-Reply-To: <20220811091701.1dfd4e6c@canb.auug.org.au>
References: <20220811091701.1dfd4e6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y_T9Hb8KRsEVelOotiaRk5f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y_T9Hb8KRsEVelOotiaRk5f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Aug 2022 09:17:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the loongarch tree got a conflict in:
>=20
>   arch/loongarch/include/asm/irq.h
>=20
> between commit:
>=20
>   fda7409a8fcf ("irqchip/loongson-pch-pic: Move find_pch_pic() into CONFI=
G_ACPI")
>=20
> from the irqchip-fixes tree and commit:
>=20
>   4e9fa7e1c08d ("LoongArch: Parse MADT to get multi-processor information=
")
>=20
> from the loongarch tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/loongarch/include/asm/irq.h
> index 093aee99167d,4b130199ceae..000000000000
> --- a/arch/loongarch/include/asm/irq.h
> +++ b/arch/loongarch/include/asm/irq.h
> @@@ -81,8 -81,7 +81,6 @@@ extern struct acpi_vector_group msi_gro
>   #define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
>   #define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
>  =20
> - extern int eiointc_get_node(int id);
> -=20
>  -extern int find_pch_pic(u32 gsi);
>   struct acpi_madt_lio_pic;
>   struct acpi_madt_eio_pic;
>   struct acpi_madt_ht_pic;

This is now a conflict between the irqchip-fixes tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/y_T9Hb8KRsEVelOotiaRk5f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL5f4MACgkQAVBC80lX
0GzOugf7Btc3WzcKkagnfXNU3QUa7I2juUezKt1Id/k4OXVLRkhekgGF2jnkOm58
Z6O7ttjVwjSMN7MJdzLCMGcqDDhr5ScTJ+B6SpLEJNImmcNgBTpQyb/bF5Pk+9e0
CgqOKgF6sCF5zqZCOhqDmKMp4PbwF1nHmxzgEvshD5O2SUKTtmAY/Sl87Re4hGoq
FX/7I+/7FLJyQ73iVB9TPQRucHEL/2SNLSvLNszQ7Qr6m7ygl7ybQYi7sPCH+/rZ
Exv4xN/WzRd+W5l7QFhLcZPTASv+uNMlhtdw5PNi0hbLMszI6z5zHcw41fjYDQ3O
3QEApEOnv+x3ABE5O4pgpVSMCqNSbg==
=jFSJ
-----END PGP SIGNATURE-----

--Sig_/y_T9Hb8KRsEVelOotiaRk5f--
