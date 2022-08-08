Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327E758C94C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbiHHNWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbiHHNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:22:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE32DC0;
        Mon,  8 Aug 2022 06:22:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p10so10861307wru.8;
        Mon, 08 Aug 2022 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=KLHKDXpHcU82gaHGnpnAu4pIt0tPUIHhQH8CqcYbLZc=;
        b=KYPBN9Pj7fd0e6z9mPr39VZ1NRfra+FwUEAtyHuoZ8+QHZfeg0utxfcTJb7uFe5ATB
         S6sM6WGLoN22gOQxkZL+4SawjzST7wCI2Qg06EK0cVlf9aGNnRomYdxgbUr2qEGs3KUa
         VZojYjtIHagZq8WR5nlGBk00jqLC4LsRXmi5+CD20SomPsdzFodiEXt8JaLvepX9FJEP
         voRlOo1jo9L6timxqCZR/IRW461ypJNOTJR9t32Vc5yXUylO49JWTLTV3+ZQsJqIjOmO
         i0vvjx+UOT8giw1Dw11ZZDu5ppg37GLAfwl/O2YzjrBEmCLl9OflVI7fPsGYYaRTdkai
         Ss6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KLHKDXpHcU82gaHGnpnAu4pIt0tPUIHhQH8CqcYbLZc=;
        b=zsZkr/8+w9BHYYSGtUCtTf9BysFJtOTRpFQFjckWklS14Ebss84YlE/TyO/4kv743W
         ADkG16lcTIafC6g3R450dZ+gvjnrxOA3XM3Bmd9piYCTZ1vitpBpABIenNqZ9PCupslf
         6O6ncVVBdWJRAy/VLNT7VWqS0kUT9fc8ofID1HwAzJnTQH15X8ychazj8pwNU7WW7U+t
         KtAV0uMBhlcf+UJSF5pZ07lja4jcaQUtR8QkrndUMas8+8oZOwEY+ixvRPAqH/8JedK+
         IFfn5/OAwUJMEXT9XVPxxZJ2FkQXL9pnizpoYNvw/rQ8Qo8Piyw3v6xgRXYP0MtRxzJe
         DBPA==
X-Gm-Message-State: ACgBeo2zieBJXMPan5EVMNpAvonm/Ei73reY9rszmaxKjTst+gFcV2zk
        TuUb7D1AW6LRDPfFylj2oic=
X-Google-Smtp-Source: AA6agR5jD9AFk4goYBiiRs0dzzNvmCLerWHOd+g9es83926sFFUaahENvhdo2JUh80tOXu6TBuG09Q==
X-Received: by 2002:a5d:4352:0:b0:21e:4984:e607 with SMTP id u18-20020a5d4352000000b0021e4984e607mr11372625wrr.66.1659964939335;
        Mon, 08 Aug 2022 06:22:19 -0700 (PDT)
Received: from linux-l9pv.suse ([123.194.152.128])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm16100080wme.27.2022.08.08.06.22.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2022 06:22:18 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH] thermal/int340x_thermal: handle data_vault when the value is ZERO_SIZE_PTR
Date:   Mon,  8 Aug 2022 21:21:58 +0800
Message-Id: <20220808132158.24099-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case, the GDDV returns a package with a buffer which has
zero length. It causes that kmemdup() returns ZERO_SIZE_PTR (0x10).

Then the data_vault_read() got NULL point dereference problem when
accessing the 0x10 value in data_vault.

[   71.024560] BUG: kernel NULL pointer dereference, address:
0000000000000010

This patch uses ZERO_OR_NULL_PTR() for checking ZERO_SIZE_PTR or
NULL value in data_vault.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 80d4e0676083..365489bf4b8c 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -527,7 +527,7 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
 				   obj->package.elements[0].buffer.length,
 				   GFP_KERNEL);
-	if (!priv->data_vault)
+	if (ZERO_OR_NULL_PTR(priv->data_vault))
 		goto out_free;
 
 	bin_attr_data_vault.private = priv->data_vault;
@@ -597,7 +597,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 			goto free_imok;
 	}
 
-	if (priv->data_vault) {
+	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		result = sysfs_create_group(&pdev->dev.kobj,
 					    &data_attribute_group);
 		if (result)
@@ -615,7 +615,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 free_sysfs:
 	cleanup_odvp(priv);
 	if (priv->data_vault) {
-		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+		if (!ZERO_OR_NULL_PTR(priv->data_vault))
+			sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 		kfree(priv->data_vault);
 	}
 free_uuid:
@@ -647,7 +648,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
-	if (priv->data_vault)
+	if (!ZERO_OR_NULL_PTR(priv->data_vault))
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
-- 
2.26.2

