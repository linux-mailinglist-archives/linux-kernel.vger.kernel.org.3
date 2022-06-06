Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5469353DF57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351972AbiFFBfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiFFBe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:34:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D24C7AB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654479296; x=1686015296;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lps97B+FqFqL/LGXUNctMAf0PplziUETs8EQDiHZQFw=;
  b=E7va7ozPAmcO6bKxPQMF23w4FA7V7oHVW+zIe6n8nL9Pu4fa/cOOOGby
   U7xosfs+5o3FszbDBC/1sY4Hw1qIl/MNT+TjrvKWgOTZ6GSuDr/ebKdi1
   Xnzpe/QpDCSb7tYlMkD5Wo09+41kUDBhx5L3UKBtwRIjGURovFNM2l/xZ
   JGt4w5qMeE2OPwinS1bqsx814qkkVLQePEl3VPDThYuzdYpr9sBCZFamL
   ce1w17arVIhHBvt21+wGSuPD8PXD+EByhdHj+fwq4yCXzaQlm2EjVeati
   y7BtTaIDWgyQJQmujLZG7hiTHJVQMH0iv/50/np57Ty5iAiGtABOK4tsw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="275388150"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="275388150"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 18:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825562354"
Received: from zhang1-mobl4.ccr.corp.intel.com (HELO [10.249.174.156]) ([10.249.174.156])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 18:34:52 -0700
Message-ID: <7217a79d-fd0b-8bb8-1401-a6ab08a47f6d@linux.intel.com>
Date:   Mon, 6 Jun 2022 09:34:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-10-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
 <BN9PR11MB527652AF527A66551934CD4F8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527652AF527A66551934CD4F8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/2 14:29, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, June 1, 2022 7:02 PM
>>
>> On 2022/6/1 17:28, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Friday, May 27, 2022 2:30 PM
>>>>
>>>> When the IOMMU domain is about to be freed, it should not be set on
>> any
>>>> device. Instead of silently dealing with some bug cases, it's better to
>>>> trigger a warning to report and fix any potential bugs at the first time.
>>>>
>>>
>>>
>>>>    static void domain_exit(struct dmar_domain *domain)
>>>>    {
>>>> -
>>>> -	/* Remove associated devices and clear attached or cached domains
>>>> */
>>>> -	domain_remove_dev_info(domain);
>>>> +	if (WARN_ON(!list_empty(&domain->devices)))
>>>> +		return;
>>>>
>>>
>>> warning is good but it doesn't mean the driver shouldn't deal with
>>> that situation to make it safer e.g. blocking DMA from all attached
>>> device...
>>
>> I have ever thought the same thing. :-)
>>
>> Blocking DMA from attached device should be done when setting blocking
>> domain to the device. It should not be part of freeing a domain.
> 
> yes but here we are talking about some bug scenario.
> 
>>
>> Here, the caller asks the driver to free the domain, but the driver
>> finds that something is wrong. Therefore, it warns and returns directly.
>> The domain will still be there in use until the next set_domain().
>>
> 
> at least it'd look safer if we always try to unmap the entire domain i.e.:
> 
> static void domain_exit(struct dmar_domain *domain)
> {
> -
> -	/* Remove associated devices and clear attached or cached domains */
> -	domain_remove_dev_info(domain);
> 
> 	if (domain->pgd) {
> 		LIST_HEAD(freelist);
> 
> 		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
> 		put_pages_list(&freelist);
> 	}
> 
> +	if (WARN_ON(!list_empty(&domain->devices)))
> +		return;
> 
> 	kfree(domain);
> }

Fair enough. Removing all mappings is safer.

Best regards,
baolu
