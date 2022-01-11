Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3748AB55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiAKK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:26:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:38374 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236960AbiAKK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641896770; x=1673432770;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ARxasz8w9czeiodYacB+PZSOdJ2LfMsLx3EBjShtHfA=;
  b=kGstgODMGNsMo1xqqDeP1XK6yusEiGT+XuhxhTy7vNItOfxw/CpoKn5K
   hpLZPyaAOXxl6y0sUdbYFyRPRBWpF1Wf0fjwsyB7x7z9JkBzx4QN719xa
   LuOATVPf1r5lHN430rqSB1afbAjx3qsQC7JnGjcnF3Ug0B6MbzXboKvXs
   Xe7E7RI426yvhZxpLIpbzacawPBKit9CwPVBCkvNK2oyIMvKZZqLA7hYi
   3zM/aNLaGBy6RIbnDSBUnp3meE+u6bTLmrb+6LawOjuP2zIcTrbor7JsN
   X+Udkvh91sCYFtJash1i2dmHyEKPPc8aCMGXslp/LNT44S/Z234Ol7HqF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="224149588"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="224149588"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 02:26:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="558318453"
Received: from noblecat-mobl.ger.corp.intel.com (HELO [10.213.217.217]) ([10.213.217.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 02:26:07 -0800
Message-ID: <c7d4c7b5-e100-7a26-6a92-06b2e2a4b276@linux.intel.com>
Date:   Tue, 11 Jan 2022 10:26:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] i915: make array flex_regs static const
Content-Language: en-US
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220109203152.51414-1-colin.i.king@gmail.com>
 <5da796b5-a19e-e07b-7cb5-7a30726bd2ff@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <5da796b5-a19e-e07b-7cb5-7a30726bd2ff@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/01/2022 09:13, Tvrtko Ursulin wrote:
> On 09/01/2022 20:31, Colin Ian King wrote:
>> Don't populate the read-only array flex_regs on the stack but
>> instead it static const. Also makes the object code a little smaller.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/gpu/drm/i915/i915_perf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_perf.c 
>> b/drivers/gpu/drm/i915/i915_perf.c
>> index e27f3b7cf094..df698960fdc0 100644
>> --- a/drivers/gpu/drm/i915/i915_perf.c
>> +++ b/drivers/gpu/drm/i915/i915_perf.c
>> @@ -2114,7 +2114,7 @@ gen8_update_reg_state_unlocked(const struct 
>> intel_context *ce,
>>       u32 ctx_oactxctrl = stream->perf->ctx_oactxctrl_offset;
>>       u32 ctx_flexeu0 = stream->perf->ctx_flexeu0_offset;
>>       /* The MMIO offsets for Flex EU registers aren't contiguous */
>> -    i915_reg_t flex_regs[] = {
>> +    static const i915_reg_t flex_regs[] = {
>>           EU_PERF_CNTL0,
>>           EU_PERF_CNTL1,
>>           EU_PERF_CNTL2,
>>
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> And will merge shortly, thanks for the patch.

Actually I couldn't merge it because you have a Author and Signed-off-by 
mismatch due your entry in .mailmap. Is this something you can update or 
send the patch from an address which matches it?

Regards,

Tvrtko
