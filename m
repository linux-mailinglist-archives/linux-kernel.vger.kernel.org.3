Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8484AC895
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiBGSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbiBGSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:25:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70CDC0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644258331; x=1675794331;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+g3d/khpgpbVGXsUIHT4OSkqD8lvmSb0Jeo3mZpjGic=;
  b=fzR4grscm8MQiKDT1TZur1bxVgIaXRsuGLCvDBlq/B11EpsHvj0rBSXj
   Sf4CKNsNisN+hVe9VFx6zL5nX+UsIRmlHwWsFOy2jvFpDP/PqF6R17w3P
   g2RUjfpaf0Y2UfsZ3XpabR2/JwseZZZaXu2kEnjZeOeJh/xW+J7P7he+K
   8qIYjJ4ziPfrEj+Mt+ijlusagPl8acimf5JyQo2ECNoLAyRfzu2Gd+2bK
   7u6xrPaRtZ/P49dBU1tjwCDjMdblxCfBtTn4SauiYSKd7a6j5LlbgOG2v
   eXa9z0WbkFlsZn9j1FvO0ucmduT2I5xzjJa5xH4E5nN356z9bouyjQBPL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="229428066"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="229428066"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:24:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="499290647"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:24:29 -0800
Date:   Mon, 7 Feb 2022 10:27:25 -0800
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
Message-ID: <20220207102725.3ce9320d@jacob-builder>
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

>  static void intel_iommu_release_device(struct device *dev)
>  {
> -	struct intel_iommu *iommu;
> -
> -	iommu = device_to_iommu(dev, NULL, NULL);
> -	if (!iommu)
> -		return;
> -
> -	dmar_remove_one_dev_info(dev);
> +	struct device_domain_info *info = get_domain_info(dev);
> +	unsigned long index = DEVI_IDX(info->segment, info->bus,
> info->devfn); 
> +	xa_erase(&device_domain_array, index);
> +	dev_iommu_priv_set(info->dev, NULL);
>  	set_dma_ops(dev, NULL);
> +	kfree(info);
Now that info and sinfo are under RCU, should we use kfree_rcu?

Thanks,

Jacob
