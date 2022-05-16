Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E1527BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiEPCEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiEPCEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:04:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E9192BE
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652666643; x=1684202643;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mw8DJE8yvOSuw3spkKWsSAhd7sIYW0oNHvTKwxzir2Y=;
  b=ZArC2NGzT0y65F6cs+UgYiPWDubNdpfq+dJZ0Ty3J7Mwcts+9kgSi4dl
   Jtf4TA+P6a/Sd/Dk7p7lcby5Oxci0GeI4VQQ8LGloFb1ZOS3zUGCgQK8u
   XIO6LTE1unIC6Dc2cMCNniRnQMbQOKtTmuryCcUrhCwzmxCJvNg78VUdW
   bC0rKNzuGtGzPVWFd004stWawg2miJt7JrArvlIinz7AAauq2mdjh7mCZ
   OE3RCKAjZUDsbNjAvwSlK0JwaC963wP8h0BNpczBVCXvY6txVFLXjhQXM
   oJZfI58Za5ydpdCyBeSDyDaJ4HIt+wgbntoOLXAMyWiYAf/fkQ1Fk0+DG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="252778603"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="252778603"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:04:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="522254130"
Received: from yanjiepa-mobl.ccr.corp.intel.com (HELO [10.249.192.19]) ([10.249.192.19])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:03:56 -0700
Message-ID: <90619325-ea39-410e-2e8b-a38895f0dabf@linux.intel.com>
Date:   Mon, 16 May 2022 10:03:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yntrv+nq2t/IeVo2@myrica> <20220511120240.GY49344@nvidia.com>
 <Ynywqxo4P+aEeS6c@myrica> <20220512115101.GU49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220512115101.GU49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 19:51, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 08:00:59AM +0100, Jean-Philippe Brucker wrote:
> 
>>> It is not "missing" it is just renamed to blocking_domain->ops->set_dev_pasid()
>>>
>>> The implementation of that function would be identical to
>>> detach_dev_pasid.
>>
>>    attach(dev, pasid, sva_domain)
>>    detach(dev, pasid, sva_domain)
>>
>> versus
>>
>>    set_dev_pasid(dev, pasid, sva_domain)
>>    set_dev_pasid(dev, pasid, blocking)
>>
>> we loose the information of the domain previously attached, and the SMMU
>> driver has to retrieve it to find the ASID corresponding to the mm.
> 
> It would be easy to have the old domain be an input as well - the core
> code knows it.

Thanks a lot for all suggestions. I have posted a follow-up series for
this:

https://lore.kernel.org/linux-iommu/20220516015759.2952771-1-baolu.lu@linux.intel.com/

Let's discuss this there.

Best regards,
baolu
