Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CC52C901
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiESAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiESAzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:55:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92579F599;
        Wed, 18 May 2022 17:55:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3Wbt52bxz4xbC;
        Thu, 19 May 2022 10:55:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652921710;
        bh=V3JqrlsADLhfhJ+MRSPiBplQsRqXjbCZz+kuhT1z+5I=;
        h=Date:From:To:Cc:Subject:From;
        b=tGnDh6e8GZDsZhvcI03y6kbnHjxCHdYasXOHwJCVrJFfdJuYOR8uHIm3GGA3a2NMR
         gFGoiDj6/B1pzdH5cYr4Ae1+tYWKjzEyjx1u7nHWfY4GSIMUjDnX3YshppxKfiyg2Y
         6ftOM6RgKYXzl76CLu5je43k88T5JLZnvj4QeiX0Y52vs+GnkSo96hqHm+ryPKVFUe
         gg20FwAwp65Gg2xAGCXep9w+2CO2PQmUfLgKnF/cDrLhFCH/JEwHp2ZSFhi4Ald8pl
         uafNTHZ2xmPOhILS+PKUPB1XZNR0+BvO7emXSJc9x1L5xhuBUoRsSsEDXSbmx27hJM
         cmOqforM/NnBg==
Date:   Thu, 19 May 2022 10:54:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bob Moore <robert.moore@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the pm tree with the loongarch tree
Message-ID: <20220519105448.74a4447e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BQv5phBh_Tx=7u+niI6=_CH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BQv5phBh_Tx=7u+niI6=_CH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  include/acpi/actbl2.h

between commit:

  cb41f313b29e ("ACPICA: MADT: Add LoongArch APICs support")

from the loongarch tree and commit:

  da6a9bbedc79 ("ACPICA: iASL/MADT: Add OEM-defined subtable")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/acpi/actbl2.h
index 2419f9e397e2,655102bc6d14..000000000000
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@@ -762,14 -865,8 +865,15 @@@ enum acpi_madt_type=20
  	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR =3D 14,
  	ACPI_MADT_TYPE_GENERIC_TRANSLATOR =3D 15,
  	ACPI_MADT_TYPE_MULTIPROC_WAKEUP =3D 16,
 -	ACPI_MADT_TYPE_RESERVED =3D 17,	/* 17 to 0x7F are reserved */
 +	ACPI_MADT_TYPE_CORE_PIC =3D 17,
 +	ACPI_MADT_TYPE_LIO_PIC =3D 18,
 +	ACPI_MADT_TYPE_HT_PIC =3D 19,
 +	ACPI_MADT_TYPE_EIO_PIC =3D 20,
 +	ACPI_MADT_TYPE_MSI_PIC =3D 21,
 +	ACPI_MADT_TYPE_BIO_PIC =3D 22,
 +	ACPI_MADT_TYPE_LPC_PIC =3D 23,
