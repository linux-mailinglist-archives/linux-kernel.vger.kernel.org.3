Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B804AA63F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379224AbiBEDbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:31:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:23232 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbiBEDbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644031896; x=1675567896;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VhfmbidGFkvXxS9uiVajIYqkNoVhiNiwmTbCsvquo3E=;
  b=SyT8uvNYrh8kXu2kOGIvg7WiuWL3XhQtWDKeLSrRz1OqWuBss0ibXQVU
   Jhln2raaJFMdnZTybkkNi0vctYr3YG7EF+3VzcCpbd8Qd28LK5oVH2elo
   3bwBBoz6CL13q/Ba8d4xZb7eYBCAUaFIQlCNpr9PBPI4RRxoldqQ8S9i0
   Jq8xoLPMVA71h/3SxFyOD+0WSmzQhg6JH2145rT9tFc08jBQ0cJHRADOP
   8gMOLQENiqnvgX/LWSJHw3K2NIFB0iGRTGEk3IWN/yfjwAGEXqGXJfCaE
   1TE9/kDRnGe4segirdLTN5aly9J3msCy6RhqxnT+It4WQCzUyetxaHH7C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="309228677"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="309228677"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 19:31:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="699883713"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.148]) ([10.254.215.148])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 19:31:34 -0800
Message-ID: <9915edbf-ccda-be71-87a0-0c74c683d3d8@linux.intel.com>
Date:   Sat, 5 Feb 2022 11:31:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] IOMMU: Intel: DMAR: Replace acpi_bus_get_device()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        David Woodhouse <dwmw2@infradead.org>
References: <1807113.tdWV9SEqCh@kreacher>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <1807113.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/2 2:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/iommu/intel/dmar.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/iommu/intel/dmar.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/intel/dmar.c
> +++ linux-pm/drivers/iommu/intel/dmar.c
> @@ -789,7 +789,8 @@ static int __init dmar_acpi_dev_scope_in
>   				       andd->device_name);
>   				continue;
>   			}
> -			if (acpi_bus_get_device(h, &adev)) {
> +			adev = acpi_fetch_acpi_dev(h);
> +			if (!adev) {
>   				pr_err("Failed to get device for ACPI object %s\n",
>   				       andd->device_name);
>   				continue;

Please adjust the patch title to "iommu/vtd: Replace acpi_bus_get_device()"

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
