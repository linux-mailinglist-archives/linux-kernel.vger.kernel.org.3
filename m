Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F751699B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357160AbiEBDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEBDp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:45:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDD45060
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 20:42:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k1so2955998pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 20:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhMy0JI7nNqcQppVA0JnYf0znLff5xYbmdVFPc+7KFQ=;
        b=ChL4RwRqNvbXjaSPkV0XOY0AhGcyDG9VMONy6kHgvW0Up2Ct3NrlwsQ8JPPPgxhxzx
         MyHet0Q8sDBWDLzfsKwdb8kC1fZQUjdhMTKmd6bqo5Bn98pct4S58/gI1ScGiCsjtyy0
         HULbiWyczH59s7EOEMjnL4nOFAOWSn5JsqIdVpmOCR6flpN/Z/O/kMvAnuRbFNFjLuVW
         SCzFmWTI4Q3K8EQE5jFn3mqh53rdRAMCtj8ZUKUbTKx/6U6ueg/QAc3OQ8CLl+GiRpgk
         s9Gxm4imDmYRi0Qsc5um+i4MzvnuLQT0p9xlBpSC7Z9spKmy+dP96bvyOVsywCYkFJGi
         GMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhMy0JI7nNqcQppVA0JnYf0znLff5xYbmdVFPc+7KFQ=;
        b=wbU64viq0l91X2U+wSaUuG8ZjxU9GYgQvW+NgdcdSJBrTz1NB5zniF6t0SPcdklajj
         Bi67KI2MY92+ADVPCmKeRxckr5cnsfDLNC1NaY6JtC59Rk/Ogh7fWGAhvCJWQIRFnvwq
         0kAd6YFQQXgSZFDNaYi9zupa5zPWFcBxrAniy5fxalJPbcBMC/9Aw2LGQTxjjb/ftN4I
         nlkX+nFxknSbvt6BRXvfSDGUkUkJwsSlXlgLTqDKIAOpbyBBHQycj2LKU41beibbGWtO
         P5R+0l4Wp6VqlFrE/lalFpRkWVOW3Z7rUztpL8KUVZcQjmfL8f/n56Q69BX7G9L6dxsn
         Bscg==
X-Gm-Message-State: AOAM530P7YqL8CAWq1pxW/ZD1fJl+tfx1SPiSRMJPZtKjX4T5jD0+yyg
        teF0Fp+pc/m5lk21f6xHd0uUdg==
X-Google-Smtp-Source: ABdhPJxQ9L5CeBdFW4cwMPIBeK3305HYCgwmo/7c5uyUgh63G1/L1nCkVvbO8lV2mxdW6FmybkuIGw==
X-Received: by 2002:a17:902:b948:b0:153:9994:b587 with SMTP id h8-20020a170902b94800b001539994b587mr10048888pls.68.1651462920135;
        Sun, 01 May 2022 20:42:00 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:c18e:6070:88f2:a04d])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b0050dc7628131sm3677842pfo.11.2022.05.01.20.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 20:41:59 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>,
        Brad Griffis <bgriffis@ti.com>, Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] soc: ti: wkup_m3_ipc: Add debug option to halt m3 in suspend
Date:   Sun,  1 May 2022 20:32:12 -0700
Message-Id: <20220502033211.1383158-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add a debugfs option to allow configurable halting of the wkup_m3
during suspend at the last possible point before low power mode entry.
This condition can only be resolved through JTAG and advancing beyond
the while loop in a8_lp_ds0_handler [1]. Although this hangs the system
it forces the system to remain active once it has been entirely
configured for low power mode entry, allowing for register inspection
through JTAG to help in debugging transition errors.

Halt mode can be set using the enable_off_mode entry under wkup_m3_ipc
in the debugfs.

[1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/tree/src/pm_services/pm_handlers.c?h=08.02.00.006#n141

Suggested-by: Brad Griffis <bgriffis@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: add link for a8_lp_ds0_handler() in ti-amx3-cm3-pm-firmware]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 79 +++++++++++++++++++++++++++++++++++-
 include/linux/wkup_m3_ipc.h  |  2 +
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index c35eaecf4ab4..19bed465ad94 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -7,6 +7,7 @@
  * Dave Gerlach <d-gerlach@ti.com>
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/firmware.h>
 #include <linux/kernel.h>
