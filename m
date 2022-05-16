Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66441527EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbiEPHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiEPHlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:41:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C82600
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:41:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f10so1766274pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zv3IxfM9rqsBN5giYrSVliQlXB5yWJw2YJUUlPgHgY0=;
        b=KIkAtTgwPJvQoPRr9kQ1tZV/jSmVC6GHNojs95fbMqX43hgUvjQWWZOS9+8+ZGBfWO
         OhVjk5d6YCV+uouSxT1R+5DnYjyBpfgExMMczeeDVuMuQhsuEQZb7e4gTzztpnf6fjDL
         34cC8mthpS7+5hLRZGFcSPXogWc9ceMjqDHSPuRII6IkFArZRMGIGbZQertEZYAUEnU6
         G/kQShRY/7XBpLH57e6ZCkbN2VQpW8EnpTg2gEcjXk4qxFPAK1hF6w9ISXDpC7jDSYcJ
         Nh79hC9zAUp0pK604fL34fe84p18BzkAlkbv2QvseTctH8DF7Ebq0aUXDPRtVzYkN95B
         JCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zv3IxfM9rqsBN5giYrSVliQlXB5yWJw2YJUUlPgHgY0=;
        b=oWBor3PYvy8GohhOkoVLPMgxeJv7MPobi0PkONNgDRK/HMYYIXkWAQmb+Kvy0LB3LB
         mQK9Cz0iUMGiJa2Fm+sSj94t6Jj769xNEp69dPVy/F/SqzzhZnJVylmlNDLCbHJvPol+
         5bpOe4+A75EfgYmnNyedS+g0RaAKGMJ5ihGYfwKeMC4exRCX9QZt92zHatM55uONNGWm
         HudHwVgkArsB0Kxpff1b59DCXAMwuyext8bVfwokv0yCUEfTEY53Xl7OtL3hrf4smI4T
         LrWUXEeVdp5GjY7SEKSLfea5mpXvK1xYSFPtZ4l2ATcd66gFTE/Jwn6BovbrzcE+Vx1u
         KT+g==
X-Gm-Message-State: AOAM532T26SMfLVpaTkx8d0MZnzmj0vZeoLTz+Qs1Vo+Xu3mtJgAHrTf
        Gw+G7u0FpY1eAVEdHXFALvk=
X-Google-Smtp-Source: ABdhPJxRzUTJ5CbOjcZmRtE5V/PlMxtaQrKw43ndH8TAqTmZnio7gI8cDrdKjb+E+wlB30I3g0/9lg==
X-Received: by 2002:a17:902:e747:b0:161:822b:5fa9 with SMTP id p7-20020a170902e74700b00161822b5fa9mr2961831plf.8.1652686868992;
        Mon, 16 May 2022 00:41:08 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q11-20020a056a00150b00b0050dc76281d9sm5698833pfu.179.2022.05.16.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:41:08 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: ti: pm33xx: Fix refcount leak in am33xx_pm_rtc_setup
Date:   Mon, 16 May 2022 11:41:00 +0400
Message-Id: <20220516074100.30599-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/ti/pm33xx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 7bab4bbaf02d..b4d6e6ad85f4 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -445,8 +445,10 @@ static int am33xx_pm_rtc_setup(void)
 	if (of_device_is_available(np)) {
 		/* RTC interconnect target module clock */
 		rtc_fck = of_clk_get_by_name(np->parent, "fck");
-		if (IS_ERR(rtc_fck))
-			return PTR_ERR(rtc_fck);
+		if (IS_ERR(rtc_fck)) {
+			error = PTR_ERR(rtc_fck);
+			goto err_node_put;
+		}
 
 		rtc_base_virt = of_iomap(np, 0);
 		if (!rtc_base_virt) {
@@ -479,6 +481,7 @@ static int am33xx_pm_rtc_setup(void)
 	} else {
 		pr_warn("PM: no-rtc available, rtc-only mode disabled.\n");
 	}
+	of_node_put(np);
 
 	return 0;
 
@@ -486,7 +489,8 @@ static int am33xx_pm_rtc_setup(void)
 	iounmap(rtc_base_virt);
 err_clk_put:
 	clk_put(rtc_fck);
-
+err_node_put:
+	of_node_put(np);
 	return error;
 }
 
-- 
2.25.1

