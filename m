Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3464855DFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiF1LeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344431AbiF1LeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:34:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB0C2FFCA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656416044; x=1687952044;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WyQ7Lhg64UA7faLJ8umQR8gY+ay9xEU5cNZImGlhWOk=;
  b=g++m3x6mmFxR0QSm6D15pTqOF+Bz7OH4dxd+KDBmDMAeF1IwxolEjvx2
   unj9GxSg6s0ecAnT6VWQhXU3wFzAaLoPIb+3G87x8oJl5j1k2b9Qw1LyD
   ihTZrgmcJGmg5wP9i+AeVuhcU976MHMKU1zOfZx6Gs3lQPuCv4uxdJGjh
   KfLSAZklpY3je0MHU+0tt22m1Qfu6VER1Ps8cQzsniu5tilogNFFiFN5V
   SRxbBKahkWSNiefbUQQJ4hlsdI1kyGYXBR+CRZ6PVtK133lqn6W+3y9i/
   Vdr1J7r74wM/ozri+vQY3irsM43iKBkXTHfyJn5FPPd/Rhk6WLWgIBVci
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270465406"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270465406"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:34:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646877561"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:33:59 -0700
Message-ID: <89130952-155c-38f0-3318-1c071562661f@linux.intel.com>
Date:   Tue, 28 Jun 2022 19:33:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
 <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/28 16:50, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 28, 2022 1:41 PM
>>>>    struct iommu_domain {
>>>>    	unsigned type;
>>>>    	const struct iommu_domain_ops *ops;
>>>>    	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>>>> -	iommu_fault_handler_t handler;
>>>> -	void *handler_token;
>>>>    	struct iommu_domain_geometry geometry;
>>>>    	struct iommu_dma_cookie *iova_cookie;
>>>> +	union {
>>>> +		struct {	/* IOMMU_DOMAIN_DMA */
>>>> +			iommu_fault_handler_t handler;
>>>> +			void *handler_token;
>>>> +		};
>>> why is it DMA domain specific? What about unmanaged
>>> domain? Unrecoverable fault can happen on any type
>>> including SVA. Hence I think above should be domain type
>>> agnostic.
>> The report_iommu_fault() should be replaced by the new
>> iommu_report_device_fault(). Jean has already started this work.
>>
>> https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/
>>
>> Currently this is only for DMA domains, hence Robin suggested to make it
>> exclude with the SVA domain things.
>>
>> https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-
>> 68305f683349@arm.com/
> Then it's worthy a comment that those two fields are for
> some legacy fault reporting stuff and DMA type only.

The iommu_fault and SVA fields are exclusive. The former is used for
unrecoverable DMA remapping faults, while the latter is only interested
in the recoverable page faults.

I will update the commit message with above explanation. Does this work
for you?

Best regards,
baolu
