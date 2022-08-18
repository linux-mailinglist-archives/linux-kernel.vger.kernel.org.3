Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4B5981A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbiHRKtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244159AbiHRKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:48:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE2844CF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:48:56 -0700 (PDT)
Received: from localhost (unknown [82.79.170.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5084E6601C5E;
        Thu, 18 Aug 2022 11:48:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660819735;
        bh=LgveB+2L8BE4MBvfRoHK1uA4FxUgfkXgoYyqUZpED8w=;
        h=From:To:Cc:Subject:Date:From;
        b=ORwhMJRHF3UMU841ITHY/OwPVsREe9Stdym6R0LrxcpdNIH9XZ4R560+KyaPLOiuw
         EggoVWjfrocRdY5hmUnXgXks7q6xkfyvjtGbkwu3c7tDvHJGMX29G8GE9EL+dbC7Vg
         1LmXbMyvwl7PFDP7AOxwurMEMYCIB19qzF1C3ZQnWMRMCsy2k3QSC6WHOSjE6H7lbB
         nJTljJ1YJEwMcEjxM74UgUoQoUnvVvCwCn2RnX63CMpEEOv5a7rlK94R57t2kneEb4
         yCl1V5YveMHWKRBvpIqBjt6vzm4AED1B9v3+0BA6UWg3KklXSIe4d2QmzYW6ABiLKG
         12gz4fWBslqKA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2] regmap: spi: Reserve space for register address/padding
Date:   Thu, 18 Aug 2022 13:48:51 +0300
Message-Id: <20220818104851.429479-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the max_raw_read and max_raw_write limits in regmap_spi struct
do not take into account the additional size of the transmitted register
address and padding.  This may result in exceeding the maximum permitted
SPI message size, which could cause undefined behaviour, e.g. data
corruption.

Fix regmap_get_spi_bus() to properly adjust the above mentioned limits
by reserving space for the register address/padding as set in the regmap
configuration.

Fixes: f231ff38b7b2 ("regmap: spi: Set regmap max raw r/w from max_transfer_size")

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
 - Make use of BITS_PER_BYTE, as suggested by Lucas
 - Small correction in the commit message

 drivers/base/regmap/regmap-spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 719323bc6c7f..37ab23a9d034 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -113,6 +113,7 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 						   const struct regmap_config *config)
 {
 	size_t max_size = spi_max_transfer_size(spi);
+	size_t max_msg_size, reg_reserve_size;
 	struct regmap_bus *bus;
 
 	if (max_size != SIZE_MAX) {
@@ -120,9 +121,16 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 		if (!bus)
 			return ERR_PTR(-ENOMEM);
 
+		max_msg_size = spi_max_message_size(spi);
+		reg_reserve_size = config->reg_bits / BITS_PER_BYTE
+				 + config->pad_bits / BITS_PER_BYTE;
+		if (max_size + reg_reserve_size > max_msg_size)
+			max_size -= reg_reserve_size;
+
 		bus->free_on_exit = true;
 		bus->max_raw_read = max_size;
 		bus->max_raw_write = max_size;
+
 		return bus;
 	}
 

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2

