Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52848AA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiAKJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:13:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:34703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234465AbiAKJNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641892422; x=1673428422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wxK4JVsCowwIeFcR/jlNkVOqhexiiPM/2Udwn90bZxk=;
  b=kWvLRDWxK6oZud5wR6zDmk+LZN8ulJLBPRA9kXDyd7Tu1lot0TDfQjar
   HD1XeS+gJTNmdWSZ5/9GMXnWMPiF/J0tQjxmajQtRVMcvirnQBb3ivpGZ
   sF4awQFMC36hC4Xm652flP6drxcLktk0VcNA+/dqV7ikXP6yJ4oj2KXhG
   kfMOoH+YklgTDu/3QLWYmftrWcKCqRGxbgLN91oA1zAKp9RhCmEdgdqUM
   tuOZzS2J+d4O/apIWMh603TEZ08pcDdbY8mVgUJXSPTQZ8X9YCLFgdK/T
   4wKPGULU7aRwvwxgo18Ievy/Z5GFlYDp9F12STRC5H5b/Yy5sX1M+Z6UR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="304179660"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="304179660"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 01:13:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="558302531"
Received: from noblecat-mobl.ger.corp.intel.com (HELO [10.213.217.217]) ([10.213.217.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 01:13:39 -0800
Message-ID: <5da796b5-a19e-e07b-7cb5-7a30726bd2ff@linux.intel.com>
Date:   Tue, 11 Jan 2022 09:13:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] i915: make array flex_regs static const
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220109203152.51414-1-colin.i.king@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220109203152.51414-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/2022 20:31, Colin Ian King wrote:
> Don't populate the read-only array flex_regs on the stack but
> instead it static const. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/gpu/drm/i915/i915_perf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index e27f3b7cf094..df698960fdc0 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -2114,7 +2114,7 @@ gen8_update_reg_state_unlocked(const struct intel_context *ce,
>   	u32 ctx_oactxctrl = stream->perf->ctx_oactxctrl_offset;
>   	u32 ctx_flexeu0 = stream->perf->ctx_flexeu0_offset;
>   	/* The MMIO offsets for Flex EU registers aren't contiguous */
> -	i915_reg_t flex_regs[] = {
> +	static const i915_reg_t flex_regs[] = {
>   		EU_PERF_CNTL0,
>   		EU_PERF_CNTL1,
>   		EU_PERF_CNTL2,
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

And will merge shortly, thanks for the patch.

Regards,

Tvrtko
