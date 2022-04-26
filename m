Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D0510995
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354480AbiDZUMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiDZUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:12:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705C16096A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:08:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so3111517pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6QIcs+xFWuzyKmT6GkfiHptzHoBTbTRx8qrcCtwFnc=;
        b=DZtwSDR59d9/nLK1HZwTBNQzX9gSTqZg2xBQrCVREkKHrmPP4sBEZ8HolRQxXAYmFP
         UeAjsisGKJCkOmuVMSD/G+XjDMqkPk3cLw5Gnn3sNIszlqKTpLb9vzuh62xfCQrRKyAL
         7iRqGq3IZY8ZyMH3UyRIdHRAPRcZHYkQtVksDDWqa/+x4G60z0xJb8X1SeXsgBjFiM2X
         Y/BMeF6YfdnAkrgSfMa5RD/DUuAnFuZl8w+a4jxnv9H+mtgiL1w804Y8T3728sPC9I3v
         gPJB8sSEr6HGG6raBwM2IdQ1yEJPl9QATWKPC/1uPA9afIpOfXsdzQ7HIlhSV4VfGq6V
         VZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6QIcs+xFWuzyKmT6GkfiHptzHoBTbTRx8qrcCtwFnc=;
        b=Wk6Tk9P/udFv5Vg6JG/5BNZyGK4QezN+IIJg5huuEz1fmeiqCLlBobD5tFJVdFyqG8
         xQC1u+D4PRKVpwYsfxmr13k384I/GKNKBnnnmnGpuWyu+NHmKbAiIpYXRoxDU4sXGCcZ
         l3vQ1l+Z/6WwH83OxhUZJ9gg9oZxb8ZGrGyGWc4xMvGXmC+cf0vMzgDFsc35gZ33gTSV
         V5If6kfIWCHD2mNioRybMG4aIVeUzYqwan17wl3J0j+24BT+yUb0abUlUq+xtcmhKzR/
         tJ4jkAj+54pYk+0Bd54w8ArYcq/GlDorW6V7qITdKkrYBJIOMlPPcSfSxA4/jojnS3hH
         HZvA==
X-Gm-Message-State: AOAM531Z7/uuwnxrv8O7rMVYtjDeiSzBIYVjI+qB25vJKWbQVLje6IuX
        brapmUx/JOvjgacbDb9VosD9kw==
X-Google-Smtp-Source: ABdhPJwHI8FI0L27+NnbqfEx0gDcABPcjvCE8f8g/FApGB/+/BmsZI5dOFL2TRsiqQXkGghV5QpSxA==
X-Received: by 2002:a17:90b:38cb:b0:1d2:6c52:5be0 with SMTP id nn11-20020a17090b38cb00b001d26c525be0mr28861358pjb.32.1651003736611;
        Tue, 26 Apr 2022 13:08:56 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:9bcd:e060:b370:70d8])
        by smtp.gmail.com with ESMTPSA id o5-20020a62f905000000b0050b5b5efa47sm16203839pfh.191.2022.04.26.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:08:56 -0700 (PDT)
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
Subject: [PATCH v3 2/2] soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling
Date:   Tue, 26 Apr 2022 13:07:44 -0700
Message-Id: <20220426200741.712842-3-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426200741.712842-1-dfustini@baylibre.com>
References: <20220426200741.712842-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes from v2:
- None

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

