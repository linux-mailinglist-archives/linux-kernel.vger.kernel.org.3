Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA94EDA30
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiCaNH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiCaNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:07:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DD49926
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b15so28115081edn.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UE4Nx0CiTaCczhJ2vYi5Ie0116akL9a7MnthzOVYiR8=;
        b=OlrEIJa52NH8jCOlaQ3+hYcIEuyuwp6tVMbKB787dxYsbdcsPPQC63OIJ7VXhU8w1/
         6csxZjXYaHkH4zNGIrJKU7PTMU++UO96s5nYGHyCkDelF5NUR3WiN9dFlaN151HUeC7b
         o4QS/zJIo2eht4oEw7/9hP7g/t56wamG5LNWNTQRL/DKY1l/Vn4CZz9hgaJdykwiDX0C
         dNrfSccT8zp1WbZwYOX/ZVQ37qSCeIquilyrpyW0n5t3wfoiNpLcsN/eBhZkz1hyFm3W
         hKKY5iCsb3YK++J57+r8agGJTN2uxJC5zAa1widOmsXzpt2Zg57D6pycVBbVgVa+KtYU
         4C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UE4Nx0CiTaCczhJ2vYi5Ie0116akL9a7MnthzOVYiR8=;
        b=NmmzJ7+KKz9MsdIqYbKP1XSd7rIVS4IBCuOg2u2swagSEMrY97QbLw1iykKPrxk2gk
         9jCeFxwaiR4PLdh2ZB2Qtii49edyw7XSjV4hFi79zsZVdbjKr8/xHpl+wgAbo6ZI2+T5
         MlTakGDlmXEGImWF7b+I8pY9DXybi4gV0DdZmGSaJ1kakYFRrXM7bLxRll6Izctt3PJz
         ULtSnSxPq5jJ8z5ssI2gB7B5qlF0lmk/j8uhHaVYJJ71/yaxDlDIaVR6e0Q576YEkhbG
         r5USO5y9LUMvDWBPHg2fIr2ck6BAA3oIuU6QBWZhzvZqBLDqryctcRW4ETPzcWzplOoi
         fb5w==
X-Gm-Message-State: AOAM530Gt8aunhGxHOq3TwpPikWBlQghJFYUDfbpgB0xRcM6Fz+Q9Enx
        OemygI+VOVAnaBsswUXp+Z0=
X-Google-Smtp-Source: ABdhPJxuP9Apo1VHcnc/4RfNtkPAHelI4026bKbbWIjW9YKgNTAt9ARLJUajmJmP5l37C4vHBGYO6Q==
X-Received: by 2002:a05:6402:51d2:b0:419:7d2e:9d0 with SMTP id r18-20020a05640251d200b004197d2e09d0mr16378621edd.82.1648731931763;
        Thu, 31 Mar 2022 06:05:31 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm9333358ejc.197.2022.03.31.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:05:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: remove HW_VAR_CHK_HI_QUEUE_EMPTY from GetHwReg8188EU()
Date:   Thu, 31 Mar 2022 15:05:20 +0200
Message-Id: <20220331130522.6648-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331130522.6648-1-straube.linux@gmail.com>
References: <20220331130522.6648-1-straube.linux@gmail.com>
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

The HW_VAR_CHK_HI_QUEUE_EMPTY from GetHwReg8188EU() just calls
rtw_read32(). Remove HW_VAR_CHK_HI_QUEUE_EMPTY from GetHwReg8188EU()
and call rtw_read32() directly. Move the call to a new function to
indicate what it actually does. This is part of the ongoing effort to
get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     | 14 +++++++-------
 drivers/staging/r8188eu/hal/usb_halinit.c  |  3 ---
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 859ec8d8ad9e..496fb67f2253 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1199,6 +1199,11 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 	return res;
 }
 
+static bool rtw_is_hi_queue_empty(struct adapter *adapter)
+{
+	return (rtw_read32(adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0;
+}
+
 static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 {
 	int cnt = 0;
@@ -1210,12 +1215,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 		return;
 
 	if (psta_bmc->sleepq_len == 0) {
-		u8 val = 0;
-
-		/* while ((rtw_read32(padapter, 0x414)&0x00ffff00)!= 0) */
-		/* while ((rtw_read32(padapter, 0x414)&0x0000ff00)!= 0) */
-
-		GetHwReg8188EU(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
+		bool val = rtw_is_hi_queue_empty(padapter);
 
 		while (!val) {
 			msleep(100);
@@ -1225,7 +1225,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 			if (cnt > 10)
 				break;
 
-			GetHwReg8188EU(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
+			val = rtw_is_hi_queue_empty(padapter);
 		}
 
 		if (cnt <= 10) {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8c4bc78681e1..611785caa17f 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1310,9 +1310,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_CHK_HI_QUEUE_EMPTY:
-		*val = ((rtw_read32(Adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0) ? true : false;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 065fc7bd78d5..f0a6d697e68b 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -33,7 +33,6 @@ enum hw_variables {
 	HW_VAR_FIFO_CLEARN_UP,
 	HW_VAR_RPT_TIMER_SETTING,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
-	HW_VAR_CHK_HI_QUEUE_EMPTY,
 };
 
 enum hal_def_variable {
-- 
2.35.1

