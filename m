Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480A14E95B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiC1LwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243264AbiC1Lok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB06557
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g20so16552562edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5U5/Qr+cQNGt04R4HkgE3JZ2XZt3yyTkgQ3RavyTc6g=;
        b=NFFGrqLusL2W2aloJb7UyHTq8l406uyV6/lUS/xNlz23h9z3LaprrosVjLtorPeLPn
         y1EuSFNpwiEQEjs3pqEj2v8vwEFLd8+Mka9DKzi2PwH5Yq4FXEBo4DYFymttBTDlRd+h
         IdRlNPn6GUkW4r6fLpl+K2cyP2w/KN7C6zMusxdLplnARrmQ9LGFqOfQPjAwqwXcLcHv
         VHKoCQcl8cdSL9zKj1o62kNt6Wk2fPwiomcljqT92a+1/MaAJl7yeBA1hepgvWzzxwyE
         cFA1LepEXNpW2L2Zgi4+QtoH4BvpoM/sa+hRng5ICBnMMNCUg6owfPNJBopBlCEOLGGP
         GClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5U5/Qr+cQNGt04R4HkgE3JZ2XZt3yyTkgQ3RavyTc6g=;
        b=cDyBz1C25mBNwFh4juf/ifsqA2g6rWEmCJSBJ7WmePkYGLbv/gDLnlwP7JljdOAjqn
         i8IbnbD1Cgl6hQXCnYwQ1vPP/FROF5l6xXWD33SJqUOYCo+DNBB/pWB/gIaH8MoFrwvq
         Vi5Lvj+omZrtFZbnbLNDXvezsH0CraF0ZelNtqg/85cRioiYWSVTD/9D3vqVMEaqgBqY
         K/uM4/Kl9eVxe+q6rwbrokap/yR+ry9mvD2UO0Ozuu1aIN80Rk/hmKoNdt0eLreydrhC
         +z7kL5ndlOWGzHYCz6mOih4p9dMeBOn0jyrjkTF8hSt+3iK0dP3y1OPbqRrjys82qgsZ
         a6XA==
X-Gm-Message-State: AOAM530s7PNBlTLpp/rLFPztf5mi/CNsak09uxqecjFINwCxGeUiN/Ns
        fTjqaS7U4r5aZ/tdRUGdqdw=
X-Google-Smtp-Source: ABdhPJzOXu7cB9SOxfdEWZGeyRyOBY/WMvEq+jyyC1TxxcvsjDwuDeqnyyL2prnzrZBAakSEa+cvkg==
X-Received: by 2002:a05:6402:354b:b0:419:4af8:c5c9 with SMTP id f11-20020a056402354b00b004194af8c5c9mr15818762edd.91.1648467599289;
        Mon, 28 Mar 2022 04:39:59 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:58 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 9/9] staging: r8188eu: remove HW_VAR_BCN_VALID from SetHwReg8188EU()
Date:   Mon, 28 Mar 2022 13:39:40 +0200
Message-Id: <20220328113940.6396-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328113940.6396-1-straube.linux@gmail.com>
References: <20220328113940.6396-1-straube.linux@gmail.com>
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

The HW_VAR_BCN_VALID case in SetHwReg8188EU() just calls rtw_write8().
Remove HW_VAR_BCN_VALID from SetHwReg8188EU() and call rtw_write8()
directly. This is part of the ongoing effort to getrid of the unwanted
hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c |  5 ++++-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  | 12 ++++++++----
 drivers/staging/r8188eu/hal/usb_halinit.c   |  4 ----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index b5c2e7d4cb48..313e1a3beecb 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5765,7 +5765,10 @@ unsigned int send_beacon(struct adapter *padapter)
 
 	u32 start = jiffies;
 
-	SetHwReg8188EU(padapter, HW_VAR_BCN_VALID, NULL);
+	/* Clear beacon valid check bit. */
+	/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
+	rtw_write8(padapter, REG_TDECTRL + 2, rtw_read8(padapter, REG_TDECTRL + 2) | BIT(0));
+
 	do {
 		issue_beacon(padapter, 100);
 		issue++;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index f1464e4ba429..f58284eba70a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -557,8 +557,9 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl & (~BIT(6))));
 		haldata->RegFwHwTxQCtrl &= (~BIT(6));
 
-		/*  Clear beacon valid check bit. */
-		SetHwReg8188EU(adapt, HW_VAR_BCN_VALID, NULL);
+		/* Clear beacon valid check bit. */
+		/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
+		rtw_write8(adapt, REG_TDECTRL + 2, rtw_read8(adapt, REG_TDECTRL + 2) | BIT(0));
 		DLBcnCount = 0;
 		poll = 0;
 		do {
@@ -596,8 +597,11 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		}
 
 		/*  Update RSVD page location H2C to Fw. */
-		if (bcn_valid)
-			SetHwReg8188EU(adapt, HW_VAR_BCN_VALID, NULL);
+		if (bcn_valid) {
+			/* Clear beacon valid check bit. */
+			/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
+			rtw_write8(adapt, REG_TDECTRL + 2, rtw_read8(adapt, REG_TDECTRL + 2) | BIT(0));
+		}
 
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4be5c5ed8711..8bff4c6c29cf 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1281,10 +1281,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_H2C_MEDIA_STATUS_RPT:
 		rtl8188e_set_FwMediaStatus_cmd(Adapter, (*(__le16 *)val));
 		break;
-	case HW_VAR_BCN_VALID:
-		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
-		rtw_write8(Adapter, REG_TDECTRL + 2, rtw_read8(Adapter, REG_TDECTRL + 2) | BIT(0));
-		break;
 	default:
 		break;
 	}
-- 
2.35.1

