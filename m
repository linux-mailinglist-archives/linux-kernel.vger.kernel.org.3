Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD5A4CF057
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiCGDiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiCGDin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:38:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6075D25C5C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:37:49 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d61f6c1877so122726527b3.15
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5hsSDKF2hxibRKdAOZqtgoiMABLvidZTZY6Q7kdG83c=;
        b=jVPRDH7CQUQtiRuTpytBrFdR1wfbt3PNKmeOwJtryOBtIEGbJke19zP8PeGyFR+TRT
         SJa8P8Xy5F3x5KCno7dOTPpV5k8FQYoLKQftvu7nhCXDoTqp5z7tojgIQ1odyjmoKCtr
         F2hgGgjqEQonVbXKmaSdVZT1m3s3FZ6lFmKu/vuKkZhEcBQ9Vo8lDalbo5MSELlG2D7z
         kvX1UWCdRiknSAsegKwRCZtGCLuUVd03yZ82mseEFMspCsFNNXzqNxnwG5I+BqjHg++H
         xCflgpOa0IV/x+KIzBm+f1hW/W5g2HvNKFYsjehZ8l+YKkp6m8042UQfdt5DAnaWsW6s
         1XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5hsSDKF2hxibRKdAOZqtgoiMABLvidZTZY6Q7kdG83c=;
        b=2KA3chPijMtf2C5Z9aF35WgCQVlAjd4c/aPsOnHEhlg+ir4z1Zt0/iiyccyNI/BehI
         07YuLAApL6Hjcfm2njDqgVhRnYSGxumayTbIQxjFVMxMaCdUG5KR+LXqLOsaPhSHLDhN
         EyULybgu/YrLNYAmXW2atg58Zoq7h5Gs6gNciK/WibaG4MzxXo/J+9kJJTvKE81S0f4i
         ldONDviaRUpAA9iLCe68jZEmklT20KT01zbtFrG9U5ROo6m3BAfbStd2qj1Xf/rlbzNN
         qm46LP5npB5aBxxzmSGdID/7oRd52UKjBhi8p6oZtia+jYsdvFGhhnhMM2ENLIk+AXgk
         aTNw==
X-Gm-Message-State: AOAM530dpjd+6MOgfo+yGsze1NL63GYAB4Ql84gr3Byx/RN1Rd0BZHMv
        OmzJOH7nqqaOZkUzkBJmhhxvf2foNw==
X-Google-Smtp-Source: ABdhPJwtjLf2Ob9SB7B/YTmp6P3LOygor58g0RrQpBuPiCI3xKjxhPxoE7UsT5rHm+Tb2pD84FoaJe+Cqw==
X-Received: from wjack.tao.corp.google.com ([2401:fa00:fd:203:309f:cb85:fb3d:7ae0])
 (user=wjack job=sendgmr) by 2002:a81:1d50:0:b0:2dc:2e6d:6c34 with SMTP id
 d77-20020a811d50000000b002dc2e6d6c34mr7019035ywd.104.1646624268381; Sun, 06
 Mar 2022 19:37:48 -0800 (PST)
Date:   Mon,  7 Mar 2022 11:31:09 +0800
In-Reply-To: <20220307033110.283379-1-wjack@google.com>
Message-Id: <20220307033110.283379-2-wjack@google.com>
Mime-Version: 1.0
References: <20220307033110.283379-1-wjack@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v2] power: supply: add dock type
From:   Jack Wu <wjack@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jack Wu <wjack@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dock power_supply_type for the drivers which supports dock can
register a power supply class device with POWER_SUPPLY_TYPE_DOCK.

Signed-off-by: Jack Wu <wjack@google.com>
---
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 859501366777..0b45d9d3a50f 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -34,7 +34,7 @@ Description:
 		Describes the main type of the supply.
 
 		Access: Read
-		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
+		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless", "Dock"
 
 **Battery and USB properties**
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c0dfcfa33206..2b1f18b7f98c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
 	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
 	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
 	[POWER_SUPPLY_TYPE_WIRELESS]		= "Wireless",
+	[POWER_SUPPLY_TYPE_DOCK]		= "Dock",
 };
 
 static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e218041cc000..8f0425f00803 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -189,6 +189,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
+	POWER_SUPPLY_TYPE_DOCK,			/* Dock Charging */
 };
 
 enum power_supply_usb_type {
-- 
2.35.1.616.g0bdcbb4464-goog

