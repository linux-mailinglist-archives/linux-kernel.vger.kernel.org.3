Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A955DCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiF0GPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiF0GPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:15:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26D2AE8;
        Sun, 26 Jun 2022 23:15:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x4so8053516pfq.2;
        Sun, 26 Jun 2022 23:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7g6umiUOwdOMCfOCryyw3MLC4pOLulgBLoXtBSgLW0=;
        b=LuaevszstNhWFFRYwAKoCq5sp1iYifHqTXb6Newe+keBwKV+Kubc9ReysUvW+hjzKT
         M3tZiFU2mrGBs+ulpYkB7m8hNn2SR20+dLgZyBrBptnssSMbKiaJRz6yBz0yYquLj5hU
         RW8oXC7dpNEXeaZHi6aE4xcevdT79DKRpZLyAOagde31MmIQQ5vD8fsfCm5Men9Ub+/m
         eBnpCW3qqTOS7EdTI4hMUdieANZhAnjv9YANuNjwnrXb0twrA9ZhToEp9jM4697XjJn7
         FjFFmqNCT5FNE8fZUbiSYiC9eiLddV5X7fvPXYAG4wrBGBVOi60kR5dGD2UXaNlrzfTo
         vM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7g6umiUOwdOMCfOCryyw3MLC4pOLulgBLoXtBSgLW0=;
        b=xTc2GLyCnP60FYPADLBE1ao2QGmAHEXXTzLX6kuFC/bURvysdXGCkGZr24ZKGOcV5y
         Hy+EjlF3s1CQi4huETrGDBk6eeN0eElAW0dLqny104c+RmGp+HzvfA5zSQeZeSXqClc6
         NW6Rfgqoma4XxYQ/AYuF9Ecp2bBk9ns0QuFsC9arF6Z5b28oE/76MowGyxlU9w4Uw/HY
         xJgiLcTnLk4SQhwuUq0fGMtVf/oWrBmp2gDeW5SHeH7bbywGhrXcWpQ+Ey/rR6aE8YUr
         Dy088DQdb3EL8ycWWEXH8XYmlo1rwc2A+3lZ0sGTJfWJs5e04vTU5BTesadmkHxaMdBG
         1AZQ==
X-Gm-Message-State: AJIora8VZJrzyya8fAfk8PqSCuxpzSzaGWjlEQlsoSpRd5O6bHga4A2J
        sPU6WczmWxUZZ1Yu5jML9desAdmWrzJqhucM
X-Google-Smtp-Source: AGRyM1sIWT9n1hmrzELvQ2YM0qCSfHEM+RUEpYxlMJPLKQYOnoVyyYyWMefV1d3YR5akrxipdN44Mw==
X-Received: by 2002:a05:6a00:2402:b0:4e1:3df2:5373 with SMTP id z2-20020a056a00240200b004e13df25373mr12719859pfh.40.1656310539136;
        Sun, 26 Jun 2022 23:15:39 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm6247798pls.100.2022.06.26.23.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 23:15:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Keerthy <j-keerthy@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] thermal: k3_j72xx_bandgap: Fix memory leak in k3_j72xx_bandgap_probe
Date:   Mon, 27 Jun 2022 10:15:29 +0400
Message-Id: <20220627061529.42624-1-linmq006@gmail.com>
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

ref_table is allocated in kzalloc, but it doesn't get freed in later
error paths. This function only release it in normal path.
Fix this by add err_free_ref_table label and goto this in some error
paths.

Fixes: ffcb2fc86eb7 ("thermal: k3_j72xx_bandgap: Add the bandgap driver
support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 64e323158952..ce4a62148653 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -433,7 +433,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 				     GFP_KERNEL);
 	if (!derived_table) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto err_free_ref_table;
 	}
 
 	/* Workaround not needed if bit30/bit31 is set even for J721e */
@@ -483,7 +483,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		if (IS_ERR(ti_thermal)) {
 			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
-			goto err_alloc;
+			goto err_free_ref_table;
 		}
 	}
 
@@ -514,6 +514,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_ref_table:
+	kfree(ref_table);
 err_alloc:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

