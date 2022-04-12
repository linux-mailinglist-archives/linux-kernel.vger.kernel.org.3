Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5332D4FE06E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348114AbiDLMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351194AbiDLMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:36:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD334CC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649764580; x=1681300580;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L0qUnMQOFRRb2Pk8gqURd8V55DtzojRRl0dzjoOnUPY=;
  b=aPb2Qki5qVZwYQ9w8N0hBFRX4NSqJqdPJd0nGKyUxluWAgng4eJ29FL6
   crUaZhTul+0xvdfTyP5JhPpPuQbi2+hDxIFIbB14nieKnRE9Xf2ij7TqQ
   gdYUPEU2CtVVPNC8ChdUl5juPoIQkosmdP4M7RSBgypNPDYpeeS1weOxB
   1ytezj99tLtd0jZbs5RBODh5XDuPGPRjH9QbsreN3cPKl4u/414M9oRQm
   XI934fUZ4tlu1weptVSjnNSIDBjNnNgQpIAk2/oHQ18mmngFd6j6CTJnr
   7gVAlZw4XVzEibrrC1/17SpwoUSd99XkNk0OCrcnQRT08e4IkaVLamV9Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325267536"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="325267536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:56:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572730132"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:56:16 -0700
Message-ID: <317c1d39-13df-2559-dff7-2a5c82630739@linux.intel.com>
Date:   Tue, 12 Apr 2022 19:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
 <e8d8d08c-8327-b0ad-6bdd-ef10cd34e212@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <e8d8d08c-8327-b0ad-6bdd-ef10cd34e212@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On 2022/4/12 14:34, Yi Liu wrote:
>>>
>>>>
>>>> This adds a flag in the iommu_group struct to indicate an immutable
>>>> singleton group, and uses standard PCI bus topology, isolation 
>>>> features,
>>>> and DMA alias quirks to set the flag. If the device came from DT, 
>>>> assume
>>>> it is static and then the singleton attribute can know from the device
>>>> count in the group.
>>>
>>> where does the assumption come from?
>>
>> Hotplug is the only factor that can dynamically affect the
>> characteristics of IOMMU group singleton as far as I can see. If a
>> device node was created from the DT, it could be treated as static,
>> hence we can judge the singleton in iommu probe phase during boot.
> 
> not sure if hotplug is the only factor. Is it possible that admin modifies
> the ACS configuration on the bridge?

Not likely. This will completely change the existing iommu_group
settings.

Best regards,
baolu
