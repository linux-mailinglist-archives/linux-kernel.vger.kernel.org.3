Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B450957315E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiGMImz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiGMImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:42:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9BDF639
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657701771; x=1689237771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yU5zgyQcalCKx3f1uNTpJxvReddjKxaKURPv3zJdOtY=;
  b=oDOA+4NZvNEN1uGmxHgv/w4ZwyXxgCS12o7UWGf3jqcNjMMTxv1ZIcnL
   jdeAv0XMNqpF+KtHg8A0eoXNjLqDbnRXemYFnBwmSooEw10Yl23I3zoVb
   jMdA+xzgZTP/iIDdmXRfn6vYuBSe2ZDnJC7Y9eIJSMnHXsIp2fwruHLYX
   v/XYY8GPgiSFI09boV3LR8K4JjaPL0vL7i6/HvGy8VkcqE3Wv/eElUbIM
   hkAoHnsHM6+0Lwu7xB878fL9sIg8jtqBBju4uFz+vr4PH0t7oXEaEpZaO
   Wj5z5ivV2LjRalDBwJH1GtrIOFGvxFkQqRu1s6LNeu56x8GoXTbzYAnjc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286286881"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="286286881"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:42:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="685083290"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.252.18.234]) ([10.252.18.234])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:42:47 -0700
Message-ID: <43192086-b9a6-387c-4a29-ea28aa65a3b4@linux.intel.com>
Date:   Wed, 13 Jul 2022 10:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/syncobj: Fix sync syncobj issue
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        jie1zhan <jesse.zhang@amd.com>, broonie@kernel.org,
        dri-devel-bounces@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
        lucas.demarchi@intel.com, lionel.g.landwerlin@intel.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707102953.769684-1-jesse.zhang@amd.com>
 <22a21338-305d-bdf7-0079-df67fb030fc7@amd.com>
From:   "Das, Nirmoy" <nirmoy.das@linux.intel.com>
In-Reply-To: <22a21338-305d-bdf7-0079-df67fb030fc7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 7/12/2022 12:26 PM, Christian König wrote:
> Ping to the Intel guys here. Especially Lucas/Nirmoy/Lionel.
>
> IIRC you stumbled over that problem as well, have you found any solution?

I might be wrong but  I think you are talking about 
igt@syncobj_timeline@transfer-timeline-point testcase which seems to be

green in CI now 
https://intel-gfx-ci.01.org/tree/drm-tip/igt@syncobj_timeline@transfer-timeline-point.html

Lucas found out that the issues got fixed after ec8d985ff26f ("drm: use 
dma_fence_unwrap_merge() in drm_syncobj")


Regards,

Nirmoy

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
