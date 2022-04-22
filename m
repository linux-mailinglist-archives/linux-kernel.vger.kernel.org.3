Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F250B9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448449AbiDVOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448455AbiDVON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:13:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA805AA5C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:10:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so11204210wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9pKfwCchdHC4OwwMYDqENqNCTj3wO3pUrxgL+YUsCg=;
        b=LgxY8EKn2SQB6F5GTuWAky1algw6CCJDrp4WE5zG/F7V9C38hu6xBWw8LSXEDyjVQq
         O8AH1ZOhVDuEsz64tWiqvJ+j5HZoCRDNLsCvRtTgKL86zuwxz3I8Go+0qQJpmZem19TK
         U0EEKjbViyPjQwsH5p7GVcE9cobEbO9RLG8LeSReyVJ9Tjll/tERERZBCh/7h7QxkQm5
         jXSD8RXCT/8riVqPknBhkITGyKtnjnHMOOcfnRo5aaI1MreVjezwHxd3H6XYdSv99Ba9
         DGdonBD0EQEV6eMv/YLdV7Qo3Ovf25RI/Ruv3P1q3D0glSgUpTos3pBIDl8zOj3bdNAL
         K/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9pKfwCchdHC4OwwMYDqENqNCTj3wO3pUrxgL+YUsCg=;
        b=K7vgNm74Nqje6YyTokP0yFyVL/1DRrVLoKa3EYQf09RipsIW/qpkP42Bh8OHKpr7L2
         l8gZU3OgQ9YSZfubjYs5j6twdmh1kE5SUkAMSJZ+pP/qPx2aw2qrNvSaDmZlC7i6soBo
         E8bLc0Bvjwc8W+Z4sZm2byGibPpn6Ziz2QKOFuyC47nUhMEKXvqhZe8MG8Fm+dWa4Jlb
         4i8hqse8ZBAXchUzMt84XJ6oSDA5aSpLy7DowhKOdqnQzBD0JAfT89yGizB+19Yx0lqF
         iGWBOddFFimB/dRAK5Yksl8jzqS7O6TxOdNM2VKeggEmuFk59OGBRUDXqRSPAgdtoH/r
         VX1A==
X-Gm-Message-State: AOAM531lXhgVuiF7xtpw657P+iF+T4Tv8xPykitgOX6Og3ZXqLvRUw7r
        oB27ahoh39/YQToOv05zcHn17Q==
X-Google-Smtp-Source: ABdhPJw5XaV/YsAIMcO+prtxlgGuQnolZli3V4e28i77qY0gN2YrEC5ZZgZvZz4DoiFdDwTKU/0SzA==
X-Received: by 2002:adf:e609:0:b0:20a:8110:2245 with SMTP id p9-20020adfe609000000b0020a81102245mr3845074wrm.211.1650636658458;
        Fri, 22 Apr 2022 07:10:58 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm4607430wma.43.2022.04.22.07.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:10:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     srinivas.pandruvada@intel.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 2/2] thermal/governor: Remove deprecated information
Date:   Fri, 22 Apr 2022 16:10:29 +0200
Message-Id: <20220422141029.968212-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422141029.968212-1-daniel.lezcano@linaro.org>
References: <20220422141029.968212-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userspace governor is still on different production system and the
deprecating warning is scary.

Even if we want to get rid of the userspace governor, it is too soon
yet as the alternatives are not yet adopted.

Change the deprecated warning by an information message suggesting to
switch to the netlink thermal events.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig          | 6 ++++--
 drivers/thermal/gov_user_space.c | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e37691e0bf20..0e5cc948373c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -113,8 +113,10 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 	bool "user_space"
 	select THERMAL_GOV_USER_SPACE
 	help
-	  Select this if you want to let the user space manage the
-	  platform thermals.
+	  The Userspace governor allows to get trip point crossed
+	  notification from the kernel via uevents. It is recommended
+	  to use the netlink interface instead which gives richer
+	  information about the thermal framework events.
 
 config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
 	bool "power_allocator"
diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 64a18e354a20..72c90486b46d 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -17,8 +17,7 @@
 
 static int user_space_bind(struct thermal_zone_device *tz)
 {
-	pr_warn_once("Userspace governor deprecated: use thermal netlink " \
-		     "notification instead\n");
+	pr_info_once("Consider using the netlink events interface\n");
 
 	return 0;
 }
-- 
2.25.1

