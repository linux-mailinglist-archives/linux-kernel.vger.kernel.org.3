Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0F522B84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiEKFJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiEKFJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:09:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7196D19E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:09:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so3872336pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gq3sKC60SlE1+eqSd0WEC2zbcLYJeGd4RWGvL2PnVo=;
        b=L5ekbGaTbHgSsh0r0y/zK4RhBJ+lXwEzBFBByDBax0oQlNdDzs4Nmp8n3gaPjtZLlZ
         QQKetg8TBFkSJ08qx6TUveyXFAdt8DhFDP/9hjKukMvSOV5cC7CDUZJzLaRv40GREyNa
         14FW4YDz86Q5UF49J6G3h9I8vtaX4XZfRRe5N1gucDftFkpVmBiov3KFEX19pbqJT6AN
         j/1NUewVh4sKZrX7j/p+eXzfAxgqV6O5Nek/EERMm7YbPVLtZImC3x65ElfFFCjGmEFi
         P2A060F8R3PhJN6UUHOYUFUwqoHwmSOD2cQ43Se0icrOcSkEO4SAQnlRCRkmxoMCdbHD
         MslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gq3sKC60SlE1+eqSd0WEC2zbcLYJeGd4RWGvL2PnVo=;
        b=Q15m6PeJl6bN92h8GOEFynQDuO6ppC7RCBPVWZ6Zt7c//ELmeHiuyvmXQYx5CtDi9Z
         t1yhoYT57VsoQxxc1s9JgFJNNRkSKtDZu9CIYMAJH/iTPPpzdTgIlezbMTOrr+yAOQNB
         tVcfpzDFlSBxu/+W4Li88Gyyv/DqwY4bcYDJ8XdajbfMUNMrFecCN+9moEZl6Vf0AE0y
         0kMDYxoE1JRg6ze/LQRtStabUWyBRx73OV/9aoZdJLTy9oRE+lWZb9KfF79n6gTu4B4S
         WqDXthgtEl0Q78keO4IoL/jEYCu6nTtwBSovY/UkDG19GoCLnA4oyj73tl/uW/vD9VbV
         w/WA==
X-Gm-Message-State: AOAM533ksStF3Sr4DUvCGj7C+QEDC8BngQNy45JG/QkMRlJmRnkUKck9
        yOL0HmEXDoi9eRwgJFKBf4c=
X-Google-Smtp-Source: ABdhPJx0pFUFYJjVt28setLfLu4qvNgaY8D2j7D6DoMGcX9NPav0eUXgwrj31VFCo7KV0wUsGF77UA==
X-Received: by 2002:a17:90a:cf:b0:1d9:44ad:2607 with SMTP id v15-20020a17090a00cf00b001d944ad2607mr3432138pjd.25.1652245762403;
        Tue, 10 May 2022 22:09:22 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y5-20020aa78045000000b0050dd876f5f8sm497649pfm.49.2022.05.10.22.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 22:09:21 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: HiSilicon: Fix refcount leak in hi3670_pcie_get_resources_from_pcie
Date:   Wed, 11 May 2022 09:08:53 +0400
Message-Id: <20220511050903.42763-1-linmq006@gmail.com>
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

1. of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.

2. bus_find_device_by_of_node() also take a references, use put_device()
to drop the reference in error handling.

Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index 0ac9634b398d..01f3090b4372 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -565,6 +565,7 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	}
 
 	pcie_dev = bus_find_device_by_of_node(&platform_bus_type, pcie_port);
+	of_node_put(pcie_port);
 	if (!pcie_dev) {
 		dev_err(dev, "Didn't find pcie device\n");
 		return -ENODEV;
@@ -581,6 +582,7 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	phy->apb = dev_get_regmap(pcie_dev, "kirin_pcie_apb");
 	if (!phy->apb) {
 		dev_err(dev, "Failed to get APB regmap\n");
+		put_device(pcie_dev);
 		return -ENODEV;
 	}
 
-- 
2.25.1

