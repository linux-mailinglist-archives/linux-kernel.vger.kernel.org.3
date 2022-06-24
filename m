Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC73558F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiFXDoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiFXDoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:44:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E048301;
        Thu, 23 Jun 2022 20:43:59 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cs6so2943776qvb.6;
        Thu, 23 Jun 2022 20:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7lECqj/KTT6R7Y2DbuJ+s242n59A/nhYJhuv3zJ1j4=;
        b=iiHUpp1qxJ4sBASPjqL0B9UPIJYuMKimMZaQFPxHn7xMQnScvg0NX5kHisM0bngk+A
         zIuRDzK+lWrXxIpAUJDDn73aapThx1fNNP4Oi3KQr14eaGXVFd+ENV1wzBGKKLkCzDko
         psnlO+xBvCiwoAPBW4ZlcIpMlFByKR3QzExLZmN2HKmsm69BpTD3ewuLaMcin+piLHuR
         W/nUmc9+6Ttl0g7Za1asG7gidSA5z6mVV8GgDb03MLV25JDJPHoJ7lKkcFlPFJtRqFeN
         uD1jlJPq9cX1STLkN5jg2iSaeHO/bEiqXvegcLNG08QutNlx+b59naXefcGjJSv3cLLW
         z4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7lECqj/KTT6R7Y2DbuJ+s242n59A/nhYJhuv3zJ1j4=;
        b=gfUGcCO3mlD7o9YNQtHKjq+nq2EaeeEVs8cn2mM0sGYRC0F9P5XfLlQaaZB7TUS7O0
         ltSqSo7wmULTLroeWgdfohR3JTnOrs9eSe0re+e8vi3YY7uZkaS+Vh11lax4sgml8x4d
         0NaLxf8VuJYyRd5WwkDMIV6muu9Jf8s2aIF7DkHN9UUOzFVNkpaBF7p+ovcUG/SSpndD
         FeA/xPToCJdyK2rIeXvGYTrNf1PcRkvrfdtgftaQhndA6HdG4h03BtZvSKp18f61Ozrj
         0FaVMfGpaqkN2RtvGrq++6wFdkawGpyoqT6S70O1gsBNtw5x/O9g0cYOjcmgPb+lObcB
         hUZA==
X-Gm-Message-State: AJIora/52Nhutf/0hg74VYEEwaFBaldmlKKtJnvUwgtmfcFfLv8Oi/Rp
        9p6AbkCaSjlvLqbc58LUHco=
X-Google-Smtp-Source: AGRyM1sHBdtFnDDbMNuPLmBftyRVs46/s/vFa/UghxU/Mdhw0/m39cRijZeIzLPoE1eflgc1ef62VQ==
X-Received: by 2002:a0c:90e9:0:b0:470:3c64:668e with SMTP id p96-20020a0c90e9000000b004703c64668emr23569659qvp.124.1656042238467;
        Thu, 23 Jun 2022 20:43:58 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:bdf1:2a9b:4f43:67ef])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a454300b006aef6a244a4sm1048691qkp.129.2022.06.23.20.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 20:43:52 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/2]  of: unittest: treat missing of_root as error instead of fixing up
Date:   Thu, 23 Jun 2022 22:43:27 -0500
Message-Id: <20220624034327.2542112-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624034327.2542112-1-frowand.list@gmail.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

 setup_of() now ensures that of_root node is populated with the
 root of a default devicetree. Remove the unittest code that
 created of_root if it was missing.  Verify that of_root is
 valid before attempting to attach the testcase-data subtree.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7f6bba18c515..9d106998c1f2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1469,20 +1469,16 @@ static int __init unittest_data_add(void)
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
 
 	/* attach the sub-tree to live tree */
+	if (!of_root) {
+		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
+		kfree(unittest_data);
+		return -ENODEV;
+	}
+
 	np = unittest_data_node->child;
 	while (np) {
 		struct device_node *next = np->sibling;
-- 
Frank Rowand <frank.rowand@sony.com>

