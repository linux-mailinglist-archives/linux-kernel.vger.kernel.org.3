Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129284B7AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbiBOWoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:44:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiBOWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:44:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBEF5437
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:43:50 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x4so442099plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2j3UCpWXBi4AmTzt5oXDEwOkgC+VwKfMNXNXsfNIBmg=;
        b=FNK69IXTJfKEfKcxbgiNQJ278OO5Vc0E/LupRMcQeZziacWg4+sb7MPa9on9wQcLN4
         1EtIUJLal3PKTMo/4IHdERnN2BbFrG+SatuEkIc3riHBQ1xgxv0UvXzpIEKavsWrEWVe
         BpSH9KGFrjh+I93D8yNdjmJz2ToU/pdoTeKRjlOSnv+h7N1Sd6h9FT3C7vg+44q6Uypr
         cTnSHaLV1EWf0eRnJREY/FSgDXES+v6dpy+kXtkeAhiPZfNbUZA30G2Ii6+ZHS1V8skT
         lJO0bS3Ho6nL4tnsUn3OhWXyR5Kogoa2MMXKaDTXYAdwCjE2wmwnKRPqHLqRn7bxF/jx
         ddpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2j3UCpWXBi4AmTzt5oXDEwOkgC+VwKfMNXNXsfNIBmg=;
        b=7t6xLH7U1hxsZa+9gaUPPecapUBI8JZrYOKgxeFJ9Iu+/SBG3rjOPdnt8+CJtcsb1d
         nP6WxzSDW+RmZIXhH1m5eZYNm3q7GUcxHicDiLammU9ZaRa01RMgfBBYbp7VktKmavjH
         aILppf5aElMEveNzBZUzaCjgysJb/YnH14WvgSBx/r7XcjzcAs/eNf1eIYmR44LiIKiy
         zYsU57dN8OKlQAV61oZoDJdtNX41C3IIczETPLBRBAmGZHHZXNDzVIuNlTNgknjw6g9y
         5T3LcMY6yBwNJEjw3T+73drpmpLMHmiih42FaThiXt4P/BXlg/WEoEWBA+mlqoOPdhBb
         xHtw==
X-Gm-Message-State: AOAM5327RjVKtSMg6H8jKcyY2FJLVOeej+vfGfuP+qKkems1wZnjPUMa
        LYvqwCO/wx5qUN+r1/BTmPc6gYrzvMI=
X-Google-Smtp-Source: ABdhPJz3Fjg8GVi3oVTBznPycf5n3SEn1rJ/8aJnPoOKEXjBQtMPgcCQ82B4vweHkQbw8eVddZ8djg==
X-Received: by 2002:a17:90b:4b4c:b0:1b8:b4fe:3353 with SMTP id mi12-20020a17090b4b4c00b001b8b4fe3353mr6977023pjb.113.1644965029242;
        Tue, 15 Feb 2022 14:43:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q21sm42538461pfu.104.2022.02.15.14.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:43:48 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        opendmb@gmail.com, robh@kernel.org, will@kernel.org,
        tientzu@chromium.org, Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS)
Subject: [PATCH] dma-contiguous: Prioritize restricted DMA pool over shared DMA pool
Date:   Tue, 15 Feb 2022 14:43:44 -0800
Message-Id: <20220215224344.1779145-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Some platforms might define the same memory region to be suitable for
used by a kernel supporting CONFIG_DMA_RESTRICTED_POOL while maintaining
compatibility with older kernels that do not support that. This is
achieved by declaring the node this way;

	cma@40000000 {
		compatible = "restricted-dma-pool", "shared-dma-pool";
		reusable;
		...
	};

A newer kernel would leverage the 'restricted-dma-pool' compatible
string for that reserved region, while an older kernel would use the
'shared-dma-pool' compatibility string.

Due to the link ordering between files under kernel/dma/ however,
contiguous.c would try to claim the region and we would never get a
chance for swiotlb.c to claim that reserved memory region.

To that extent, update kernel/dma/contiguous.c in order to check
specifically for the 'restricted-dma-pool' compatibility string when
CONFIG_DMA_RESTRICTED_POOL is enabled and give up that region such that
kernel/dma/swiotlb.c has a chance to claim it.

Similarly, kernel/dma/swiotlb.c is updated to remove the check for the
'reusable' property because that check is not useful. When a region is
defined with a compatible string set to 'restricted-dma-pool', no code
under kernel/dma/{contiguous,coherent}.c will match that region since
there is no 'shared-dma-pool' compatible string. If a
region is defined with a compatible string set as above with both
'restricted-dma-pool" *and* 'shared-dma-pool' however, checking for
'reusable' will prevent kernel/dma/swiotlb.c from claiming the region
while it is still perfectly suitable since contiguous.c gave it up.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/dma/contiguous.c | 7 +++++++
 kernel/dma/swiotlb.c    | 3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..3c418af6d306 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -416,6 +416,13 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	if (of_flat_dt_is_compatible(node, "restricted-dma-pool")) {
+		pr_warn("Giving up %pa for restricted DMA pool\n", &rmem->base);
+		return -ENOENT;
+	}
+#endif
+
 	if ((rmem->base & mask) || (rmem->size & mask)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
 		return -EINVAL;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..9d6e4ae74d04 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -883,8 +883,7 @@ static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
 {
 	unsigned long node = rmem->fdt_node;
 
-	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	if (of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
 	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.25.1

