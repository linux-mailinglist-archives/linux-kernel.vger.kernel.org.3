Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335E510913
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354167AbiDZTfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiDZTfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:35:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF61101761
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:31:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso3054983pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFkswMgpne+UcrkFhk762yyJlUSfm2r0QU+c4khVfyo=;
        b=W/nsavgFAZLbWFtHtX1hWcbBSa/v9kPWsQDeV29u0q2W/70Ry95HPXUGxz/dG4KYGZ
         4BxyGMTU0QDjcC59+lrxQzyHq3l62blG9lOiVBjnH+nvdGGpj2+P0Gf6sgVZ4898Ggds
         zhaJkIHj+DTdEbed3njXfPSpTJsuywMscqm7btnhB055sqSG+dicTz7kZVItZVTM2Xq4
         WeBJ5ZQCXL17YgtGhJcJbmCvT8hngwZ0SIJfAA2TNPr4uD+kNpMJE+5tQ6z2xvl9jv+X
         uQLibxfRzgXIsnRkoYMjQQtaqwZarpLBk69gyP/akdabEQs1gXBR3LcNh5kE5kghbG2d
         D5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFkswMgpne+UcrkFhk762yyJlUSfm2r0QU+c4khVfyo=;
        b=2QQU2pAU6/HbAlmIWodY9zp/flfzTp36RQd2wscAuqGYwsdkSSiWTiA9tqfjYCQNti
         ieBdB3/XKSB2/1+a1my80+oH0FyY6oqjxY50eZj3sHe2XLPGv1e/UfU0kOZTZpibnR39
         0CkAwrISYsRgxHPUqCrx0LZ4bbe4ImrcAqszSVFq1cykZsVeNL1PRlAUWTkU+HJcHwZl
         NBtcZwAJ0cQ0Pg6p1mEpEelXhy3fdvBmDCc+1nq48enkebxD0bZpdJHUiR4nRGzWjUXK
         NajoDTFfSrh9cGo/RnyR2TpxSsBWmu2IcYif5xsHh+Hy0EpNttyZK6VEUyukQgYwoEmX
         qEaw==
X-Gm-Message-State: AOAM532zpYB0UELZrcAnc92UFeVesnAS4DgyqLJiXse2PgoP4COm+GD/
        85cLyRI/k2Jt/I4UwEHhDphIYQ==
X-Google-Smtp-Source: ABdhPJwpv7Jy4MbU9KYijX29TOmNV1w8YtFKr5tWpxisyZZR26TAMCX4qT6XXtW/sh0Z6PYI/wqLYw==
X-Received: by 2002:a17:90b:4f45:b0:1d9:91df:ad2f with SMTP id pj5-20020a17090b4f4500b001d991dfad2fmr9885003pjb.4.1651001516857;
        Tue, 26 Apr 2022 12:31:56 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:9bcd:e060:b370:70d8])
        by smtp.gmail.com with ESMTPSA id v16-20020a62a510000000b0050759c9a891sm15793410pfm.6.2022.04.26.12.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:31:56 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/2] soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling
Date:   Tue, 26 Apr 2022 12:32:53 -0700
Message-Id: <20220426193253.663582-3-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426193253.663582-1-dfustini@baylibre.com>
References: <20220426193253.663582-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Allow loading of a binary containing i2c scaling sequences to be
provided to the wkup_m3 firmware in order to properly scale voltage
rails on the PMIC during low power modes like DeepSleep0. Proper binary
format is determined by the FW in use.

Code expects firmware to have 0x0C57 present as the first two bytes
followed by one byte defining offset to sleep sequence followed by one
byte defining offset to wake sequence and then lastly both sequences.
Each sequence is a series of I2C transfers in the form:

u8 length | u8 chip address | u8 byte0/reg address | u8 byte1 | u8 byteN
..

The length indicates the number of bytes to transfer, including the
register address. The length of each transfer is limited by the I2C
buffer size of 32 bytes.

Based on previous work by Russ Dill.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
[dfustini: add NULL argument to rproc_da_to_va() call]
[dfustini: replace FW_ACTION_HOTPLUG with FW_ACTION_UEVENT]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Changes from v1:
- change 'ti,scale-data-fw' to 'firmware-name'

 drivers/soc/ti/wkup_m3_ipc.c | 93 +++++++++++++++++++++++++++++++++++-
 include/linux/wkup_m3_ipc.h  |  9 ++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 988162dd153a..c35eaecf4ab4 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
@@ -55,6 +56,12 @@
 #define M3_STATE_MSG_FOR_LP		3
 #define M3_STATE_MSG_FOR_RESET		4
 
