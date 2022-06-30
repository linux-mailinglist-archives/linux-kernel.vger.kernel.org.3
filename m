Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF556125C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiF3GRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiF3GRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:17:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA518387
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:17:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d2so25197621ejy.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvHWb6v/L+9TZulap61szS7kTn+A6pLkouACTWq4ICs=;
        b=O4H/GNUaM/GvnoSxCdLpx5xQY6bwb28Lp46JQ5zdGTFD6CbTr1GFpG6J8PVz3tT4sc
         DFgs09OoHNGhAOUGtznZk+QlMCXtFobTmGm1HhIyTqM6uOXZDKaukavsoSP1/kBCvnhx
         tPYIo/12QBPwdJOmvBZwnKBHlTBmhZH+P5IPjahz29soU/DJCpDsgkj1FGcezlOoKct/
         1oc+Jl65hPvaZZZKEFbdljeYIA8SJN77rxBo271eSnSrYWaLIoifhKBiFWzH41XDCX7r
         FuO4lvfKsSt2IUFsl6fB6XRGkvXArNes3cMS/wyYzrhOAAqXWuFEWalDb92d5ZRrTCCP
         Xvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvHWb6v/L+9TZulap61szS7kTn+A6pLkouACTWq4ICs=;
        b=4wYpoLeGMOn3SYfwipL6hg2BEfKXJOXXmzJpqP4GJuPCey43LLtflcnN3k8NMMH/Cg
         zFWnb4SsaJLDvdkAHa9GVrqhTi2D23CDFOwFzMOulSDc53rQ95skW33v8HIz1nIH8WBn
         xEtOBnPkNXmZVpRWgFjINSad0oODLRd64XD55sE8gO11/nMoiS4ae0nMaV/rJcom0eKw
         IwrgFDVbnrHQOMeXcwqGUDNQqMrBN3JQf4ZaxhY6UAP62HXo3sK+8CG4hyQ23N1iUKWr
         /X/mx/MvTiR2/mjEOl45/rN4kydk+/ijuwYk4r4NJjEqqAgbFjonFNAk/fBp8fIIP2eH
         TSdQ==
X-Gm-Message-State: AJIora/eTrtNbxo+lqXS21mJu14cV1AAEg+fiuXSF7/ttcvCTjH2hEXz
        M5IKvKEK8YHht+ibDaDuF0HOS+cUq/M=
X-Google-Smtp-Source: AGRyM1v5UhqAppkr1+rRYEt0Ld4fLLrvujMKGPsKLjbVw+1Cf27ruc7TcbrqO0oMOsjj8ioRCtat3w==
X-Received: by 2002:a17:907:3f9d:b0:726:31d9:c872 with SMTP id hr29-20020a1709073f9d00b0072631d9c872mr7179147ejc.524.1656569864540;
        Wed, 29 Jun 2022 23:17:44 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb57.dynamic.kabel-deutschland.de. [95.90.187.87])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170906e94e00b007263481a43fsm8317524ejb.81.2022.06.29.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 23:17:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove HW_VAR_H2C_MEDIA_STATUS_RPT from SetHwReg8188EU()
Date:   Thu, 30 Jun 2022 08:17:36 +0200
Message-Id: <20220630061736.9200-1-straube.linux@gmail.com>
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

The HW_VAR_H2C_MEDIA_STATUS_RPT case in SetHwReg8188EU() only calls
rtl8188e_set_FwMediaStatus_cmd(). In order to get rid of
SetHwReg8188EU() remove the case HW_VAR_H2C_MEDIA_STATUS_RPT and call
rtl8188e_set_FwMediaStatus_cmd() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c     | 4 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h  | 1 -
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 56c8bd5f4c60..2705c9d87b14 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1117,7 +1117,7 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
 
 	/* MACID|OPMODE:1 connect */
 	media_status_rpt = (u16)((psta->mac_id << 8) | mstatus);
-	SetHwReg8188EU(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status_rpt);
+	rtl8188e_set_FwMediaStatus_cmd(adapter, media_status_rpt);
 }
 
 void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
@@ -1195,7 +1195,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		u16 media_status;
 		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
 		/* for STA, AP, ADHOC mode, report disconnect stauts to FW */
-		SetHwReg8188EU(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
+		rtl8188e_set_FwMediaStatus_cmd(adapter, media_status);
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index cce0575e93b7..7122d5d85e8c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6709,7 +6709,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		rtw_set_max_rpt_macid(padapter, psta->mac_id);
 
 		media_status = (psta->mac_id << 8) | 1; /*   MACID|OPMODE: 1 means connect */
-		SetHwReg8188EU(padapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
+		rtl8188e_set_FwMediaStatus_cmd(padapter, media_status);
 	}
 
 	mlme_join(padapter, 2);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index bb3045111147..3908c46d2fbe 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1235,9 +1235,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_H2C_MEDIA_STATUS_RPT:
-		rtl8188e_set_FwMediaStatus_cmd(Adapter, (*(__le16 *)val));
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 0104ee463a10..c3704618bccc 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -18,7 +18,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_RESET,
 	HW_VAR_DM_FUNC_CLR,
 	HW_VAR_AMPDU_FACTOR,
-	HW_VAR_H2C_MEDIA_STATUS_RPT,
 };
 
 typedef s32 (*c2h_id_filter)(u8 id);
-- 
2.36.1

