Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F694CB0CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbiCBVL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiCBVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:11:54 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D649BBE33;
        Wed,  2 Mar 2022 13:11:09 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 917C11C0007;
        Wed,  2 Mar 2022 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646255467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awXHKYLutlWI1DCRzb/ig8zBY3AfY1mc3nmGyuIUbQY=;
        b=KC5jb/0eHDiE+UiESbAJKbofE4wMxj2wpGyLvefgPb4frgv9R644ZgOXbt7iLeqooqnazd
        +nUlxI4bCo5QWhCw7lWkjIHhNFbUWMw4IP/6Dp6mjLe6Fz/38poJtxPE13HgUys8w9hYyc
        mE5XebOAoPcIjmzGv7phwh9Xzc6gq9x0Rrl6hlBZIlxOIlXWnOTNOLZ6r8QZrhp1kKq/sM
        UCiau4lIXmoqQ8BEGimmZf+KZxMajFXvUakP9SxcUVjLQ7SmoVrimo6sEfl76q/t+r6dGk
        Ek4tSAs8dXnCEPcW5Mlo3qJ02BjFQvLVjIB5vWZQWvMtPHavTxSua1jZY9A61g==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH RFC v3 1/8] of: Mark interconnects property supplier as optional
Date:   Wed,  2 Mar 2022 22:10:53 +0100
Message-Id: <20220302211100.65264-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to set their correct DMA address offset, some devices rely on
the device-tree interconnects property which identifies an
interconnect node that provides a dma-ranges property that can be used
to set said offset.

Since that logic is all handled by the generic openfirmware and driver
code, the device-tree description could be enough to properly set
the offset.

However the interconnects property is currently not marked as
optional, which implies that a driver for the corresponding node
must be loaded as a requirement. When no such driver exists, this
results in an endless EPROBE_DEFER which gets propagated to the
calling driver. This ends up in the driver never loading.

Marking the interconnects property as optional makes it possible
to load the driver in that situation, since the EPROBE_DEFER return
code will no longer be propagated to the driver.

There might however be undesirable consequences with this change,
which I do not fully grasp at this point.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8e90071de6ed..ef7c56b510e8 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1365,7 +1365,7 @@ static struct device_node *parse_interrupts(struct device_node *np,
 
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
-	{ .parse_prop = parse_interconnects, },
+	{ .parse_prop = parse_interconnects, .optional = true,},
 	{ .parse_prop = parse_iommus, .optional = true, },
 	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
-- 
2.35.1

