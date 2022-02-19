Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B94BCAEE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbiBSV4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiBSV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:14 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62275468B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so1662162pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t+5B6LvYZGVsC3RYEHxmGkbftMOyxJbez7YJNLu0KHE=;
        b=aMZG0ids+uNPndh1cyCwh2vSTCkuG5aqqdJ/jVm8LjYLl/PohNxzF+Bogj1X01eGgA
         VUJkkonUSbHfr78kn1xUS+s/pWBSiBVxPpIUCQKQN3lktHeCcjIGCSI8wYw8aWvmH8AB
         SVj409alfkBwXv2gn0m0yrGFYcM2xyRYoroSjQJOvzEW5hzFN/2h9saJml6kiCUwnq8H
         saVqhc9PrFgce7gwLWT1mep+GWykmEEX+60Yqx9xFIN9PVguKVamO+mtptv9N46/4sDk
         b2721BTjA60KOxw53Y5NgZHXIJd+18O9FDcUdGVeth/54OsX022OQbfSxqFFHJkwcVC7
         whqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+5B6LvYZGVsC3RYEHxmGkbftMOyxJbez7YJNLu0KHE=;
        b=ZcWg5Eav8s0swbWc0XnwM5B8Q4H26jdLZ+vaKT1YZ81TwKRjQFOU334Jif39A6pk0Y
         JnBkwMNCPBd0avcz512i8rnWGjGHk1kUSPYYX/BVHeA+brZCtK+dnMi8gifpJFfJwx0j
         Gu8yQ0ZKgyT1NDwdB+/r2iEQn1rxiZyhPzwczVvHVyfHeNAwaMEBKRtTMXqQlyaFYrx9
         rBCScA15PZuNr3tlDBYm/h6mRnGI3pafT6U3AUsVI9ADSJMcJU9hn/LMZaAQlqESWaqy
         z/4rvLtBYVzvGzzS73K7GPGbptxMUcbPrUWtDAkzCAXcP0AdtVyz8RT2l3BjqZxby+kj
         8s2w==
X-Gm-Message-State: AOAM530Q9HT2Wc91HhzsO8EYwI93ATpJtNZLRI6i/7+1SLY8AjMlTAfC
        rLD2lokGXPd6hKH5xCP4yHI4qQ==
X-Google-Smtp-Source: ABdhPJwyfHS3ghnsjIwEF90RzGT1P8dhDe8Avt9cgZIMwrN4JBt5Xp8oD5kaPGBxoAenuP43h80mhQ==
X-Received: by 2002:a17:902:7892:b0:14e:c520:e47d with SMTP id q18-20020a170902789200b0014ec520e47dmr12728416pll.105.1645307750121;
        Sat, 19 Feb 2022 13:55:50 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:49 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, s-anna@ti.com,
        khilman@baylibre.com
Subject: [PATCH 08/11] soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling
Date:   Sat, 19 Feb 2022 13:53:25 -0800
Message-Id: <20220219215328.485660-9-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219215328.485660-1-dfustini@baylibre.com>
References: <20220219215328.485660-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/soc/ti/wkup_m3_ipc.c | 93 +++++++++++++++++++++++++++++++++++-
 include/linux/wkup_m3_ipc.h  |  9 ++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index e7ae942b7014..5a1722c3bf1a 100644
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
 
@@ -529,6 +614,12 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	if (of_find_property(np, "ti,set-io-isolation", NULL))
 		wkup_m3_set_io_isolation(m3_ipc);
 
+	ret = of_property_read_string(np, "ti,scale-data-fw",
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

