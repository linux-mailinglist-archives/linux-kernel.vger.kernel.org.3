Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB574721C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhLMHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:32:31 -0500
Received: from smtp-4.b-tu.de ([141.43.208.14]:33948 "EHLO smtp-4.b-tu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLMHca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:32:30 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 02:32:30 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp-4.b-tu.de (Postfix) with ESMTP id 4JCCfK5yntzGsZY1;
        Mon, 13 Dec 2021 08:23:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=b-tu.de; h=
        mime-version:content-type:content-type:user-agent:subject
        :subject:from:from:message-id:date:date:received:received
        :received:received; s=smtp; t=1639380200; x=1640244201; bh=JVQRV
        ENz9DxHI0Z01BT3KYvPrLb1vNXRKAJ7nIEt/bw=; b=0dHyotUN7mhV1kQE8Un7S
        LRACv1ogwZGHLbAE7ogZU7nCZENiTvstHwqixuHFMabehjyzNxTiVp0Z9bCkGF8t
        E69dfDqsd584cwK9Knx3ZHI4pgsfE7SBVQeHJDM8oSS+hBwel/eqazsT2yJIruWy
        1uIfQKwCEqT2PV2aHsVURc=
X-Virus-Scanned: by AMaViS (at smtp-4.b-tu.de)
Received: from smtp-4.b-tu.de ([127.0.0.1])
        by localhost (smtp-4.b-tu.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QUS1i5r9Vbh8; Mon, 13 Dec 2021 08:23:20 +0100 (CET)
Received: from webmail.b-tu.de (webmail.b-tu.de [141.43.208.17])
        by smtp-4.b-tu.de (Postfix) with ESMTPS id 4JCCfH3bm0zGsZnQ;
        Mon, 13 Dec 2021 08:23:19 +0100 (CET)
Received: from Webmail.b-tu.De (localhost [127.0.0.1])
        (Authenticated sender: werneand)
        by webmail.b-tu.de (Postfix) with ESMTPA id 272D41B24;
        Mon, 13 Dec 2021 08:23:19 +0100 (CET)
Received: from [212.185.67.148] (212.185.67.148 [212.185.67.148]) by
 www.b-tu.de (Horde Framework) with HTTPS; Mon, 13 Dec 2021 08:23:19 +0100
Date:   Mon, 13 Dec 2021 08:23:19 +0100
Message-ID: <20211213082319.Horde.z0oaiJ-O4G6vhVbw4WSBjnN@webmail.b-tu.de>
From:   =?utf-8?b?QW5kcsOp?= Werner <Andre.Werner@b-tu.de>
To:     lgirdwood@gmail.com, broonie@kernel.org, anson.huang@nxp.com
Cc:     linux-kernel@vger.kernel.org, andre.werner@systec-electronic.com
Subject: [PATCH] linux: regulator: pca9450.h: Correct register masks for
 LDOs
User-Agent: Horde Application Framework 5
Content-Type: multipart/mixed; boundary="=_2z3QDgo2TCtlgWB0VJxc1f_"
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

--=_2z3QDgo2TCtlgWB0VJxc1f_
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline


 From 6dda12150785665ddd1059d53aa22bf902bfe4aa Mon Sep 17 00:00:00 2001
From: Andre Werner <andre.werner@systec-electronic.com>
Date: Mon, 22 Nov 2021 15:40:17 +0100
Subject: [PATCH] linux: regulator: pca9450.h: Correct register masks for LDOs

Within the defines of the register masks for LDO3 and LDO4,
the most significant bit was missing. The datasheet said
the range is 4:0 bits. Thus, the output voltage cannot be
set above 1.7V for each.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
  include/linux/regulator/pca9450.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regulator/pca9450.h  
b/include/linux/regulator/pca9450.h
index 71902f41c919..0c3edff6bdff 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -196,11 +196,11 @@ enum {

  /* PCA9450_REG_LDO3_VOLT bits */
  #define LDO3_EN_MASK                   0xC0
-#define LDO3OUT_MASK                   0x0F
+#define LDO3OUT_MASK                   0x1F

  /* PCA9450_REG_LDO4_VOLT bits */
  #define LDO4_EN_MASK                   0xC0
-#define LDO4OUT_MASK                   0x0F
+#define LDO4OUT_MASK                   0x1F

  /* PCA9450_REG_LDO5_VOLT bits */
  #define LDO5L_EN_MASK                  0xC0
-- 
2.31.1


--=_2z3QDgo2TCtlgWB0VJxc1f_
Content-Type: application/pgp-keys
Content-Description: PGP Public Key

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.22 (GNU/Linux)

mI0EX5/e0wEEAKhvN7nLqNpIrTL6k0d8yuhXahKc/1+lkUIxU6nAUGmVB3ONxUyn
MuaBGJMWmSfDXQKoJFIm+09XdQAq9INtAleiFrcXWwMHLzvnBjTB8wF/tHTaU8EU
CVDs7ZU+uNlnb9bLu9h0fIpW+7wIzlDYDPOci0VS/CFVPhbRqls7a51bABEBAAG0
NHdlcm5lYW5kIChUaW1lIFRha2VzIFVzIEFsbC4pIDxBbmRyZS5XZXJuZXJAYi10
dS5kZT6IuQQTAQIAIwUCX5/e0wIbLwYLCQgHAwIGFQgKCQsCBRYCAwEAAh4BAheA
AAoJEN/s1QVADNUWof8EAISJiRgrfPaLTFpPHJpYrWz5Ea2CiHH2VkZv01WY9HCw
6aYaDcBNOXf1bgvBO3RW4d4SRdE7fb6r6LvO1i5jB1v1JSCgUYZCv3aLX4tqvO8a
inXXrpypbpqzefODrL/HirLu6LEuj6twwAdOPXKCU+yFQjWgUv5AA301QXmzIVFl
uI0EX5/e0wEEAMCP4iXYB28hGFu2sLXraDKf75g2VqSnqy6kjX4kje3elq4fbscf
fPywdgMtFBj3L1AvTw/QoRrKQGQtC9QSoReqv9Iqo8tJPagL+AX7q6AX/7sAJ9bn
yByZ6Xw6cg52+yy4SmxXI4ki1aQuUuZvM8w3z79zkWk6JUlObe9od9uVABEBAAGJ
AT0EGAECAAkFAl+f3tMCGy4AqAkQ3+zVBUAM1RadIAQZAQIABgUCX5/e0wAKCRDv
leJKNd5FhfeqA/wOzcD+rpCaEXREcxBWC5rIO1ANhX9TqHuh83Y9+Lpea4kavm6h
MMxXw/o6WSIdDIDlawa8gFN3eMOh+NEIVkD3j2sDJqnill40UMqSUmZQyK80X+aE
WjuTfnxX30ZS3T7cSpf8PSj8ur4iF4UuJ7AV64T11wu88twsTkG6r75gYHC4A/9+
E6eAM6+LgyhBQsodlF24r1jkWtF8MufFgxgeWrFVAXV6GSVh0bBolQXbYh3IRnU+
lgO5YEiZ5Z3kvlGwClb8ieY29mHJ4rJz0ULVUrfV+/l2sggGMjf8y3bh/fVSl+8s
d0A1F5CxhvfpQlHjuzXA8QvxhewqvkmeRr5qmtmFxQ==
=W0cT
-----END PGP PUBLIC KEY BLOCK-----
--=_2z3QDgo2TCtlgWB0VJxc1f_--

