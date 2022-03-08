Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C14D1948
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiCHNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiCHNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:37:31 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941FF496A0;
        Tue,  8 Mar 2022 05:36:33 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6AA27200008;
        Tue,  8 Mar 2022 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646746592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LUCMaYTWqiKx7LqcNaU/7e75EOSuDoqcd8vHOCDL/Eo=;
        b=FgvAwVzsb7DBuXYXfg8s+dFP5z7Jzpm1pUOHTlIfI4zvR9NqLg5uQW5vzzrk4hfHNFSobB
        mv2v3ow98i2gC7JsDcLyPS6F6AzOVeJDUTxCBzuKbezYq62W0WkTie0X2hpdsvXCF7gyaP
        9oypJ7HIrXpTNRPJYzHkErByrYmo91y1e+LVs4q9pmA37AkFJ51vbpzrEGaUlKV06mlNfq
        JW6Dt+zN0gnaCJbc/Iks3X9PWWoyrIxMk00Nifll+s5nBkwAHh+nVxDbOMvpIJojvT2iHM
        2iAALAKB5ogX2VkHh2tLjYnSQ+FFg485run+P4g3ncVDUYsxcMLos9UH9JsZrw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v4] rtc: optee: add RTC driver for OP-TEE RTC PTA
Date:   Tue,  8 Mar 2022 14:35:05 +0100
Message-Id: <20220308133505.471601-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
This PTA allows to query RTC information, set/get time and set/get
offset depending on the supported features.

[1] https://github.com/OP-TEE/optee_os/pull/5179

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---

Changes in v4:
 - Remove error prints except the ones in probe

Changes in v3 (was resent as a second v2 due to a mistake);
 - Fix error messages to include ret value and fix wrong IOCTL names
 - Use 100 columns char limit

Changes in v2:
 - Rebased over tee-shm-for-v5.18
 - Switch to tee_shm_alloc_kernel_buf()
 - Use export_uuid() to copy uuid
 - Fix warnings reported by checkpatch
 - Free SHM in error exit path

 MAINTAINERS             |   6 +
 drivers/rtc/Kconfig     |  10 ++
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-optee.c | 362 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 drivers/rtc/rtc-optee.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..b21375ad73d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14361,6 +14361,12 @@ L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
 
+OP-TEE RTC DRIVER
+M:	Clément Léger <clement.leger@bootlin.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	drivers/rtc/rtc-optee.c
+
 OPA-VNIC DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
 M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d85a3c31347c..cba5427f79b3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1293,6 +1293,16 @@ config RTC_DRV_OPAL
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-opal.
 
+config RTC_DRV_OPTEE
+	tristate "OP-TEE based RTC driver"
+	depends on OPTEE
+	help
+	  Select this to get support for OP-TEE based RTC control on SoCs where
+	  RTC are not accessible to the normal world (Linux).
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-optee.
+
 config RTC_DRV_ZYNQMP
 	tristate "Xilinx Zynq Ultrascale+ MPSoC RTC"
 	depends on OF && HAS_IOMEM
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e92f3e943245..2d827d8261d5 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_RTC_DRV_GAMECUBE)	+= rtc-gamecube.o
 obj-$(CONFIG_RTC_DRV_NTXEC)	+= rtc-ntxec.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
+obj-$(CONFIG_RTC_DRV_OPTEE)	+= rtc-optee.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+= rtc-palmas.o
 obj-$(CONFIG_RTC_DRV_PCAP)	+= rtc-pcap.o
 obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
