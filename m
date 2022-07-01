Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E1562F94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiGAJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiGAJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:12:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8B23334E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656666750; x=1688202750;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/kNlVEyPH0w8WhI0mhYcgoRy3O47A7bOqC6yeIddZ5M=;
  b=WWk6sr7+/Hj1Dm1lFwXe+4Vnjwrs41oxnVSqcwdfPG3WgTpMeGSlXfQv
   wX3S1dMEXQKj/n3b40n/3eAio12B/jynJ3rYmtnHg2rTwW/BQggpc/HsR
   EPf/Vq+H2akuG32KJgRDeB7Cd3OuL8xoUB29Sl2Cofs+yNPE27F+nXXns
   Aep8MRHDbqD3OUFKTsFAedhsZz0NPGV78hrJ8ZfIdv1ji0/XIQwJABhUo
   1hM91kTSSjZueLzuSAbALH+7GpHtSLjfjEmhxxIyBm7fxt5ri3PCLqbkd
   uloxnkfKVrmNfR7ETeYO9jkLUIJI8pxaU+dKce+pgIdnYWjbhlQaHd0be
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="344290111"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="344290111"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 02:12:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="659366507"
Received: from wenjuhe-mobl1.ccr.corp.intel.com (HELO [10.249.171.195]) ([10.249.171.195])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 02:12:27 -0700
Message-ID: <94c67e49-4604-e296-fa1a-e1105d67c5fd@linux.intel.com>
Date:   Fri, 1 Jul 2022 17:12:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/11] iommu/vt-d: Use device_domain_lock accurately
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52763F336B2535BC89E2C7498CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763F336B2535BC89E2C7498CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/1 16:15, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, June 29, 2022 3:47 PM
>>
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>>   	list_for_each_entry(info, &domain->devices, link) {
>> -		if (!info->dev)
>> -			continue;
>> -
> 
> suppose you can replace all spin_lock_irqsave() with spin_lock()
> in patch5 instead of leaving some replacement to next patch.
> 

Make sense. I will update the series.

Best regards,
baolu
