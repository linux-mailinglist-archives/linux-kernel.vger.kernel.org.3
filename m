Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC1F4BCADC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbiBSV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbiBSV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4454197
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:44 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so11685193pjm.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DPqC7sk0jXG3KL4pgR3flZBRy+4blHrbIS6/yBS27Mg=;
        b=RCOdYH6WIaW2xVqRGFA32u3oOOKisUBbxh2bQZ6OLEuubkB37e/DLlUPUI/qS7ZsPp
         K9vvLxcUrbv9BMjXSg9sciDkhvYNEdsasmZcb9Ita6e1im3+L2SufG4wk2DJXmvo5pK+
         Wx2IcMPhbQ1baTb9PqWZsTEBmfmjFo8u1nF5FRQu3fsbnEslXRYQAawKzZ/FeLpMmYU+
         P3YLroiH1jtnPz8t/uPk7nZkuRosB1f+3Lu82Nd6FqbNMUN3ETXpC3qUUkI2D6KutTCV
         MvLoFxsc1KMYD2sK6O4571yQv32Zu02CNtmn8AKwLrNsFHFGSBRAnJHyhvH6+ZTianzC
         Gd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPqC7sk0jXG3KL4pgR3flZBRy+4blHrbIS6/yBS27Mg=;
        b=aabeinzV/rAMczB4iSNED1nM8X4ogOtd1In372gqWHGI1KU4lQrgGEXevqVCNWc+Ea
         /ZMj8At5rJVJLgN1457adCqabLlXDbhovcKKL5sQ1m89IXt03lPDzZMFHMpRLPhb18gx
         O505PYJAMc1rLNdEaeD2NW+p2ZCbsOS37g+G2nczBRW5Aw91zUHB5Hh/Nu91qeuVr9+C
         BcvMAPrya6UibMZUizhFrarqBibjNzYFefFOJYRZrdy+pfSyxZ9r0Bpr/ZvGHPrnkhT1
         YU5N1DY/a5GJGDICDrXSEBps7xzk4l9X9O/JNfnGl2iGtIPNtS9jQgyNy0c7pxPRQ7Hd
         Xxsw==
X-Gm-Message-State: AOAM533OheqhaW6JShzI0sobjAaSh2/7bIlF3cW4MG/yHxyziXPS2ivI
        umvqMAxHCBINj1jT+ncu5m5KLbj8wLrsbU7uQsQ=
X-Google-Smtp-Source: ABdhPJyrjgGWD8uK2oJsFpdirNDfgtzWoV5CCSu0s9ORmrFOQ1CeFPo+nYa0r4tS45fI/XS//g8JLQ==
X-Received: by 2002:a17:90a:9309:b0:1bc:1bf1:dad4 with SMTP id p9-20020a17090a930900b001bc1bf1dad4mr1336912pjo.169.1645307744093;
        Sat, 19 Feb 2022 13:55:44 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:43 -0800 (PST)
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
Subject: [PATCH 03/11] soc: ti: wkup_m3_ipc: Add support for toggling VTT regulator
Date:   Sat, 19 Feb 2022 13:53:20 -0800
Message-Id: <20220219215328.485660-4-dfustini@baylibre.com>
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

Some boards (currently AM335x EVM-SK) provides s/w control via
GPIO to toggle VTT regulator to reduce power consumption in low
power state.

The VTT regulator should be disabled after enabling self-refresh on
suspend, and should be enabled before disabling self-refresh on resume.
This is to allow proper self-refresh entry/exit commands to be
transmitted to the memory.

Add support for toggling VTT regulator using DT properties.
Actual toggling happens in CM3 Firmware. The enable option & the GPIO
pin used is collected in A8 Core and then sent to CM3 using IPC
registers.

Note:
Here it is assumed that VTT Toggle will be done using a pin on GPIO-0
Instance. The reason is GPIO-0 is in wakeup domain.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 27 +++++++++++++++++++++++++--
 include/linux/wkup_m3_ipc.h  |  1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 72386bd393fe..974b4118a893 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -40,6 +40,13 @@
 #define M3_FW_VERSION_MASK		0xffff
 #define M3_WAKE_SRC_MASK		0xff
 
+#define IPC_MEM_TYPE_SHIFT		(0x0)
+#define IPC_MEM_TYPE_MASK		(0x7 << 0)
+#define IPC_VTT_STAT_SHIFT		(0x3)
+#define IPC_VTT_STAT_MASK		(0x1 << 3)
+#define IPC_VTT_GPIO_PIN_SHIFT		(0x4)
+#define IPC_VTT_GPIO_PIN_MASK		(0x3f << 4)
+
 #define M3_STATE_UNKNOWN		0
 #define M3_STATE_RESET			1
 #define M3_STATE_INITED			2
@@ -215,6 +222,12 @@ static int wkup_m3_is_available(struct wkup_m3_ipc *m3_ipc)
 		(m3_ipc->state != M3_STATE_UNKNOWN));
 }
 
+static void wkup_m3_set_vtt_gpio(struct wkup_m3_ipc *m3_ipc, int gpio)
+{
+	m3_ipc->vtt_conf = (1 << IPC_VTT_STAT_SHIFT) |
+			    (gpio << IPC_VTT_GPIO_PIN_SHIFT);
+}
+
 /* Public functions */
 /**
  * wkup_m3_set_mem_type - Pass wkup_m3 which type of memory is in use
@@ -294,7 +307,8 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 	/* Program each required IPC register then write defaults to others */
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->resume_addr, 0);
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_power_state, 1);
-	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->mem_type, 4);
+	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->mem_type |
+			       m3_ipc->vtt_conf, 4);
 
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 2);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 3);
@@ -433,12 +447,13 @@ static int wkup_m3_rproc_boot_thread(void *arg)
 static int wkup_m3_ipc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	int irq, ret;
+	int irq, ret, temp;
 	phandle rproc_phandle;
 	struct rproc *m3_rproc;
 	struct resource *res;
 	struct task_struct *task;
 	struct wkup_m3_ipc *m3_ipc;
+	struct device_node *np = dev->of_node;
 
 	m3_ipc = devm_kzalloc(dev, sizeof(*m3_ipc), GFP_KERNEL);
 	if (!m3_ipc)
@@ -496,6 +511,14 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 
 	m3_ipc->ops = &ipc_ops;
 
+	if (of_find_property(np, "ti,needs-vtt-toggle", NULL) &&
+	    !(of_property_read_u32(np, "ti,vtt-gpio-pin", &temp))) {
+		if (temp >= 0 && temp <= 31)
+			wkup_m3_set_vtt_gpio(m3_ipc, temp);
+		else
+			dev_warn(dev, "Invalid VTT GPIO(%d) pin\n", temp);
+	}
+
 	/*
 	 * Wait for firmware loading completion in a thread so we
 	 * can boot the wkup_m3 as soon as it's ready without holding
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index 3f496967b538..2bc52c6381d5 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -33,6 +33,7 @@ struct wkup_m3_ipc {
 
 	int mem_type;
 	unsigned long resume_addr;
+	int vtt_conf;
 	int state;
 
 	struct completion sync_complete;
-- 
2.32.0

