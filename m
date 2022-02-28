Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94BB4C6F94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiB1Oe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiB1Oe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:34:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A66F275D6;
        Mon, 28 Feb 2022 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646058827; x=1677594827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ucZ5anih82JGSYnw7NJxPpFc3x0RvGFm0k0UeSwKr+Y=;
  b=gvYQn+U5cKOH1n1z9pD2lnLyoLZLOGI5VhKCS/K4P16ip2Hxq8Wj21ZB
   CAXinEQGdxLGk4InHVUooplFc7+4n0a4e83CLgRWaz43v4ImvscGpaXGb
   sOWBmJFaOClL5MqmwpqLA4pgoDwVebTBYKOFcMGByTg8CRQj+vy4Twc/e
   9TeFys4kZuKI3WJd8AGGCaG3GR9/O/RsTzt/ttFXVNTd0vcbcGSMRTWhm
   hEhwHeIYk002BEQQj9OGPu1Ml0QSU+FGF7KTeEOYUKu8uGpYXSPby8dyA
   wj3RfSZ9NuHL7A0XOWJhvQfG/9pnTtNomYd5q8YW8JhKEkOokOzJDnED0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="253086133"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="253086133"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:33:47 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="708659832"
Received: from jpdecker-mobl3.ger.corp.intel.com (HELO [10.213.235.138]) ([10.213.235.138])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:33:44 -0800
Message-ID: <f460b115-6ff6-7f69-8b0d-174c4defc771@linux.intel.com>
Date:   Mon, 28 Feb 2022 14:33:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] drm/msm: Expose client engine utilization via fdinfo
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220225202614.225197-1-robdclark@gmail.com>
 <20220225202614.225197-3-robdclark@gmail.com>
 <CAF6AEGvXs9etrtBUP5fAx7z6pLMV76a-FEXrdk2gY8npDHrFnA@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAF6AEGvXs9etrtBUP5fAx7z6pLMV76a-FEXrdk2gY8npDHrFnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/02/2022 22:14, Rob Clark wrote:
> On Fri, Feb 25, 2022 at 12:25 PM Rob Clark <robdclark@gmail.com> wrote:
>>
>> From: Rob Clark <robdclark@chromium.org>
>>
>> Similar to AMD commit
>> 874442541133 ("drm/amdgpu: Add show_fdinfo() interface"), using the
>> infrastructure added in previous patches, we add basic client info
>> and GPU engine utilisation for msm.
>>
>> Example output:
>>
>>          # cat /proc/`pgrep glmark2`/fdinfo/6
>>          pos:    0
>>          flags:  02400002
>>          mnt_id: 21
>>          ino:    162
>>          drm-driver:     msm
>>          drm-client-id:  7
>>          drm-engine-gpu: 1734371319 ns
>>          drm-cycles-gpu: 1153645024

Nice, so my vendor agnostic actually worked (with that single fixup of 
accounting for the fact pdev tag is optional)?

> Note that it might be useful to have a standardized way to report # of
> cycles and max freq, so userspace tool can derive %utilization in
> addition to just %busy

How do you define %utilisation vs %busy - I don't exactly follow since I 
see the two as same?

Looking at your patch I guess I don't understand the difference between 
'elapsed' and 'cycles' inside your retire_submit(). Both are scoped to a 
single context and are not global? If 'elapsed' is time context has 
spent on the GPU, cycles isn't the same just in a different unit?

Regards,

Tvrtko

