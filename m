Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D17504F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiDRLkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDRLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:40:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F8D1583D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650281845; x=1681817845;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=QbdV17HFyoNuctqfGiYLR8ES3+m65lg3wiD/rXJX7uE=;
  b=lKPSGBZlV/oXeVgVUPFcoHcpxGJUuUObMD8MDADU5O9Fjq8GEjguhrZJ
   sgCYgyUtdyjrSQI9LTjdN6z/bzlAbPmNAPYiAjPUQanxPmzp3aVsTTi5L
   FKFvQ3K8AR23SzNUK5a6EdyrWwFlVIL+z4YGVDF6/wTFUJyUIZU+2Hiut
   DEEaOFoQINd83yb7KUWr1/Lyg0mozo95S6iWTu7Mi9gq3vwE3co1J6iAT
   ckEw2xNndUJrVz/B8hdeXb4wMn8NlGQS+9UHyU+PzAR70bkBGXRdtNFq7
   L7Dmeske+pu/QV65gdkyv/Jx/3yUmpLT8nNgVnhvgOckL5SvLZvNgLX1+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262359496"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262359496"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 04:37:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="575540119"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.231]) ([10.254.208.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 04:37:22 -0700
Message-ID: <15089cab-f896-3c4f-1986-2f84d418696b@linux.intel.com>
Date:   Mon, 18 Apr 2022 19:37:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F7FCE2E82106ABDEBBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Drop stop marker messages
In-Reply-To: <BN9PR11MB52767F7FCE2E82106ABDEBBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/18 14:58, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Saturday, April 16, 2022 8:31 PM
>>
>> The VT-d driver explicitly drains the pending page requests when a CPU
>> page table (represented by a mm struct) is unbound from a PASID according
>> to the procedures defined in the VT-d spec. Hence, there's no need to
>> report the stop-marker message in prq_event_thread(). The stop marker
>> messages do not need a response. This drops stop marker messages silently
>> if any of them is found in the page request queue.
> The comment for iommu_queue_iopf says:
> 
>   * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
>   * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
>   * expect a response. It may be generated when disabling a PASID (issuing a
>   * PASID stop request) by some PCI devices.
> 
> So obviously the current vt-d driver behavior violates that requirement.
> Then should this be a bug fix instead?
> 

Our platforms have no devices issuing Stop Marker messages yet. But in a
virtualization environment, a device might be emulated with this
capability. Yes! Let me make it as a fix.

Best regards,
baolu
