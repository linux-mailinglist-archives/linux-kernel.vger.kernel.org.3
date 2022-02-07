Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AD4AB3E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349234AbiBGFwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbiBGDZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:25:16 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 19:25:13 PST
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992BC061A73;
        Sun,  6 Feb 2022 19:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644204313; x=1675740313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GreEbN9bxCgqwDOJq88wEmj1GZLM/Ik6W+xfBQPRD0Y=;
  b=j99kwDuJo2eom7bdaUJzHgTqxG7zfvLrahitlArtSiP4DoXKsvVQkCO3
   3uFTIoTOSu3kxbA/KcDMsHOdikCh0lBA8OivwM9hgZqTBGQ2u5uI0YL+M
   KouFAKqFXONAg740kHbRrSbkC0LiM4Y9QBdABrTAh+HGcGp4Ii+meGzM0
   WOD0lCbIbn7eEOoR3C2eGJA+lPZFZDspHPWaa9bQEzGu+1vDvOlB/Psv2
   Xf6OTrsLHq/nf+ewqjNmxqmyqZWlpHbQTKmH4nSIGTkvTWXbGtk0Fk8bm
   lFJZ9CsPrtqwMwL79XxhRD2dmb9u4LCWDOhcESuGFFDe6X5Mb9PETq0vV
   w==;
IronPort-SDR: UFH1WsWImFsqwwLj1WuLG3LnumHPkLeqP1aAbx3l2Q+vT74Qb28uaamQIJTD7yn17w+FAzwzZG
 wixrkeYuu+lgURWUXCvL3rk8GUGjFEuaYHHBrOE5Xc9U58XNJ0shF5+baU7fyPJaBJx/ZQL4nP
 ORZis4eYaXpt5QRQuOsm3yB43AhiI61o6HqIDYnCrcPBah1C8Sx/NV6qCVfDhqqwbZgpj+oTTI
 akDcqPA5lrP3gXVEJVjFlfYGO4VNt7wWxx1A4SGlyZZX7wM5zaRVaSVRxae7ngKjt2mL4AL8uo
 3jrMHGKLdUEoklfLrOOKe9Ph
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="152654138"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2022 20:24:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 6 Feb 2022 20:24:10 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sun, 6 Feb 2022 20:24:07 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>
CC:     <davem@davemloft.net>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/3] dt-bindings: crypto: Convert atmel-{aes,tdes,sha} to YAML
Date:   Mon, 7 Feb 2022 05:24:02 +0200
Message-ID: <20220207032405.70733-1-tudor.ambarus@microchip.com>
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

Tudor Ambarus (3):
  dt-bindings: crypto: Convert Atmel AES to yaml
  dt-bindings: crypto: Convert Atmel TDES to yaml
  dt-bindings: crypto: Convert Atmel SHA to yaml

 .../devicetree/bindings/crypto/atmel,aes.yaml | 65 ++++++++++++++++++
 .../devicetree/bindings/crypto/atmel,sha.yaml | 59 ++++++++++++++++
 .../bindings/crypto/atmel,tdes.yaml           | 63 +++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 68 -------------------
 4 files changed, 187 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,sha.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,tdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt

-- 
2.25.1