> BR,
> -R
> 
>>
>> See also: https://patchwork.freedesktop.org/patch/468505/
>>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>   drivers/gpu/drm/msm/msm_drv.c | 17 ++++++++++++++++-
>>   drivers/gpu/drm/msm/msm_gpu.c | 20 ++++++++++++++++++--
>>   drivers/gpu/drm/msm/msm_gpu.h | 19 +++++++++++++++++++
>>   3 files changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>> index 16f37f3d9061..fdf401e6f09e 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -911,7 +911,22 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
>>          DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
>>   };
>>
>> -DEFINE_DRM_GEM_FOPS(fops);
>> +static void msm_fop_show_fdinfo(struct seq_file *m, struct file *f)
>> +{
>> +       struct drm_file *file = f->private_data;
>> +       struct drm_device *dev = file->minor->dev;
>> +       struct msm_drm_private *priv = dev->dev_private;
>> +       struct drm_printer p = drm_seq_file_printer(m);
>> +
>> +       if (!priv->gpu)
>> +               return;
>> +
>> +       msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, &p);
>> +}
>> +
>> +DEFINE_DRM_GEM_FOPS(fops,
>> +       .show_fdinfo = msm_fop_show_fdinfo,
>> +);
>>
>>   static const struct drm_driver msm_driver = {
>>          .driver_features    = DRIVER_GEM |
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>> index 173ebd449f2f..6302f3fe564b 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -4,6 +4,8 @@
>>    * Author: Rob Clark <robdclark@gmail.com>
>>    */
>>
>> +#include "drm/drm_drv.h"
>> +
>>   #include "msm_gpu.h"
>>   #include "msm_gem.h"
>>   #include "msm_mmu.h"
>> @@ -146,6 +148,15 @@ int msm_gpu_pm_suspend(struct msm_gpu *gpu)
>>          return 0;
>>   }
>>
>> +void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
>> +                        struct drm_printer *p)
>> +{
>> +       drm_printf(p, "drm-driver:\t%s\n", gpu->dev->driver->name);
>> +       drm_printf(p, "drm-client-id:\t%u\n", ctx->seqno);
>> +       drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
>> +       drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
>> +}
>> +
>>   int msm_gpu_hw_init(struct msm_gpu *gpu)
>>   {
>>          int ret;
>> @@ -643,7 +654,7 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>>   {
>>          int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
>>          volatile struct msm_gpu_submit_stats *stats;
>> -       u64 elapsed, clock = 0;
>> +       u64 elapsed, clock = 0, cycles;
>>          unsigned long flags;
>>
>>          stats = &ring->memptrs->stats[index];
>> @@ -651,12 +662,17 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>>          elapsed = (stats->alwayson_end - stats->alwayson_start) * 10000;
>>          do_div(elapsed, 192);
>>
>> +       cycles = stats->cpcycles_end - stats->cpcycles_start;
>> +
>>          /* Calculate the clock frequency from the number of CP cycles */
>>          if (elapsed) {
>> -               clock = (stats->cpcycles_end - stats->cpcycles_start) * 1000;
>> +               clock = cycles * 1000;
>>                  do_div(clock, elapsed);
>>          }
>>
>> +       submit->queue->ctx->elapsed_ns += elapsed;
>> +       submit->queue->ctx->cycles     += cycles;
>> +
>>          trace_msm_gpu_submit_retired(submit, elapsed, clock,
>>                  stats->alwayson_start, stats->alwayson_end);
>>
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
>> index 696e2ed8a236..ad4fe05dee03 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.h
>> +++ b/drivers/gpu/drm/msm/msm_gpu.h
>> @@ -328,6 +328,22 @@ struct msm_file_private {
>>          struct kref ref;
>>          int seqno;
>>
>> +       /**
>> +        * elapsed:
>> +        *
>> +        * The total (cumulative) elapsed time GPU was busy with rendering
>> +        * from this context in ns.
>> +        */
>> +       uint64_t elapsed_ns;
>> +
>> +       /**
>> +        * cycles:
>> +        *
>> +        * The total (cumulative) GPU cycles elapsed attributed to this
>> +        * context.
>> +        */
>> +       uint64_t cycles;
>> +
>>          /**
>>           * entities:
>>           *
>> @@ -511,6 +527,9 @@ static inline void gpu_write64(struct msm_gpu *gpu, u32 lo, u32 hi, u64 val)
>>   int msm_gpu_pm_suspend(struct msm_gpu *gpu);
>>   int msm_gpu_pm_resume(struct msm_gpu *gpu);
>>
>> +void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
>> +                        struct drm_printer *p);
>> +
>>   int msm_submitqueue_init(struct drm_device *drm, struct msm_file_private *ctx);
>>   struct msm_gpu_submitqueue *msm_submitqueue_get(struct msm_file_private *ctx,
>>                  u32 id);
>> --
>> 2.35.1
>>
