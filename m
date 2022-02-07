Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAF4AC5B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389472AbiBGQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389775AbiBGQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:27:06 -0500
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 08:27:04 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F28C0401CC;
        Mon,  7 Feb 2022 08:27:04 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1MKbwg-1nbwVi0iyK-00L0Yj; Mon, 07 Feb 2022 17:21:38 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] imx_thermal: Fix temperature retrieval after overheat
Date:   Mon,  7 Feb 2022 17:18:30 +0100
Message-Id: <20220207161829.4807-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nB1bTMwZBFWEuhylUis7rLw5EQ2337iNQATK8GFDRXIZ7yaAo/p
 zViD23GEZDiLLLdymY7ZtS9rODuTGylsdyaKoZB79ML/Z2+8UizghvoK42a8KJ8Tn06M/4j
 AFo4amFvwIIsyIsFNo+iZeTzpA5njJ5N0jNl6i2nFhqy92t9GRJNMK/KzQ+RUkbjxb5tjnD
 OFMPHJEHWe8qhJRaOwAfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DrdQU+NYlxo=:ZI9BjRW9eZMtiZ1FpJjbHp
 YZxmh/MqKo+wLu95PSRy/e7+58EAOV5H2v7N6n1YIJwMVO+Re1f0E2o4EEbpQoOdPirIJIrXh
 rkUN4LQGj0pRbCiGo4O9cbGbr6t4GK1IjCfkgVJkpFtjGPojf7yolu202n+GJn3KRRZ15grHW
 EvlOGKNGOmPXaH8U/iuy2Xh2decU44u4/VX+WxEiWyq7UgvNOTxKqmg2K2kPvgIijFScTJU+c
 IkFolc9rXr4kePFy936LnSMonyF0XShig3loZAvWjVVZ389EE2u2TPcnmT9uhLKbSzoyoHrSY
 EBHBBaU1t6Ksa27R2/TmTjyKicWbqBh+WWq0qMt1cy39cCCKwmsFVly1aZprxuvipPenNVXsL
 0gNykysooh377d4oVg5fHdjj77Ry+QkBQYAp1ldcCbGpY6Acl5bse1nLwr1NIvZ/nFCcGLIqH
 mjj6q9HUyAZg2vDtB6dlwemQGkDCIq4J565fNoqF8xN2qO8oNktogCb4yC+kbQBUftsZFjIhr
 qChuXN96Wfasnvcwr14wXQDLcdRjnBGBCnrVaz/7dxvrZQeQTZJ5RNhKIoz1W9x7XguUR8kJV
 9d6iTM9OvV752nu4PZdsDNBDfIIZ1l0JjNM3bPTEJjIrIHHznqLcDi8R3gzgYCk6JrZG9UnZv
 yIrJkS5f3YZLR4I5LhQTSdCY72OuJGyClxZxJnG7armMo1zoIqvtauQS2v9oqXQpGf88S8Bvd
 Yt9a9kpJumHqeo9s52H1Zi61KQSbtvOJsHvotA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU temperature is above the passive trip point, reading the
temperature would fail forever with EAGAIN.  Fortunately, the thermal
core would continue to assume that the system is overheating, so would
put all passive cooling devices to the max.  Unfortunately, it does
this forever, even if the temperature returns to normal.

This can be easily tested by setting a very low trip point and crossing
it with while(1) loops.

The cause is commit d92ed2c9d3ff ("thermal: imx: Use driver's local data
to decide whether to run a measurement"), which replaced a check for
thermal_zone_device_is_enabled() by a check for irq_enabled, which
tests if the passive trip interrupt is enabled.

Normally, when the thermal zone is enabled, the temperature sensors
are always enabled and the interrupt is used to detect overheating.
When the interrupt fires, it must be disabled.
In that case, the commit causes the measurements to be done
manually (enable sensor, do measurement, disable sensor).
If the thermal core successfully cools down the system below the trip
point (which it typically does quickly), the irq is enabled again but
the sensor is not enabled.

To fix this without using thermal_zone_device_is_enabled(), use a
separate variable to record if the thermal zone is enabled.

Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide
whether to run a measurement")

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/thermal/imx_thermal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2c7473d86a59..5a6ad5bae238 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -205,6 +205,7 @@ struct imx_thermal_data {
 	int alarm_temp;
 	int last_temp;
 	bool irq_enabled;
+	bool tz_enabled;
 	int irq;
 	struct clk *thermal_clk;
 	const struct thermal_soc_data *socdata;
@@ -252,11 +253,10 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	const struct thermal_soc_data *soc_data = data->socdata;
 	struct regmap *map = data->tempmon;
 	unsigned int n_meas;
-	bool wait, run_measurement;
+	bool wait;
 	u32 val;
 
-	run_measurement = !data->irq_enabled;
-	if (!run_measurement) {
+	if (data->tz_enabled) {
 		/* Check if a measurement is currently in progress */
 		regmap_read(map, soc_data->temp_data, &val);
 		wait = !(val & soc_data->temp_valid_mask);
@@ -283,7 +283,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	regmap_read(map, soc_data->temp_data, &val);
 
-	if (run_measurement) {
+	if (!data->tz_enabled) {
 		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
 			     soc_data->measure_temp_mask);
 		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
@@ -339,6 +339,7 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	const struct thermal_soc_data *soc_data = data->socdata;
 
 	if (mode == THERMAL_DEVICE_ENABLED) {
+		data->tz_enabled = true;
 		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
 			     soc_data->power_down_mask);
 		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
@@ -349,6 +350,7 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 			enable_irq(data->irq);
 		}
 	} else {
+		data->tz_enabled = false;
 		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
 			     soc_data->measure_temp_mask);
 		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
-- 
2.34.1

