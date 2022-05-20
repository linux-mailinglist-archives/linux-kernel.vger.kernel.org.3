Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604A252F302
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352837AbiETSfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352717AbiETSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697AC195783;
        Fri, 20 May 2022 11:34:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m20so1473798wrb.13;
        Fri, 20 May 2022 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSTVujSZxd7jybS/Xm7tv3qPDlYb2MEOHKZDRGbEpQ4=;
        b=dJg9CQe3nx273fBEBZF9WXB3LktQmm+FfckxuUxi32ZHs5Hnk9iwWc49xyjTpTK85r
         UbolqjCZgEvqbWO3Z9hFSBMhiQutha2QIf9FIt7VjTUHjsjRZt/KgX7Cmq8TgL1Vpl2L
         my39hrNeKD2g/2GCAsx6qptExQRN5QNKiqvbQkDwhZMVXXeHr2+MXnZQsAe1w6anupgn
         Gpzht8aV3N/xQi7xPJ068ufGTB1ivTUdw2elNrZw/uaSuRY0p7I9JzUCPSbk/U9okiWQ
         EDGYP7EbCKTH3x6UO9XdH9Sz4/2Y9rL1Wa2ftb8zVFpKW79T85nRGoORlKuDrVrMIrmq
         UMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSTVujSZxd7jybS/Xm7tv3qPDlYb2MEOHKZDRGbEpQ4=;
        b=A+HvFrwk46GApWQkPf8Oa4mLITCYaSMzRDD/WJnEZz8ZTlnoKCfqaJluSrjXNoCfyF
         +I4MfFHoN0CY2qxh0y/qcRgjy/rczlJruH5CPPwvHBuC+OIQDUYBpsLi65NQv/IDAO/S
         YmdIYfGdMleyz8oad2dI9YShf9JyfUZawvLP9941I7NfypgeNs4cbcZAMMdlPdrfPcGq
         995H7cVjr88jiKlW31pZkakO3p1dtDZ93sz+WF9pyo/MPi01HBj1wqQBQzdZL8Qsll9c
         Hhq/u47uFH5ms6L1zH5wz/Gz32murncnoXd52jVHwc4/IVrSE1hsMX2eVEKjbpc+BKGD
         unLQ==
X-Gm-Message-State: AOAM5320J3/HAQS1sFaQhrsOVqnZ0XvhUx9jQoti5ciX5tiLd5gUu1Dx
        2OEoR3UQsuMLMmRj7Gb/+MeAZEPLlHU=
X-Google-Smtp-Source: ABdhPJxGAMbJ8hZRi7BTY3l1yRertQpGm8j1ElOR4tU22rk62QJymMuemNP8L8Yer/YbcP1WXy2Gqw==
X-Received: by 2002:adf:f24c:0:b0:20c:fe15:504c with SMTP id b12-20020adff24c000000b0020cfe15504cmr9404828wrp.123.1653071686072;
        Fri, 20 May 2022 11:34:46 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:45 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] power/supply: surface_battery: Use client device wrappers for notifier registration
Date:   Fri, 20 May 2022 20:34:17 +0200
Message-Id: <20220520183422.7185-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
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

Use newly introduced client device wrapper functions for notifier
registration and unregistration.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/power/supply/surface_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index 5ec2e6bb2465..540707882bb0 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -802,7 +802,7 @@ static int spwr_battery_register(struct spwr_battery_device *bat)
 	if (IS_ERR(bat->psy))
 		return PTR_ERR(bat->psy);
 
-	return ssam_notifier_register(bat->sdev->ctrl, &bat->notif);
+	return ssam_device_notifier_register(bat->sdev, &bat->notif);
 }
 
 
@@ -837,7 +837,7 @@ static void surface_battery_remove(struct ssam_device *sdev)
 {
 	struct spwr_battery_device *bat = ssam_device_get_drvdata(sdev);
 
-	ssam_notifier_unregister(sdev->ctrl, &bat->notif);
+	ssam_device_notifier_unregister(sdev, &bat->notif);
 	cancel_delayed_work_sync(&bat->update_work);
 }
 
-- 
2.36.1

