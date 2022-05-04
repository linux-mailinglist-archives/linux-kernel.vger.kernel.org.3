Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF3519DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348609AbiEDLRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348017AbiEDLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:17:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CBA1570A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:14:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A906C1042;
        Wed,  4 May 2022 04:14:16 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAA1B3FA50;
        Wed,  4 May 2022 04:14:12 -0700 (PDT)
Message-ID: <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
Date:   Wed, 4 May 2022 12:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right
 way to retrieve iommu_ops")
Content-Language: en-GB
To:     Jan Stancek <jstancek@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, bgoncalv@redhat.com
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com>
 <20220504075356.GA2361844@janakin.usersys.redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220504075356.GA2361844@janakin.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-04 08:53, Jan Stancek wrote:
[...]
> Hi,
> 
> I'm getting panics after hunk above was applied in this patch
> on ppc64le KVM guest, dev->iommu is NULL.

Oof, this can probably be hit with vfio-noiommu too, and by the look of
things, `echo auto > /sys/kernel/iommu_groups/0/type` would likely blow
up as well. Does the patch below work for you?

Thanks,
Robin.

----->8-----
 From abf0a38563bb2922a849e235d33d342170b5bc90 Mon Sep 17 00:00:00 2001
Message-Id: <abf0a38563bb2922a849e235d33d342170b5bc90.1651662442.git.robin.murphy@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Date: Wed, 4 May 2022 11:53:20 +0100
Subject: [PATCH] iommu: Make sysfs robust for non-API groups

Groups created by VFIO backends outside the core IOMMU API should never
be passed directly into the API itself, however they still expose their
standard sysfs attributes, so we can still stumble across them that way.
Take care to consider those cases before jumping into our normal
assumptions of a fully-initialised core API group.

Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/iommu.c | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 29906bc16371..41ea2deaee03 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,6 +510,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
  	list_for_each_entry(device, &group->devices, list) {
  		struct list_head dev_resv_regions;
  
+		/*
+		 * Non-API groups still expose reserved_regions in sysfs,
+		 * so filter out calls that get here that way.
+		 */
+		if (!device->dev->iommu)
+			break;
+
  		INIT_LIST_HEAD(&dev_resv_regions);
  		iommu_get_resv_regions(device->dev, &dev_resv_regions);
  		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
@@ -2977,7 +2984,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
  		return -EACCES;
  
-	if (WARN_ON(!group))
+	if (WARN_ON(!group) || !group->default_domain)
  		return -EINVAL;
  
  	if (sysfs_streq(buf, "identity"))
-- 
2.35.3.dirty

