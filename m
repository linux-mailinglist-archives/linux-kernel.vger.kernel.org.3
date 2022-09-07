Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF895B081F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiIGPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIGPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:11:58 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA1565722E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:11:56 -0700 (PDT)
Received: from lemmy.home.8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 8C935240A3E;
        Wed,  7 Sep 2022 17:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1662563515;
        bh=KmpFpEz/lyHaEET/ThZz16jqJhRrdPrH8I/CQGSh0EE=;
        h=From:To:Cc:Subject:Date:From;
        b=tSBsAA5F/euIUSUVa3hW4mgnDwG/+G9aXFKoTqf1dBUwtIs661DrL6++eaMjQNMkY
         z1K4YABe5aQDz/W4H6ig14SVS+b8dK3JaieCO+WCx3/Jw9Q30GyOdroe1skonkJSqh
         w6Qi9vAdbQmMoTyxNBKDhu4ydZYitsJajoSX/ljQ3FkXR+vdyYDvCqC1c/iEP3uMbe
         b5iBKOFA+Eezm0z6Kcn49MKBCT8SuUx6kjhfEqXb223k1q7oGsIBacGIIwhIPwD7hT
         GFquWshAK15inEjOsUHUncIw7LiIT/pw1ythPAVGsEkd7IKBhT7bzDViCWSMJ5A4Q3
         w5TIWNwYAr8Xw==
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc:     Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/virtio: Fix compile error with viommu_capable()
Date:   Wed,  7 Sep 2022 17:11:54 +0200
Message-Id: <20220907151154.21911-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

A recent fix introduced viommu_capable() but other changes
from Robin change the function signature of the call-back it
is used for.

When both changes are merged a compile error will happen
because the function pointer types mismatch. Fix that by
updating the viommu_capable() signature after the merge.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index da463db9f12a..1b12825e2df1 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1005,7 +1005,7 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
-static bool viommu_capable(enum iommu_cap cap)
+static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
-- 
2.36.1

