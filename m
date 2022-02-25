Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7764C5133
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiBYWHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBYWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:07:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE401F636C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645826792; x=1677362792;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0LnNa5rgaykiuNGMZGPVXAMkCcNVFd2QMGGkX2fDMc=;
  b=fW/WVDVrg2g4JRNkndn9IdZ0zyybZ6MUeMWiGv45/u32zWaVtmgK58Tz
   OVUed07z9k4glq8qGM6h6VmS85PYJMPXXQWXXNwvjOl0RgLN34Xf1rbXc
   6WahMQm7ZdfTv6iDEXhmjq3NAsFuiu/U0ww33zjFtTr+mDcJqvTdjR93w
   HTFgnnsBYqONRtnWTdzzg/QShoU/FzU9c+7bYsc41GDmNmGtmhf3MhZ1w
   Xok+ZlqtYlkTiYjMp42Ezs7Qg6/zUqMHoEmVFjmwQrbnHd9bw7umv3ymq
   sO2WYzTZUpXQ5GFo0CfV4vNUEjzhXikJXMsztwpJXHKhoycWSKbmv0CgQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="233214070"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="233214070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 14:06:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="684776647"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 14:06:32 -0800
Date:   Fri, 25 Feb 2022 14:09:37 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v1 09/10] iommu/vt-d: Refactor
 dmar_insert_one_dev_info()
Message-ID: <20220225140617.63a95344@jacob-builder>
In-Reply-To: <20220207064142.1092846-10-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-10-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi BaoLu,

On Mon,  7 Feb 2022 14:41:41 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

>  
> -	if (dev && domain_context_mapping(domain, dev)) {
> -		dev_err(dev, "Domain context map failed\n");
> -		dmar_remove_one_dev_info(dev);
> -		return NULL;
> -	}
> +	/* Setup the context entry for device: */
> +	ret = domain_context_mapping(domain, dev);
> +	if (ret)
> +		goto setup_context_err;
>  
> -	return domain;
> +	info->domain = domain;
> +	list_add_rcu(&info->link, &domain->devices);
> +
There seems to be an ordering problem. We need to do list_add_rcu()
*before*  domain_context_mapping(). Otherwise, while doing context mapping
the search for dev IOTLB support in iommu_support_dev_iotlb() will fail.
Then ATS capable device context will not have DTE bit set. The result is
DMAR unrecoverable fault while doing DMA.


Thanks,

Jacob
