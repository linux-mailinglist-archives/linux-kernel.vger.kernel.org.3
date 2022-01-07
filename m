Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3D4873EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbiAGIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiAGIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:09:22 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D0C061245;
        Fri,  7 Jan 2022 00:09:22 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s1so4856459pga.5;
        Fri, 07 Jan 2022 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=caUCLOkN9Sm5eFbTFlsGP0xGxd9i8A6ITsUxSKuDZSU=;
        b=WY/WNVDa2zoOWuTB2YVH4wuHLFq2e9CIso+fXhU/yxNqPV9XnMLUs0wHbcAcoSC8Cp
         ZdE9df2U1E1PBq0RNLJpJ6dAN/1F5Eewfpu4jvb1CSBW6Casb7KuqLiuzl71lW+E7uPj
         GyXI6xs7CBcNKVp1afXOFx23kY9H74FmQyPeklWjevF6nv2LAuEtif3vAvHzUAL+ICE0
         VbjgqgbboWbi4SOZCWoVgDxGTsjYSAfBQOEMIETCvifmIyvbmrNto9X4ZV7AKafuExyM
         kkOibA2PXx04DdKwBSDZ1ZYVq/nIUk2FpDAqJ2NEjKU6qYlO7g/7M5AgML58mJDvEcWO
         0FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=caUCLOkN9Sm5eFbTFlsGP0xGxd9i8A6ITsUxSKuDZSU=;
        b=ISMNuAvmqBAUqxBeeAc5XdiunpnNIPY3yGNkmwd4Obld3URa7nVQ45VsM5MbOSIP+z
         sGt/hF/M5diIGy3zSpOEAGCQhMbBCGLyf4q6BH9+3KA4kb/Qw3fu9/fTFv5TK7tmU/gI
         k1XyfgxQLt/gqQPPWVdYCgul0By5LSKMBGI06SZ1Pb5mAnMyJPl5fj1KplLjww82aAos
         xM3JgZWhqq9sXuHX67aozLsKi6tPoNE2qSigSsjpLi/i0Mz71zWLdiBmsAYkI97lkynB
         URpOd6G79DziYXEXxJHYQqBxJnmx5YH2Lgv6DlyTQTRnADd553G0fAba/ckV7HJ2GHyE
         R0KQ==
X-Gm-Message-State: AOAM533KoCJi1nsP9YE4ZQGWXHUSy1mc5pVd+/+m2EXv6elgLxFnE+Qr
        kAYoU5w7cg+l5MtEg/LwmMY=
X-Google-Smtp-Source: ABdhPJzXiICbOdrKbRllujNfXHikmjg0aDAbByOyuYXvxpGswTzgKfpOmmbL0h/jbB/xfkqNf5bN9A==
X-Received: by 2002:a62:7813:0:b0:4ba:7afa:3786 with SMTP id t19-20020a627813000000b004ba7afa3786mr63360812pfc.55.1641542961614;
        Fri, 07 Jan 2022 00:09:21 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id il18sm8686899pjb.37.2022.01.07.00.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:09:21 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/tegra-smmu: Fix missing put_device() call in tegra_smmu_find
Date:   Fri,  7 Jan 2022 08:09:11 +0000
Message-Id: <20220107080915.12686-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: 765a9d1d02b2 ("iommu/tegra-smmu: Fix mc errors on tegra124-nyan")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e900e3c46903..2561ce8a2ce8 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -808,8 +808,10 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
 		return NULL;
 
 	mc = platform_get_drvdata(pdev);
-	if (!mc)
+	if (!mc) {
+		put_device(&pdev->dev);
 		return NULL;
+	}
 
 	return mc->smmu;
 }
-- 
2.17.1

