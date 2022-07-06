Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED689567BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiGFBxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGFBxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:53:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D1F5A7;
        Tue,  5 Jul 2022 18:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657072426; x=1688608426;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cllxWuAAFHFoBQ2YHklsc1bQWN4Ue9DGBlCsCLtMYVY=;
  b=DqdcywRBAMvxMouIMH4yS/vJ25gUizGRlA5XXGarFK3DH4GuOsrQxZHp
   hNsyKv3yfoWDrKnsj0FuaTHQ/2vfaXtAZ1ibldoPtdOxc90Qi32nBIQWh
   qJiOlpBXYwgXHk8Iy1yYCblScjSQjlI70GS+vhWLMYcsWGZiU9hb/PC/8
   LiKgHK1H1ODtk0xpx29bO4jR60MCFSRPV6a+hOpod/dx58wa4MSxLFy8Z
   WRItjMv/vjhjwKNLzQAfKNGh7layD4dO6IRHeLJXpKhxbkzC1sHDPMxwT
   wGzjAWtEXnZhHXjsFa6lorc7iDr9UZmu17cBujz7aqKKjhHMtxjXiAZO9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347598260"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="347598260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:53:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="650433945"
Received: from zhuoliu-mobl1.ccr.corp.intel.com (HELO [10.249.174.206]) ([10.249.174.206])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:53:42 -0700
Message-ID: <1fab4c8a-7bc5-9a50-d48a-0dc590cac7a6@linux.intel.com>
Date:   Wed, 6 Jul 2022 09:53:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] iommu: Always register bus notifiers
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/6 01:08, Robin Murphy wrote:
>   /*
>    * Use a function instead of an array here because the domain-type is a
>    * bit-field, so an array would waste memory.
> @@ -152,6 +172,10 @@ static int __init iommu_subsys_init(void)
>   			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>   				"(set via kernel command line)" : "");
>   
> +	/* If the system is so broken that this fails, it will WARN anyway */

Can you please elaborate a bit on this? iommu_bus_init() still return
errors.

> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
> +		iommu_bus_init(iommu_buses[i]);
> +
>   	return 0;

Best regards,
baolu
