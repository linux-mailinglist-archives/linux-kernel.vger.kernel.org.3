Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C27D562D89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiGAIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGAIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:12:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AB70AD2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656663148; x=1688199148;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uIBc20BRpWux/L4QNgzOIj1nZj/HX/ViDlZzamfMVRw=;
  b=Zb/TFXLvv+aXXM1z+d36Y4zYM/HCQPbJt+bsxGR+aUXWyknzchu1hAfu
   FmaS9lT4gXlbFslWDBiirg2Yuo9qBs3pTBOcYAZRXHnGX43pYczvZ1zS/
   bBNsFfUlcxQxpXMd/tCTpRYG0nohf8TYUtbfwZ1TZDmpScv/nM4/CKwLL
   l5XGicCzLbu4AIPBMC7yG43kRFpuhmfpBU72MfnWfEGejGRDdYBAn3Tdb
   MqPuIon5AyAzQu9pTm17iTXs31bRD1U3M2PNjbkD9p+HlCkemY+uSXIkq
   P+MPpHoVVxTfuD4QmU/ID8dI0TwbbD9D5Two17qPlPmjcqX6G8iETrrhi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262386448"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262386448"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="659344362"
Received: from wenjuhe-mobl1.ccr.corp.intel.com (HELO [10.249.171.195]) ([10.249.171.195])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:12:26 -0700
Message-ID: <50a05134-349a-0921-2a70-63f303bf86a4@linux.intel.com>
Date:   Fri, 1 Jul 2022 16:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/11] iommu/vt-d: Optimize the use of locks
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <BN9PR11MB527645CF20DA53BF9009A9118CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527645CF20DA53BF9009A9118CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/1 15:53, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, June 29, 2022 3:47 PM
>>
>> v3:
>>   - Split reduction of lock ranges from changing irqsave.
>>     https://lore.kernel.org/linux-
>> iommu/BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.
>> namprd11.prod.outlook.com/
>>   - Fully initialize the dev_info before adding it to the list.
>>     https://lore.kernel.org/linux-
>> iommu/BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.
>> namprd11.prod.outlook.com/
>>   - Various code and comments refinement.
>>
> 
> This doesn't say why original patch2 was removed:
> 
> 	"iommu/vt-d: Remove for_each_device_domain()"
> 
> It took me a while to realize that it's already covered by your another
> patch fixing RID2PASID. 😊

My fault! I forgot to mention it in the change log. Sorry about it.

Best regards,
baolu
