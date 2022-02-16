Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716224B7E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiBPC6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:58:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiBPC55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:57:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42EF2BB29
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644980266; x=1676516266;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jy/68Jo+rlTOCwXa1YivsLzibuxvincunuTmDdjbiSQ=;
  b=NrHVwJptIln/DvTrftRucdqOpnfqn+dQWkMOLFg6A/Mx42s+/BGP66Ox
   Dj1wB75Dcd3PB7E31PBtfY4nmHjZnbrtTaTM2qv5AuCS21oj3OFhWachh
   A1kKf+NFjUfCjKCZli7/KOya4eAWyuuLBay14azf+Cgd3DJvV8+sgJdTN
   CUlvnWtDdQZgBi9K/GXV1NKOYWycJbhEsHzgpZdZqxk6BnKhUcpw32eLH
   ++eRpTnsH1iRW8mubmxf9mdRXCHFe0h0OERX5EjISxW5CPeUTLs+cLnja
   NgYBGFCcxVKj+vb9LFNmO+FCsTp/tKtrRAspNQinrefGhr+qkH/dZkAf9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250709622"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250709622"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="681313261"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 18:57:41 -0800
Message-ID: <04c8042a-9aab-332f-6607-44b60be9f514@linux.intel.com>
Date:   Wed, 16 Feb 2022 10:56:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <YgpjzNtQlOdq+1AB@8bytes.org>
 <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
 <YgtvrJ2eIUV+U84u@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgtvrJ2eIUV+U84u@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 5:17 PM, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Feb 15, 2022 at 10:05:42AM +0800, Lu Baolu wrote:
>> Do you want me to send a new version with below changes:
>>
>> - Remove WARN_ON() in dev_iommu_ops();
>> - Merge above two patches.
>>
>> Or, you can change above yourself?
> 
> Please make the changes and send a new version. I will apply it to the
> iommu core branch then. The build-tests with this patch-set went well
> and I havn't spotted anything else in my review, so I think it is in
> good shape for linux-next testing.

Sure and done.

Best regards,
baolu
