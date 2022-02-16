Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDB94B8DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiBPQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:27:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiBPQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:27:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C3EF0A7;
        Wed, 16 Feb 2022 08:27:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id F33431F4186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645028850;
        bh=FvRE4vIjMgfNul3dDW6gVmKk27dQW8jd1YySuZZxOh0=;
        h=From:To:Cc:Subject:Date:From;
        b=nrSEwB/4eMPWebyuPYpNNEcNAl6yhXtihUp6GwcnBIfxunofg63zU5sZivgOp3w+/
         7Hcg/SLYmWuqmGKeIjF/d87aujuYtwHMCdrRPi/bTdZbYXTSqOpXm8WkRECeR2ew4z
         acG80kPxYEiIJSSc/OogR7yjdPPeZGYhN4suS19zJ41JLyu0CDX+mkA2L5ty8fznh0
         MLSUWshFGBIXEZ45uPApTjDxaJENkBwE4yfNfa07IOQdHruqWIC4Xsun14GCWXLQYY
         vy7rU543E+GupyUIe62+ntDlTv0u2KkvQ1l2NU9Ljnck5TrQx6F9sgzJ2V7FoAw/my
         K3FIjeEdO4l2g==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] spi: amd: Fix building without ACPI enabled
Date:   Wed, 16 Feb 2022 13:27:19 -0300
Message-Id: <20220216162719.116062-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 209043554915 ("spi: amd: Add support for version AMDI0062")
removed the cast ACPI_PTR() for no good reason. This wrapper is
important to make sure that the driver can be compiled with or without
CONFIG_ACPI enabled, useful for compiling test. Give back the cast so
compilation works again.

Fixes: 209043554915 ("spi: amd: Add support for version AMDI0062")
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 341a8f2b4614..acf65d949c57 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -495,7 +495,7 @@ MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
 static struct platform_driver amd_spi_driver = {
 	.driver = {
 		.name = "amd_spi",
-		.acpi_match_table = spi_acpi_match,
+		.acpi_match_table = ACPI_PTR(spi_acpi_match),
 	},
 	.probe = amd_spi_probe,
 };
-- 
2.35.1

