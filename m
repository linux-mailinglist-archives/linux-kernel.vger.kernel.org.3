Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A946D397
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhLHMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhLHMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:49:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F24BC0617A1;
        Wed,  8 Dec 2021 04:46:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0FC4B81F79;
        Wed,  8 Dec 2021 12:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9AFC341C7;
        Wed,  8 Dec 2021 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638967584;
        bh=qOak39y2UEAkUcWUmmEsOSdOVVwbNbLIXTN1949QVzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eA02PeOvYp9E2APv9D7iHgwK7X/dHdpLAWQjVFxpSiecQfgA1CluPieCYaRlijyD+
         MjiW94IYqeBhliZlAj02fGSX22w9Hk4BP9NFJME+/iPvPGdNHtYDBqJC6QIOMQdG8T
         rpxp01IBAur5VhEP/X5ED/SvQBNJL0IX6xe/MjivknpXp141TO2YP6L8/y5waUEw8I
         74U59PvCRP341FzVna/boE0mFgKQyximrF9PfoTU96SyX3SYNZJbF9guGy+wzrxLL4
         LrWtpdmarVM8Ac9dpo6BDu78vP6xIyzMFawTFaxGfE2JCYPwfqlvL4wOb20qDOwk2k
         YFslcUamV3RKQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 3/4] memory: omap-gpmc: check for nand node name instead of just compatibility
Date:   Wed,  8 Dec 2021 14:46:10 +0200
Message-Id: <20211208124611.16843-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208124611.16843-1-rogerq@kernel.org>
References: <20211208124611.16843-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have added new compatibles for controller so just checking for
"ti,omap2-nand" compatible is not enough. Check for "nand" node name
as well.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/omap-gpmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 624153048182..9f0062a262db 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2183,7 +2183,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		}
 	}
 
-	if (of_device_is_compatible(child, "ti,omap2-nand")) {
+	if (of_device_is_compatible(child, "ti,omap2-nand") ||
+	    of_node_name_eq(child, "nand")) {
 		/* NAND specific setup */
 		val = 8;
 		of_property_read_u32(child, "nand-bus-width", &val);
-- 
2.17.1

