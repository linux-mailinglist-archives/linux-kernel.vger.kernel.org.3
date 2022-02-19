Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271184BCADD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbiBSV4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiBSV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9282154197
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w20so9873387plq.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALItf1cmaYde5anKiXpaOkvR8+mXdj6IXy5l9T74CXY=;
        b=Fn3Ru8rk2m6UM8OQLbL67IIZ8/ISkk5RdEHaoDTmx+kgG1d3LaSWDLlgU5hpIz1l7O
         J7wJiWswQe2eiNiH9NK+KlcuyYwX5V/xk9AHURcL6gvv2KVTbN0ZXmOqjFP+Ymae+m6A
         XsyBw4215bt3cTNo+f3XJ9PD+lGYKgdRNXJuv4eDuVCSb1Kd3aWbB/DRxrG1zuO6qOK6
         bmbXgCSMop4xAHAEGWRHJpJPJUIw19GqTB9pqV/e0IkSqhlP2Oz0sYn9UK88VS0LbwQK
         NDpXPd0nK3sJsBc29nP85v40SbCnUAjXVZumbtGJ7Ffb2doMS7kbn7u00qZ8C4AP5K39
         rWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALItf1cmaYde5anKiXpaOkvR8+mXdj6IXy5l9T74CXY=;
        b=spaGPPUZuI7W+qA4uLbJoTqHKY0umH1c8Yuk1vnTPDVMsZdTbNsPHEE38QYS6yxwcR
         spbIYRFDZ8ncS8w2pRCLrbEU7KVWmgxsnKC4//1kFq4Eb8i4uWyTYlFOCFgiAnSILeyK
         fMzGY8yEYtjduIa1oCIRokEjWXu2nYZEG2PJDgTrT2pzpP2EEvO61g+a4wnYhnHGM7os
         FQPY0ZV0ThbqozwOoClNU3zcqnqIq1lcjwpzP7Svunp918Q5OYO/JrmPTWFcPQCqdJFk
         0drr7JKiran2XEsxL4cifU/zrSLuobXDHmPxdCztnNGCOMGHUqbh5eFbrg20foIHFjfB
         X5KQ==
X-Gm-Message-State: AOAM530CuWZOdi3OmDVFu6eAnzQhQA/mk8354w7dZyHl7WMxbHIU+TZ+
        oaeH05vcv0OFAcLNVPjrl3f6iA==
X-Google-Smtp-Source: ABdhPJxMLUiSjR9mcVV1iK9+hG/lKSlGmCHqWar1s22AM6LNq/uC41pK9n3kfEId/9Rjt1hG8v3Asg==
X-Received: by 2002:a17:902:ba96:b0:14c:8407:8e4b with SMTP id k22-20020a170902ba9600b0014c84078e4bmr12646881pls.135.1645307754101;
        Sat, 19 Feb 2022 13:55:54 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:53 -0800 (PST)
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
Cc:     Brad Griffis <bgriffis@ti.com>
Subject: [PATCH 11/11] soc: ti: wkup_m3_ipc: Add debug option to halt m3 in suspend
Date:   Sat, 19 Feb 2022 13:53:28 -0800
Message-Id: <20220219215328.485660-12-dfustini@baylibre.com>
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

Add a debugfs option to allow configurable halting of the wkup_m3
during suspend at the last possible point before low power mode entry.
This condition can only be resolved through JTAG and advancing beyond
the while loop in a8_lp_ds0_handler. Although this hangs the system it
forces the system to remain active once it has been entirely configured
for low power mode entry, allowing for register inspection through JTAG
to help in debugging transition errors.

Halt mode can be set using the enable_off_mode entry under wkup_m3_ipc
in the debugfs.

Suggested-by: Brad Griffis <bgriffis@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: resolve trivial line conflicts]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 78 +++++++++++++++++++++++++++++++++++-
 include/linux/wkup_m3_ipc.h  |  2 +
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 5a1722c3bf1a..244bce3f52e8 100644
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
@@ -137,6 +141,73 @@ static void wkup_m3_scale_data_fw_cb(const struct firmware *fw, void *context)
 	release_firmware(fw);
 };
 
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
 static int wkup_m3_init_scale_data(struct wkup_m3_ipc *m3_ipc,
 				   struct device *dev)
 {
@@ -402,7 +473,8 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_power_state, 1);
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->mem_type |
 			       m3_ipc->vtt_conf |
-			       m3_ipc->isolation_conf, 4);
+			       m3_ipc->isolation_conf |
+			       m3_ipc->halt, 4);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 2);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 3);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 6);
@@ -634,6 +706,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
+	wkup_m3_ipc_dbg_init(m3_ipc);
+
 	return 0;
 
 err_put_rproc:
@@ -645,6 +719,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 
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

