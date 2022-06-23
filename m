Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD35557833
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiFWKwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiFWKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:52:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EE4B42F;
        Thu, 23 Jun 2022 03:51:59 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E13C4E001A;
        Thu, 23 Jun 2022 10:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655981518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24+arAKJhTGIKfgrnJIiZ/9RG62zhef/20t26Jbq8Qs=;
        b=TDYzkiRWBxX0NL8q0DTTu/8bOwxD73E83l+t8uMK1NtOHcvg5aNHsdlt+ChwGFVe5ekQ70
        ewAkv+/eQPBqzptFi3nBa2+D1HR9EwElYSKzt9+PacPGvk50if3hGKeT49jE4EFBi/SGSV
        jqmkMocV4MAXRxVYGx4Br1tF9Vm7xiGQZHmuRHfsil107eESMUSoXJS//rC/XlyQUny/gQ
        190kxwQSdbc20rjGOEMu5I9KGTCmLPkKW3joN8Y6BcpIm5rZd4yrbvGlxIiBmMqpWDtOXM
        R83MKOs8IkohWqBtNfnIdDE40DUPtbVf6DmtB3P1uuJ6CtPXg0tKWJqpkjBqGA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1 2/2] of: unittest: remove check for of_root
Date:   Thu, 23 Jun 2022 12:50:44 +0200
Message-Id: <20220623105044.152832-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623105044.152832-1-clement.leger@bootlin.com>
References: <20220623105044.152832-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that of_root node is always populated in of_core_init(), remove
this manual tree creation and assume that the root node always exists.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/unittest.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7f6bba18c515..a787d212c0f6 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1469,16 +1469,6 @@ static int __init unittest_data_add(void)
 		return -EINVAL;
 	}
 
-	if (!of_root) {
-		of_root = unittest_data_node;
-		for_each_of_allnodes(np)
-			__of_attach_node_sysfs(np);
-		of_aliases = of_find_node_by_path("/aliases");
-		of_chosen = of_find_node_by_path("/chosen");
-		of_overlay_mutex_unlock();
-		return 0;
-	}
-
 	EXPECT_BEGIN(KERN_INFO,
 		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
-- 
2.36.1

