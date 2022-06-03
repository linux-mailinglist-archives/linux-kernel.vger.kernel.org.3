Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4053CA5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbiFCNFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244506AbiFCNE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:04:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8226455
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:04:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so12044928pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgx3vHNyJbaOi/OKE5EKg7IR7hr4OygDFxk7UQieO18=;
        b=cVglTdj9MVE0vlUFsrXgWQ3B5eWCleCCPkLjgPBT2Ik+i4PYzM55ENiK561uDJc5kr
         oKcjPQeto/5Xx2WiEQug+CqXlqw98LpBqFCX+doTWXvTGH548sazDYwe2SRFsgYWKGmk
         ApdmlNLIYZRFYDwyPM2wfB6USMvZjN13PxVpLXdZbCbrBCo5Q3TDJbJXMYrWE178tAHN
         1qC/NgJfXjoZfbEJTHsb/emXaDEpFR06vwlLBXinial7us4oToDa1VpH0dxTPeY1EcFG
         9okxNJJ23Gj2bUo0U/PJU8d+2l/mb4caQ0CtdvqxR6a8hgz9QXrsfaN7QTiIO5hpw3PU
         WpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgx3vHNyJbaOi/OKE5EKg7IR7hr4OygDFxk7UQieO18=;
        b=vlwAl6aQDbjiBRDYOrsLPZb2jiDfQUTiZNJCd+FiXRwYSClNPDY5FuCy8tKc+a5Zsg
         3z2g1bsuewFFF1wAhg4ts8TACe4r+JQaYFCINlk4FCf6GUMBPJ3Ikjd47LxtZlCsDD1p
         RhhR7rBLvazppPK16vDTgfe2cpFGuVtSF1fZBUntJKXpgMFVfqGBxMFFFEyyUDKVyZoq
         7V7Y3lUhZqtzzhXgbWWgL0Lix+4YwyyRRaaHRzMhdiz4DcijgkWZAlIytHED1OH4+wef
         KtxXtEU+rKxmhMfCv0/ftjXvWoWMYtpZH2dSDvAxm9eYJB72gguBfw+Wb0xhaPpXmxq5
         uxJQ==
X-Gm-Message-State: AOAM532NWKAIHAwe4KjQ5T1hXU4OleMFTTcWWvAZ8QO+k3AI/4cyiK9C
        sVDwoJlL38SseFzVTLXTA7c=
X-Google-Smtp-Source: ABdhPJwruDljVXqATyDd4k7ZLwZ0z6BzXJRH7II470dwr72K7QZ1irkVJ9/f5Du5DV97WEQhocWG6A==
X-Received: by 2002:a17:90b:3b45:b0:1dd:1f37:d159 with SMTP id ot5-20020a17090b3b4500b001dd1f37d159mr46298929pjb.44.1654261495269;
        Fri, 03 Jun 2022 06:04:55 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s1-20020a63e801000000b003c14af505f8sm5226110pgh.16.2022.06.03.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:04:54 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jyri Sarha <jsarha@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: ti: j721e-wiz: Fix refcount leak in wiz_get_lane_phy_types
Date:   Fri,  3 Jun 2022 17:04:42 +0400
Message-Id: <20220603130446.36924-1-linmq006@gmail.com>
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

Fixes: 7ae14cf581f2 ("phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag.
v1 Link: https://lore.kernel.org/r/20220602130906.18095-1-linmq006@gmail.com
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

