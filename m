Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1F4B97E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiBQEv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:51:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiBQEvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:51:54 -0500
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 20:51:38 PST
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2215D1D306
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:51:37 -0800 (PST)
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
        by gw2.atmark-techno.com (Postfix) with ESMTP id 54A0F20D68
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:41:48 +0900 (JST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 5716F20D5E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:41:47 +0900 (JST)
Received: by mail-pl1-f199.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so2021560plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKsjr+x4bYzy8xFM4/3x570D+BJpN9nVsFl77PyeRNg=;
        b=MbjQ3OiCzYS13uJeEGzKMv4vaR1N/O4Hw4D7s9VsPs/zDw3MraT6T9oB6x0INuqIWF
         NtBIAmN+03ZVeAx5xSgeVhWGR6FCTiOURhNtrOuFv2jzKFtyTgkwZSYSFem6V5DHzc1P
         UrEUUebK0bXeh0wBW6AHAio7X5mRDWLUnlQvYAVLJh7o3vayrzWQAo9JSWV7g/DUP7Gs
         XJ5Mudao0E0i5aMs5V8EHs9di3Qis6RCOn+a9IwE1qWunmOOoDhwuR0IQvXRCGGACSpa
         RbmV9Mt8boJW4m2NKbDkbV15AWuKjdwSEbxWGMrzrQumjT+tCjzdmx/HlrPle672kTk2
         ri6Q==
X-Gm-Message-State: AOAM533qKQLejF/91O7JE1XzyQUPpQy3XRwu2MZx1WE40CCkULHvP90J
        moJ7fKf4amkD7nstBLQfREynMQJ7sOyxBwK0JunxcREOfHE9pJNDkS2e54eYcNfBI3+Iz/6KAjx
        doSIRFsi+JDabkLsTq7Te7yxZvg==
X-Received: by 2002:a17:902:9a8e:b0:14d:ae35:19f9 with SMTP id w14-20020a1709029a8e00b0014dae3519f9mr1269991plp.66.1645072906408;
        Wed, 16 Feb 2022 20:41:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYHbGg95GLg8jdxKJTeG6Rw5yCJLRLB3wzOYl/Ms2jX2K8wdo8xn1KWLpPl3U31H77CuOH3A==
X-Received: by 2002:a17:902:9a8e:b0:14d:ae35:19f9 with SMTP id w14-20020a1709029a8e00b0014dae3519f9mr1269975plp.66.1645072906139;
        Wed, 16 Feb 2022 20:41:46 -0800 (PST)
Received: from pc-0115 (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id j15sm48674401pfj.102.2022.02.16.20.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 20:41:45 -0800 (PST)
Received: from martinet by pc-0115 with local (Exim 4.95)
        (envelope-from <martinet@pc-0115>)
        id 1nKYbv-008JBg-6L;
        Thu, 17 Feb 2022 13:41:43 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH] thermal/drivers/imx: add missing pm_runtime_put on error path
Date:   Thu, 17 Feb 2022 13:41:32 +0900
Message-Id: <20220217044132.1980370-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211117103426.81813-1-o.rempel@pengutronix.de>
References: <20211117103426.81813-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We took a reference so need to put it back when imx_get_temp() returns
EAGAIN.

Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
stumbled upon this merging our stable tree, but I don't actually use
imx-thermal so haven't tested it.

 drivers/thermal/imx_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..641f90f9c750 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -265,6 +265,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	if ((val & soc_data->temp_valid_mask) == 0) {
 		dev_dbg(&tz->device, "temp measurement never finished\n");
+		pm_runtime_put(data->dev);
 		return -EAGAIN;
 	}
 
-- 
2.34.1

