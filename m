Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00B554832
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354486AbiFVL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiFVL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:57:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CAD1D306
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655899036; x=1687435036;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2XnILATBKEg2okUGd1tyEzLN3TTBjUfdFRatA/QoRs=;
  b=iDqh7o5PmuOxDHvCLpe3QIYGad0bTy+9SGZ9sA46ieksLhdpFPKmBuCw
   aPLTz1mmmHN6ShCJt8kuNXgQmVMPjIt5bL3g4N7nZWdoTHfsCIaIYggid
   gp2md+8gcKL4kIdlCViBkQ6L3l8sipbpkFXxdmL3WR/rE3sOh3poOb9Ia
   FQM6TKrn7jvZyaAYsjcgaMphFZe5TOrK2nqnSI1uT5KPQ6jNXNqqx0iBA
   XRnsMrFSpRiC7yZ9sZFf0B+V62xiYpFvAzkwQ8GOoGILzNRl0H2joYuMe
   a8wQpiXgBa0h+cU8frCxVxVIA8XSd1dsXOH6WvUljeo3sJGeKjeNTZ/jn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="305847870"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305847870"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:57:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834076732"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26]) ([10.249.172.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:57:14 -0700
Message-ID: <3ce651de-f375-176e-3435-735365dd3d8f@linux.intel.com>
Date:   Wed, 22 Jun 2022 19:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: Clean up release_device checks
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
 <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
 <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/22 15:17, Robin Murphy wrote:
> On 2022-06-22 02:36, Baolu Lu wrote:
>> On 2022/6/21 23:14, Robin Murphy wrote:
>>> Since .release_device is now called through per-device ops, any call
>>> which gets as far as a driver definitely*is*  for that driver, for a
>>> device which has successfully passed .probe_device, so all the checks to
>>> that effect are now redundant and can be removed. In the same vein we
>>> can also skip freeing fwspecs which are now managed by core code.
>>
>> Does this depend on any other series? I didn't see iommu_fwspec_free()
>> called in the core code. Or I missed anything?
> 
> dev_iommu_free() cleans up param->fwspec directly (see b54240ad4943). 
> FWIW the plan is that iommu_fwspec_free() should eventually go away - of 
> the remaining uses after this, two are in fact similarly redundant 
> already, since there's also a dev_iommu_free() in the probe failure 
> path, and the other two should disappear in part 2 of fixing the bus 
> probing mess (wherein the of_xlate step gets pulled into 
> iommu_probe_device as well, and finally works correctly again).

Yes, it is. Thanks for the explanation.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
