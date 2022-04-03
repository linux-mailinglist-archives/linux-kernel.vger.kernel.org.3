Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6C4F0B94
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359654AbiDCR14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiDCR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:27:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32200393D8;
        Sun,  3 Apr 2022 10:26:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h7so13331957lfl.2;
        Sun, 03 Apr 2022 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3scStYqZ3wk1G1xDmtw2Vpu4MDgRB2HE25Bs83q2zE=;
        b=PVBZAamv/D8qgzwVXyP5SU2fYfkNqZpTXUksNOgIJ0sFKm9wpoIJIm4B07NeX7VtP3
         6Tzt/gXrpXmb+YZjHEfL74es7ioP2HyjWfT85lyactqSfYOYQBurv94T6c8tWgeSbDIk
         Pa+b+t8Su2l3xFMEsRxleS7Gw7R6L5xetHuO4qfz/zdQmiPU45Rly6oI2h+PGKPMpeDf
         r5Qgw+DO3vSD1u9J1MulM9rjA2cA4vwD3CeKIS5BxUzrE/rLH8OeekEeghN/2GZMg0H+
         I5XwoZ91sn4+gkAaJK3ncS1lU2gkRzouaY//XZ+UOyLo833Q9QLMtENDzi5dUfCKvVHl
         comQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3scStYqZ3wk1G1xDmtw2Vpu4MDgRB2HE25Bs83q2zE=;
        b=GrkV/sZ8tOFn+EK/DMw30mF+fWX7l4LaHBJtdzQ8TFZG+ATfaHM9BDuXSFogFbWSUl
         ZenI4gYpG/pOBuJzD3FVPZcd7/S3BNhaP7+hlsGgC56pL9MpC0yFCc6kGGYBq2yugI3X
         WWKI1j+8uTmwE2BbvkmKxUCmFT31an5cGOJqCVsDmHqIgYCjEEbROifnQzTtCSk/kdZD
         0TBtg2zFvddiRb0gDs3aSOuM7bpctcz85FPHseKhWux1Wt3VzcF3C6xk1umMooFjAVw/
         FP2UF8LSyGe7zCGL5tmLmt8MV/H4qsDw2HHhNYgNq+mm4l3nE+bC5sBknMgDTkBjxHmK
         4dIg==
X-Gm-Message-State: AOAM532Ik9jVTXpN6i2ZfA/3hgiATgHW69X4oMhLEaZqutFtxpmU/Evv
        mv6swJ6YRrhMKjl5+hOf8Dw=
X-Google-Smtp-Source: ABdhPJzbykuiQjUQeiT6oYYmsJzhiJsqIHtUWSPGGkPtSKeBxTsh/4T1amdJn25mhYruTAXuiB1yxQ==
X-Received: by 2002:a05:6512:b8d:b0:44b:111:1643 with SMTP id b13-20020a0565120b8d00b0044b01111643mr1556982lfv.68.1649006758226;
        Sun, 03 Apr 2022 10:25:58 -0700 (PDT)
Received: from localhost.localdomain ([178.136.134.212])
        by smtp.googlemail.com with ESMTPSA id t4-20020a2e9c44000000b0024ac62a66d9sm806682ljj.60.2022.04.03.10.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 10:25:56 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus_wmi_sensors) Fix CROSSHAIR VI HERO name
Date:   Sun,  3 Apr 2022 20:25:42 +0300
Message-Id: <20220403172546.953-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CROSSHAIR VI HERO motherboard is incorrectly named as
ROG CROSSHAIR VI HERO. Issue is found by github user in [1].

[1]: https://github.com/electrified/asus-wmi-sensors/pull/79

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/asus_wmi_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index 8fdcb62ae52d..9e935e34c998 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -71,7 +71,7 @@ static const struct dmi_system_id asus_wmi_dmi_table[] = {
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X399-A"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X470-PRO"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI EXTREME"),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO"),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("CROSSHAIR VI HERO"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO (WI-FI AC)"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO (WI-FI)"),

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
prerequisite-patch-id: 3e3c2f102857578c8e0ca204b552fefb2a57ddf3
prerequisite-patch-id: 94ca5a5c7ebefa5fff0e287d0cc9d571ff2bc415
prerequisite-patch-id: 61c8e1af178282b3da7ab8e57f141be3e1ad2281
prerequisite-patch-id: 24a90db10ac4f7445c065ca703bf295bb60f60e1
prerequisite-patch-id: bc8bd3988720bce1923f266b9029e8b4577032b6
prerequisite-patch-id: 5a150577643ec4cd7fbee8db3d9c1562bf0669bd
prerequisite-patch-id: 6991b9920fe16c0da7fd13e1dc52bf1e29e68d6a
prerequisite-patch-id: 49ec7bda24e420231d812dc83bb0383fdfa04256
prerequisite-patch-id: b70ec1d44a1f313bd60ecb84115b6db54eda3273
prerequisite-patch-id: d500e4a21722432152a4988480af1d67407de206
prerequisite-patch-id: 2459efcb493cfd5b2e425cf390ff86c71e4d54a0
prerequisite-patch-id: 74cd3e2498edfc9980fa159bf800240ad59f43a1
prerequisite-patch-id: ab6f755b65d101e05f41a8a184dd720047738474
prerequisite-patch-id: 4ab262658b83a93ecd910bf7b904fb75fcdb0f1a
prerequisite-patch-id: e686f0332ac2efde1b6577efe1a573cbfcd4ced2
prerequisite-patch-id: a1a635a5327b2d041523bb09ba3d395b01210768
prerequisite-patch-id: 7ad265c16dc64e612383fd2e97b569ffdade4cee
prerequisite-patch-id: 6d682cfafbc79e66d4163a30866d926aad8c5833
prerequisite-patch-id: f159482a5ac26a863ba85da010005dae14c7108e
prerequisite-patch-id: a429026f0e759896817ba97cd705ba2b10bb1469
prerequisite-patch-id: 11751c70f9ca541565943ac5bf71361821bd8944
prerequisite-patch-id: ef0d0dbc51f433c0d090f463e51dea13a9363039
prerequisite-patch-id: 424fabfc5b896c7fbdfef1f6077d88c000d67846
-- 
2.35.1

