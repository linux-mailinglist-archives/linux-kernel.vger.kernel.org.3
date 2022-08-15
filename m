Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8735C5932E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiHOQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHOQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E31BF72
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71548113E;
        Mon, 15 Aug 2022 09:20:25 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 385D33F70D;
        Mon, 15 Aug 2022 09:20:23 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/16] iommu/vt-d: Handle race between registration and device probe
Date:   Mon, 15 Aug 2022 17:20:02 +0100
Message-Id: <579f2692291bcbfc3ac64f7456fcff0d629af131.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we rely on registering all our instances before initially
allowing any .probe_device calls via bus_set_iommu(). In preparation for
phasing out the latter, make sure we won't inadvertently return success
for a device associated with a known but not yet registered instance,
otherwise we'll run straight into iommu_group_get_for_dev() trying to
use NULL ops.

That also highlights an issue with intel_iommu_get_resv_regions() taking
dmar_global_lock from within a section where intel_iommu_init() already
holds it, which already exists via probe_acpi_namespace_devices() when
an ANDD device is probed, but gets more obvious with the upcoming change
to iommu_device_register(). Since they are both read locks it manages
not to deadlock in practice, and a more in-depth rework of this locking
is underway, so no attempt is made to address it here.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: Update commit message

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7cca030a508e..65c340e2003c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4449,7 +4449,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
+	if (!iommu || !iommu->iommu.ops)
 		return ERR_PTR(-ENODEV);
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-- 
2.36.1.dirty

