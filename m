Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8AF553585
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352580AbiFUPL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352389AbiFUPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:10:52 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582072A422;
        Tue, 21 Jun 2022 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kX6TxBhPYP7/zzOagr1iopz1md+3ufdCaT6isU511rc=; b=B4KKsAdu7ncsWr+sdy3pVK/C2G
        F9YntmRgqGqxvX76WIfvo5Bto6O+odkTbiTPPDM+32fAURI4qFZVyFaXANbZOtWY6P1pAD4xoj14j
        xQcyruASEd11BtNOygFKk+XD2RvarhUmlEPkcW1xvo0WaBZPEs3uXQqwgWCwJNI/JXjIWQa9ge1eH
        dJngun6cI8gCZ1JV/+NuCUqIXwVm6N66Bik5gqtjaQbsubaJCpkHhhrDKkOtQYE9RQ1kqN/962VQg
        0QMqUW8pOmXl2Z03Ipm31EhdPeswilXhzfbGpDBe3JXtX+Uq7C2qRqrUPpZoiMAzpwbCe2g1jgEqf
        GFiXRPbg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o3fWU-00Ea3F-Gr; Tue, 21 Jun 2022 18:10:34 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v6 08/10] drm/tegra: nvdec: Fix TRANSCFG register offset
Date:   Tue, 21 Jun 2022 18:10:20 +0300
Message-Id: <20220621151022.1416300-9-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621151022.1416300-1-cyndis@kapsi.fi>
References: <20220621151022.1416300-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

NVDEC's TRANSCFG register is at a different offset than VIC.
This becomes a problem now when context isolation is enabled and
the reset value of the register is no longer sufficient.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v6:
* New patch
---
 drivers/gpu/drm/tegra/nvdec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 79e1e88203cf..386f9b2e78c4 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -21,6 +21,8 @@
 #include "falcon.h"
 #include "vic.h"
 
+#define NVDEC_TFBIF_TRANSCFG			0x2c44
+
 struct nvdec_config {
 	const char *firmware;
 	unsigned int version;
@@ -63,7 +65,7 @@ static int nvdec_boot(struct nvdec *nvdec)
 		u32 value;
 
 		value = TRANSCFG_ATT(1, TRANSCFG_SID_FALCON) | TRANSCFG_ATT(0, TRANSCFG_SID_HW);
-		nvdec_writel(nvdec, value, VIC_TFBIF_TRANSCFG);
+		nvdec_writel(nvdec, value, NVDEC_TFBIF_TRANSCFG);
 
 		if (spec->num_ids > 0) {
 			value = spec->ids[0] & 0xffff;
-- 
2.36.1

