Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386E74BCAE0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243222AbiBSV4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbiBSV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DC3541B6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso11665423pjl.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9DbHqa7/PuuNUMOB7llAk+nGQ8XUCY82hlr70rx3hVw=;
        b=lMjdjwfj/yDZTTN1HHuqEqPG/1HemUUV8Zai5f4adJ5QtFzGfu892IQ+bv5mTvsCdC
         hKeH346azPEzDp7/Qee0oz31oraJBCRHEJBp+3bc0zfjWKaIC/2DErWJW/PlQiSEp796
         +pDt3kN28gf1Bgr0wZ8xOlhxKf6CBK7MQleRRBLx3tdSPuDwDfxkjCdpPfluTJXCWWke
         fLVHPkKFGUsMUAwLRWalE3t5L6NumiQ64GU6D0CahKtRD5D562bkHFyaSM+XyjtTwnL5
         cxTLxN6H3KPXLOyCgUmogh5pOcF1ugmkJvBage57cVzRK9F2p5b1aDgP+nRfPkWEfAj8
         HA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DbHqa7/PuuNUMOB7llAk+nGQ8XUCY82hlr70rx3hVw=;
        b=furmC/rBD5cMUSuLq2HA8POzyd6plShrt0PW2hyB2iLVvVf2CLtXXjOIIfzABs8pd6
         K/hox1bisZd1bC/aOkQHAYM6DFMDB81c9yY5hQBTreCeDPW/Z6HwsRkydR0KfT8Ylo56
         OPNS0yOBn0OTrZRWPm+mZ8290xKmFRupRASsNM8fyST9t/WiIki9USPhr22G1GMC7FZ7
         Wt3Ac9OObL/uDO1QovIOU7wcUP1ogujTQYfBEnn2qy6d7UsWWrPprZ3QL+nBrvuvUFDz
         pUpcw8wexgysGTmRkBZyVhL5t4Na9EIyMwh211pYx9teBIW0F9p9XAcrT1HMylruq5v2
         GCQg==
X-Gm-Message-State: AOAM531GzIz2OWevHmsn7ImEDcbnVH6NKBu+uvNJeliyDuoUJ4lNPY3u
        9i75cFiywR6pwpB0bBNcouuFfg==
X-Google-Smtp-Source: ABdhPJwn7h7JYGRUMVhMEzpjLHw+5/dBjRfY4qeN6ev9JfTP0JOjdKzAk7hp+6ntGi56C2g+1y40Vg==
X-Received: by 2002:a17:90b:358d:b0:1bb:74a3:7088 with SMTP id mm13-20020a17090b358d00b001bb74a37088mr14369662pjb.141.1645307746444;
        Sat, 19 Feb 2022 13:55:46 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:46 -0800 (PST)
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
Subject: [PATCH 05/11] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Date:   Sat, 19 Feb 2022 13:53:22 -0800
Message-Id: <20220219215328.485660-6-dfustini@baylibre.com>
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

AM43xx support isolation of the IOs so that control is taken
from the peripheral they are connected to and overridden by values
present in the CTRL_CONF_* registers for the pad in the control module.

The actual toggling happens from the wkup_m3, so use a DT property from
thea wkup_m3_ipc node to allow the PM code to communicate the necessity
for placing the IOs into isolation to the firmware.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 14 ++++++++++++--
 include/linux/wkup_m3_ipc.h  |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 974b4118a893..e7ae942b7014 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -46,6 +46,8 @@
 #define IPC_VTT_STAT_MASK		(0x1 << 3)
 #define IPC_VTT_GPIO_PIN_SHIFT		(0x4)
 #define IPC_VTT_GPIO_PIN_MASK		(0x3f << 4)
+#define IPC_IO_ISOLATION_STAT_SHIFT	(10)
+#define IPC_IO_ISOLATION_STAT_MASK	(0x1 << 10)
 
 #define M3_STATE_UNKNOWN		0
 #define M3_STATE_RESET			1
@@ -228,6 +230,11 @@ static void wkup_m3_set_vtt_gpio(struct wkup_m3_ipc *m3_ipc, int gpio)
 			    (gpio << IPC_VTT_GPIO_PIN_SHIFT);
 }
 
+static void wkup_m3_set_io_isolation(struct wkup_m3_ipc *m3_ipc)
+{
+	m3_ipc->isolation_conf = (1 << IPC_IO_ISOLATION_STAT_SHIFT);
+}
+
 /* Public functions */
 /**
  * wkup_m3_set_mem_type - Pass wkup_m3 which type of memory is in use
@@ -308,8 +315,8 @@ static int wkup_m3_prepare_low_power(struct wkup_m3_ipc *m3_ipc, int state)
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->resume_addr, 0);
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_power_state, 1);
 	wkup_m3_ctrl_ipc_write(m3_ipc, m3_ipc->mem_type |
-			       m3_ipc->vtt_conf, 4);
-
+			       m3_ipc->vtt_conf |
+			       m3_ipc->isolation_conf, 4);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 2);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 3);
 	wkup_m3_ctrl_ipc_write(m3_ipc, DS_IPC_DEFAULT, 5);
@@ -519,6 +526,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 			dev_warn(dev, "Invalid VTT GPIO(%d) pin\n", temp);
 	}
 
+	if (of_find_property(np, "ti,set-io-isolation", NULL))
+		wkup_m3_set_io_isolation(m3_ipc);
+
 	/*
 	 * Wait for firmware loading completion in a thread so we
 	 * can boot the wkup_m3 as soon as it's ready without holding
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index 2bc52c6381d5..b706eac58f92 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -34,6 +34,7 @@ struct wkup_m3_ipc {
 	int mem_type;
 	unsigned long resume_addr;
 	int vtt_conf;
+	int isolation_conf;
 	int state;
 
 	struct completion sync_complete;
-- 
2.32.0

