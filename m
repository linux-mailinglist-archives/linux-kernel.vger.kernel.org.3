Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0C562A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGAE3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiGAE3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:29:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DA658FE0;
        Thu, 30 Jun 2022 21:29:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2614TOdI022208;
        Thu, 30 Jun 2022 23:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656649764;
        bh=ZZpTjhFTAu6hQIWqxUkqm1xErTjHOgN3ive3sAMZfRo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TOiJ08uHEub6ZBK3naZVJbWyeivMiQELfUMPgDDu+7osyFSPk30ZUJ9JBraUH3VND
         U80CsUI228LON00wdpjzCxPzdw2uMRSwG/2yE/m1a/leoqGiBUHEFCyYPS8MSDK2OG
         tNfpXkRI2xRbefiKlRbcMrnjSFA8xAzQdIwN1mZ0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2614TOEY009657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jun 2022 23:29:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 30
 Jun 2022 23:29:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 30 Jun 2022 23:29:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2614TOmu001166;
        Thu, 30 Jun 2022 23:29:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Florian Eckert <fe@dev.tdt.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution devices support
Date:   Thu, 30 Jun 2022 23:29:19 -0500
Message-ID: <20220701042919.18180-3-nm@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701042919.18180-1-nm@ti.com>
References: <20220701042919.18180-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adcxx4s communicates with a host processor via an SPI/Microwire Bus
interface. The device family responds with 12bit data, of which the LSB
bits are transmitted by the lower resolution devices as 0. We don't need
to mess with ADC108S102_BITS as a result for the lower resolution
devices.

I have been able to test adc102s051, hence adding just the missing
ones in that family.

Lets reuse the driver to support the family of devices with name
ADC<bb><c>S<sss>, where
* bb is the resolution in number of bits (8, 10, 12)
* c is the number of channels (1, 2, 4, 8)
* sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
  and 101 for 1 MSPS)

Complete datasheets are available at TI's website here:
  https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf

Also see: drivers/hwmon/adcxx.c

Signed-off-by: Nishanth Menon <nm@ti.com>
---

This does add on additional sparse warnings around casting .data value
to const from int for the of_match_table, and a bunch around the .cls
field for acpi_device_id - maybe someone could suggest a smarter way to
fix those.

Applies after https://lore.kernel.org/linux-iio/20220630230107.13438-1-nm@ti.com/

 drivers/iio/adc/ti-adc128s052.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 21a7764cbb93..0a3aab4df60e 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -7,6 +7,20 @@
  * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
  * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
+ *
+ * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
+ * interface. This driver supports the whole family of devices with name
+ * ADC<bb><c>S<sss>, where
+ * bb is the resolution in number of bits (8, 10, 12)
+ * c is the number of channels (1, 2, 4, 8)
+ * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
+ * and 101 for 1 MSPS)
+ *
+ * Complete datasheets are available at TI's website here:
+ *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
+ *
+ * Handling of 8, 10 and 12 bits converters are the same, the
+ * unavailable bits are 0 in LSB :)
  */
 
 #include <linux/acpi.h>
@@ -185,6 +199,12 @@ static const struct of_device_id adc128_of_match[] = {
 	{ .compatible = "ti,adc122s021", .data = 1},
 	{ .compatible = "ti,adc122s051", .data = 1},
 	{ .compatible = "ti,adc122s101", .data = 1},
+	{ .compatible = "ti,adc102s021", .data = 1},
+	{ .compatible = "ti,adc102s051", .data = 1},
+	{ .compatible = "ti,adc102s101", .data = 1},
+	{ .compatible = "ti,adc082s021", .data = 1},
+	{ .compatible = "ti,adc082s051", .data = 1},
+	{ .compatible = "ti,adc082s101", .data = 1},
 	{ .compatible = "ti,adc124s021", .data = 2},
 	{ .compatible = "ti,adc124s051", .data = 2},
 	{ .compatible = "ti,adc124s101", .data = 2},
@@ -197,6 +217,12 @@ static const struct spi_device_id adc128_id[] = {
 	{ "adc122s021",	1 },
 	{ "adc122s051",	1 },
 	{ "adc122s101",	1 },
+	{ "adc102s021",	1 },
+	{ "adc102s051",	1 },
+	{ "adc102s101",	1 },
+	{ "adc082s021",	1 },
+	{ "adc082s051",	1 },
+	{ "adc082s101",	1 },
 	{ "adc124s021", 2 },
 	{ "adc124s051", 2 },
 	{ "adc124s101", 2 },
-- 
2.31.1

