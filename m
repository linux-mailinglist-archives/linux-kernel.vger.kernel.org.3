Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA45AA2E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiIAWWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiIAWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:21:11 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2AA2620;
        Thu,  1 Sep 2022 15:19:20 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id B7C822209;
        Fri,  2 Sep 2022 00:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662070753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFjv7dJFpQ+L/+5iWkUoVgYZNozNXbOSg5BVzbMzGGc=;
        b=Qt0kiq7il6F978sDpy2pchihqLpiRtEiQsZa2FbKzPwS08bYhlaAqpgpHT+HgW75YU1guf
        DJrBaW2KsEc5IJxE+UJGOj6Ac9vwwmrblO6+pF+Y6XhwfdgvNSRe/rXFkByF3JQ3NZyenG
        iPmU+fJGn9pNVf/X78l7EtSnAT4z++OreoaNo7fjYmZmk1vAZA93tpCmz4zvQl1MhJVnzu
        ouphqV0VwQSjpA2AwPnwi60vEl63jTXA/gliwSGn95wzSiSMooE1fZFGc+HwBb0ZXliXug
        Sz225qm9PxNvKvMC4Ku+i2tqYAWe8mun/8MOr+OCY9Sk6qJ4aBFcA1QFTjMmmA==
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 14/20] dt-bindings: mtd: relax the nvmem compatible string
Date:   Fri,  2 Sep 2022 00:18:51 +0200
Message-Id: <20220901221857.2600340-15-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901221857.2600340-1-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "user-otp" and "factory-otp" compatible string just depicts a
generic NVMEM device. But an actual device tree node might as well
contain a more specific compatible string. Make it possible to add
more specific binding elsewhere and just match part of the compatibles
here.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - fix typo in commit message

 Documentation/devicetree/bindings/mtd/mtd.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 3498e485679b..25b91f25fcf4 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -33,9 +33,10 @@ patternProperties:
 
     properties:
       compatible:
-        enum:
-          - user-otp
-          - factory-otp
+        contains:
+          enum:
+            - user-otp
+            - factory-otp
 
     required:
       - compatible
-- 
2.30.2

