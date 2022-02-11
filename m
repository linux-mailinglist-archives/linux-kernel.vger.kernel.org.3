Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D94B2232
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbiBKJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:39:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348685AbiBKJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:39:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7C109C;
        Fri, 11 Feb 2022 01:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644572368; x=1676108368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uab3V4+bIdpYnckUfKm5nPvtJZjxdW5mFoAh+fvhJOc=;
  b=iIjHRyZJ7VAwLjGnAE0lpG2ck4xXYI7uWP+2lvGYi6WimGv2am7KPCAY
   KBFI7jAhhoGJ78OSN1UurJ8Gk4rCaPLztP+CIAUbVnWWFmSw/DX4+ZZWg
   44xZxVTWh84nHcB2DQArN/wAvm7c1aPEeNsdWdqlslNiSTts8goAItYFU
   vn+xnNCTmadnF5AuoxWKlZ7BJ/1cK4jj8rDVv96zQ7FAMKc0WnQh7kECQ
   PVFvBGvRv7HB06uhwKUslYgsuPK2OAidzcAoXK8QCa57i6wYhYBHmDbIE
   XUGBQ5T42yDx7BITHTTha+WGXOuEkNPiEqccIXk/hJFqHtOLXf51STKZs
   w==;
IronPort-SDR: MM7bv+IEic80mkET68rgWi5jjnpph61TewMllFa1kTvIW0yuH3AV3h6BVJ14UDZtFsW8j4FP6L
 ODVUxC7QHCpGYCkWnERSWaLdKfYORgyCWtcCiJNm/0RlmZsbhNRCOeGJxc8f0XnefZojZMLg0m
 OIIpZQW1Vl7W2wax8QHqYcM2f3OOx763febGHsj7XvXU6Lw7sqWjVq6SxItElmORPw5DZ8YltX
 mSU/Gkpm3rk3xH90dRLHv682OjZo8mF+1/Zvs4JWler3l8C/V784IdVJ5D46R3qf70Z5YTWtAC
 G8Ixfxb22zFYksC5u5jhok5k
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="153263758"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 02:39:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 02:39:27 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 02:39:24 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PACTH v4 0/3] dt-bindings: crypto: Convert atmel-crypto to YAML
Date:   Fri, 11 Feb 2022 11:39:19 +0200
Message-ID: <20220211093922.456634-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel AES, TDES and SHA documentation to yaml format. There is one
binding defined per file. Keeping all bindings under the same yaml does
not make sense, as these are individual IPs. With the conversion the clock
and clock-names properties are made mandatory, to reflect how the drivers
treat them: when these properties are not provided, the drivers return
error.

v4:
- fix the AES example: match the node's address with the reg's address
- collect Krzysztof's R-b tags

v3:
- update license to (GPL-2.0-only OR BSD-2-Clause)
- add "Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries"
- add Krzysztof's R-b tag on patch 3/3. Chose to keep "maxItems: 1" instead
of "items" and "description" because that's what the guide at [1] suggests:
"# Cases that have only a single entry just need to express that with
maxItems"

[1] https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-schema.html#annotated-example-schema

v2:
- use generic "crypto" node name
- drop redundant status = "okay" - it's the default state anyway
- introduce empty line for readability
- be specific and rename the bindings to let room for future possible
  lines of architectures.

Tudor Ambarus (3):
  dt-bindings: crypto: Convert Atmel AES to yaml
  dt-bindings: crypto: Convert Atmel TDES to yaml
  dt-bindings: crypto: Convert Atmel SHA to yaml

 .../crypto/atmel,at91sam9g46-aes.yaml         | 66 ++++++++++++++++++
 .../crypto/atmel,at91sam9g46-sha.yaml         | 60 ++++++++++++++++
 .../crypto/atmel,at91sam9g46-tdes.yaml        | 64 +++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 68 -------------------
 4 files changed, 190 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt

-- 
2.25.1

