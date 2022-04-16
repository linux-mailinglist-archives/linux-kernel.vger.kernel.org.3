Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F79503354
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356703AbiDPAHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiDPAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:07:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC931E3FE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650067488; x=1681603488;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ORZu87hIYWf3otFQvn50x69LdK/rm8I6UEhGlMpo+9U=;
  b=jclw5Fp1mvvq0PwQ2mrqa5EDI2qYrn7rF976e4ISAGrIeKfe0vEq+Cll
   wRzl9QKgOReSgMJT+MOHnsQK7J6eQxDo+wf3Q0CQnjTfbhcUza6ey1uC+
   CfYWB52dBEWGw36VyYBxw4+3LziRU2MJM+F7rk0XeC0eeID//SzyUmLf+
   Vxz3mwbvjTXDIB6X3qf/beEWVkfb5qxAyr5+KtMQGBKWYVRdTrx2b8GJC
   F5vrBPqXpybxCHEN9eOFc9BcTXjZ1MHKmEF1PjIUAPWicLjViU57KsAX2
   J2qtjMjAsqWGK6fFkIaLOo4xLXLOeszUQEzGcsffvPZJfz+q6v4rQ5vTx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263007084"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="263007084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 17:04:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="574590902"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.123]) ([10.254.212.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 17:04:44 -0700
Message-ID: <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
Date:   Sat, 16 Apr 2022 08:04:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        yong.wu@mediatek.com, mjrosato@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/14 20:42, Robin Murphy wrote:
> @@ -1883,27 +1900,12 @@ static int iommu_bus_init(struct bus_type *bus)
>    */
>   int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>   {
> -	int err;
> -
> -	if (ops == NULL) {
> -		bus->iommu_ops = NULL;
> -		return 0;
> -	}
> -
> -	if (bus->iommu_ops != NULL)
> +	if (bus->iommu_ops && ops && bus->iommu_ops != ops)
>   		return -EBUSY;
>   
>   	bus->iommu_ops = ops;

Do we still need to keep above lines in bus_set_iommu()?

Best regards,
baolu