+#define WKUP_M3_SD_FW_MAGIC		0x570C
+
+#define WKUP_M3_DMEM_START		0x80000
+#define WKUP_M3_AUXDATA_OFFSET		0x1000
+#define WKUP_M3_AUXDATA_SIZE		0xFF
+
 static struct wkup_m3_ipc *m3_ipc_state;
 
 static const struct wkup_m3_wakeup_src wakeups[] = {
@@ -75,6 +82,81 @@ static const struct wkup_m3_wakeup_src wakeups[] = {
 	{.irq_nr = 0,	.src = "Unknown"},
 };
 
+/**
+ * wkup_m3_copy_aux_data - Copy auxiliary data to special region of m3 dmem
+ * @data - pointer to data
+ * @sz - size of data to copy (limit 256 bytes)
+ *
+ * Copies any additional blob of data to the wkup_m3 dmem to be used by the
+ * firmware
+ */
+static unsigned long wkup_m3_copy_aux_data(struct wkup_m3_ipc *m3_ipc,
+					   const void *data, int sz)
+{
+	unsigned long aux_data_dev_addr;
+	void *aux_data_addr;
+
+	aux_data_dev_addr = WKUP_M3_DMEM_START + WKUP_M3_AUXDATA_OFFSET;
+	aux_data_addr = rproc_da_to_va(m3_ipc->rproc,
+				       aux_data_dev_addr,
+				       WKUP_M3_AUXDATA_SIZE,
+				       NULL);
+	memcpy(aux_data_addr, data, sz);
+
+	return WKUP_M3_AUXDATA_OFFSET;
+}
+
+static void wkup_m3_scale_data_fw_cb(const struct firmware *fw, void *context)
+{
+	unsigned long val, aux_base;
+	struct wkup_m3_scale_data_header hdr;
+	struct wkup_m3_ipc *m3_ipc = context;
+	struct device *dev = m3_ipc->dev;
+
+	if (!fw) {
+		dev_err(dev, "Voltage scale fw name given but file missing.\n");
+		return;
+	}
+
+	memcpy(&hdr, fw->data, sizeof(hdr));
+
+	if (hdr.magic != WKUP_M3_SD_FW_MAGIC) {
+		dev_err(dev, "PM: Voltage Scale Data binary does not appear valid.\n");
+		goto release_sd_fw;
+	}
+
+	aux_base = wkup_m3_copy_aux_data(m3_ipc, fw->data + sizeof(hdr),
+					 fw->size - sizeof(hdr));
+
+	val = (aux_base + hdr.sleep_offset);
+	val |= ((aux_base + hdr.wake_offset) << 16);
+
+	m3_ipc->volt_scale_offsets = val;
+
+release_sd_fw:
+	release_firmware(fw);
+};
+
+static int wkup_m3_init_scale_data(struct wkup_m3_ipc *m3_ipc,
+				   struct device *dev)
+{
+	int ret = 0;
+
+	/*
+	 * If no name is provided, user has already been warned, pm will
+	 * still work so return 0
+	 */
+
+	if (!m3_ipc->sd_fw_name)
+		return ret;
+
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+				      m3_ipc->sd_fw_name, dev, GFP_ATOMIC,
+				      m3_ipc, wkup_m3_scale_data_fw_cb);
+
+	return ret;
+}
+
 static void am33xx_txev_eoi(struct wkup_m3_ipc *m3_ipc)
 {
 	writel(AM33XX_M3_TXEV_ACK,
@@ -139,6 +221,7 @@ static irqreturn_t wkup_m3_txev_handler(int irq, void *ipc_data)
 		}
 
 		m3_ipc->state = M3_STATE_INITED;
+		wkup_m3_init_scale_data(m3_ipc, dev);
 		complete(&m3_ipc->sync_complete);
 		break;
 	case M3_STATE_MSG_FOR_RESET:
@@ -300,12 +383,15 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 	switch (state) {
 	case WKUP_M3_DEEPSLEEP:
 		m3_power_state = IPC_CMD_DS0;
+		wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->volt_scale_offsets, 5);
 		break;
 	case WKUP_M3_STANDBY:
 		m3_power_state = IPC_CMD_STANDBY;
+		wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 5);
 		break;
 	case WKUP_M3_IDLE:
 		m3_power_state = IPC_CMD_IDLE;
+		wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 5);
 		break;
 	default:
 		return 1;
@@ -319,7 +405,6 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 			       m3_ipc->isolation_conf, 4);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 2);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 3);
-	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 5);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 6);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 7);
 
@@ -528,6 +613,12 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	if (of_find_property(np, "ti,set-io-isolation", NULL))
 		wkup_m3_set_io_isolation(m3_ipc);
 
+	ret = of_property_read_string(np, "firmware-name",
+				      &m3_ipc->sd_fw_name);
+	if (ret) {
+		dev_dbg(dev, "Voltage scaling data blob not provided from DT.\n");
+	};
+
 	/*
 	 * Wait for firmware loading completion in a thread so we
 	 * can boot the wkup_m3 as soon as it's ready without holding
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index b706eac58f92..fef0fac60f8c 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -37,6 +37,9 @@ struct wkup_m3_ipc {
 	int isolation_conf;
 	int state;
 
+	unsigned long volt_scale_offsets;
+	const char *sd_fw_name;
+
 	struct completion sync_complete;
 	struct mbox_client mbox_client;
 	struct mbox_chan *mbox;
@@ -50,6 +53,12 @@ struct wkup_m3_wakeup_src {
 	char src[10];
 };
 
+struct wkup_m3_scale_data_header {
+	u16 magic;
+	u8 sleep_offset;
+	u8 wake_offset;
+} __packed;
+
 struct wkup_m3_ipc_ops {
 	void (*set_mem_type)(struct wkup_m3_ipc *m3_ipc, int mem_type);
 	void (*set_resume_address)(struct wkup_m3_ipc *m3_ipc, void *addr);
-- 
2.32.0

