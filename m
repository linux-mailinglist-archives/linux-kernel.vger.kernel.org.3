Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E579506040
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiDRXd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiDRXdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:33:54 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id B9581245A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:31:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650324674; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=cUyk4WeVp+7lDDXFiewp5XkVKA3vNjvg2iTdrwTV7jk=; b=fEWiSC9CHlf1UW46B5+FABN2njRABPakwMTMofI2x+pImOHS4Y9Q31YVoDfzaDSRsxO2Lq2h
 0JePL4xYRgr4DLt32S1IyVhp9TSGhIkhMQ8VywgqVpmSj3nks87qimGSBqWu9Q+aQ8VoszEd
 /uh5uFfXqkMuxGQkF85ynIJZv+jB9Io0KZACsC4ldkX1jolyL5VctLaBgWN93/OJUKaue/DU
 kKTIJ+Qkbg2+kecwrd/pcls1iIoff9z29HO6QTffoEKS0PdVR1xpx/ruEC8qZoREcSz7VJSb
 GAE5K0QPCgG0jlZIulFrCG5XkXaDyPnNwVH2HlaFHlDYXdPcf07SVQ==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 625df4c157b6987692272704 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 18 Apr 2022 23:31:13 GMT
Sender: codeagain@codeagain.dev
Date:   Mon, 18 Apr 2022 20:31:09 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v2 2/3] staging: vme: Add VME_BUS dependency to Kconfig
Message-ID: <00de5644d7c2f8c8878eccf86b761e0602732080.1650321310.git.codeagain@codeagain.dev>
References: <cover.1650321310.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="puumcnxop7gnfgad"
Content-Disposition: inline
In-Reply-To: <cover.1650321310.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--puumcnxop7gnfgad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The KConfig file for VME_USER ('drivers/staging/vme/devices/Kconfig')
sourced at "drivers/vme/boards/KConfig" misses a `depends on` line for
VME_BUS, which is unnoticeable for menuconfig users who aren't be able
to select it through this interface without setting the CONFIG_VME_BUS
option because it's nested on VME_BUS menu entry.

A patch to move appropriately this driver to the "Staging" submenu
([PATCH 1/3], originally sent as a single patch submitted at
https://lore.kernel.org/linux-staging/3fbc5325e94b9ae0666a1f5a56a4e5372bfce=
a1d.camel@codeagain.dev/T/#t),
however, unveiled this missing `depends on` line, since it moved the
`source` line for VME_USER's KConfig to somewhere else, allowing it to
be compiled without the support for VME_BUS. While it compiles fine and
seems to initialize the driver fine (tested both as module and as built-
in), it seems to make no sense having VME_USER without VME_BUS.

This patches addresses it by adding the VME_BUS to the `depends on` line
at "drivers/staging/vme/devices/Kconfig".

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 drivers/staging/vme/devices/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme/devices/Kconfig b/drivers/staging/vme/devi=
ces/Kconfig
index 5651bb16b28b..e8b4461bf27f 100644
--- a/drivers/staging/vme/devices/Kconfig
+++ b/drivers/staging/vme/devices/Kconfig
@@ -3,7 +3,7 @@ comment "VME Device Drivers"
=20
 config VME_USER
 	tristate "VME user space access driver"
-	depends on STAGING
+	depends on STAGING && VME_BUS
 	help
 	  If you say Y here you want to be able to access a limited number of
 	  VME windows in a manner at least semi-compatible with the interface
--=20
2.35.3


--puumcnxop7gnfgad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl30vQAKCRAZtd3tyEY2
kohYAQDEeD7sf3Z3MEfQ4IbsXM+kMkMKZFFU7UTHectNWRtjGgEAleJ6U7vvTNA8
TbWm4PGZ6Auk3ajk62MwvZUGnEJOuwM=
=DWuN
-----END PGP SIGNATURE-----

--puumcnxop7gnfgad--
