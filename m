Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3558B808
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiHFT4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiHFT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:00 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C4763EB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:55:58 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPto-0004Tu-Qp; Sat, 06 Aug 2022 21:55:53 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/13] staging: r8188eu: move endpoint init functions to usb_halinit.c
Date:   Sat,  6 Aug 2022 21:55:31 +0200
Message-Id: <20220806195540.777390-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806195540.777390-1-martin@kaiser.cx>
References: <20220806195540.777390-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Hal_MappingOutPipe function and the functions
one_/two_/three_out_pipe from hal_com.c to usb_halinit.c.

After this move, all the functions that rtl8188eu_interface_configure
calls are in one file and we can continue to summarize and merge them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/hal_com.c     | 108 ----------------------
 drivers/staging/r8188eu/hal/usb_halinit.c | 108 ++++++++++++++++++++++
 drivers/staging/r8188eu/include/hal_com.h |   2 -
 3 files changed, 108 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index d24e0e5924eb..8416a65ba47b 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -138,114 +138,6 @@ void HalSetBrateCfg(struct adapter *adapt, u8 *brates, u16 *rate_cfg)
 	}
 }
 
-static void one_out_pipe(struct adapter *adapter)
-{
-	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
-
-	pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
-	pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
-	pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[0];/* BE */
-	pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[0];/* BK */
-
-	pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
-	pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
-	pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
-	pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
-}
-
-static void two_out_pipe(struct adapter *adapter, bool wifi_cfg)
-{
-	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
-
-	if (wifi_cfg) { /* WMM */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  0,  1,  0,  1,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:L */
-
-		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[1];/* VO */
-		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
-		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
-		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[0];/* BK */
-
-		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
-		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
-		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
-		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
-
-	} else {/* typical setting */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  1,	1,  0,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:L */
-
-		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
-		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
-		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
-		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[1];/* BK */
-
-		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
-		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
-		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
-		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
-	}
-}
-
-static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
-{
-	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
-
-	if (wifi_cfg) {/* for WMM */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  1,	2,  1,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:N, 2:L */
-
-		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
-		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
-		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
-		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[1];/* BK */
-
-		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
-		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
-		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
-		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
-
-	} else {/* typical setting */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  2,  2,  1,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:N, 2:L */
-
-		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
-		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
-		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
-		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[2];/* BK */
-
-		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
-		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
-		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
-		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
-	}
-}
-
-int Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
-{
-	struct registry_priv *pregistrypriv = &adapter->registrypriv;
-	bool wifi_cfg = pregistrypriv->wifi_spec;
-
-	switch (numoutpipe) {
-	case 2:
-		two_out_pipe(adapter, wifi_cfg);
-		break;
-	case 3:
-		three_out_pipe(adapter, wifi_cfg);
-		break;
-	case 1:
-		one_out_pipe(adapter);
-		break;
-	default:
-		return -ENXIO;
-	}
-	return 0;
-}
-
 /*
 * C2H event format:
 * Field	 TRIGGER		CONTENT	   CMD_SEQ	CMD_LEN		 CMD_ID
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index ed0faf4fd51d..8be93c44c903 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -35,6 +35,114 @@ static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 	}
 }
 
+static void one_out_pipe(struct adapter *adapter)
+{
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
+
+	pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+	pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
+	pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[0];/* BE */
+	pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[0];/* BK */
+
+	pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+	pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+	pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+	pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+}
+
+static void two_out_pipe(struct adapter *adapter, bool wifi_cfg)
+{
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
+
+	if (wifi_cfg) { /* WMM */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  0,  1,  0,  1,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[1];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[0];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+
+	} else {/* typical setting */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  1,	1,  0,  0,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[1];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+	}
+}
+
+static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
+{
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
+
+	if (wifi_cfg) {/* for WMM */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  1,	2,  1,  0,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:N, 2:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[1];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+
+	} else {/* typical setting */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  2,  2,  1,  0,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:N, 2:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[2];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+	}
+}
+
+static int Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
+{
+	struct registry_priv *pregistrypriv = &adapter->registrypriv;
+	bool wifi_cfg = pregistrypriv->wifi_spec;
+
+	switch (numoutpipe) {
+	case 2:
+		two_out_pipe(adapter, wifi_cfg);
+		break;
+	case 3:
+		three_out_pipe(adapter, wifi_cfg);
+		break;
+	case 1:
+		one_out_pipe(adapter);
+		break;
+	default:
+		return -ENXIO;
+	}
+	return 0;
+}
+
 int rtl8188eu_interface_configure(struct adapter *adapt)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
index 3dfb61e64ee0..e8007295cd79 100644
--- a/drivers/staging/r8188eu/include/hal_com.h
+++ b/drivers/staging/r8188eu/include/hal_com.h
@@ -143,8 +143,6 @@ u8 MRateToHwRate(u8 rate);
 
 void HalSetBrateCfg(struct adapter *Adapter, u8 *mBratesOS, u16 *pBrateCfg);
 
-int Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
-
 s32 c2h_evt_read(struct adapter *adapter, u8 *buf);
 
 #endif /* __HAL_COMMON_H__ */
-- 
2.30.2

