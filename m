Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43337504F60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiDRLbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiDRLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:31:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6118E3C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650281313; x=1681817313;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tNq4Qjm5TYIl9oCAWJApb6um0N6xU0LHIz6k7RGPfeQ=;
  b=DZavhnFToWcBroZSN2CPi/d1ZF4PYo0pZW3Llwq4MIx2W5hduqAoUgOr
   YiZZ8PRcpwNywQZp/Empq5nelY0qTJJyTaIxOqvOaOX9ewAAK4FrA6P1/
   HeeMK64tzOfeEFa8dMgc5InHgxfRwgbV3MmkRSxwul0B7+AKIEu9xkofy
   Bl2QdFaoJeQXd1eKmzJfaKBN28ddsMCTBQk5qIfHsjMJPQf99eoL1jZjB
   qGqs/E15Gae7muyMYNZnznAPN571KxsrQvRs0TJtqqXhja7eDoqU5QHTQ
   YuEydEwfpB3KD74LZvcUOOIqti3o3CrXZ7j+CFW3ykjuIxlcR+yh4/Kih
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="244083275"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="244083275"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 04:28:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="575537747"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.231]) ([10.254.208.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 04:28:30 -0700
Message-ID: <d051f1a3-3d26-15f9-f5b0-46bd903e73e0@linux.intel.com>
Date:   Mon, 18 Apr 2022 19:28:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iommu/vt-d: Set PGSNP bit in pasid table entry for
 sva binding
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A47E4013FA692C7560D58CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A47E4013FA692C7560D58CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/18 14:56, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Saturday, April 16, 2022 8:31 PM
>>
>> This field make the requests snoop processor caches irrespective of other
>> attributes in the request or other fields in paging structure entries
>> used to translate the request. The latest VT-d specification states that
>> this field is treated as Reserved(0) for implementations not supporting
>> Snoop Control (SC=0 in the Extended Capability Register). Hence add a
>> check in the code.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 2 +-
>>   drivers/iommu/intel/svm.c   | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..9ca3c67a2058 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -625,7 +625,7 @@ int intel_pasid_setup_first_level(struct intel_iommu
>> *iommu,
>>   		}
>>   	}
>>
>> -	if (flags & PASID_FLAG_PAGE_SNOOP)
>> +	if ((flags & PASID_FLAG_PAGE_SNOOP) && ecap_sc_support(iommu-
>>> ecap))
>>   		pasid_set_pgsnp(pte);
> If the caller wants snoop for some reason is it correct to simply
> ignore the request when lacking of hw support? Suppose certain
> errno should be returned here...

Good catch. Perhaps I should make the cap check in a separated patch.

Best regards,
baolu
