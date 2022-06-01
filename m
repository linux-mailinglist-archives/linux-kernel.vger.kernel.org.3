Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A821C53A368
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352267AbiFALCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiFALCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:02:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E315FF3E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654081354; x=1685617354;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wFH8T+zSg8Moq4RtO8mNRcBXgugvMhh+yaRgqFYUaWE=;
  b=TzS55Q44/blOcOoaEiriE0qjg9eKJdvZ8cgFC3ytFvbmXlxkXb2L6jwH
   6eHcMsQhckcMVeaMEGyfbQyB21hCx6me8WTL3h9+yu5omYxRqUTZhYruH
   18wODoAWJgq3QWIeV4GHvxp43LmWcVTcZ7ff0xjGd2k6W+GZLuXVXuYVj
   P+ZB+ZVIcv8Giq2rnJnUo2IsTQZkRuZetjlJBpXyjeZeANW9WyAgxb9Vb
   NAfzDk3IvF2HojlqPFh5tvHzJjvdlj1F6/pLz1STmgMy6nmHqFrRVmQVq
   3asCmXc65WFdbBo56CElr/ZXkxBzr7d7/G7DHPNIohODklzJ7BHQ7jkAH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="257620250"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="257620250"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 04:02:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="707007893"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123]) ([10.255.28.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 04:02:30 -0700
Message-ID: <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
Date:   Wed, 1 Jun 2022 19:02:28 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 17:28, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, May 27, 2022 2:30 PM
>>
>> When the IOMMU domain is about to be freed, it should not be set on any
>> device. Instead of silently dealing with some bug cases, it's better to
>> trigger a warning to report and fix any potential bugs at the first time.
>>
> 
> 
>>   static void domain_exit(struct dmar_domain *domain)
>>   {
>> -
>> -	/* Remove associated devices and clear attached or cached domains
>> */
>> -	domain_remove_dev_info(domain);
>> +	if (WARN_ON(!list_empty(&domain->devices)))
>> +		return;
>>
> 
> warning is good but it doesn't mean the driver shouldn't deal with
> that situation to make it safer e.g. blocking DMA from all attached
> device...

I have ever thought the same thing. :-)

Blocking DMA from attached device should be done when setting blocking
domain to the device. It should not be part of freeing a domain.

Here, the caller asks the driver to free the domain, but the driver
finds that something is wrong. Therefore, it warns and returns directly.
The domain will still be there in use until the next set_domain().

Best regards,
baolu
