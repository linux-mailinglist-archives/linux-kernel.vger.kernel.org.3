Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36826571C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiGLOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiGLOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:22:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCD1B7E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657635730; x=1689171730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LoMioghV+nWquLuGyQGrSZFnMEkThiMZmXo0rtNNBY0=;
  b=FVy0sekxaqHZLmBHkKUSjz8PRH95a7/8BpabLZtGOMl8RafKfxFIuid5
   fE1T8Um3RdDV9EOLtvWTWMUP7+KXfq0aetEofL6eoI0QtuP8fykqjJ3Hm
   WboNM4xcimb1twUweab2ARJ5xwTOwpPSGxW+VtzPqKt530Phva/CUZ1XB
   rtx7rc4ifjsqVg1MU15dAiuUegRnKY2JOPDjNEoyb3dFEla3BXLCpmOZw
   Wjmz4oQn/1ndk79fUenKNOKDwIDOxi/9uMeVneJXhS5yS5u6SiRMv2+0C
   O5LsoIlZOo4glByC8uHRL69B9IoHIRj3VQKm0/7m9kbe1gVzImxwUe7pd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285687224"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="285687224"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 07:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="922219730"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2022 07:22:08 -0700
Received: from [10.249.147.246] (unknown [10.249.147.246])
        by linux.intel.com (Postfix) with ESMTP id 7794C580890;
        Tue, 12 Jul 2022 07:22:04 -0700 (PDT)
Message-ID: <ea892ffc-4a03-7772-6d99-85a356a3738b@intel.com>
Date:   Tue, 12 Jul 2022 17:22:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/syncobj: Fix sync syncobj issue
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        jie1zhan <jesse.zhang@amd.com>, broonie@kernel.org,
        dri-devel-bounces@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
        lucas.demarchi@intel.com, nirmoy.das@linux.intel.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707102953.769684-1-jesse.zhang@amd.com>
 <22a21338-305d-bdf7-0079-df67fb030fc7@amd.com>
From:   Lionel Landwerlin <lionel.g.landwerlin@intel.com>
In-Reply-To: <22a21338-305d-bdf7-0079-df67fb030fc7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll let Lucas comment. I've only looked a little at it.
 From what I remember just enabling sw_signaling was enough to fix the 
issue.

-Lionel

On 12/07/2022 13:26, Christian König wrote:
> Ping to the Intel guys here. Especially Lucas/Nirmoy/Lionel.
>
> IIRC you stumbled over that problem as well, have you found any solution?
>
> Regards,
> Christian.
>
> Am 07.07.22 um 12:29 schrieb jie1zhan:
>> enable signaling after flatten dma_fence_chains on transfer
>>
>> Signed-off-by: jie1zhan <jesse.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/drm_syncobj.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c 
>> b/drivers/gpu/drm/drm_syncobj.c
>> index 7e48dcd1bee4..0d9d3577325f 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -920,6 +920,7 @@ static int 
>> drm_syncobj_transfer_to_timeline(struct drm_file *file_private,
>>       if (ret)
>>           goto err_free_fence;
>>   +    dma_fence_enable_sw_signaling(fence);
>>       chain = dma_fence_chain_alloc();
>>       if (!chain) {
>>           ret = -ENOMEM;
>

