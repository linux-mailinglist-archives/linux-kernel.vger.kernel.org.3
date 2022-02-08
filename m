Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7C4AD6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbiBHLaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356464AbiBHKt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:49:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52DC03FEC0;
        Tue,  8 Feb 2022 02:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644317365; x=1675853365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ExAnA3KUM5ihqc3qu/vjIF3YfwTPLq/0oU/0/foiKj4=;
  b=ZtYxey7ZPPiwTzg262vm5WQ2XOteXQipgXP5GX5sm+6JZJbnOqK4vHNH
   jiAe+dVvsKAt/M6AdKvX/rqKttanHkwR+x4k3s0iKY1xkaMaUewveaVF3
   bZ4ehoFdmuoiqXQ7/hMJIh4Q/dta7Nw/pbsNHtSpWCIn3hyb82Qp3UaFo
   Isi/4P4FrGt9tl/Pyg1wI+epGVORDayy6IgdZIorE7D7p6QXAOZqpa8dc
   eoW91Q3Sl/tR6aPZc5mL1P3931ph2rhno54CZuVEpb7efl0ATVhuOlv67
   KgT1SttCfvaVKmB0ilP8H9eWdrRuUseZ+bXW8295EmW64/STBNsoFhvpP
   Q==;
IronPort-SDR: CA61ojMJxtINYbptMgA/Jl1JNnAE0lc+jf1ytB3HHNzAZKYJB7/gOnPMzkPKA4tmhjMj1fflQb
 TpI6FlDL7KnhBnUJvCBhKz1LBCfyLUfmcizyM6uy4DYhrJ01UYiV+slz5T26oxkJi4F2qBWrnH
 rGH6cMs5E1u8qQwU3ubUTySxECXAX3R4He1c6W/Y1fcLj496gFTMm92uMvDlb0R2UdOMnp2aUE
 URCmzAw77komXXgpnX5hkkpEHEXzwxF/kmHRt5lY8VDR/h7hNSoo76ioeEq8JFvADYiGu/luS9
 1StbxmIhjLItpvkImWqgCv2z
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="152826392"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 03:49:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 03:49:24 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 03:49:21 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 0/3] crypto: Convert atmel-crypto to YAML
Date:   Tue, 8 Feb 2022 12:49:15 +0200
Message-ID: <20220208104918.226156-1-tudor.ambarus@microchip.com>
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

 .../crypto/atmel,at91sam9g46-aes.yaml         | 65 ++++++++++++++++++
 .../crypto/atmel,at91sam9g46-sha.yaml         | 59 ++++++++++++++++
 .../crypto/atmel,at91sam9g46-tdes.yaml        | 63 +++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 68 -------------------
 4 files changed, 187 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt

-- 
2.25.1

