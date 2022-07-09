Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3656C868
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiGIJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGIJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:45:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FE9655A7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:45:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so1072956edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGIVjf5vW/EUUkhmIqbf5S+gejrj/oARvzNhzjkZ/VM=;
        b=mpacY3Va0LHU+m15x7pqL+F12TryC9p30Ppx39VNRBaKGCubsxJNzDEF3RGNXwVzNX
         IR3a7bjZfbfpDuuCnp1Wpd8diHZvdmnS9u6ib7J+zYwYCNH7psnmU+eIQj0PwrmHR2us
         8KVIVGjQ9JKnyluZigYN/61asz7gxxXt1y39oYSNn7niKRGYSWepvmaZMrnGZrzFlDiN
         /kvMecb0O/2BpqscsBzmZua8uu3DlfO4TSuydpdSsH1EHVUZuAZ62ZEu9vGB8VtSxg+h
         NqqpDQ05Q7GKvRH9G8UeJDquAA4LPtcznaIWbV3WArRZw++unhcVk34/4kHJCMbN1IHj
         PlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGIVjf5vW/EUUkhmIqbf5S+gejrj/oARvzNhzjkZ/VM=;
        b=mr+GsQnOJMglWgoE+jOixcnR7304phDx3RCZ8ZBS+f5lKXF0YFpiGTBrxLCM9aNPrw
         XiszKgR/N+XnFMugn3TMhdtCm1RUGeX+CwHI8xm0dNARS/TmWvPLvJfSOnnNkerpJS0Q
         deIPEBycMPe9+rILrhAS587sVrknWowG6Oz4tPmb9PAgr7O/Ml4fjUSJ9bVeBNufx0IH
         GCwBqAU72kcASuPLO6h85JpA6ppj/P3GcUnrtjQvAwMmgA0HVZteMpzFEIQRomVV1YmP
         sn6wfSxa/LoKP0w2Rc/RotWLSOJUQBkvY3sxhHv5JGDvmPiRg0ZYhBDdy6nfJuzETHXB
         Mk0w==
X-Gm-Message-State: AJIora/NcYJtkHENnIdns+VjxxE2GzkWF7WUVBamk+KahPy/FqoYliOb
        6osqXMQv5b/bJVJCpdA99w4=
X-Google-Smtp-Source: AGRyM1stc7bBBslEiwpN5c/PUsFT88nDQvt/5UzaeI+algk2jRN8UGk3LQummgWvZjU3aiX/3Sz70Q==
X-Received: by 2002:a50:fe83:0:b0:437:9c60:12f3 with SMTP id d3-20020a50fe83000000b004379c6012f3mr10281495edt.120.1657359910877;
        Sat, 09 Jul 2022 02:45:10 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6f.dynamic.kabel-deutschland.de. [95.90.187.111])
        by smtp.gmail.com with ESMTPSA id hy10-20020a1709068a6a00b00704757b1debsm441521ejc.9.2022.07.09.02.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 02:45:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: remove HW_VAR_DM_FUNC_RESET from SetHwReg8188EU()
Date:   Sat,  9 Jul 2022 11:44:57 +0200
Message-Id: <20220709094458.9578-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709094458.9578-1-straube.linux@gmail.com>
References: <20220709094458.9578-1-straube.linux@gmail.com>
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

Remove the HW_VAR_DM_FUNC_RESET case from SetHwReg8188EU() and move
its functionality to a static function. This is part of the ongoing
effort to get rid of SetHwReg8188EU().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 11 ++++++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c   |  4 ----
 drivers/staging/r8188eu/include/hal_intf.h  |  1 -
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index a16996982b58..31d936ad063a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6646,6 +6646,15 @@ void update_sta_info(struct adapter *padapter, struct sta_info *psta)
 	psta->state = _FW_LINKED;
 }
 
+static void rtw_reset_dm_func_flag(struct adapter *adapter)
+{
+	struct hal_data_8188e *haldata = &adapter->haldata;
+	struct dm_priv *dmpriv = &haldata->dmpriv;
+	struct odm_dm_struct *odmpriv = &haldata->odmpriv;
+
+	odmpriv->SupportAbility = dmpriv->InitODMFlag;
+}
+
 void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 {
 	struct sta_info		*psta, *psta_bmc;
@@ -6676,7 +6685,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	}
 
 	/* turn on dynamic functions */
-	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_RESET, NULL);
+	rtw_reset_dm_func_flag(padapter);
 
 	/*  update IOT-releated issue */
 	update_IOT_info(padapter);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index ece57565b082..92446cd1a096 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1062,7 +1062,6 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 *val)
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
-	struct dm_priv	*pdmpriv = &haldata->dmpriv;
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 	u8 reg;
 	int res;
@@ -1157,9 +1156,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write32(Adapter, REG_RCR, reg32 | RCR_CBSSID_BCN);
 		}
 		break;
-	case HW_VAR_DM_FUNC_RESET:
-		podmpriv->SupportAbility = pdmpriv->InitODMFlag;
-		break;
 	case HW_VAR_DM_FUNC_CLR:
 		podmpriv->SupportAbility = 0;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 89aeb6c2229f..d33e75bcac74 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -12,7 +12,6 @@ enum hw_variables {
 	HW_VAR_SET_OPMODE,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_MLME_SITESURVEY,
-	HW_VAR_DM_FUNC_RESET,
 	HW_VAR_DM_FUNC_CLR,
 };
 
-- 
2.36.1

