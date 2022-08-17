Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0A596740
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbiHQCGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiHQCGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:06:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F598D00
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660701978; x=1692237978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eAXvkVBxq2Yz0rp1C3vUTZ4WeY9kQ3s6M3PSgH+MdjU=;
  b=ezuxv2Ce8Cq1eZD4z+WY7fbdh796in8AHDXVJ4vlFb5LCElKrgWvhi28
   slJowS9noQxQB0BMBs9hSL201JGnQtXbNcEPENtwHw1PN7NzIgOJxKb3n
   G78q1zw+4WPsWctjWyYZAUonpZuwmQMcHnqu7FXnsj1Vjer6ALKP8nEyx
   ZazlPE++XCTwPClaUymV5DqCQ5AgEtwG1E1XJ2mlMph6TsRHDsHY2BBNB
   /rdwJB11keZeE2MklWKjQI+7BNs88j9rG4hRJKkW0YU25JLV3SMM17rwq
   KKCVpBDS33TSVSA59+DjpC2cJYfcMRj5NYirPdwp4RYCaPcfJgdI8no0h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291131628"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="291131628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:06:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583563293"
Received: from xinpei-mobl1.ccr.corp.intel.com (HELO [10.255.29.150]) ([10.255.29.150])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:06:14 -0700
Message-ID: <a5e2c27e-8990-210e-1d33-c2147de75545@linux.intel.com>
Date:   Wed, 17 Aug 2022 10:06:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] iommu: return early when devices in a group require
 different domain type
To:     Yuan Can <yuancan@huawei.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
References: <20220816020701.90533-1-yuancan@huawei.com>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220816020701.90533-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuan,

在 2022/8/16 10:07, Yuan Can 写道:
> When alloc default domain for an iommu_group in
> probe_alloc_default_domain, the expected domain
> type of each device in the iommu_group is checked
> in a loop, if two devices require different types,
> the loop can be breaked since the default domain
s/breaked/broken
> will be set to iommu_def_domain_type.
> Return 1 when this happened to break the loop in
> __iommu_group_for_each_dev.
>
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 74bc9111c7be..0d4d78946d31 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1653,6 +1653,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
>   				 dev_name(gtype->dev),
>   				 iommu_domain_type_str(gtype->type));
>   			gtype->type = 0;
> +			return 1; /* end the outer loop */
>   		}
>   
>   		if (!gtype->dev) {

Thanks,

Ethan

-- 
"firm, enduring, strong, and long-lived"

