Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF124E95B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbiC1Lwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiC1Loj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDAE6599
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j15so27997461eje.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8msKbWjmWaaAEB0ve/uVsBqzn8oJg5GhyY4aeWNy/tU=;
        b=BuzmH4hJJtuOW1CwUw5MEPHfiGqswfkecIwmzFKYX+/EjhHaAgxDUzT3HD9LeeJYMV
         q5mCMfTle/ekaqqAFrIeGbwgBfWjbYD0JTjQffNNsIrZQfNYfRl5hvrYAZOeYJyMtfFs
         aruRud3NNV2uSoy/dIQJ/6zxwsNr5W4g539j1yR21Wdm10krdy4OXLTITXi+mrhlYY5l
         1WnQFExhnFY789jU8kTrnoAeMKUIlT4zJQs798+mG3yVQv+CeCppo9CUCb9u+KfBSkjE
         6aWmwQ+sgpo7Il11lg7q2yM5SIblS+Tqt9F86VMrZPgjQpe8KxbTLXqnN8eDHYYgHgom
         SE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8msKbWjmWaaAEB0ve/uVsBqzn8oJg5GhyY4aeWNy/tU=;
        b=7cb+kRzwQ/71oC1tBi7/9RKCaLV43LOe9Jea9A0viFL/vUeYp3RevjF52NA1yIn6TA
         R8uld6C2x0vrpyRvv8EZyu8wdsK62nL+HjzbVsJqP10T4/ZeSWk8OeW0EDrOyKFbXHMe
         MozguUXoWQvdrSFOdOAJMg/jLb59szotS30pBWdflDMXgjP0ExjisVic7viN5WmAUSoI
         /6TEmgs4sb19z5B/urO4Gyl+CaaG9lhVNRz7OWdQdZA2XiyLejApDguSQIr7YFD7pVhi
         p1g17tdLtQxJO6jaDfYRQ94rBMRSX7jLsFWIEeUN8iE3QSrtCEeTZiBgmgj0UXlgAwZd
         0PKw==
X-Gm-Message-State: AOAM530bE6+X+19qyfJazTSW9Z71B6iYv/KEylLLOYKp0fmsbCkD9okJ
        6662+7zkY6wmHJZogpPKpcs=
X-Google-Smtp-Source: ABdhPJzNdkBbdP8Mi+9mKteraiatVeNOfkFX3eBFwbj6yJBxXaR5/MFhtcyMKz5IE221hvJTPLK83Q==
X-Received: by 2002:a17:906:a4b:b0:6d0:fbdd:7cb5 with SMTP id x11-20020a1709060a4b00b006d0fbdd7cb5mr27586011ejf.152.1648467598366;
        Mon, 28 Mar 2022 04:39:58 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/9] staging: r8188eu: remove HW_VAR_TX_RPT_MAX_MACID from SetHwReg8188EU()
Date:   Mon, 28 Mar 2022 13:39:39 +0200
Message-Id: <20220328113940.6396-9-straube.linux@gmail.com>
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

The HW_VAR_TX_RPT_MAX_MACID case in SetHwReg8188EU() just calls
rtw_write8(). Remove HW_VAR_TX_RPT_MAX_MACID from SetHwReg8188EU() and
call rtw_write8() directly. This is part of the ongoing effort to get
rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c     | 3 ++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ++-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 6 ------
 drivers/staging/r8188eu/include/hal_intf.h  | 1 -
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 1569f719af1b..06c17a16dab9 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1141,7 +1141,8 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
 		return;
 
 	macid = search_max_mac_id(adapter);
-	SetHwReg8188EU(adapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&macid);
+	rtw_write8(adapter, REG_TX_RPT_CTRL + 1, macid + 1);
+
 	/* MACID|OPMODE:1 connect */
 	media_status_rpt = (u16)((psta->mac_id << 8) | mstatus);
 	SetHwReg8188EU(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status_rpt);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index b2adb05856a0..b5c2e7d4cb48 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6750,7 +6750,8 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 		/* set per sta rate after updating HT cap. */
 		set_sta_rate(padapter, psta);
-		SetHwReg8188EU(padapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&psta->mac_id);
+		rtw_write8(padapter, REG_TX_RPT_CTRL + 1, psta->mac_id + 1);
+
 		media_status = (psta->mac_id << 8) | 1; /*   MACID|OPMODE: 1 means connect */
 		SetHwReg8188EU(padapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 219f0e5d36aa..4be5c5ed8711 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1278,12 +1278,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_TX_RPT_MAX_MACID:
-		{
-			u8 maxMacid = *val;
-			rtw_write8(Adapter, REG_TX_RPT_CTRL + 1, maxMacid + 1);
-		}
-		break;
 	case HW_VAR_H2C_MEDIA_STATUS_RPT:
 		rtl8188e_set_FwMediaStatus_cmd(Adapter, (*(__le16 *)val));
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 9d755eb59224..98f00c46fe8e 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -33,7 +33,6 @@ enum hw_variables {
 	HW_VAR_ANTENNA_DIVERSITY_SELECT,
 	HW_VAR_FIFO_CLEARN_UP,
 	HW_VAR_RPT_TIMER_SETTING,
-	HW_VAR_TX_RPT_MAX_MACID,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
 	HW_VAR_CHK_HI_QUEUE_EMPTY,
 };
-- 
2.35.1

