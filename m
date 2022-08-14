Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBBC5926F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 01:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiHNXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 19:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 19:20:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13DD55;
        Sun, 14 Aug 2022 16:20:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M5YLR2kL7z4xD2;
        Mon, 15 Aug 2022 09:20:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660519249;
        bh=dZBjGIr+Z5C+hlv3yZPMValSeXkKaf6abWdDH55WeXU=;
        h=Date:From:To:Cc:Subject:From;
        b=FfdT8vc83/c6VghkPrpdUEg5dJVVQezzAh44vU7v6Pn7SXF+DMcGH+9dRHkIorw8r
         hqa3O+j0tjEAIcoVi2Y+XY3HFmWknkYkhwINUJvPRh9IJsOpHLpthjwTQo//ZFAC5C
         sDvlAKkSWEiGv16XxZ9OXh2xKIL9UJhEayRKkCniSgKW8CCMFGkjcTxbV3NNp94opY
         lLSdEocuEJXn93gLNFsCC/jrLVaF48CxiPgPa4L+G6oDVWCQwNoMLH7RZCmX5lCLWg
         b63ttCO6ZCvhYQP0LCPcKq0I/gmLf1UDBJPs3+YtySgZD+j0BAER2X7ZfF0jHFhggL
         RwvB4o0WzhWtQ==
Date:   Mon, 15 Aug 2022 09:20:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Subject: linux-next: manual merge of the thermal tree with Linus' tree
Message-ID: <20220815092046.644a0afa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hdJQg1IQYyF/k9OIEDMBcV+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hdJQg1IQYyF/k9OIEDMBcV+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c

between commits:

  03978fb88b06 ("mlxsw: core_thermal: Use common define for thermal zone na=
me length")
  ef0df4fa324a ("mlxsw: core_thermal: Extend internal structures to support=
 multi thermal areas")

from Linus' tree and commit:

  9b5e2c897cd1 ("Revert "mlxsw: core: Add the hottest thermal zone detectio=
n"")

from the thermal tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 3548fe1df7c8,373a77c3da02..000000000000
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@@ -21,7 -21,7 +21,6 @@@
  #define MLXSW_THERMAL_ASIC_TEMP_HOT	105000	/* 105C */
  #define MLXSW_THERMAL_HYSTERESIS_TEMP	5000	/* 5C */
  #define MLXSW_THERMAL_MODULE_TEMP_SHIFT	(MLXSW_THERMAL_HYSTERESIS_TEMP * =
2)
- #define MLXSW_THERMAL_TEMP_SCORE_MAX	GENMASK(31, 0)
 -#define MLXSW_THERMAL_ZONE_MAX_NAME	16
  #define MLXSW_THERMAL_MAX_STATE	10
  #define MLXSW_THERMAL_MIN_STATE	2
  #define MLXSW_THERMAL_MAX_DUTY	255
@@@ -101,9 -91,10 +100,7 @@@ struct mlxsw_thermal=20
  	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
  	u8 cooling_levels[MLXSW_THERMAL_MAX_STATE + 1];
  	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
- 	unsigned int tz_highest_score;
- 	struct thermal_zone_device *tz_highest_dev;
 -	struct mlxsw_thermal_module *tz_module_arr;
 -	u8 tz_module_num;
 -	struct mlxsw_thermal_module *tz_gearbox_arr;
 -	u8 tz_gearbox_num;
 +	struct mlxsw_thermal_area line_cards[];
  };
 =20
  static inline u8 mlxsw_state_to_duty(int state)

--Sig_/hdJQg1IQYyF/k9OIEDMBcV+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL5g04ACgkQAVBC80lX
0GxpFAf+NqVTf19Fn5sYyjTwNW+xOEScAjKqShJWwX6kBuvmXCpk6TcV5dIdKFmQ
KKB6TFmi+4ixDPmbodu9jo3pzyJ5YsxbKmZPuYD5pz0D3ygy50UJXipTW+UwzXs0
FsD0mWmruIWlcpKM1cfRtnQAQ2B9KVO9pKSSh50VfYeC//4W8lULVEsXcaQo0Kxh
8qcFCWt2uwvsqFEbQmE3T9qSd0eVwwnCcSm1aeeQeSVyplmT+O2BSvnJ0YHZGrl4
VbIJpbOrL4bXmW9yOfgdw1AzkG4LTWdXmzd8Y+N9+TcEg3iC/PvHCOnrBtwh7KeX
ugu5rG7fS/9bUbT+Ch8YM6kd2o2K/Q==
=g7L7
-----END PGP SIGNATURE-----

--Sig_/hdJQg1IQYyF/k9OIEDMBcV+--
