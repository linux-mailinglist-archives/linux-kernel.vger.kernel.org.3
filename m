Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA953B974
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiFBNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiFBNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:09:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7116213C4DA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:09:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n10so4865918pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/kcUz7iGlHGzh5+WMm96tVRqgBGqVmBjrJsf3+xK1w=;
        b=O/Ff5ZsLRl2HcI4aExUbCpE+GcliUTIzcwvVM7kXO9pTFrOQTLBizn50/Mf9pORGgJ
         ewAq5ypsSDVJh0Jlo0KSu9kfSdi+x8bYT+Mozq64lvhjjoSORz9MtszYss5ObJ3JArOf
         K3Yh3zXbJn4r0466KlrdhjdU1PAzRPawDF7uYyd0Bfg5RBXIuDaNOQblQ35r5E3Fg+0C
         jE+iPXqXwRApvQPnAVt1E82R2WbExNaLfeb+qJqXmnIRFetjicyRg8RbKqLE0sh2IRYm
         wt2RheEa82blIOfGQwtFiMl8K59N10gvevjzUDj1e+nyR40qw7IPMGTCxFvfgHibTGus
         4snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/kcUz7iGlHGzh5+WMm96tVRqgBGqVmBjrJsf3+xK1w=;
        b=l2Cw8ISooLTWfyjGQ+aU4Ahs4XnjlGAtcqIQ20WywA4RMGa36XiV/6bhQ1Xtc+GAf8
         YG3E0IqtnvSQqHh62uDFrPlfp1fNB3pAOJs8gJREajudcSigWj0StvsmkYQmrw3BZ5YT
         H/vTFicuGirp6IOFST3J+I3IeySN8nvf/LsezE6m3NoyGYLRYQl4yjwCADxCSkpmfVDc
         22qykDDe89jXqUZsT2UWVOZSUTArmGJkq8hq1ZbiHMbwTileY8cIWFzUpMmJofdqg57n
         wDROnQjG8kb3L30PU167sRAhKzpuBeVhAPRgpCYxnwNKiTRQQOtFX7WFLTDorwdzF75N
         V8oQ==
X-Gm-Message-State: AOAM5320zZkq09CyXjAecUywC+BjTop44HNPqRN8qIWtEJRnEQQTrEQw
        giUnKmK0VpKqDLXE3ltESTU=
X-Google-Smtp-Source: ABdhPJzWOPeBb7ZR5wPCa08NQ2QSqxMgQ+VgmGCVXylXS1SERSV4H2spF22sy/9jxcqjLVLYcD3Vmw==
X-Received: by 2002:a17:902:e947:b0:163:91e5:d3c with SMTP id b7-20020a170902e94700b0016391e50d3cmr4755418pll.39.1654175357990;
        Thu, 02 Jun 2022 06:09:17 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id w2-20020a17090a15c200b001e32a7f876dsm3291062pjd.16.2022.06.02.06.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:09:17 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: ti: j721e-wiz: Fix refcount leak in wiz_get_lane_phy_types
Date:   Thu,  2 Jun 2022 17:09:03 +0400
Message-Id: <20220602130906.18095-1-linmq006@gmail.com>
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

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: format:7ae14cf581f2 ("phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index da546c35d1d5..c6b53d4f6643 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1113,6 +1113,7 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		ret = of_property_read_u32(subnode, "reg", &reg);
 		if (ret) {
 			of_node_put(subnode);
+			of_node_put(serdes);
 			dev_err(dev,
 				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
 				__func__, subnode->name, ret);
@@ -1127,6 +1128,7 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		for (i = reg; i < reg + num_lanes; i++)
 			wiz->lane_phy_type[i] = phy_type;
 	}
+	of_node_put(serdes);
 
 	return 0;
 }
-- 
2.25.1

