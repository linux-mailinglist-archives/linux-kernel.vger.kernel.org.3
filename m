Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2454A940
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbiFNGNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbiFNGNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:13:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E736E20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655187192; x=1686723192;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IZRzfWpYvGVD0DwSCHu4cFNQN2SHmCQjRiubdBK1bSs=;
  b=CyZ6ErbK9PJKrE09geYmOJ6d0ICtrCfGiAbbGa6tMvdyBM/Iff6xPgc/
   9mOqKnTCxG4eEYpLesgIF5rNZ4JZxSzMBKeBWcJe+SqRZSyXDhtV+4NCl
   wCWRr4F5k+ERCTaDvtECTzvNlx0cBogEKqJE+9ek/n9l7tgWtNF3wjW20
   pYBOoNTrMMvahpSxXccnaQSLbvkxBrcvSF8R5ybuw2QH82LLQNu3i/2/K
   SYohRrXGarApP4rbH63PLcJfMyKNBtxKCptygv2QGDxcQ9+X7dwLfUSgu
   AoYz8zOy6agTFTUEya7oVXODY9jwf6w/F3UgV7RG+ljffJNdxHsW1lnlY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340185939"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="340185939"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:13:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910803754"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:13:09 -0700
Message-ID: <3e2e6ee7-984f-254e-7a3e-e32d6256c8f2@linux.intel.com>
Date:   Tue, 14 Jun 2022 14:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
 <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
 <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
 <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/6/14 13:36, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 12:48 PM
>>
>> On 2022/6/14 12:02, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, June 14, 2022 11:44 AM
>>>>
>>>> This allows the upper layers to set a domain to a PASID of a device
>>>> if the PASID feature is supported by the IOMMU hardware. The typical
>>>> use cases are, for example, kernel DMA with PASID and hardware
>>>> assisted mediated device drivers.
>>>>
>>> why is it not part of the series for those use cases? There is no consumer
>>> of added callbacks in this patch...
>> It could be. I just wanted to maintain the integrity of Intel IOMMU
>> driver implementation.
> but let's not add dead code. and this patch is actually a right step
> simply from set_dev_pasid() p.o.v hence you should include in any
> series which first tries to use that interface.
> 

Yes, that's my intention. If it reviews well, we can include it in the
driver's implementation.

Best regards,
baolu
