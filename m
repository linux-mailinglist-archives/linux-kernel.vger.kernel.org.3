Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45E48D4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiAMJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:21:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:1346 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbiAMJVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642065681; x=1673601681;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kJXpkD0TqGstWjsq8Z/m8Tr6Aqf885r5vhHL1qEhWr4=;
  b=KjkzXh5hmBv52PLnwlztZyHpCcmXgCVtjInEJtdJNv/yMpLNr3pCzmkx
   Yq5tlH26qyWg5LH3h1WgkaLjJNGFsJID7zDufqKP3uCN1uQM++DWGl0WF
   Ki6jMwgDKKTJxzP2aKn8CabVy5uW13ozKRUWJ3BPWLuh0tNqapNaj8LVO
   8hedctvlEW1Y303JLw0NHa6BMidjJmzudm7xCAh2Cr4d5mq2FdPRfUdTO
   xW2+rxvDwVcjNuAJsNiACimO9zg+vClZ4eIAk6SKByWgpD0CLIsnsPMd5
   Ojh91lhK3OVUavt1THX7qG/82cIq53N702F7ypRcVRQD5Ng6s3/poONb2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="268321358"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="268321358"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 01:21:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529590256"
Received: from joneil3-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.0.221])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 01:21:17 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] i915: make array flex_regs static const
In-Reply-To: <20220112223435.949071-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220112223435.949071-1-colin.i.king@gmail.com>
Date:   Thu, 13 Jan 2022 11:21:15 +0200
Message-ID: <87h7a86lf8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022, Colin Ian King <colin.i.king@gmail.com> wrote:
> Don't populate the read-only array flex_regs on the stack but
> instead it static const. Also makes the object code a little smaller.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> ---
>
> RESEND: Use correct e-mail address for sign-off and From: in e-mail.

There are a number of things at play here:

- Our tooling checks for certain things, such as author/signed-off-by
  match, after applying the patch.

- You have an entry in the kernel git .mailmap.

- The git log.mailmap config default has changed from false to true.

We apply the patch, and, with the default options, git show will display
a different author than the signed-off-by.

We should use --no-use-mailmap when examining a commit to ensure the
commit is internally consistent, regardless of .mailmap.


BR,
Jani.


>
> ---
>  drivers/gpu/drm/i915/i915_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index e27f3b7cf094..df698960fdc0 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -2114,7 +2114,7 @@ gen8_update_reg_state_unlocked(const struct intel_context *ce,
>  	u32 ctx_oactxctrl = stream->perf->ctx_oactxctrl_offset;
>  	u32 ctx_flexeu0 = stream->perf->ctx_flexeu0_offset;
>  	/* The MMIO offsets for Flex EU registers aren't contiguous */
> -	i915_reg_t flex_regs[] = {
> +	static const i915_reg_t flex_regs[] = {
>  		EU_PERF_CNTL0,
>  		EU_PERF_CNTL1,
>  		EU_PERF_CNTL2,

-- 
Jani Nikula, Intel Open Source Graphics Center
