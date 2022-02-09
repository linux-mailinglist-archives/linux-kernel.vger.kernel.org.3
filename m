Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740064AF3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiBIOR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiBIORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:17:53 -0500
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 06:17:54 PST
Received: from forward401o.mail.yandex.net (forward401o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::694])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3FC06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:17:54 -0800 (PST)
Received: from myt6-1d5cc1e732c7.qloud-c.yandex.net (myt6-1d5cc1e732c7.qloud-c.yandex.net [IPv6:2a02:6b8:c12:400d:0:640:1d5c:c1e7])
        by forward401o.mail.yandex.net (Yandex) with ESMTP id 12643132BE5D;
        Wed,  9 Feb 2022 17:09:41 +0300 (MSK)
Received: from 2a02:6b8:c12:3ea4:0:640:a551:2e99 (2a02:6b8:c12:3ea4:0:640:a551:2e99 [2a02:6b8:c12:3ea4:0:640:a551:2e99])
        by myt6-1d5cc1e732c7.qloud-c.yandex.net (mxback/Yandex) with HTTP id d9aY5k0cNOs1-9ecmFMq6;
        Wed, 09 Feb 2022 17:09:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxt.ru; s=mail; t=1644415780;
        bh=5ulkJqajbHG9J23l0qCLkGERVMQ9orcqxfnm8rT6Fyw=;
        h=Message-Id:Date:Subject:To:From;
        b=h4+jJ164rHZPVkXJ/eIWkrU5kqR733nUGGFEvo7PEEMqOl5XJ2eK3JITXUcTMoj/4
         5YpyXJn17adziOWSZwAgDSamj/o1MW/qDaoRfu+vlVJ4iX9gEK/fxDbC9/MYkFRvL9
         IwU9NaPJTDlevla9lnLvddfMHaBxgng9g+hlpEXA=
Authentication-Results: myt6-1d5cc1e732c7.qloud-c.yandex.net; dkim=pass header.i=@nxt.ru
Received: by myt5-a5512e99e394.qloud-c.yandex.net with HTTP;
        Wed, 09 Feb 2022 17:09:40 +0300
From:   Aleksandr Fedorov <sanekf@nxt.ru>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: explicitly check for NULL in iommu_dma_get_resv_regions()
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 09 Feb 2022 17:09:40 +0300
Message-Id: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_dma_get_resv_regions() assumes that iommu_fwspec field for
corresponding device is set which is not always true.  Since
iommu_dma_get_resv_regions() seems to be a future-proof generic API
that can be used by any iommu driver, add an explicit check for NULL.

Currently it can work by accident since compiler can eliminate
the 'iommu_fwspec' check altogether when CONFIG_ACPI_IORT=n, but
code elimination from optimizations is not reliable.

Signed-off-by: Aleksandr Fedorov <halcien@gmail.com>
---
A compilation failure has been observed on a gcc-compatible compiler based on EDG.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..474b1b7211d7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -382,10 +382,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
+	struct iommu_fwspec *iommu_fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+	if (iommu_fwspec && !is_of_node(iommu_fwspec->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
-
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
