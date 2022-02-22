Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE824BF843
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiBVMn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiBVMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:43:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6C122F77;
        Tue, 22 Feb 2022 04:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645533808; x=1677069808;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=V3OvJzcIYv9Xc/I5EnGnnaoV/n9suE3zy47qd9uxvdY=;
  b=dq30ReBFRk1oDtE+KjAUesMwl76N53alJ8Yej0XpdSre37Nu8FDwMIpG
   SUm/M2LqcxaqivsYBaWbbxkHb6QYMdRq1kAG8dUOzKTDg3pufM7du/kK4
   mSJ/8pFngeTRVcDWl5Al6NTGxsncXCkROdkkNY2TGhpNOqOCccCebOGMW
   9WzNYGBiU+WF3ERypsLDoe6cCsBNIlqlnGovz3IxbMMS9T4xnxoBU2kOb
   TQ5fVJSsgm6pD97XOUsh2bGM5C8OdL2MhgmBS5x2r5Mw/AsEIoamMgkX8
   S0GbLeHWzIWuGOoTCiq1vIC6t1Jy4YkvCgYigqdM/jGfBTVJI8UshsjgO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251625687"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251625687"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 04:43:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="547725699"
Received: from torta-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 04:43:24 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vandita Kulkarni <vandita.kulkarni@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>
Subject: Re: [PATCH] drm/i915: make a handful of read-only arrays static const
In-Reply-To: <20220222120323.86480-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220222120323.86480-1-colin.i.king@gmail.com>
Date:   Tue, 22 Feb 2022 14:43:22 +0200
Message-ID: <87tucr6phx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022, Colin Ian King <colin.i.king@gmail.com> wrote:
> Don't populate the read-only arrays on the stack but instead make
> them static const. Also makes the object code a little smaller.
> Reformat the statements to clear up checkpatch warning.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_vdsc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
> index 3faea903b9ae..d49f66237ec3 100644
> --- a/drivers/gpu/drm/i915/display/intel_vdsc.c
> +++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
> @@ -378,10 +378,18 @@ calculate_rc_params(struct rc_parameters *rc,
>  {
>  	int bpc = vdsc_cfg->bits_per_component;
>  	int bpp = vdsc_cfg->bits_per_pixel >> 4;
> -	int ofs_und6[] = { 0, -2, -2, -4, -6, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12 };
> -	int ofs_und8[] = { 2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12 };
> -	int ofs_und12[] = { 2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12 };
> -	int ofs_und15[] = { 10, 8, 6, 4, 2, 0, -2, -4, -6, -8, -10, -10, -12, -12, -12 };
> +	static const int ofs_und6[] = {
> +		0, -2, -2, -4, -6, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12
> +	};
> +	static const int ofs_und8[] = {
> +		2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12
> +	};
> +	static const int ofs_und12[] = {
> +		2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -10, -12, -12, -12
> +	};

Hmm, I wonder why the same values are duplicated in ofs_und8 and
ofs_und12. Cc: Vandita, Manasi.

Regardless, the patch is sane.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> +	static const int ofs_und15[] = {
> +		10, 8, 6, 4, 2, 0, -2, -4, -6, -8, -10, -10, -12, -12, -12
> +	};
>  	int qp_bpc_modifier = (bpc - 8) * 2;
>  	u32 res, buf_i, bpp_i;

-- 
Jani Nikula, Intel Open Source Graphics Center
