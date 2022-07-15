Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71C575F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiGOKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiGOKLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:11:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A68245E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657879870; x=1689415870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F53xOVXD6SXnMEhauy9BZi5+b7oTcShiZ3/x0q9GEec=;
  b=P5EtBl4blk1H28AmF7H3K71PQVjhw50V1jVxqnErd4P/qpdldBc1XPTK
   h/PdDxdgceufqravf8VxG3DahHPRpj8kXQqwxSQLwhrYZ/7evEU7/4gov
   loQKpmybaJ8mY0JpClNhpewAd9g+6ROKHtos/WuBnYv/R+jBf8Wn4fyYh
   aJVn5ro7fAUkCpynMxbZI9Gxu0Cji44pY13K1AunArY7Vx75leu6H/uRL
   g4IOjvUIlhEW8Ix5szAkuzZ0b2oZfTxQIuLjV9EHE2WkcJPUwAopisiAA
   WUzlm2c3vCs6aqJSFIv+mxPUxpeEgmO2k9HWcd5NmcAnh9nJ6cwtpopKu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284514450"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="284514450"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:11:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="664136850"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.9.242]) ([10.213.9.242])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:11:07 -0700
Message-ID: <04263a0c-6ba0-ba70-a3e7-3865df5adca8@intel.com>
Date:   Fri, 15 Jul 2022 12:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [Intel-gfx] [PATCH RFC] drm/i915/gt: Retry RING_HEAD reset until
 it sticks
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Matthew Auld <matthew.auld@intel.com>
References: <2378da383d043de17172d928e59da0ec423cae76.1657873550.git.mchehab@kernel.org>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2378da383d043de17172d928e59da0ec423cae76.1657873550.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2022 10:26, Mauro Carvalho Chehab wrote:
> From: Chris Wilson <chris@chris-wilson.co.uk>
> 
> On Haswell, in particular, we see an issue where resets fails because
> the engine resumes from an incorrect RING_HEAD. Since the RING_HEAD
> doesn't point to the remaining requests to re-run, but may instead point
> into the uninitialised portion of the ring, the GPU may be then fed
> invalid instructions from a privileged context, oft pushing the GPU into
> an unrecoverable hang.
> 
> If at first the write doesn't succeed, try, try again.
> 
> References: https://gitlab.freedesktop.org/drm/intel/-/issues/5432
> Testcase: igt/i915_selftest/hangcheck
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>


That is pity hw does not provide reliable way of reset.

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej


> ---
>   .../gpu/drm/i915/gt/intel_ring_submission.c   | 44 +++++++++++++------
>   drivers/gpu/drm/i915/i915_utils.h             | 10 +++++
>   2 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
> index d5d6f1fadcae..cc53feb1f8ed 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
> @@ -190,6 +190,7 @@ static bool stop_ring(struct intel_engine_cs *engine)
>   static int xcs_resume(struct intel_engine_cs *engine)
>   {
>   	struct intel_ring *ring = engine->legacy.ring;
> +	ktime_t kt;
>   
>   	ENGINE_TRACE(engine, "ring:{HEAD:%04x, TAIL:%04x}\n",
>   		     ring->head, ring->tail);
> @@ -228,9 +229,20 @@ static int xcs_resume(struct intel_engine_cs *engine)
>   	set_pp_dir(engine);
>   
>   	/* First wake the ring up to an empty/idle ring */
> -	ENGINE_WRITE_FW(engine, RING_HEAD, ring->head);
> +	until_timeout_ns(kt, 2 * NSEC_PER_MSEC) {
> +		ENGINE_WRITE_FW(engine, RING_HEAD, ring->head);
> +		if (ENGINE_READ_FW(engine, RING_HEAD) == ring->head)
> +			break;
> +	}
> +
>   	ENGINE_WRITE_FW(engine, RING_TAIL, ring->head);
> -	ENGINE_POSTING_READ(engine, RING_TAIL);
> +	if (ENGINE_READ_FW(engine, RING_HEAD) != ENGINE_READ_FW(engine, RING_TAIL)) {
> +		ENGINE_TRACE(engine, "failed to reset empty ring: [%x, %x]: %x\n",
> +			     ENGINE_READ_FW(engine, RING_HEAD),
> +			     ENGINE_READ_FW(engine, RING_TAIL),
> +			     ring->head);
> +		goto err;
> +	}
>   
>   	ENGINE_WRITE_FW(engine, RING_CTL,
>   			RING_CTL_SIZE(ring->size) | RING_VALID);
> @@ -239,12 +251,16 @@ static int xcs_resume(struct intel_engine_cs *engine)
>   	if (__intel_wait_for_register_fw(engine->uncore,
>   					 RING_CTL(engine->mmio_base),
>   					 RING_VALID, RING_VALID,
> -					 5000, 0, NULL))
> +					 5000, 0, NULL)) {
> +		ENGINE_TRACE(engine, "failed to restart\n");
>   		goto err;
> +	}
>   
> -	if (GRAPHICS_VER(engine->i915) > 2)
> +	if (GRAPHICS_VER(engine->i915) > 2) {
>   		ENGINE_WRITE_FW(engine,
>   				RING_MI_MODE, _MASKED_BIT_DISABLE(STOP_RING));
> +		ENGINE_POSTING_READ(engine, RING_MI_MODE);
> +	}
>   
>   	/* Now awake, let it get started */
>   	if (ring->tail != ring->head) {
> @@ -257,16 +273,16 @@ static int xcs_resume(struct intel_engine_cs *engine)
>   	return 0;
>   
>   err:
> -	drm_err(&engine->i915->drm,
> -		"%s initialization failed; "
> -		"ctl %08x (valid? %d) head %08x [%08x] tail %08x [%08x] start %08x [expected %08x]\n",
> -		engine->name,
> -		ENGINE_READ(engine, RING_CTL),
> -		ENGINE_READ(engine, RING_CTL) & RING_VALID,
> -		ENGINE_READ(engine, RING_HEAD), ring->head,
> -		ENGINE_READ(engine, RING_TAIL), ring->tail,
> -		ENGINE_READ(engine, RING_START),
> -		i915_ggtt_offset(ring->vma));
> +	ENGINE_TRACE(engine,
> +		     "initialization failed; "
> +		     "ctl %08x (valid? %d) head %08x [%08x] tail %08x [%08x] start %08x [expected %08x]\n",
> +		     ENGINE_READ(engine, RING_CTL),
> +		     ENGINE_READ(engine, RING_CTL) & RING_VALID,
> +		     ENGINE_READ(engine, RING_HEAD), ring->head,
> +		     ENGINE_READ(engine, RING_TAIL), ring->tail,
> +		     ENGINE_READ(engine, RING_START),
> +		     i915_ggtt_offset(ring->vma));
> +	GEM_TRACE_DUMP();
>   	return -EIO;
>   }
>   
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index c10d68cdc3ca..717fb6b9cc15 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -256,6 +256,16 @@ wait_remaining_ms_from_jiffies(unsigned long timestamp_jiffies, int to_wait_ms)
>   	}
>   }
>   
> +/**
> + * until_timeout_ns - Keep retrying (busy spin) until the duration has passed
> + * @end: temporary var to be used to track the spent time
> + * @timeout_ns: Maximum timeout, in nanosseconds
> + */
> +#define until_timeout_ns(end, timeout_ns) \
> +	for ((end) = ktime_get() + (timeout_ns); \
> +	     ktime_before(ktime_get(), (end)); \
> +	     cpu_relax())
> +
>   /**
>    * __wait_for - magic wait macro
>    *

