Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8064F5F18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiDFNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiDFNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:18:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC62EC125
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649239104; x=1680775104;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K4D5i89qRlTIWic6S+jWeNyHDTTwKQUiVi4l1V+GtPQ=;
  b=ZhmkTup06OI7u7cB9Wuq5oHAswriTIO9R284vkm7tffmEMm6ntISaeOC
   JyN0mwjLQlavFVVv6YWDdt78US+hxwPDt018E1u71uD0CGZciHCyAE/66
   Ii/srjRIs7aHkJ4unxBzulrpxpStNWSS35Ulu7xqc5HO+KIjTeI2WGjwD
   lJ7rCJS15hjgNPA5CLfyvI8jd8U/gkAwguBNMF+2bFN/c2+hBqACwXdCz
   3wLnbugcheYHVJ3jIJPaoPIil5AtYcVRlP6j1EkB/P3dqRgw1b8YAOol3
   C6rd4FBgWhCpKnKAqexxZrfqCApg75hO71RhUToa8m9ZmxTPHDFvadYek
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260994171"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="260994171"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:51:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570437455"
Received: from huipengt-mobl1.ccr.corp.intel.com (HELO [10.254.215.82]) ([10.254.215.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:51:05 -0700
Message-ID: <77dafe0b-a601-def6-c6bd-287d464ce892@linux.intel.com>
Date:   Wed, 6 Apr 2022 17:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <6ebd4f9b-5824-9489-43c3-7810963ec918@linux.intel.com>
 <20220404172403.GO2120790@nvidia.com>
 <5ca5d34a-2394-b8bd-837b-cd6bf3301989@linux.intel.com>
 <20220405141008.GS2120790@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220405141008.GS2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/5 22:10, Jason Gunthorpe wrote:
> On Tue, Apr 05, 2022 at 02:12:42PM +0800, Lu Baolu wrote:
>> On 2022/4/5 1:24, Jason Gunthorpe wrote:
>>> On Mon, Apr 04, 2022 at 01:43:49PM +0800, Lu Baolu wrote:
>>>> On 2022/3/30 19:58, Jason Gunthorpe wrote:
>>>>>>> Testing the group size is inherently the wrong test to make.
>>>>>> What is your suggestion then?
>>>>> Add a flag to the group that positively indicates the group can never
>>>>> have more than one member, even after hot plug. eg because it is
>>>>> impossible due to ACS, or lack of bridges, and so on.
>>>>
>>>> The check method seems to be bus specific. For platform devices, perhaps
>>>> this kind of information should be retrieved from firmware interfaces
>>>> like APCI or DT.
>>>>
>>>>   From this point of view, would it be simpler and more reasonable for the
>>>> device driver to do such check? After all, it is the device driver that
>>>> decides whether to provide SVA services to the application via uacce.
>>>
>>> The check has to do with the interconnect, not the device - I don't
>>> see how a device driver would know any better.
>>
>> I'm worried about how to support this group flag for devices that are
>> not connected to the system through PCI buses. If IOMMU can support
>> sva_bind() only when this flag is set, the SVA on many devices cannot
>> be supported. Or this flag is always set for non PCI devices by
>> default?
> 
> IHMO it is not so different from how we determine if ACS like
> functionality is supported on non-PCI. It is really just a more narrow
> application of the existing ACS idea.
> 
> For instance it may be that if the iommu_group came from DT we can
> assume it is static and then singleton can know ACS is reliable.

Okay, let me head this direction.

Best regards,
baolu
