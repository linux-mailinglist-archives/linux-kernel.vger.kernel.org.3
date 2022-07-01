Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06F563B92
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiGAVIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGAVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:08:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B656B831
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:08:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sb34so6051540ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHuqyEIXQpdDe9hw0YGVIKUxE052PWFvNDZe12GKtKM=;
        b=SCn6U43tkUsHk3DESgQq5eZ4zuqbkjqwqB/qUX5TmvjIIbQro72DaWVJ9uLeghWhOB
         RY/dg1Mh9DHqqbsGG2+vf5NLElWTH4zKpVPHuNzHDSS419T35ksAjnE3kHrDFhGqT0wI
         BAzx94t+jXiNBtxrivIJJnste+/YJAL010gbhe8y52/yibBopCbvgDXehA6hicOXqtkG
         DnD2pbvfcqNDbPWL1YV3JNG58o0JebxDMinoEWXSIxXOtHWsF6fjTYhL2T4hgT4QkM+t
         TQC5PfV0u7NbB4KRqkILXNE530GjrV7cavcGMt7Yp/O96MM2ur6uxXZOdjoIlS+UfrrN
         ELjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHuqyEIXQpdDe9hw0YGVIKUxE052PWFvNDZe12GKtKM=;
        b=xeZ96uL+3hYfqlbcAki/VbwQRgnN78qfyqngK7gt6TqMnV6P1GkVLfcMvxXJYlHVgY
         9XX2H4mPPmuDgx3PLK7qlA08zFbdGCwcU/NdfDpX4nb5XhowydghgqUEBaZC86t0pB+1
         AIVJQmY9kGUUfqFSTypUThSN38Wn3vpbPHmu4DhzIdKQNpjOsppxutODB6Z2tUQcY826
         l4YpLyuNLvMtIsyUkqMFm0MmbWsupZmWd5+nOHVKGky0dplfxGdhczaxsg8sRgx4dA9b
         xltDEj/AmuO9rRGKPLI1hJMlLMgSTmCmucijAujsWzWSfBCApjXFHplh7fg5JKaROfgw
         XOvg==
X-Gm-Message-State: AJIora8kTv99Z6uZtkcuJdZFS9nD31qnb+Efzvu+v5j2mGF075MpUTrW
        eolCYqLz4ecl432e70WXtuw=
X-Google-Smtp-Source: AGRyM1sAbB3wYi2bxdam8OWBiz/ndF8TAO0VUSjJb9oP+7GZmYAMuQiaiYSDE4Y+0boIeJu0p6Z7iw==
X-Received: by 2002:a17:907:16a2:b0:726:abbc:69bf with SMTP id hc34-20020a17090716a200b00726abbc69bfmr15880254ejc.363.1656709680316;
        Fri, 01 Jul 2022 14:08:00 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb5d.dynamic.kabel-deutschland.de. [95.90.187.93])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7dc09000000b00437938c731fsm9646646edu.97.2022.07.01.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 14:08:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove HW_VAR_AMPDU_FACTOR from SetHwReg8188EU()
Date:   Fri,  1 Jul 2022 23:07:53 +0200
Message-Id: <20220701210753.8210-1-straube.linux@gmail.com>
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

Remove the case HW_VAR_AMPDU_FACTOR from SetHwReg8188EU() and move
the functionality to a static function in rtw_wlan_util.c. This is
part of the ongoing effort to get rid of SetHwReg8188EU().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 28 +++++++++++++++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 26 ------------------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 2d5fd654ead9..aa6b549fd54d 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -805,6 +805,32 @@ static void set_min_ampdu_spacing(struct adapter *adapter, u8 spacing)
 	}
 }
 
+static void set_ampdu_factor(struct adapter *adapter, u8 factor)
+{
+	u8 RegToSet_Normal[4] = {0x41, 0xa8, 0x72, 0xb9};
+	u8 FactorToSet;
+	u8 *pRegToSet;
+	u8 index = 0;
+
+	pRegToSet = RegToSet_Normal; /*  0xb972a841; */
+	FactorToSet = factor;
+	if (FactorToSet <= 3) {
+		FactorToSet = (1 << (FactorToSet + 2));
+		if (FactorToSet > 0xf)
+			FactorToSet = 0xf;
+
+		for (index = 0; index < 4; index++) {
+			if ((pRegToSet[index] & 0xf0) > (FactorToSet << 4))
+				pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet << 4);
+
+			if ((pRegToSet[index] & 0x0f) > FactorToSet)
+				pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
+
+			rtw_write8(adapter, (REG_AGGLEN_LMT + index), pRegToSet[index]);
+		}
+	}
+}
+
 void HTOnAssocRsp(struct adapter *padapter)
 {
 	unsigned char		max_AMPDU_len;
@@ -831,7 +857,7 @@ void HTOnAssocRsp(struct adapter *padapter)
 
 	set_min_ampdu_spacing(padapter, min_MPDU_spacing);
 
-	SetHwReg8188EU(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
+	set_ampdu_factor(padapter, max_AMPDU_len);
 }
 
 void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 3908c46d2fbe..1a08de85a6ae 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1209,32 +1209,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FUNC_CLR:
 		podmpriv->SupportAbility = 0;
 		break;
-	case HW_VAR_AMPDU_FACTOR:
-		{
-			u8 RegToSet_Normal[4] = {0x41, 0xa8, 0x72, 0xb9};
-			u8 FactorToSet;
-			u8 *pRegToSet;
-			u8 index = 0;
-
-			pRegToSet = RegToSet_Normal; /*  0xb972a841; */
-			FactorToSet = *((u8 *)val);
-			if (FactorToSet <= 3) {
-				FactorToSet = (1 << (FactorToSet + 2));
-				if (FactorToSet > 0xf)
-					FactorToSet = 0xf;
-
-				for (index = 0; index < 4; index++) {
-					if ((pRegToSet[index] & 0xf0) > (FactorToSet << 4))
-						pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet << 4);
-
-					if ((pRegToSet[index] & 0x0f) > FactorToSet)
-						pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
-
-					rtw_write8(Adapter, (REG_AGGLEN_LMT + index), pRegToSet[index]);
-				}
-			}
-		}
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index c3704618bccc..b81144932d9a 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -17,7 +17,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_RESET,
 	HW_VAR_DM_FUNC_CLR,
-	HW_VAR_AMPDU_FACTOR,
 };
 
 typedef s32 (*c2h_id_filter)(u8 id);
-- 
2.36.1

