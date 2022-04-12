Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D464FD3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357808AbiDLITN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354953AbiDLH1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:27:00 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id D139247553
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:06:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1649747215; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=fvgEOeU8QI1dhGiQvK+nRA/UPCGXfJKOpsdVofoakIo=; b=NvGv8dEjAAp3+VikOfUObAxYtrnLW9QAOOGMeh/7ELD/XyzyaKSNVHMn0CATTdFo76WVcK5F
 u9wE02pYhBY8/XWTK6F846LO3zgn7wIvmlyEZsLgctaLPYn6w9TX3TWgZS69ZaI3XrE968qv
 8oKDBGa99Hyrmw+lOyc8yQTX7qATSRxUX2SRLpl0AukHcM0HrRYcnOpVcoEhg+XBW9Gg8XLf
 guUPLpQTfhqAERLhzrqrRMP2K04yuZ8UztSOAxKyxK5CWvjGRWd90eqzFaIMCW2hXqZ4TgOQ
 rOTnEAZLAGJRtzG+Y3B+c/l+uEgFtfR/9cDyaAQYGJ27Kn/YhwB8FQ==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 625522b5487c9ee854845f89 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 12 Apr 2022 06:56:53 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 12 Apr 2022 03:56:43 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v2 2/3] staging: vme: Fix missing `depends on` at KConfig
Message-ID: <aab0591ac73a54059621c722a63635d43a446fd2.1649721450.git.codeagain@codeagain.dev>
References: <cover.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r67e4p532boyyctc"
Content-Disposition: inline
In-Reply-To: <cover.1649721450.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r67e4p532boyyctc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Originally, the KConfig file for VME_USER
("drivers/staging/vme/devices/Kconfig") was sourced at
"drivers/vme/boards/KConfig". It misses a `depends on` line for VME_BUS,
which went unnoticeable for a menuconfig user who wouldn't be able to
select it through this interface without selecting the CONFIG_VME_BUS
option because it was nested on its menu.

A patch to move appropriately this driver to the "Staging" submenu[1],
however, unveiled this missing `depends on` line, since it moved the
`source` line for VME_USER's KConfig to somewhere else, allowing it to
be compiled without the support for VME_BRIDGE. While it compiles fine
and seems to initialize the driver fine[2], it seems to make no sense
having VME_USER without VME_BUS.

This patches addresses it by adding the VME_BUS to the `depends on` line
at "drivers/staging/vme/devices/Kconfig".

CHANGELOG:
v2:
- Added this patch to the patchset

REFERENCES AND NOTES
[1] First commit in this patch, originally submitted at
https://lore.kernel.org/linux-staging/3fbc5325e94b9ae0666a1f5a56a4e5372bfce=
a1d.camel@codeagain.dev/T/#t
[2] Tested both as module and as built-in.

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
2.35.1


--r67e4p532boyyctc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYlUiqwAKCRAZtd3tyEY2
kh7WAQDnPJNUjIPGKOS6iN5nijD+bLt8dlNylHDXGzcDp/x21QEAttFRYM5TnNEi
Wn7P5NtTX55JavXFp1wmv2lUDtDWZww=
=So4f
-----END PGP SIGNATURE-----

--r67e4p532boyyctc--