new file mode 100644
index 000000000000..9f8b5d4a8f6b
--- /dev/null
+++ b/drivers/rtc/rtc-optee.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Microchip.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/tee_drv.h>
+
+#define RTC_INFO_VERSION	0x1
+
+#define TA_CMD_RTC_GET_INFO		0x0
+#define TA_CMD_RTC_GET_TIME		0x1
+#define TA_CMD_RTC_SET_TIME		0x2
+#define TA_CMD_RTC_GET_OFFSET		0x3
+#define TA_CMD_RTC_SET_OFFSET		0x4
+
+#define TA_RTC_FEATURE_CORRECTION	BIT(0)
+
+struct optee_rtc_time {
+	u32 tm_sec;
+	u32 tm_min;
+	u32 tm_hour;
+	u32 tm_mday;
+	u32 tm_mon;
+	u32 tm_year;
+	u32 tm_wday;
+};
+
+struct optee_rtc_info {
+	u64 version;
+	u64 features;
+	struct optee_rtc_time range_min;
+	struct optee_rtc_time range_max;
+};
+
+/**
+ * struct optee_rtc - OP-TEE RTC private data
+ * @dev:		OP-TEE based RTC device.
+ * @ctx:		OP-TEE context handler.
+ * @session_id:		RTC TA session identifier.
+ * @shm:		Memory pool shared with RTC device.
+ * @features:		Bitfield of RTC features
+ */
+struct optee_rtc {
+	struct device *dev;
+	struct tee_context *ctx;
+	u32 session_id;
+	struct tee_shm *shm;
+	u64 features;
+};
+
+static int optee_rtc_readtime(struct device *dev, struct rtc_time *tm)
+{
+	struct optee_rtc *priv = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct optee_rtc_time *optee_tm;
+	struct tee_param param[4] = {0};
+	int ret;
+
+	inv_arg.func = TA_CMD_RTC_GET_TIME;
+	inv_arg.session = priv->session_id;
+	inv_arg.num_params = 4;
+
+	/* Fill invoke cmd params */
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[0].u.memref.shm = priv->shm;
+	param[0].u.memref.size = sizeof(struct optee_rtc_time);
+
+	ret = tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0)
+		return ret ? ret : -EPROTO;
+
+	optee_tm = tee_shm_get_va(priv->shm, 0);
+	if (IS_ERR(optee_tm))
+		return PTR_ERR(optee_tm);
+
+	if (param[0].u.memref.size != sizeof(*optee_tm))
+		return -EPROTO;
+
+	tm->tm_sec = optee_tm->tm_sec;
+	tm->tm_min = optee_tm->tm_min;
+	tm->tm_hour = optee_tm->tm_hour;
+	tm->tm_mday = optee_tm->tm_mday;
+	tm->tm_mon = optee_tm->tm_mon;
+	tm->tm_year = optee_tm->tm_year - 1900;
+	tm->tm_wday = optee_tm->tm_wday;
+	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
+
+	return 0;
+}
+
+static int optee_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct optee_rtc *priv = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct tee_param param[4] = {0};
+	struct optee_rtc_time optee_tm;
+	void *rtc_data;
+	int ret;
+
+	optee_tm.tm_sec = tm->tm_sec;
+	optee_tm.tm_min = tm->tm_min;
+	optee_tm.tm_hour = tm->tm_hour;
+	optee_tm.tm_mday = tm->tm_mday;
+	optee_tm.tm_mon = tm->tm_mon;
+	optee_tm.tm_year = tm->tm_year + 1900;
+	optee_tm.tm_wday = tm->tm_wday;
+
+	inv_arg.func = TA_CMD_RTC_SET_TIME;
+	inv_arg.session = priv->session_id;
+	inv_arg.num_params = 4;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm = priv->shm;
+	param[0].u.memref.size = sizeof(struct optee_rtc_time);
+
+	rtc_data = tee_shm_get_va(priv->shm, 0);
+	if (IS_ERR(rtc_data))
+		return PTR_ERR(rtc_data);
+
+	memcpy(rtc_data, &optee_tm, sizeof(struct optee_rtc_time));
+
+	ret = tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0)
+		return ret ? ret : -EPROTO;
+
+	return 0;
+}
+
+static int optee_rtc_readoffset(struct device *dev, long *offset)
+{
+	struct optee_rtc *priv = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct tee_param param[4] = {0};
+	int ret;
+
+	if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
+		return -EOPNOTSUPP;
+
+	inv_arg.func = TA_CMD_RTC_GET_OFFSET;
+	inv_arg.session = priv->session_id;
+	inv_arg.num_params = 4;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret = tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0)
+		return ret ? ret : -EPROTO;
+
+	*offset = param[0].u.value.a;
+
+	return 0;
+}
+
+static int optee_rtc_setoffset(struct device *dev, long offset)
+{
+	struct optee_rtc *priv = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct tee_param param[4] = {0};
+	int ret;
+
+	if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
+		return -EOPNOTSUPP;
+
+	inv_arg.func = TA_CMD_RTC_SET_OFFSET;
+	inv_arg.session = priv->session_id;
+	inv_arg.num_params = 4;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a = offset;
+
+	ret = tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0)
+		return ret ? ret : -EPROTO;
+
+	return 0;
+}
+
+static const struct rtc_class_ops optee_rtc_ops = {
+	.read_time	= optee_rtc_readtime,
+	.set_time	= optee_rtc_settime,
+	.set_offset	= optee_rtc_setoffset,
+	.read_offset	= optee_rtc_readoffset,
+};
+
+static int optee_rtc_read_info(struct device *dev, struct rtc_device *rtc,
+			       u64 *features)
+{
+	struct optee_rtc *priv = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct tee_param param[4] = {0};
+	struct optee_rtc_info *info;
+	struct optee_rtc_time *tm;
+	int ret;
+
+	inv_arg.func = TA_CMD_RTC_GET_INFO;
+	inv_arg.session = priv->session_id;
+	inv_arg.num_params = 4;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[0].u.memref.shm = priv->shm;
+	param[0].u.memref.size = sizeof(*info);
+
+	ret = tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0)
+		return ret ? ret : -EPROTO;
+
+	info = tee_shm_get_va(priv->shm, 0);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	if (param[0].u.memref.size != sizeof(*info))
+		return -EPROTO;
+
+	if (info->version != RTC_INFO_VERSION)
+		return -EPROTO;
+
+	*features = info->features;
+
+	tm = &info->range_min;
+	rtc->range_min = mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_hour, tm->tm_min,
+				  tm->tm_sec);
+	tm = &info->range_max;
+	rtc->range_max = mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_hour, tm->tm_min,
+				  tm->tm_sec);
+
+	return 0;
+}
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+static int optee_rtc_probe(struct device *dev)
+{
+	struct tee_client_device *rtc_device = to_tee_client_device(dev);
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct optee_rtc *priv;
+	struct rtc_device *rtc;
+	struct tee_shm *shm;
+	int ret, err;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	/* Open context with TEE driver */
+	priv->ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(priv->ctx))
+		return -ENODEV;
+
+	/* Open session with rtc Trusted App */
+	export_uuid(sess_arg.uuid, &rtc_device->id.uuid);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+
+	ret = tee_client_open_session(priv->ctx, &sess_arg, NULL);
+	if (ret < 0 || sess_arg.ret != 0) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n", sess_arg.ret);
+		err = -EINVAL;
+		goto out_ctx;
+	}
+	priv->session_id = sess_arg.session;
+
+	shm = tee_shm_alloc_kernel_buf(priv->ctx, sizeof(struct optee_rtc_info));
+	if (IS_ERR(shm)) {
+		dev_err(priv->dev, "tee_shm_alloc_kernel_buf failed\n");
+		err = PTR_ERR(shm);
+		goto out_sess;
+	}
+
+	priv->shm = shm;
+	priv->dev = dev;
+	dev_set_drvdata(dev, priv);
+
+	rtc->ops = &optee_rtc_ops;
+
+	err = optee_rtc_read_info(dev, rtc, &priv->features);
+	if (err) {
+		dev_err(dev, "Failed to get RTC features from OP-TEE\n");
+		goto out_shm;
+	}
+
+	err = devm_rtc_register_device(rtc);
+	if (err)
+		goto out_shm;
+
+	/*
+	 * We must clear this bit after registering because rtc_register_device
+	 * will set it if it sees that .set_offset is provided.
+	 */
+	if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
+		clear_bit(RTC_FEATURE_CORRECTION, rtc->features);
+
+	return 0;
+
+out_shm:
+	tee_shm_free(priv->shm);
+out_sess:
+	tee_client_close_session(priv->ctx, priv->session_id);
+out_ctx:
+	tee_client_close_context(priv->ctx);
+
+	return err;
+}
+
+static int optee_rtc_remove(struct device *dev)
+{
+	struct optee_rtc *priv = dev_get_drvdata(dev);
+
+	tee_client_close_session(priv->ctx, priv->session_id);
+	tee_client_close_context(priv->ctx);
+
+	return 0;
+}
+
+static const struct tee_client_device_id optee_rtc_id_table[] = {
+	{UUID_INIT(0xf389f8c8, 0x845f, 0x496c,
+		   0x8b, 0xbe, 0xd6, 0x4b, 0xd2, 0x4c, 0x92, 0xfd)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(tee, optee_rtc_id_table);
+
+static struct tee_client_driver optee_rtc_driver = {
+	.id_table	= optee_rtc_id_table,
+	.driver		= {
+		.name		= "optee_rtc",
+		.bus		= &tee_bus_type,
+		.probe		= optee_rtc_probe,
+		.remove		= optee_rtc_remove,
+	},
+};
+
+static int __init optee_rtc_mod_init(void)
+{
+	return driver_register(&optee_rtc_driver.driver);
+}
+
+static void __exit optee_rtc_mod_exit(void)
+{
+	driver_unregister(&optee_rtc_driver.driver);
+}
+
+module_init(optee_rtc_mod_init);
+module_exit(optee_rtc_mod_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Clément Léger <clement.leger@bootlin.com>");
+MODULE_DESCRIPTION("OP-TEE based RTC driver");
-- 
2.34.1

