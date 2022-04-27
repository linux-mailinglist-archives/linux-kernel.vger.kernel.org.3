Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8944B511B76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiD0NNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiD0NNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:13:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA8837828A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:09:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so4003403pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=ZYb3vUijUP/NyZqXmWZa6zg6eCAM3aNiluQBHOKaXu4=;
        b=T9n8GWOWPuyVfKVg18apvINtMQvVuxtX79reGAz128+QPOmBHySPk7mCq9WwWiCi5b
         NFTAmaZRGiCrHIRgBRFPsCZnS/bfPoTGvnqbsfQRgLjYw5lmssjP2lIgWzKHSdutD9vh
         BDnIe7DIRrSLVsfDb4tlrXNy0J88bDGyt4F7riJTvbOPurWYXN45eNc50NFgAkQ5gfdy
         llE2np+FsdYHfOOl+/TEPjUmiYWtqYXAfyBV0GO5BMUWs5roPnzazaqAC/fxSbXavdle
         Vvqb2txvcoPtAtdWKvo7DwLZlS+GNYCgwhJI64H3jeg88uDDtigEnT/edbzs5MM9ptFW
         zi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=ZYb3vUijUP/NyZqXmWZa6zg6eCAM3aNiluQBHOKaXu4=;
        b=43imP8NSRojkYsIbhSoYwArhiPl2wTVmEPzxz+V+2mE7vxDN20XHevdc3ZrTNbGbHr
         n16ZUmtQI+5c+IMKdufnZGZvvvs8vmksXk1AWxRhtr1ehQp1j4kyqqXu6O5wd16oDYkG
         gN8a8C0r9GknZCJzp4OeYT4rgJCB2R07u5SL7MMoNFttPXEgGeCesOzrlUobJndeML0T
         oTYdVGJaq7N7rtKkXiWGdqDHColaMVJ5ueKmKWZ055VDOXGCXJp8ys38bePR/ATsjAOo
         sUBAck+rmNg2H9AZMnbNWr6vv1QwEpaLrtPCFjTTUR4uArNHlNobOdDjJNeUGswjSlY9
         Yo3A==
X-Gm-Message-State: AOAM532tla5Tg01TNWKxNQLOBT8YdJexF9POjqJW8MPYCGmk6+exPGzE
        O7u4plHeOqleYHfvlxSRM72r3Q==
X-Google-Smtp-Source: ABdhPJzXQ2ZZmdY6ZK0xKsnswCSrpuwmFl6MzNi6VYyBZ1WayQBIcsK4weFjFqUnY2jeM59sF6EBwQ==
X-Received: by 2002:a17:902:d717:b0:156:20a9:d388 with SMTP id w23-20020a170902d71700b0015620a9d388mr28761186ply.19.1651064995464;
        Wed, 27 Apr 2022 06:09:55 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-98.751444.bne.nbn.aussiebb.net. [117.20.68.98])
        by smtp.gmail.com with UTF8SMTPSA id mj19-20020a17090b369300b001d29a04d665sm6718308pjb.11.2022.04.27.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:09:54 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:09:28 +0000
Message-Id: <20220427130928.540007-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] net: dsa: mv88e6xxx: Single chip mode detection for MV88E6*41
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mv88e6xxx driver expects switches that are configured in single chip
addressing mode to have the MDIO address configured as 0. This is due to
the switch ADDR pins representing the single chip addressing mode as 0.
However depending on the device (e.g. MV88E6*41) the switch does not
respond on address 0 or any other address below 16 (the first port
address) in single chip addressing mode. This allows for other devices
to be on the same shared MDIO bus despite the switch being in single
chip addressing mode.

When using a switch that works this way it is not possible to configure
switch driver as single chip addressing via device tree, along with
another MDIO device on the same bus with address 0, as both devices
would have the same address of 0 resulting in mdiobus_register_device
-EBUSY errors for one of the devices with address 0.

In order to support this configuration the switch node can have its MDIO
address configured as 16 (the first address that the device responds
to). During initialization the driver will treat this address similar to
how address 0 is, however because this address is also a valid
multi-chip address (in certain switch models, but not all) the driver
will configure the SMI in single chip addressing mode and attempt to
detect the switch model. If the device is configured in single chip
addressing mode this will succeed and the initialization process can
continue. If it fails to detect a valid model this is because the switch
model register is not a valid register when in multi-chip mode, it will
then fall back to the existing SMI initialization process using the MDIO
address as the multi-chip mode address.

This detection method is safe if the device is in either mode because
the single chip addressing mode read is a direct SMI/MDIO read operation
and has no side effects compared to the SMI writes required for the
multi-chip addressing mode.

In order to implement this change, the reset gpio configuration is moved
to occur before any SMI initialization. This ensures that the device has
the same/correct reset gpio state for both mv88e6xxx_smi_init calls.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
Changes in v2:
- Return result of mv88e6xxx_single_chip_detect into err variable to
  clarify the result is in error value and not a true/false result
---
 drivers/net/dsa/mv88e6xxx/chip.c | 46 ++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 64f4fdd029..b8f956eece 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6276,6 +6276,32 @@ static int mv88e6xxx_detect(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static int mv88e6xxx_single_chip_detect(struct mv88e6xxx_chip *chip,
+					struct mdio_device *mdiodev)
+{
+	int err;
+
+	/* dual_chip takes precedence over single/multi-chip modes */
+	if (chip->info->dual_chip)
+		return -EINVAL;
+
+	/* If the mdio addr is 16 indicating the first port address of a switch
+	 * (e.g. mv88e6*41) in single chip addressing mode the device may be
+	 * configured in single chip addressing mode. Setup the smi access as
+	 * single chip addressing mode and attempt to detect the model of the
+	 * switch, if this fails the device is not configured in single chip
+	 * addressing mode.
+	 */
+	if (mdiodev->addr != 16)
+		return -EINVAL;
+
+	err = mv88e6xxx_smi_init(chip, mdiodev->bus, 0);
+	if (err)
+		return err;
+
+	return mv88e6xxx_detect(chip);
+}
+
 static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(struct device *dev)
 {
 	struct mv88e6xxx_chip *chip;
@@ -6959,10 +6985,6 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 
 	chip->info = compat_info;
 
-	err = mv88e6xxx_smi_init(chip, mdiodev->bus, mdiodev->addr);
-	if (err)
-		goto out;
-
 	chip->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(chip->reset)) {
 		err = PTR_ERR(chip->reset);
@@ -6971,9 +6993,19 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (chip->reset)
 		usleep_range(1000, 2000);
 
-	err = mv88e6xxx_detect(chip);
-	if (err)
-		goto out;
+	/* Detect if the device is configured in single chip addressing mode,
+	 * otherwise continue with address specific smi init/detection.
+	 */
+	err = mv88e6xxx_single_chip_detect(chip, mdiodev);
+	if (err) {
+		err = mv88e6xxx_smi_init(chip, mdiodev->bus, mdiodev->addr);
+		if (err)
+			goto out;
+
+		err = mv88e6xxx_detect(chip);
+		if (err)
+			goto out;
+	}
 
 	if (chip->info->edsa_support == MV88E6XXX_EDSA_SUPPORTED)
 		chip->tag_protocol = DSA_TAG_PROTO_EDSA;
---
2.36.0
