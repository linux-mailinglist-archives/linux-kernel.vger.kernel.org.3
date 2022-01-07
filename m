Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2572E4873DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbiAGIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbiAGIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:04:33 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA00DC061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 00:04:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x15so4358492plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 00:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5wW8NfAn9pQjxsJKsrZHm4OzxBBzuThAXcIy8E5AppU=;
        b=C/xfse/uxT2x9U/Tl+654bYJSgGUNOo661B+VyheRZrXA/TtzFIeiRbcIjHxH0RYT3
         Gt1y6wEmMzdV8HTH5F6gk6s7qQfFX5GC4TPFO5rzoerh5MXtn+dw2XgjPTNca20YiBsT
         R+7t5IOsj4DquenT2BiiGtDUXvlqb//qBkTGVoQNFOVTDR14/qfqVu2/KGLImu4ASX3r
         btfkRNgesp8oC4WSYRI9FoknS5gKBUSssP5udDH1o1fHs/0NKNuqaMTBs2xddLVKYAEe
         EvwXR+J+pDbICtJOAydYtPMb2OGRgH+D0PjgGoXXMd1aI7xvFqS2pqQ6MJtIq2k6uOwx
         7HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5wW8NfAn9pQjxsJKsrZHm4OzxBBzuThAXcIy8E5AppU=;
        b=hldFpKQ3ZRHnLbAOcwpzAqlIUsibnD7TBNWrm+Umn/ESV4Q9Pn7RrCjdAVkoUqNp9t
         /as7QGpd2Tk60JsxlXb1BxoIWEGd2w4A78b1LHMOs1hPhJcZj4HeMovpf4GmVtkBOZyu
         2komzP2OlYHSBKovR8gpohPus0JNXP79D4h8/HYQWdx0MeYzr6wxaaaFamwABV0KZQxM
         gU0hd5eb11y7o5vTgG4j7nDwtoEM7v1JjJSEM/PychHp3T24IoATShYmin0qYpHrzAhi
         3TslKCrW5V7maQWckQon7yXLlza7K0KseymZeJV6l4P+M5dHzPccDpjUgl5Ijf13383U
         5zRg==
X-Gm-Message-State: AOAM530AEHus7v4NrSbDrfayfnEgGW1r7dwu8WFq1QpAvlhiytP5uRjb
        gC41EjBJs2F/GXFDhsx6Kd4=
X-Google-Smtp-Source: ABdhPJxqn041UHbxvVSnHdNKGkj65+PAU2TXMvpsM1SyWkimxkNQbsHYzQdgIS0Tn1N+1c3rRVAyhQ==
X-Received: by 2002:a17:90a:7f98:: with SMTP id m24mr6788243pjl.163.1641542673336;
        Fri, 07 Jan 2022 00:04:33 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f10sm5416663pfj.145.2022.01.07.00.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:04:33 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Suman Anna <s-anna@ti.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/omap: Fix missing put_device() call in omap_iommu_probe_device
Date:   Fri,  7 Jan 2022 08:04:28 +0000
Message-Id: <20220107080428.10873-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling paths.

Fixes: ede1c2e7d4dc ("iommu/omap: Store iommu_dev pointer in arch_data")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/omap-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..cbc7ca5e890a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1684,6 +1684,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
 			of_node_put(np);
+			put_device(&pdev->dev);
 			kfree(arch_data);
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.17.1

