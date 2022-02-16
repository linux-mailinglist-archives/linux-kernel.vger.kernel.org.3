Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129BD4B82D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiBPIR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:17:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiBPIRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:17:21 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52D13E9B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:17:10 -0800 (PST)
Received: from dslb-188-097-046-221.188.097.pools.vodafone-ip.de ([188.97.46.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nKFUo-0008Pc-BC; Wed, 16 Feb 2022 09:17:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: evt_done_cnt is set but not used
Date:   Wed, 16 Feb 2022 09:16:56 +0100
Message-Id: <20220216081657.622467-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216081657.622467-1-martin@kaiser.cx>
References: <20220216081657.622467-1-martin@kaiser.cx>
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

evt_done_cnt in struct evt_priv is set but not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_cmd.c      | 1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 --
 drivers/staging/r8188eu/include/rtw_cmd.h   | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index c7e8602d2097..ae7d620bc4a0 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -65,7 +65,6 @@ static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 	atomic_set(&pevtpriv->event_seq, 0);
-	pevtpriv->evt_done_cnt = 0;
 
 	INIT_WORK(&pevtpriv->c2h_wk, c2h_wk_callback);
 	pevtpriv->c2h_wk_alive = false;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index ceca6751cdee..5e1f3a197dcb 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -7967,8 +7967,6 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if (peventbuf) {
 		event_callback = wlanevents[evt_code].event_callback;
 		event_callback(padapter, (u8 *)peventbuf);
-
-		pevt_priv->evt_done_cnt++;
 	}
 
 _abort_event_:
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 6ca141b04344..39273f9775cb 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -55,7 +55,6 @@ struct	evt_priv {
 	#define C2H_QUEUE_MAX_LEN 10
 	atomic_t event_seq;
 	u8	*evt_buf;	/* shall be non-paged, and 4 bytes aligned */
-	u32	evt_done_cnt;
 };
 
 #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
-- 
2.30.2

