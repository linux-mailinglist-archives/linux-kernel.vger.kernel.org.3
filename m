Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62494F0019
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354164AbiDBJ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354130AbiDBJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:25:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA05418E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:23:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bq8so10398171ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p1nCazU2RR08u9chSBMxQI9AzP6gAEkfhwUIFi0LIXg=;
        b=Wg7mpw7XUE4bov9iBjuBYKFcVHyxOb+b9cnznxNDNvkRKByMlQ7DM4l1oY7shpcn7Z
         Mp3duqVwKMMQS0k8odTmhEn8wBwbhUff89OkcdqppYTImkQ8/2eE2brZQC8XLFBqlUIG
         WvLby9+1lF2IxSRDIQ0MWXsPzcCasBitTAqHvgLm78AtAkSour981+e+X5gAWiqMifo9
         cyhclO/5zGCHK0PsB83VIND20i/wKTfkIEsbKX4vMG519BakSPP+inVty+D44YTYbl7r
         d4myFPDQ3GKa3SOpY42ShIFERYpO7YhTAXTzNAHtoh7/BD18u96vVjRkGIyBBeFHdpK7
         FV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1nCazU2RR08u9chSBMxQI9AzP6gAEkfhwUIFi0LIXg=;
        b=CxwMazAhKo8uLhSApTG8poGCujM6DfKpwC2ogIHt4rwaJPMuhMLFXucaHqH6Wdyuiq
         YdWX009NZtcbM7wEwYcAqywVD8HItn5YolWzZgTlkppO67JKn0dOKyNjs/XWKzTdAQTh
         B1LC1QRIjh78DV9oGFWFp+Rl59aoxwt5J5IojOtbKct0KmP18KhJfzrnibfqPmig1qjw
         zmmp+q6m0fDotn7pgqUqKasaJ2R3Gx3prsEwaXv7Yz0muNeVSpgRnriBK2MpzE6bfEBG
         ORy3pjls68KidbsnvqAg9GPorLqg+tnOfyOSbDePuO/3utkmD0sS8TZy94CYqw4vJTfH
         7NUQ==
X-Gm-Message-State: AOAM532+b8kI3a4GNrrN4psGCrse6dm+f9K5eQQWbUNZmTN2YVNwsmLC
        AxHtQpniNCbqh0ALdXZXUJpz1QRWo/g=
X-Google-Smtp-Source: ABdhPJyrGqa254pGglGEIFCVEPeMoDDg7oWpzf0Pv4SVMvPPifEA4K17QwjnhZRW3g/ZSTqFTJ5DRg==
X-Received: by 2002:a17:907:7da5:b0:6e4:e40f:60a0 with SMTP id oz37-20020a1709077da500b006e4e40f60a0mr3240474ejc.486.1648891426020;
        Sat, 02 Apr 2022 02:23:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm1897679ejc.109.2022.04.02.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 02:23:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: r8188eu: remove HW_VAR_H2C_FW_P2P_PS_OFFLOAD from SetHwReg8188EU()
Date:   Sat,  2 Apr 2022 11:23:32 +0200
Message-Id: <20220402092332.6627-8-straube.linux@gmail.com>
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

The HW_VAR_H2C_FW_P2P_PS_OFFLOAD case in SetHwReg8188EU() just calls a
function. Call the function directly and remove the
HW_VAR_H2C_FW_P2P_PS_OFFLOAD case from SetHwReg8188EU(). This is part
of the ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c     | 6 +++---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 6 ------
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 48500fb82250..1e728a03e0ac 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1602,7 +1602,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 	case P2P_PS_DISABLE:
 		pwdinfo->p2p_ps_state = p2p_ps_state;
 
-		SetHwReg8188EU(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
+		rtl8188e_set_p2p_ps_offload_cmd(padapter, p2p_ps_state);
 
 		pwdinfo->noa_index = 0;
 		pwdinfo->ctwindow = 0;
@@ -1626,7 +1626,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 					SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
 				}
 			}
-			SetHwReg8188EU(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
+			rtl8188e_set_p2p_ps_offload_cmd(padapter, p2p_ps_state);
 		}
 		break;
 	case P2P_PS_SCAN:
@@ -1634,7 +1634,7 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 	case P2P_PS_ALLSTASLEEP:
 		if (pwdinfo->p2p_ps_mode > P2P_PS_NONE) {
 			pwdinfo->p2p_ps_state = p2p_ps_state;
-			SetHwReg8188EU(padapter, HW_VAR_H2C_FW_P2P_PS_OFFLOAD, (u8 *)(&p2p_ps_state));
+			rtl8188e_set_p2p_ps_offload_cmd(padapter, p2p_ps_state);
 		}
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index cbd49183be13..4bc6b08fb282 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1150,12 +1150,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtl8188e_set_FwPwrMode_cmd(Adapter, psmode);
 		}
 		break;
-	case HW_VAR_H2C_FW_P2P_PS_OFFLOAD:
-		{
-			u8 p2p_ps_state = (*(u8 *)val);
-			rtl8188e_set_p2p_ps_offload_cmd(Adapter, p2p_ps_state);
-		}
-		break;
 	case HW_VAR_INITIAL_GAIN:
 		{
 			struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 0f64cb41cca6..e222ab89bfc5 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -22,7 +22,6 @@ enum hw_variables {
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_AMPDU_FACTOR,
 	HW_VAR_H2C_FW_PWRMODE,
-	HW_VAR_H2C_FW_P2P_PS_OFFLOAD,
 	HW_VAR_INITIAL_GAIN,
 	HW_VAR_FIFO_CLEARN_UP,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
-- 
2.35.1

