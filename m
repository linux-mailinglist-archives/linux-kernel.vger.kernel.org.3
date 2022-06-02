Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2688353B732
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiFBK3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiFBK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:29:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D31101F8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:29:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so4499327pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63b5H/jbrN4zsEaLSTowv5XFpFbFjaloCWZOaeCKErw=;
        b=FFB+1QOTTt8is4Lpy02ycAznu7zIS+nBeHgJm6A97sArAMtK4ouvIfXi/9Nmo02kFX
         x9Su2oapjRRtbDbKcG5zsp+U2MNJ07zXfURS0G2T4Dw/T3RNrEE7dyZpfn2BY8aAhaYV
         EfLwDuONuMr/5B3geO74OagdcDHZhW2r4BZcxkghTheDsLBz7gZ6YrkdcfRsGAWbq+em
         oZYbT5CyIotGnq8CpQv0rTlIMQPYae4hbre2C+joSY96odjT8knDKaBt9Gt8dTgLkBuX
         MRGO1Z3aiNkxO+yBlG4Gg9qdKl6tAtZyhFQp1L6GnE5OMlIj/VBjVRAqhhElOvpRozBC
         nW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63b5H/jbrN4zsEaLSTowv5XFpFbFjaloCWZOaeCKErw=;
        b=JYx8eraDepQh72wwL6BxIZtTf4Sdnoy69da7qOOI1IePdB8TxRy2MChAZ8OCifTTNG
         lFOpovbaPzSi7OBuZTP/YNgbQ/xL3gr96TwDy2rreoys6lHeeQFT3aUFSZxCdzq+bKIc
         L+kqAuSfLKAlFMiDBRKcjbpK3k4REobNdeAnnE2WhEZQafX+QBdhc6aTbbmbUh0grWmH
         T+zyqRwqBzDcnt6FjfXluNZiEqH5FMGA/J5UQQ/6QHLPZTSVKI8DkP7dKLgpXT7F1Q4O
         X76CmFHf31/Mr7xAVjrWBYMJSaDDEjB4H9gip5flj4AiksJGzJuuQyDKxhaq8e35zXZc
         K3bA==
X-Gm-Message-State: AOAM533rFrCd4vxWLd/rarLoMuxE4BkLhV9Q10DsszpcLsxG/ZNkjNuq
        uvOAjkAQOcugwcTSM7sjEk4=
X-Google-Smtp-Source: ABdhPJwu9mqYKpYp1hwjbiBc5BO3cUGxpRnmcfigvPGjyE/9GFjj0Yq3NSrsum6ALSidivqGLDl+iQ==
X-Received: by 2002:a17:902:f552:b0:163:f64a:6154 with SMTP id h18-20020a170902f55200b00163f64a6154mr4202768plf.147.1654165780607;
        Thu, 02 Jun 2022 03:29:40 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id h11-20020a62830b000000b0050dc7628150sm3107441pfe.42.2022.06.02.03.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:29:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [RESEND PATCH v2] iommu/omap: Fix missing put_device() call in omap_iommu_probe_device
Date:   Thu,  2 Jun 2022 14:29:26 +0400
Message-Id: <20220602102926.47456-1-linmq006@gmail.com>
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

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path and
the regular path.

Fixes: ede1c2e7d4dc ("iommu/omap: Store iommu_dev pointer in arch_data")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- move put_device() before of_node_put().
- add put_device() in the regular path.

v1 Link: https://lore.kernel.org/r/20220107080428.10873-1-linmq006@gmail.com
v2 Link: https://lore.kernel.org/r/20220301063326.18120-1-linmq006@gmail.com
---
 drivers/iommu/omap-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..58f3efdac3f7 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1683,6 +1683,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
+			put_device(&pdev->dev);
 			of_node_put(np);
 			kfree(arch_data);
 			return ERR_PTR(-EINVAL);
@@ -1691,6 +1692,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		tmp->iommu_dev = oiommu;
 		tmp->dev = &pdev->dev;
 
+		put_device(&pdev->dev);
 		of_node_put(np);
 	}
 
-- 
2.25.1

