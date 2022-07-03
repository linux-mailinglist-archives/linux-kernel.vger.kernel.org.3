Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C55644C3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiGCEfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCEfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:35:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C3B65F5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656822921; x=1688358921;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pU3gfZt21o7N90tOYZMfEo8wFf2wBbFCrf4XK6NkYGQ=;
  b=i0J6GW837YWpP1uSfhzYKdiTv5NMrelxhzfhho5XfUT2YFzQ2XS5jv4z
   Aoo+iYRjvGTkVSsRiYzL/PtJ8TWqhZXIh8IVelF4zoAhBxkjn3XzDOJH6
   ZtdGVMVNQLnDsjbFwL6DGPlyKVeNhDRf7Uz0EofKgxuDx3fVTkk+HsNTC
   pN/RXex4UY0QRwo8qU7h0b9SSV4mQ34WlE+67ZxtJ6L9E/WchvWqbSLjK
   loGgAZTNnJ6qJxpJCI6XSfLtRTAZgLbBD5Ao6kMv8OqxmHrZXiaHYTJrd
   L/Isx3SUW0QE2yw9EBvjvxWQR240WtBvWJ0iSwAM5cUvS0vWIbD4ofcbG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="283631377"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="283631377"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:35:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="648966391"
Received: from sunqi-mobl1.ccr.corp.intel.com (HELO [10.249.173.69]) ([10.249.173.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:35:18 -0700
Message-ID: <49a1839a-c99d-258a-8f85-5a291c646038@linux.intel.com>
Date:   Sun, 3 Jul 2022 12:35:17 +0800
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Make sense to me. Will update this.

Best regards,
baolu
