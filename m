Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F353E1F1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiFFGlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiFFGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:41:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E57BC29
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:41:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n10so27035314ejk.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weCjhvxDXvUAz2aIdH1y4c6h+2MqQ+dMhhGf8P/t7Pw=;
        b=Mukqk75gZ6o4PfDaUwDrUwLXy3EWq6WKFDbRY6MQc+x7m6Dbbf6v2J+I4EE7Qj5P72
         JGSCOlBZ4WKMXvQ84VWbBemYtqzEabpIjy1/C3oC9RtFuc7W3Zys6dBUUXwM13OnJmnF
         QsOaxdWDvqpmGJT5JQBeZB1ZXHPhzuEgZRToS62eykf80QaREPNFxopads0eLkqIOWP2
         SHlrrYxyh150aI+ZrXXeIkW/Fupd6NJmzCmdWYPHEdqcerTNsl0OfbQ8LltUxoXQwK7J
         zPTarw1zsNl22HtIU3uvMgqUI/VL9c2jkN5QGSZUSJK5rFSQ+ls0zVz8Vtl4fUNayTmo
         tbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weCjhvxDXvUAz2aIdH1y4c6h+2MqQ+dMhhGf8P/t7Pw=;
        b=PgMjwPdSpjUOV+LcKXJkRKuS6Rguom5qOyrrUUp/GqBF0PniZyVNuWMRJKGl5ObC/6
         jilttY1z3jYxpR8TQWpkG7Rscatrlny+NeEfkUFyO3DfA1fjAbNM3a2Y5hge7t34UbdO
         cp1whc/MTuEGRcICwBKio9ACJHex6UT+7gDGAAFeSnfm6Zt7Iogrqipz321OvHi5Guk0
         N7AEYfFUiyHAmQ94IR99rXaAlyDi6OKBIy80aLru5JeM5BGCHOGszf7ZWUfKuq1Cbise
         Fcjv6k1NcNYk3eBddpmsQGxdmm2UmpXoSpHqIlUqDEFPqtDtsITtqkDRgiUBRSFeNLa5
         /wWA==
X-Gm-Message-State: AOAM531iTr3Z1WQ0SKQ0bCYStdhda/w2jfyXE/n1djUEL3P33oDKWa6Z
        93iRZY7NzdWItdIKOuihHJk=
X-Google-Smtp-Source: ABdhPJzWS0y2iPGO3+TmD0V+7BhOAZDnxyWe99KsVtI529ChPEZju5kDEnfeGJdw2lhKWJWDJSxvdA==
X-Received: by 2002:a17:907:d8d:b0:711:d82f:5d33 with SMTP id go13-20020a1709070d8d00b00711d82f5d33mr681891ejc.595.1654497662731;
        Sun, 05 Jun 2022 23:41:02 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb61.dynamic.kabel-deutschland.de. [95.90.187.97])
        by smtp.gmail.com with ESMTPSA id ee36-20020a056402292400b0042bca34bd15sm7912578edb.95.2022.06.05.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 23:41:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove HW_VAR_SLOT_TIME from SetHwReg8188EU()
Date:   Mon,  6 Jun 2022 08:40:55 +0200
Message-Id: <20220606064055.12565-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get rid of the function SetHwReg8188EU() remove the
HW_VAR_SLOT_TIME case from that function and move the functionality
into a static function in rtw_wlan_util.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 26 +++++++++++++++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 24 ------------------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 392a65783f32..9f0a823b6e52 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1348,6 +1348,30 @@ static void set_ack_preamble(struct adapter *adapter, bool short_preamble)
 	rtw_write8(adapter, REG_RRSR + 2, val8);
 };
 
+static void set_slot_time(struct adapter *adapter, u8 slot_time)
+{
+	u8 u1bAIFS, aSifsTime;
+	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+
+	rtw_write8(adapter, REG_SLOT, slot_time);
+
+	if (pmlmeinfo->WMM_enable == 0) {
+		if (pmlmeext->cur_wireless_mode == WIRELESS_11B)
+			aSifsTime = 10;
+		else
+			aSifsTime = 16;
+
+		u1bAIFS = aSifsTime + (2 * pmlmeinfo->slotTime);
+
+		/*  <Roger_EXP> Temporary removed, 2008.06.20. */
+		rtw_write8(adapter, REG_EDCA_VO_PARAM, u1bAIFS);
+		rtw_write8(adapter, REG_EDCA_VI_PARAM, u1bAIFS);
+		rtw_write8(adapter, REG_EDCA_BE_PARAM, u1bAIFS);
+		rtw_write8(adapter, REG_EDCA_BK_PARAM, u1bAIFS);
+	}
+}
+
 void update_capinfo(struct adapter *Adapter, u16 updateCap)
 {
 	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
@@ -1386,7 +1410,7 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 		}
 	}
 
-	SetHwReg8188EU(Adapter, HW_VAR_SLOT_TIME, &pmlmeinfo->slotTime);
+	set_slot_time(Adapter, pmlmeinfo->slotTime);
 }
 
 void update_wireless_mode(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index a217272a07f8..895619fea501 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1036,30 +1036,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
 		}
 		break;
-	case HW_VAR_SLOT_TIME:
-		{
-			u8 u1bAIFS, aSifsTime;
-			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-
-			rtw_write8(Adapter, REG_SLOT, val[0]);
-
-			if (pmlmeinfo->WMM_enable == 0) {
-				if (pmlmeext->cur_wireless_mode == WIRELESS_11B)
-					aSifsTime = 10;
-				else
-					aSifsTime = 16;
-
-				u1bAIFS = aSifsTime + (2 * pmlmeinfo->slotTime);
-
-				/*  <Roger_EXP> Temporary removed, 2008.06.20. */
-				rtw_write8(Adapter, REG_EDCA_VO_PARAM, u1bAIFS);
-				rtw_write8(Adapter, REG_EDCA_VI_PARAM, u1bAIFS);
-				rtw_write8(Adapter, REG_EDCA_BE_PARAM, u1bAIFS);
-				rtw_write8(Adapter, REG_EDCA_BK_PARAM, u1bAIFS);
-			}
-		}
-		break;
 	case HW_VAR_DM_FLAG:
 		podmpriv->SupportAbility = *((u8 *)val);
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index a56f3d6ca399..0104ee463a10 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -13,7 +13,6 @@ enum hw_variables {
 	HW_VAR_BASIC_RATE,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_MLME_SITESURVEY,
-	HW_VAR_SLOT_TIME,
 	HW_VAR_DM_FLAG,
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_RESET,
-- 
2.36.1