@@ -50,6 +51,9 @@
 #define IPC_IO_ISOLATION_STAT_SHIFT	(10)
 #define IPC_IO_ISOLATION_STAT_MASK	(0x1 << 10)
 
+#define IPC_DBG_HALT_SHIFT		(11)
+#define IPC_DBG_HALT_MASK		(0x1 << 11)
+
 #define M3_STATE_UNKNOWN		0
 #define M3_STATE_RESET			1
 #define M3_STATE_INITED			2
@@ -157,6 +161,73 @@ static int wkup_m3_init_scale_data(struct wkup_m3_ipc *m3_ipc,
 	return ret;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static void wkup_m3_set_halt_late(bool enabled)
+{
+	if (enabled)
+		m3_ipc_state->halt = (1 << IPC_DBG_HALT_SHIFT);
+	else
+		m3_ipc_state->halt = 0;
+}
+
+static int option_get(void *data, u64 *val)
+{
+	u32 *option = data;
+
+	*val = *option;
+
+	return 0;
+}
+
+static int option_set(void *data, u64 val)
+{
+	u32 *option = data;
+
+	*option = val;
+
+	if (option == &m3_ipc_state->halt) {
+		if (val)
+			wkup_m3_set_halt_late(true);
+		else
+			wkup_m3_set_halt_late(false);
+	}
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(wkup_m3_ipc_option_fops, option_get, option_set,
+			"%llu\n");
+
+static int wkup_m3_ipc_dbg_init(struct wkup_m3_ipc *m3_ipc)
+{
+	m3_ipc->dbg_path = debugfs_create_dir("wkup_m3_ipc", NULL);
+
+	if (!m3_ipc->dbg_path)
+		return -EINVAL;
+
+	(void)debugfs_create_file("enable_late_halt", 0644,
+				  m3_ipc->dbg_path,
+				  &m3_ipc->halt,
+				  &wkup_m3_ipc_option_fops);
+
+	return 0;
+}
+
+static inline void wkup_m3_ipc_dbg_destroy(struct wkup_m3_ipc *m3_ipc)
+{
+	debugfs_remove_recursive(m3_ipc->dbg_path);
+}
+#else
+static inline int wkup_m3_ipc_dbg_init(struct wkup_m3_ipc *m3_ipc)
+{
+	return 0;
+}
+
+static inline void wkup_m3_ipc_dbg_destroy(struct wkup_m3_ipc *m3_ipc)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static void am33xx_txev_eoi(struct wkup_m3_ipc *m3_ipc)
 {
 	writel(AM33XX_M3_TXEV_ACK,
@@ -402,7 +473,9 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_power_state, 1);
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->mem_type |
 			       m3_ipc->vtt_conf |
-			       m3_ipc->isolation_conf, 4);
+			       m3_ipc->isolation_conf |
+			       m3_ipc->halt, 4);
+
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 2);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 3);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 6);
@@ -633,6 +706,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
+	wkup_m3_ipc_dbg_init(m3_ipc);
+
 	return 0;
 
 err_put_rproc:
@@ -644,6 +719,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 
 static int wkup_m3_ipc_remove(struct platform_device *pdev)
 {
+	wkup_m3_ipc_dbg_destroy(m3_ipc_state);
+
 	mbox_free_channel(m3_ipc_state->mbox);
 
 	rproc_shutdown(m3_ipc_state->rproc);
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index fef0fac60f8c..26d1eb058fa3 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -36,6 +36,7 @@ struct wkup_m3_ipc {
 	int vtt_conf;
 	int isolation_conf;
 	int state;
+	u32 halt;
 
 	unsigned long volt_scale_offsets;
 	const char *sd_fw_name;
@@ -46,6 +47,7 @@ struct wkup_m3_ipc {
 
 	struct wkup_m3_ipc_ops *ops;
 	int is_rtc_only;
+	struct dentry *dbg_path;
 };
 
 struct wkup_m3_wakeup_src {
-- 
2.32.0

