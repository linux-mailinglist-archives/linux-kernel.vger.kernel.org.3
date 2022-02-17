Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57A4B9D78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiBQKq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:46:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiBQKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:46:25 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A0729410F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:46:10 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E2F3FB10;
        Thu, 17 Feb 2022 02:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645094770;
        bh=k2uD7BYduSjipdEcL2Koh9IwXWlXmu34APxpIgOo/M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETB8cvRO/ymbjLAvw0i90ILe/BawTknLjnIdlNuS+l0LHklhq+EER5ANvTDfokZBP
         DJmFLVZTD+CnF1S4y7NOr01Oitch4Ho5x3sFJOM4Vp8sKh5BHxo7+IpRKPwoexW9Sz
         f4PXv2y5yy/WzxvILlg3isIO2A3PurYgpD73mFto=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/4] hwmon: (pmbus) Add get_error_flags support to regulator ops
Date:   Thu, 17 Feb 2022 02:44:41 -0800
Message-Id: <20220217104444.7695-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217104444.7695-1-zev@bewilderbeest.net>
References: <20220217104444.7695-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various PMBus status bits don't all map perfectly to the more
limited set of REGULATOR_ERROR_* flags, but there's a reasonable
number where they correspond well enough.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/pmbus/pmbus_core.c | 97 ++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 776ee2237be2..a274e8e524a5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2417,10 +2417,107 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
 	return _pmbus_regulator_on_off(rdev, 0);
 }
 
+/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
+struct pmbus_regulator_status_assoc {
+	int pflag, rflag;
+};
+
+/* PMBus->regulator bit mappings for a PMBus status register */
+struct pmbus_regulator_status_category {
+	int func;
+	int reg;
+	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
+};
+
+static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
+	{
+		.func = PMBUS_HAVE_STATUS_VOUT,
+		.reg = PMBUS_STATUS_VOUT,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
+			{ },
+		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_IOUT,
+		.reg = PMBUS_STATUS_IOUT,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
+			{ },
+		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_TEMP,
+		.reg = PMBUS_STATUS_TEMPERATURE,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
+			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
+			{ },
+		},
+	},
+};
+
+static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	int i, status, statusreg;
+	const struct pmbus_regulator_status_category *cat;
+	const struct pmbus_regulator_status_assoc *bit;
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	u8 page = rdev_get_id(rdev);
+	int func = data->info->func[page];
+
+	*flags = 0;
+
+	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
+		cat = &pmbus_regulator_flag_map[i];
+		if (!(func & cat->func))
+			continue;
+
+		status = pmbus_read_byte_data(client, page, cat->reg);
+		if (status < 0)
+			return status;
+
+		for (bit = cat->bits; bit->pflag; bit++) {
+			if (status & bit->pflag)
+				*flags |= bit->rflag;
+		}
+	}
+
+	/*
+	 * Map what bits of STATUS_{WORD,BYTE} we can to REGULATOR_ERROR_*
+	 * bits.  Some of the other bits are tempting (especially for cases
+	 * where we don't have the relevant PMBUS_HAVE_STATUS_*
+	 * functionality), but there's an unfortunate ambiguity in that
+	 * they're defined as indicating a fault *or* a warning, so we can't
+	 * easily determine whether to report REGULATOR_ERROR_<foo> or
+	 * REGULATOR_ERROR_<foo>_WARN.
+	 */
+	statusreg = data->has_status_word ? PMBUS_STATUS_WORD : PMBUS_STATUS_BYTE;
+	status = pmbus_get_status(client, page, statusreg);
+
+	if (status < 0)
+		return status;
+
+	if (pmbus_regulator_is_enabled(rdev) && (status & PB_STATUS_OFF))
+		*flags |= REGULATOR_ERROR_FAIL;
+	if (status & PB_STATUS_IOUT_OC)
+		*flags |= REGULATOR_ERROR_OVER_CURRENT;
+	if (status & PB_STATUS_VOUT_OV)
+		*flags |= REGULATOR_ERROR_REGULATION_OUT;
+
+	return 0;
+}
+
 const struct regulator_ops pmbus_regulator_ops = {
 	.enable = pmbus_regulator_enable,
 	.disable = pmbus_regulator_disable,
 	.is_enabled = pmbus_regulator_is_enabled,
+	.get_error_flags = pmbus_regulator_get_error_flags,
 };
 EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
 
-- 
2.35.1

