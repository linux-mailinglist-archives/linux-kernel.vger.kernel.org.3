Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321725B24FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiIHRlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiIHRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:40:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33042D1D5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:39:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so9021312plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=O5FoYocoznvhyRvqw8gv5IRTDjEDa6vZWW0iZZav3Ss=;
        b=ogejVbJ8uFcXB4k/W3Y8ZIi4R2OfDpBMqaqC19oqU1lGFKdJz6WgI4g6Me68KPFHnD
         sIT7WjUC4h9fnc2tIyNUA2u6g09FdIS5uQyNYiczZIf9b8woXxCh44lRnj4H4ci/u+ij
         0N/X7+wAL+Fyl1NTeXVziVFPYlWPI5w7KWwPRFqkCviQEXshYDdNkcX63Pip50hOxRL6
         UZOVklnRth/MpIboxuqe/61Qdq0O9jTqBSSnyEJFRdYbkonudb+IDiwcJ7Ihl0KXxJ4g
         HHj0Zw/3DbOk9rCgw35QakOOBgX7xINABOKSPVWyfjD//Rxp/ph0WtcPG21Ju9nTL2kx
         HL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O5FoYocoznvhyRvqw8gv5IRTDjEDa6vZWW0iZZav3Ss=;
        b=sUhQlARrBjSY4zWKSEwX8I2UIMuLzPps66bWrSjcrxrD7/WsGaeFnAeDLwR8ozOmAj
         yjneTj88nOuk6FhECXvUJMcHTKrG7h37clm+4zXDG7yvfK2O/RsqF7yEwlijPM5y71t5
         3sXV7WxV/DRv8I25WSMWWGSZFZQXc+SSY+pxYnOKIXHsCMkmCVDrBYHDhqNbPeunl4pF
         3RfvCnkXVTabSSGStxbIwDol1kPK+4FaKXN38t9sEA0HXfB/qJ2U/RbvnORCCWZF1XF/
         3l+h8m3/zaHlJ2i7sjixI4B5sfOUi3/AV1CQ/d0DgIIoiPi/V/aBjJt+eSrAJvCXw+bI
         6jcw==
X-Gm-Message-State: ACgBeo30JRMeH0aqpOufnjs5Z05mp8VSfjNhO3ugO/DFeh1fr0ZVz4et
        ykZ1E9tUm61/Ivyn980G6dqQC9m4S6TQXkES
X-Google-Smtp-Source: AA6agR5CdBHGZtnsfi2EQgd+cDex6+eBrX2IMIPIvngcLYBS62ZD6/G3M1CZFZWgrkdOsI0S6MQXFg==
X-Received: by 2002:a17:903:248:b0:172:7520:db04 with SMTP id j8-20020a170903024800b001727520db04mr10038835plh.99.1662658777993;
        Thu, 08 Sep 2022 10:39:37 -0700 (PDT)
Received: from ghaven-kernel.yocom.org.beta.tailscale.net ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id x76-20020a62864f000000b0052d4b0d0c74sm15166767pfd.70.2022.09.08.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:39:36 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: [PATCH v6 3/5] Input: joystick: xpad: Add ABS_PROFILE to uapi
Date:   Thu,  8 Sep 2022 10:39:28 -0700
Message-Id: <20220908173930.28940-4-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908173930.28940-1-nate@yocom.org>
References: <20220908173930.28940-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ABS_PROFILE axis for input devices which need it, e.g. X-Box
Adaptive Controller and X-Box Elite 2.

Signed-off-by: Nate Yocom <nate@yocom.org>
---
 drivers/hid/hid-debug.c                | 3 ++-
 include/uapi/linux/input-event-codes.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 81e7e404a5fc..2ca6ab600bc9 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1014,7 +1014,8 @@ static const char *absolutes[ABS_CNT] = {
 	[ABS_HAT3Y] = "Hat 3Y",		[ABS_PRESSURE] = "Pressure",
 	[ABS_DISTANCE] = "Distance",	[ABS_TILT_X] = "XTilt",
 	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "ToolWidth",
-	[ABS_VOLUME] = "Volume",	[ABS_MISC] = "Misc",
+	[ABS_VOLUME] = "Volume",	[ABS_PROFILE] = "Profile",
+	[ABS_MISC] = "Misc",
 	[ABS_MT_TOUCH_MAJOR] = "MTMajor",
 	[ABS_MT_TOUCH_MINOR] = "MTMinor",
 	[ABS_MT_WIDTH_MAJOR] = "MTMajorW",
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index dff8e7f17074..7ad931a32970 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -862,6 +862,7 @@
 #define ABS_TOOL_WIDTH		0x1c
 
 #define ABS_VOLUME		0x20
+#define ABS_PROFILE		0x21
 
 #define ABS_MISC		0x28
 
-- 
2.30.2

