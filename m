Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05B4706EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbhLJR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:28:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:1250 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhLJR2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639157106; x=1670693106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5UuDcLlUBY6hNX9XfK3sNQ4qtaq14yyKEoZ4SuQcqo=;
  b=YUqcVjou9gmk1xycirmov2Qy71DYcYNAhqZF8dzs0IoHEEGRfMvy22YY
   gysK33mWGz0KgNkbH0ilYkSY6it0i1R21+g+kX2q+dBfzXnOawNjvOn0S
   q8qfSAWFslKe+n660/9QkcSBVqHWQwmd/W0tzHUfULfGRVGD4TLGpVPgN
   ISLogp2nGPo15KFNy67Lmi24S/KVMyVTgmk9o88aUC+A6ZpS2bJPyTmNj
   AWix5mtEtRBu7jw/ACHeLk6GjECEdoN1+MQBdP33NeQFtJ71X1yW+O8YG
   Lm/XIt7NrCKSzwdwBKEt5XldisREswtU2RUwFsFMwVyk6AdQvgkwZbWew
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="324656364"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="324656364"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:25:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="612993405"
Received: from lgfecara-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.84.224])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:25:06 -0800
Date:   Fri, 10 Dec 2021 09:25:05 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dri-devel@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?utf-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, dan.carpenter@oracle.com
Subject: Re: [PATCH] drm: i915: display: intel_dmc: Fixes an unsigned
 subtraction which can never be negative.
Message-ID: <20211210172505.vdjhyvawwvte3lp7@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211210044129.12422-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211210044129.12422-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 08:41:24PM -0800, Harshit Mogalapalli wrote:
>smatch warning:
>drivers/gpu/drm/i915/display/intel_dmc.c:601 parse_dmc_fw() warn:
>unsigned 'fw->size - offset' is never less than zero
>
>Firmware size is size_t and offset is u32. So the subtraction is
>unsigned which can never be less than zero.
>
>Fixes: 3d5928a168a9 ("drm/i915/xelpd: Pipe A DMC plugging")
>Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

"s|drm: i915: display: Fixes|drm/i915/display: Fix|" in the subject,
that I will do when applying after we have the CI results.

thanks
Lucas De Marchi

>---
> drivers/gpu/drm/i915/display/intel_dmc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
>index 0cab18f972d1..2f477c298b00 100644
>--- a/drivers/gpu/drm/i915/display/intel_dmc.c
>+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
>@@ -598,7 +598,7 @@ static void parse_dmc_fw(struct drm_i915_private *dev_priv,
> 			continue;
>
> 		offset = readcount + dmc->dmc_info[id].dmc_offset * 4;
>-		if (fw->size - offset < 0) {
>+		if (offset > fw->size) {
> 			drm_err(&dev_priv->drm, "Reading beyond the fw_size\n");
> 			continue;
> 		}
>-- 
>2.27.0
>
