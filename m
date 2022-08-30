Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7825C5A7149
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiH3XAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiH3XAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F194EF2;
        Tue, 30 Aug 2022 16:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD1E6615F7;
        Tue, 30 Aug 2022 23:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C239C433D6;
        Tue, 30 Aug 2022 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661900434;
        bh=WsFP+jr/JWJOetQbqvy3jJUBEs3QY1vpJJXVmKgr98I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCQd396YFLgvuF4XThnikjVixCDiSZOaINBCx35IpPqiz5QbcT7s26bFCXwG0c21e
         PXYKnc9IzRbYzQLOu4MHgp3h7yMs2KlNhf3ctwmo+y+NjN6n+VV/418wj5hCxyxRU8
         anvOsHeViJNMXcuVXZqZGz2Y0rbQ86vampAqqeUm/jL8Td0ydG0famYqt05Say96n2
         tvzCiQ0wM72LNF0wRA7nz36tYg5K2577ZzpDQKqpctjzxxue5JOkhKRfWgWmMwUH8W
         87dXenm3LoEKrhWxMRzObcGi1TAJYg6TIj2Zl4qpC1OW/KSFDP5WQbks1FIIYPKQlW
         7Qtad5T7pPRQw==
Received: by pali.im (Postfix)
        id 72ECD834; Wed, 31 Aug 2022 01:00:31 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 2/3] power: reset: syscon-reboot: Add support for specifying priority
Date:   Wed, 31 Aug 2022 01:00:11 +0200
Message-Id: <20220830230012.9429-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220830230012.9429-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220830230012.9429-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read new optional device tree property priority for specifying priority
level of reset handler. Default value is 192 as before.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/power/reset/syscon-reboot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 510e363381ca..45e34e6885f7 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -44,6 +44,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	struct syscon_reboot_context *ctx;
 	struct device *dev = &pdev->dev;
 	int mask_err, value_err;
+	int priority;
 	int err;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -57,6 +58,9 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 			return PTR_ERR(ctx->map);
 	}
 
+	if (of_property_read_s32(pdev->dev.of_node, "priority", &priority))
+		priority = 192;
+
 	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
 		return -EINVAL;
 
@@ -77,7 +81,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	}
 
 	ctx->restart_handler.notifier_call = syscon_restart_handle;
-	ctx->restart_handler.priority = 192;
+	ctx->restart_handler.priority = priority;
 	err = register_restart_handler(&ctx->restart_handler);
 	if (err)
 		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
-- 
2.20.1

