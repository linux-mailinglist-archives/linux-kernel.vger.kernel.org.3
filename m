Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C959B4E95B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiC1Lwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbiC1Loi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADD56C2A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h1so16574478edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yM1+Oyjs7rm2COzVRYeg0I3yW0Tfk94lGVc8waDOVeI=;
        b=dc38IoMpWs+lEG/BmL0z48Adl6jmTMzVi6trdkH2alBV+433Xkg5FA37EOYmGfSaLh
         xmi8J2979iBiggD0YfEJyUWwMquaCxeUi0QN5lULG0BtXFeL+N3iaRZph863S28eUZU3
         PkLjjcRH2HntNTk0gihCVGxHqaEGm6jAtSWSAtqYjganrZtjfZLdq8F29muBpJyigLHG
         vBzOojqQKwfQx/MllJ51tlrlG65GjsReRtMT2n8jpU3zUwUgmFfR3COkbsHhbM5xlRGE
         UR5fGSXBfEr4bI42YRqpIalX1f8WEG0+KosM9hwkWPoiGWflZpZhZd8Si9h7fyVQzF2Z
         4gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yM1+Oyjs7rm2COzVRYeg0I3yW0Tfk94lGVc8waDOVeI=;
        b=2yLRlVuU23eWGHuQuKXaLmVjdf8FGVyK21RPb0KJGK8fN/Xm1gHceDoRwWkYiNNQUR
         Ez/eh3Fjog817JHoM6jlGRSKiGqT3BcqVeMjzKJQO+XfzKP2LsOPWfw6C3QKcnZWZe5W
         Kl5HqFbpygDKsOigqyxtadU4ozGYNAv4b6jJC88sVtyIYBdprmm+PH3qobsc8YqzGsIa
         cDYrrRntoFqMazRYJhOj1XlPGs0QQTnP1d5qStfG5V4iZWvthrnhjILhVk1w6HqyOm0j
         3LvQyX3/S8BqABTfm5Mzz24lvKbUL8v6NOVgnah6ASbOpSJP5ncpY0sfnZuIx4pkWIQK
         h5BQ==
X-Gm-Message-State: AOAM530oKooAiHVbOVuGU5CeZvh/wl+kbFL9f3rLv/rjF0MSfEOCZ05a
        Xum0nzova2ZyFWMA9CBIZmw=
X-Google-Smtp-Source: ABdhPJxVaoduq6jwj15g4ToMbp7aFdbZH7njcersBGBWMEc/mCryNyI05RgL5hVAY7VUjMz9uBiWWg==
X-Received: by 2002:a05:6402:847:b0:419:7fb0:9e29 with SMTP id b7-20020a056402084700b004197fb09e29mr15565288edz.45.1648467595613;
        Mon, 28 Mar 2022 04:39:55 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/9] staging: r8188eu: remove HW_VAR_RXDMA_AGG_PG_TH from SetHwReg8188EU()
Date:   Mon, 28 Mar 2022 13:39:36 +0200
Message-Id: <20220328113940.6396-6-straube.linux@gmail.com>
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

The HW_VAR_RXDMA_AGG_PG_TH case in SetHwReg8188EU() just sets a
variable conditionally and then calls rtw_write8(). Set the variable
in the caller and, call rtw_write8() directly and remove the
HW_VAR_RXDMA_AGG_PG_TH case from SetHwReg8188EU(). This is part of the
ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 7 +++++--
 drivers/staging/r8188eu/hal/usb_halinit.c  | 8 --------
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 6f0bff186477..14aff6a2040a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1817,10 +1817,13 @@ void rtw_joinbss_reset(struct adapter *padapter)
 			threshold = 1;
 		else
 			threshold = 0;
-		SetHwReg8188EU(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
+
+		if (threshold == 0)
+			threshold = USB_RXAGG_PAGE_COUNT;
+		rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, threshold);
 	} else {
 		threshold = 1;
-		SetHwReg8188EU(padapter, HW_VAR_RXDMA_AGG_PG_TH, (u8 *)(&threshold));
+		rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, threshold);
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 86d8b603d4fa..219f0e5d36aa 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1197,14 +1197,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_RXDMA_AGG_PG_TH:
-		{
-			u8 threshold = *((u8 *)val);
-			if (threshold == 0)
-				threshold = USB_RXAGG_PAGE_COUNT;
-			rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, threshold);
-		}
-		break;
 	case HW_VAR_H2C_FW_PWRMODE:
 		{
 			u8 psmode = (*(u8 *)val);
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index d0317f5b85ba..9d755eb59224 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -25,7 +25,6 @@ enum hw_variables {
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_AMPDU_MIN_SPACE,
 	HW_VAR_AMPDU_FACTOR,
-	HW_VAR_RXDMA_AGG_PG_TH,
 	HW_VAR_H2C_FW_PWRMODE,
 	HW_VAR_H2C_FW_JOINBSSRPT,
 	HW_VAR_FWLPS_RF_ON,
-- 
2.35.1

