Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280C50B7C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447661AbiDVNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447645AbiDVNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:00:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640757155
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650632255; x=1682168255;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TfPXEDZ0wsvvSiziOKKU6KS+4As1rWJk63FBDGUPGvQ=;
  b=R226dHKvLk9kDLumrjcOdkAi7b/8iN2fAwWtXBkX0kPv6JWTsMenK1qL
   1HODekOnHMXDKIrQdzWypCtSkhvCiic8DTlf5X3BlE83h6vgMQeQ4lVRX
   a24hewMr87+fwBXw7lilwUtZO0XyzkWd+oghJzSZ8DiKOqfiSnufA+jxy
   jjBxwnIZx7NRTYmeDfYcTTh+PWPK4dj49dtK6qQx7yySUNjfjOqUU3h1i
   4ULwpziwfV2QDMPAz7nak401Gdbk1vbxZdPk71y8F+qgFXwKGM81BG44P
   iFY1H/hU7eU7TMebCzl8cgadwv8Yly91UBLVuuqyXiZ4NXiOR69i+w89M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264443891"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264443891"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 05:57:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="556362809"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.236]) ([10.254.215.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 05:57:33 -0700
Message-ID: <2753cdef-4745-cb9c-b8db-6b336cd8082b@linux.intel.com>
Date:   Fri, 22 Apr 2022 20:57:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Use dev_iommu_ops() for probe_finalize
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <84b891ba40e4cea924ee4ea1167b00e87ad38b18.1650630616.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <84b891ba40e4cea924ee4ea1167b00e87ad38b18.1650630616.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/22 20:33, Robin Murphy wrote:
> The ->probe_finalize hook only runs after ->probe_device succeeds,
> so we can move that over to the new dev_iommu_ops() as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> 
> Another cheeky little one which doesn't need to wait...
> 
>   drivers/iommu/iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1b8dcda5fbe4..8825a4628e46 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -315,7 +315,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   int iommu_probe_device(struct device *dev)
>   {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	const struct iommu_ops *ops;
>   	struct iommu_group *group;
>   	int ret;
>   
> @@ -352,6 +352,7 @@ int iommu_probe_device(struct device *dev)
>   	mutex_unlock(&group->mutex);
>   	iommu_group_put(group);
>   
> +	ops = dev_iommu_ops(dev);
>   	if (ops->probe_finalize)
>   		ops->probe_finalize(dev);
>   
