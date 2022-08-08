Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3F58CE6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiHHTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244297AbiHHTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:13:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706A1706C;
        Mon,  8 Aug 2022 12:13:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 278JDbqa053362;
        Mon, 8 Aug 2022 14:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659986017;
        bh=VaYzGM0wSLKYt3hbuBD2/xE/BVQiPQJv7qVXQ0swYNo=;
        h=From:To:CC:Subject:Date;
        b=s7Qd7XUrsuoZOQKqmTsOf0cNX4bet7KhJcKfZNRFBVLuawceavJRA5Hof0qVVpNui
         oCjweZuhnNZ9BSqeiIsyoUA16sFrsXUPA9/iXRO9xO6MetI92Vb3115EStTvwIFCa4
         lqCDLyZpg1RqJznQcWzqJSvkdTY0dHwkNwhIBoIk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 278JDbuh016515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Aug 2022 14:13:37 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 8
 Aug 2022 14:13:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 8 Aug 2022 14:13:36 -0500
Received: from uda0500628.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 278JDaYN054740;
        Mon, 8 Aug 2022 14:13:36 -0500
From:   Daniel Parks <danielrparks@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 0/6] Add SA2UL Public Key Accelerator driver
Date:   Mon, 8 Aug 2022 14:12:49 -0500
Message-ID: <cover.1659985696.git.danielrparks@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PKA is a subdevice of the SA2UL that provides hardware acceleration
for asymmetric cryptography algorithms. RSA and Diffie-Hellman are
enabled in this patch series.

Tested using these configurations:
- CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n
- CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y

These patches are RFC for now because we're waiting for legal to clear
us to release the firmware.

The dts patches depend on [1] and [2], respectively, to apply without
fuzz.

[1]: https://www.spinics.net/lists/devicetree/msg523234.html
[2]: https://www.spinics.net/lists/devicetree/msg523233.html

Daniel Parks (6):
  dt-bindings: crypto: ti,sa2ul: add pka subdevice
  dt-bindings: crypto: add binding for eip29t2 public key accelerator
    (PKA)
  arm64: dts: ti: k3-am64-main: add SA2UL public key accelerator
    subdevice
  arm64: dts: ti: k3-j721e-main: add SA2UL public key accelerator
    subdevice
  crypto: sa2ul: turn on PKA engine
  crypto: sa2ul_pka: Add SA2UL PKA driver

 .../inside-secure,safexcel-eip29t2.yaml       |  49 ++
 .../devicetree/bindings/crypto/ti,sa2ul.yaml  |   6 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   8 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   7 +
 drivers/crypto/Kconfig                        |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/sa2ul.c                        |   2 +-
 drivers/crypto/sa2ul_pka/Kconfig              |  26 +
 drivers/crypto/sa2ul_pka/Makefile             |   3 +
 drivers/crypto/sa2ul_pka/sa2ul_pka.h          | 135 +++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_base.c     | 564 ++++++++++++++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_dh.c       | 150 +++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_op.c       | 205 +++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_op.h       |  28 +
 drivers/crypto/sa2ul_pka/sa2ul_pka_rsa.c      | 193 ++++++
 drivers/crypto/sa2ul_pka/sa2ul_pka_sg.c       | 316 ++++++++++
 16 files changed, 1694 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip29t2.yaml
 create mode 100644 drivers/crypto/sa2ul_pka/Kconfig
 create mode 100644 drivers/crypto/sa2ul_pka/Makefile
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka.h
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_base.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_dh.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_op.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_op.h
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_rsa.c
 create mode 100644 drivers/crypto/sa2ul_pka/sa2ul_pka_sg.c

-- 
2.17.1

