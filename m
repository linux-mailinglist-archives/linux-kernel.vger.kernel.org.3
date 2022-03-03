Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62364CC482
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiCCSBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCCSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:01:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2510198D1D;
        Thu,  3 Mar 2022 10:01:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D636198A;
        Thu,  3 Mar 2022 18:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E04C004E1;
        Thu,  3 Mar 2022 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646330463;
        bh=04i2eZv5qTAuP3AEyiHIUhvzqHVYSg3BWxLhzLKqjlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fThq9067ilo5VqJdZcN905SWb/WIOXTBNq9YhSAdlOjllMfhmm47DQpdfYhlMfTNK
         oTxJY9wqpBlz050G/bqoK6B65W9typ9QGvks4S0KOQBsE2GTSySHuKYoHYoagF4elI
         Do/f/sxE9cOLrCitJHgrSoAa6xuI9gb3rLbd0iVo6cO1TFxvOkGI5Y6WE5uKwj3Bak
         PEvshiZYoVt3vpz8qejgQdLM1O/EmF3VuHRRNZWVqVNDsZwX0N6CmXpC924l5wsu/s
         pmIXzeXQRtiv6LRmznrVoCaVzzw+8yXzIoyKdUxEbicv+8AVMU034LghLjDXL3XW31
         M6yy5Of9aeS8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPpl8-0000io-7K; Thu, 03 Mar 2022 19:01:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] ARM: OMAP2+: drop omap_device_register() helper
Date:   Thu,  3 Mar 2022 19:00:13 +0100
Message-Id: <20220303180014.2639-2-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303180014.2639-1-johan@kernel.org>
References: <20220303180014.2639-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The omap_device_register() helper is unused since commit 82f12e64a019
("ARM: OMAP2+: Drop legacy init for sdma") and can be removed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/mach-omap2/omap_device.c | 17 -----------------
 arch/arm/mach-omap2/omap_device.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 56d6814bec26..3cfa7b01a24b 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -473,23 +473,6 @@ struct dev_pm_domain omap_device_pm_domain = {
 	}
 };
 
-/**
- * omap_device_register - register an omap_device with one omap_hwmod
- * @pdev: the platform device (omap_device) to register.
- *
- * Register the omap_device structure.  This currently just calls
- * platform_device_register() on the underlying platform_device.
- * Returns the return value of platform_device_register().
- */
-int omap_device_register(struct platform_device *pdev)
-{
-	pr_debug("omap_device: %s: registering\n", pdev->name);
-
-	dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
-	return platform_device_add(pdev);
-}
-
-
 /* Public functions for use by device drivers through struct platform_data */
 
 /**
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index f77e76a7841a..d607532cf5e0 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -71,7 +71,6 @@ int omap_device_idle(struct platform_device *pdev);
 struct omap_device *omap_device_alloc(struct platform_device *pdev,
 				      struct omap_hwmod **ohs, int oh_cnt);
 void omap_device_delete(struct omap_device *od);
-int omap_device_register(struct platform_device *pdev);
 
 struct device *omap_device_get_by_hwmod_name(const char *oh_name);
 
-- 
2.34.1

