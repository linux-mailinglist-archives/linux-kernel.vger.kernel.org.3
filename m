Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0762D4C842E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiCAGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiCAGeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:34:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144226FA32
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:33:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso1229645pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mPo8lvO91fSVL2zNMVudPsfj5UeWu8/OYFDNcv6JjI=;
        b=EyPMwTGdSNloKDGKnCt8Rx2I35rLxgk25XazRMqOUdZAnlqtNAaW0nMyonJiVrtKmE
         yP3lz59YCiJ8K1jROjN7oh95FFAscuHexJXRDsuSXRCPYUJO3PqAPkirtQx94qiQsqnY
         PaSrbE1Ef+S/4DJ8DYi++i3W3+G5mD8JjK3gW/DaFx6VaepqdN9IPFSzmUj+XFZyV8Ce
         YbG8WLEop0vY5p68XEc5rcCMF4toOedFJ73D2Cn0B8b2JIFOfd8lg7cG8YPaUlVPx5c+
         Y9JrVKc4EytbyKW4xRpAOMB8NtJLaRlTWVnGoPY8k+jx9p6eCQyaJynwOg+jehwCnycx
         yhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mPo8lvO91fSVL2zNMVudPsfj5UeWu8/OYFDNcv6JjI=;
        b=qQDP/ksf3mXJtI5BKaAfM689xearrtuzVFEVFbqz2fQTzXSY5SHaWRw84HzQ6zsFat
         zktSjeBH3EAENgphmxGoQ28IjQ2ZRlKe41uj0g0FMQiclfqoWRu2UDz7E1AdB3t5XLsD
         ZiSWw0Msvzt6gDm2qLO4bfcOKZcsS3x/GtjC+zb42sPHV9XpXoxrZF/HpzVJ7oAKnEpR
         R7SgSOjw3a5zmjNYo6pyjW3rXM2OHzBafAXOtoOAz9aWDPXP9YGmdaEqZ9uWjr0TGLX0
         a2Stdvh0mThViH6tAF8XsZimWx/aqy2HIXVebPy2mqykwnBoDqA4uOvcopCkAXjrVEW0
         f/8w==
X-Gm-Message-State: AOAM53195vQa74W5JSIjoFdC7M9onN15b60e5JeZYXiTJ8Nh6QnKFL8K
        56OncUC2YHGmbuR8oqTZIaOt4IBdCDSktwD7RXY=
X-Google-Smtp-Source: ABdhPJxdw4f+rvERiG34ZF0VdlqFmBtf/joQpRNDllZHRbpWuzAwzWwF9v2uTYwiaAQTf/T2yM4txg==
X-Received: by 2002:a17:902:b58d:b0:14d:3d38:2690 with SMTP id a13-20020a170902b58d00b0014d3d382690mr23671504pls.78.1646116419615;
        Mon, 28 Feb 2022 22:33:39 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s17-20020a17090a441100b001bc1b59fe1asm1087916pjg.38.2022.02.28.22.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:33:39 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] iommu/omap: Fix missing put_device() call in omap_iommu_probe_device
Date:   Tue,  1 Mar 2022 06:33:25 +0000
Message-Id: <20220301063326.18120-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
References: <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
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
---
 drivers/iommu/omap-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..2222b30a0a00 100644
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
2.17.1

