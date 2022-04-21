Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9C50A11A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387092AbiDUNsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386739AbiDUNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E530F7C;
        Thu, 21 Apr 2022 06:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9D9661D28;
        Thu, 21 Apr 2022 13:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E300C385A5;
        Thu, 21 Apr 2022 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650548752;
        bh=qFtjHvTTgWNO14N1FTUsuOdtVG+DvB3hqnuYa75QkOI=;
        h=From:To:Cc:Subject:Date:From;
        b=SE1Vam8sVZvXGW1C6EBlMpdMtRLMpHLoJEwBNo+98BGtzmgrJ+0he/ZyoLN+X4PGm
         2LJ8jT2mosmoRRG5jXx4rb00MNgoqIU7zuwXp9HfsP8RBSK6vnAxDDK6PXVtDUHeVv
         tI+IP9LoS5TNMU6oTtK7t+NyZr8uT5ErOhIgo/NnhPy8hABRW9lGjSiERBtSedTOqp
         lRC0xwoz2dTSz9nQM+ZRKRa2e3yK9GqpsbYsjm56hNbLV/XEb35DI/o5WG6wa2DuPd
         5xNVh7KxNVgqTrG3bqjtA5uGSigxqSsYJh1n3YhOcRjSUBuHfpwyF0Hj4mFfnFF4gu
         nj0nuyg84MLXA==
Received: by pali.im (Postfix)
        id 5EA92CD7; Thu, 21 Apr 2022 15:45:49 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-sha204a: Add support for ATSHA204 cryptochip
Date:   Thu, 21 Apr 2022 15:44:57 +0200
Message-Id: <20220421134457.5867-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATSHA204 is predecessor of ATSHA204A which supports less features and some
of them are slightly different.

Introduce a new compatible string for ATSHA204 cryptochip "atmel,atsha204".

Current version of Linux kernel driver atmel-sha204a.c implements only hw
random number generator which is same in both ATSHA204 and ATSHA204A
cryptochips. So driver already supports also ATSHA204 hw generator, so just
simply extends list of compatible strings.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 +++-
 drivers/crypto/atmel-sha204a.c                         | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..bbff73e1b03a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -47,7 +47,9 @@ properties:
           - at,24c08
             # i2c trusted platform module (TPM)
           - atmel,at97sc3204t
-            # i2c h/w symmetric crypto module
+            # ATSHA204 - i2c h/w symmetric crypto module
+          - atmel,atsha204
+            # ATSHA204A - i2c h/w symmetric crypto module
           - atmel,atsha204a
             # i2c h/w elliptic curve crypto module
           - atmel,atecc508a
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index c96c14e7dab1..3a03f4aaf100 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -132,12 +132,14 @@ static int atmel_sha204a_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id atmel_sha204a_dt_ids[] = {
+	{ .compatible = "atmel,atsha204", },
 	{ .compatible = "atmel,atsha204a", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
+	{ "atsha204", 0 },
 	{ "atsha204a", 0 },
 	{ /* sentinel */ }
 };
-- 
2.20.1

