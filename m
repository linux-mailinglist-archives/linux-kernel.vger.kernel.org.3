Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B554F0012
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354136AbiDBJZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354116AbiDBJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:25:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDC54CD5F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:23:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id pv16so10565513ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kj0NK64/6VOX5kKDITGHXBLvkxZmhHmuskzVJ746a1s=;
        b=Hv9it68CijLFSwsSmW/b2hNjYUjEItE+yy8rNczB4SS5RU5urdnFL8gJaBqWD2eTVC
         B5dPp85eANDq7D+3V3XUQqP80sahcSVvsyg5t2FnJ08oYppLvJiglXILTPxmisjWwnBc
         EuE8Y4kURuqIlsot5yBvPzVVjomFc1upW1eHFuAIpvcUzyU0nW9Sc5N4/Td2DPmUf96A
         JdggqdCH7skF6h4IAJ/WtW0IPs9Kdit2ewBxY6UlOF4EUK3prreb575i3nNGJjUOB0Ze
         96JzHZe1dG9snZkIAL5ej3P27WYHFppuCbFWYKlgyR54aqP3nLr6IwZt1tzUURzWXjfu
         zvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kj0NK64/6VOX5kKDITGHXBLvkxZmhHmuskzVJ746a1s=;
        b=S/85igmrR3XChlzvt76mrZlQTRGPxJlC7htMo8OqsXRCM4OawQEP7oTbni3fSD0oII
         nQNXHWKyWdnCMgE+cNX3yT3Jsf50RG2vQubIyROHW6AkwrVp9SA4LqVqmRKpMX8c8HRR
         b64fgrLcIzGjbILghXipJeX3W42++jlH5yLttWd80JCthXuvLmX4wg4dKth/OMLNHp/K
         thd1gf0w+bLhHJFAygeD27Qh0hNA8HBc0shZBoNAmV1ijrG5cccv1KMZWzPEVDR0A9J/
         arm1UnC6JL2xCDWwktkwSs7yzCY9fuL7VVNZCDgxsFe9fh7+jRXwsiudZowH8V8Pcpfq
         fFVA==
X-Gm-Message-State: AOAM533AW7HRa38f9xSkcF2GaTneYAA0bzX4QYf5GA9w5QzrTQ8HZdOk
        /Lo4zp/Oit/gxk7idaFY9r0=
X-Google-Smtp-Source: ABdhPJz/yRat7Vq2PFwQGRYsW6sE5hNV6cm2sFVOlgWjf7PnjhEo4k5+lvWjAuZd7Mbk3mOJA2grbQ==
X-Received: by 2002:a17:907:7d93:b0:6da:8f57:68fa with SMTP id oz19-20020a1709077d9300b006da8f5768famr3335611ejc.42.1648891422095;
        Sat, 02 Apr 2022 02:23:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm1897679ejc.109.2022.04.02.02.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 02:23:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: r8188eu: remove HW_VAR_RPT_TIMER_SETTING from SetHwReg8188EU()
Date:   Sat,  2 Apr 2022 11:23:30 +0200
Message-Id: <20220402092332.6627-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402092332.6627-1-straube.linux@gmail.com>
References: <20220402092332.6627-1-straube.linux@gmail.com>
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

Remove the HW_VAR_RPT_TIMER_SETTING case from SetHwReg8188EU() and
move its functionality to rtw_cmd.c where it is actually used. This is
part of the ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     | 5 ++++-
 drivers/staging/r8188eu/hal/usb_halinit.c  | 6 ------
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index a9152db589c7..19a04fcb6762 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1049,7 +1049,10 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
 
 static void rpt_timer_setting_wk_hdl(struct adapter *padapter, u16 min_time)
 {
-	SetHwReg8188EU(padapter, HW_VAR_RPT_TIMER_SETTING, (u8 *)(&min_time));
+	struct hal_data_8188e *haldata = &padapter->haldata;
+	struct odm_dm_struct *odmpriv = &haldata->odmpriv;
+
+	ODM_RA_Set_TxRPT_Time(odmpriv, min_time);
 }
 
 u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 min_time)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 39db038d75fd..d13a8ab598fd 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1175,12 +1175,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_RPT_TIMER_SETTING:
-		{
-			u16 min_rpt_time = (*(u16 *)val);
-			ODM_RA_Set_TxRPT_Time(podmpriv, min_rpt_time);
-		}
-		break;
 	case HW_VAR_FIFO_CLEARN_UP:
 		{
 			struct pwrctrl_priv *pwrpriv = &Adapter->pwrctrlpriv;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1ba2eb0a46b2..edc4c6f42bc8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -26,7 +26,6 @@ enum hw_variables {
 	HW_VAR_H2C_FW_P2P_PS_OFFLOAD,
 	HW_VAR_INITIAL_GAIN,
 	HW_VAR_FIFO_CLEARN_UP,
-	HW_VAR_RPT_TIMER_SETTING,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
 };
 
-- 
2.35.1

