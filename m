Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC374AD05A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346933AbiBHE2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiBHE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:28:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6EC0401E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644294509; x=1675830509;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zeTrwKWN4UMeNdimGUS+U9RmLrMA4K1Ld5W0Y65wdyQ=;
  b=byz+gOnXPQLMuoV8pDthNUf/t/WS/SYLgdjlG7k1YGorWfWFbAkBywpD
   UIlK3AkitSDgnID5mQcpUDAoKO35WL1Yh6Um6JbodfZ6DCMphs/6+xIym
   oMh7M4UhGzhdpRbwJLG0rHW03lHxlvcxv4P5nUNSkDZpU2RD/pXoYM5Ye
   lmmNWq+rxpSHElrPFgtvH9hFgPFdju1hBmbCr8w0xvuZFPx19f6ihldF9
   7q3hDD2jhsi2li8Bj7mA1rT+KKPogHXyT5UCPO336o/SbBPIb9U50TS6R
   Jx23jq2cJDLCGwbBR5ftWvUtXngjdIaFiq+H4QA+feigEotc6fDsPXtaO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="273395899"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="273395899"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 20:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677985044"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:28:27 -0800
Message-ID: <771436d6-fda5-eeae-16ee-4cb760a056bb@linux.intel.com>
Date:   Tue, 8 Feb 2022 12:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] iommu/vt-d: Move DMAR specific helpers into
 dmar.c
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-2-baolu.lu@linux.intel.com>
 <20220207070849.GA23941@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207070849.GA23941@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 3:08 PM, Christoph Hellwig wrote:
>> --- a/include/linux/dmar.h
>> +++ b/include/linux/dmar.h
>> @@ -52,6 +52,32 @@ struct dmar_drhd_unit {
>>   	struct intel_iommu *iommu;
>>   };
>>   
>> +struct dmar_rmrr_unit {
> 
>> +struct dmar_atsr_unit {
> 
>> +struct dmar_satc_unit {
> 
> What about moving all code that is using the structures to dmar.c
> to keep the definitions local?
> 

It's difficult. References to these structures are scattered in iommu.c.

Best regards,
baolu
