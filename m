Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C5545552
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiFIUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiFIUH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:07:28 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB11AEBEA1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=34uETwjOE3l3Hek/7Bpl7iywBTk
        bCV2WpprJc3BJKCQ=; b=QyLVSL7Xr/RtMGF0FptMtiRGlD5DcEfNc4YyXxVz3nM
        /SLtbzUgmJgngxoIpqmplogmWeTk3oF3d7LsoCY4vR5feblej6seZC32jPkKwPhR
        dh5rjW2ICZOR3B1Su2dlbWHnoLZk2SQ+YSMq9RmMf7DdNs2Yw3cSklMKfHB+4Q/Q
        =
Received: (qmail 3442927 invoked from network); 9 Jun 2022 22:07:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2022 22:07:24 +0200
X-UD-Smtp-Session: l3s3148p1@LqiBXgnhY2JZD+yI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] thermal: rcar_gen3_thermal: improve logging during probe
Date:   Thu,  9 Jun 2022 22:07:09 +0200
Message-Id: <20220609200709.4455-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting up a new board, a plain "Can't register thermal zone"
didn't help me much because the thermal zones in DT were all fine. I
just had a sensor entry too much in the parent TSC node. Reword the
failure/success messages to contain the sensor number to make it easier
to understand which sensor is affected. Example output now:

rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded 1 trip point
rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded 1 trip point
rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded 1 trip point
rcar_gen3_thermal e6198000.thermal: Sensor 3: Can't register thermal zone

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change from v1: reword the dev_info string to be more like the original
one. Added a check to add the plural-'s' only when needed.

Geert: is this better now?

 drivers/thermal/rcar_gen3_thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index ccdf8a24ddc7..f7357b5bd506 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -511,7 +511,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
 		if (IS_ERR(zone)) {
-			dev_err(dev, "Can't register thermal zone\n");
+			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
 			ret = PTR_ERR(zone);
 			goto error_unregister;
 		}
@@ -533,7 +533,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
-		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
+		dev_info(dev, "Sensor %u: Loaded %u trip point%s\n", i, ret,
+			 ret == 1 ? "" : "s");
 	}
 
 	if (!priv->num_tscs) {
-- 
2.35.1

