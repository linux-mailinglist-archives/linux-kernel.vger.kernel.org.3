Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF42246D445
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhLHNXy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Dec 2021 08:23:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:17154 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhLHNXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:23:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="236565714"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="236565714"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 05:20:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="503047989"
Received: from cahanley-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.1])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 05:20:18 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        cgel.zte@gmail.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] drm/i915/display: Delete redundant post_mask
 assignment
In-Reply-To: <YbCtUZUSbEpCuDoi@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211208074619.404138-1-luo.penghao@zte.com.cn>
 <YbCtUZUSbEpCuDoi@intel.com>
Date:   Wed, 08 Dec 2021 15:20:15 +0200
Message-ID: <87lf0v44j4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> On Wed, Dec 08, 2021 at 07:46:19AM +0000, cgel.zte@gmail.com wrote:
>> From: luo penghao <luo.penghao@zte.com.cn>
>> 
>> This value will be overwritten by the following if statement, even
>> if the if is not executed, the value will not be used
>> 
>> The clang_analyzer complains as follows:
>> 
>> Value stored to 'port_mask' is never read
>> 
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
>> ---
>>  drivers/gpu/drm/i915/display/intel_ddi.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
>> index bd18432..3aad0c3 100644
>> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
>> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
>> @@ -2011,7 +2011,6 @@ void intel_ddi_sanitize_encoder_pll_mapping(struct intel_encoder *encoder)
>>  			return;
>>  	}
>>  
>> -	port_mask = BIT(encoder->port);
>>  	ddi_clk_needed = encoder->base.crtc;
>>  
>>  	if (encoder->type == INTEL_OUTPUT_DSI) {
>
> 'port_mask' declaration could now be moved into this block.

I've basically given up on patches from cgel.zte@gmail.com,
luo.penghao@zte.com.cn, zealci@zte.com.cn, etc. The patches are the
simplest possible changes to silence static analyzer warnings, with no
further analysis of the issues, and no follow-up on questions.

Until that changes, I think we're better off just regarding them static
as analyzer reports.


BR,
Jani.


>
>> -- 
>> 2.15.2
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
