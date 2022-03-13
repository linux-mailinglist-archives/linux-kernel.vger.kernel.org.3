Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4754D75FE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiCMPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiCMPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:05:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B53E31373
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:04:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 232CD1F43CEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647183849;
        bh=cUyv0+joqyyblWs/jcm3ksmtGjWXrSfWZ05J1LGle7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Kh0DGvyjL949sCDNHc2EF2VBnaEibiD9QOXCU/CiMWCBuMYZ+lDfTv5Fn6lDiSe43
         aXFsyk4W/T2d3UcOKwNzOuTmcBfeQIVgsFQTQ3cSz0kstPkiQPd8FlWlrupxhCu74w
         FkYjYcLwO+UYA+ZYukkHQc7vTCfRS/GDRaS6xyEiSrVpVctsjiSVuzf9bk3rWuZnyJ
         YLBN/lKDUbiy12Pzrls2vByc8ZkOB0yWhVlMghlZf/c71VwLzpBAyPBBObpFKiZNvd
         6HVtJ7EioPqdCDJ9Ds/f7GqRlQ2IiYfUKcLhjvzBSF3OFFHuJY+5sXy0n8590/OtPK
         U6elmxL3amUCQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: remove unneeded validity check on dev
Date:   Sun, 13 Mar 2022 20:03:37 +0500
Message-Id: <20220313150337.593650-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_iommu_priv_get() is being used at the top of this function which
dereferences dev. Dev cannot be NULL after this. Remove the validity
check on dev and simplify the code.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942b..f79edbbd651a4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2502,7 +2502,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		}
 	}
 
-	if (dev && domain_context_mapping(domain, dev)) {
+	if (domain_context_mapping(domain, dev)) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
 		return NULL;
-- 
2.30.2