- 	ACPI_MADT_TYPE_RESERVED =3D 24	/* 24 and greater are reserved */
++	ACPI_MADT_TYPE_RESERVED =3D 24	/* 24 to 0x7F are reserved */
+ 	ACPI_MADT_TYPE_OEM_RESERVED =3D 0x80	/* 0x80 to 0xFF are reserved for OE=
M use */
  };
 =20
  /*
@@@ -999,120 -1096,10 +1103,125 @@@ struct acpi_madt_multiproc_wakeup_mailb
 =20
  #define ACPI_MP_WAKE_COMMAND_WAKEUP    1
 =20
 +/* Values for Version field above */
 +
 +enum acpi_madt_core_pic_version {
 +	ACPI_MADT_CORE_PIC_VERSION_NONE =3D 0,
 +	ACPI_MADT_CORE_PIC_VERSION_V1 =3D 1,
 +	ACPI_MADT_CORE_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved =
*/
 +};
 +
 +enum acpi_madt_lio_pic_version {
 +	ACPI_MADT_LIO_PIC_VERSION_NONE =3D 0,
 +	ACPI_MADT_LIO_PIC_VERSION_V1 =3D 1,
 +	ACPI_MADT_LIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
 +};
 +
 +enum acpi_madt_eio_pic_version {
 +	ACPI_MADT_EIO_PIC_VERSION_NONE =3D 0,
 +	ACPI_MADT_EIO_PIC_VERSION_V1 =3D 1,
 +	ACPI_MADT_EIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
 +};
 +
 +enum acpi_madt_ht_pic_version {
 +	ACPI_MADT_HT_PIC_VERSION_NONE =3D 0,
 +	ACPI_MADT_HT_PIC_VERSION_V1 =3D 1,
 +	ACPI_MADT_HT_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
 +};
 +
 +enum acpi_madt_bio_pic_version {
 +	ACPI_MADT_BIO_PIC_VERSION_NONE =3D 0,
 +	ACPI_MADT_BIO_PIC_VERSION_V1 =3D 1,
 +	ACPI_MADT_BIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
 +};
 +
 +enum acpi_madt_msi_pic_version {
 +	ACPI_MADT_MSI_PIC_VERSION_NONE =3D 0,
 +	ACPI_MADT_MSI_PIC_VERSION_V1 =3D 1,
 +	ACPI_MADT_MSI_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
 +};
 +
 +enum acpi_madt_lpc_pic_version {
 +	ACPI_MADT_LPC_PIC_VERSION_NONE =3D 0,
 +	ACPI_MADT_LPC_PIC_VERSION_V1 =3D 1,
 +	ACPI_MADT_LPC_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
 +};
 +
 +/* Core Interrupt Controller */
 +
 +struct acpi_madt_core_pic {
 +	struct acpi_subtable_header header;
 +	u8 version;
 +	u32 processor_id;
 +	u32 core_id;
 +	u32 flags;
 +};
 +
 +/* Legacy I/O Interrupt Controller */
 +
 +struct acpi_madt_lio_pic {
 +	struct acpi_subtable_header header;
 +	u8 version;
 +	u64 address;
 +	u16 size;
 +	u8 cascade[2];
 +	u32 cascade_map[2];
 +};
 +
 +/* Extend I/O Interrupt Controller */
 +
 +struct acpi_madt_eio_pic {
 +	struct acpi_subtable_header header;
 +	u8 version;
 +	u8 cascade;
 +	u8 node;
 +	u64 node_map;
 +};
 +
 +/* HT Interrupt Controller */
 +
 +struct acpi_madt_ht_pic {
 +	struct acpi_subtable_header header;
 +	u8 version;
 +	u64 address;
 +	u16 size;
 +	u8 cascade[8];
 +};
 +
 +/* Bridge I/O Interrupt Controller */
 +
 +struct acpi_madt_bio_pic {
 +	struct acpi_subtable_header header;
 +	u8 version;
 +	u64 address;
 +	u16 size;
 +	u16 id;
 +	u16 gsi_base;
 +};
 +
 +/* MSI Interrupt Controller */
 +
 +struct acpi_madt_msi_pic {
 +	struct acpi_subtable_header header;
 +	u8 version;
 +	u64 msg_address;
 +	u32 start;
 +	u32 count;
 +};
 +
 +/* LPC Interrupt Controller */
 +
 +struct acpi_madt_lpc_pic {
 +	struct acpi_subtable_header header;
 +	u8 version;
 +	u64 address;
 +	u16 size;
 +	u8 cascade;
++
+ /* 17: OEM data */
+=20
+ struct acpi_madt_oem_data {
+ 	u8 oem_data[0];
  };
 =20
  /*

--Sig_/BQv5phBh_Tx=7u+niI6=_CH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKFlVgACgkQAVBC80lX
0GxrRgf/WpfGX+SERF916VHuCBgGmllOrsZwdHf3LAO74utNjyXFeURmFXdaWqSf
jdNGriuAKP4+aLyp1wQ5mSNfyhbMuvFAwk2QdysZp2BTvhjOyis4uqO0uBKhJCzB
dRvFdo/7W6zllaDbIlJJFRZGDDbnCuf0epggo+Ylygw4A9gApEz07frzy//u7t/F
3flb8xX3t/rVIc2+CaQlShHfewL0UA6n9210m29U4QtgT9x3Y/BOBhcYHIJGvZJs
ofMv0vpL5/SOLsW7aPb8Ng6c2rKTgLkvY9Wsvv0fL0CfSBmYsytte3kndG3fx0qn
gdj7XVSTazhaqvEUzcTZP+pPWduBjg==
=e1kZ
-----END PGP SIGNATURE-----

--Sig_/BQv5phBh_Tx=7u+niI6=_CH--
