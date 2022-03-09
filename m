Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436AF4D2AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiCIIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCIIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:47:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744AF1617F7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646815567; x=1678351567;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7jjpc8d9He9z6dyZOnytX0AgMjz8sxRIr5YFBPwkC9w=;
  b=IvZjlNFxN6LuRNt9dVLNpLxHLp3H5PIWSriXUCq/EsbcrTTn2jOJghjV
   p8/+Ip9dCcFgrCTJeL+pEKG3557pVYTRTFWBDkgu8ghBNY1/jpXqpN+D+
   5lsp/b2q8JkQr1BXL5jMibSOfj+5gJJe8ArCGw2Tj0ERI/OFwKPrIeH2R
   X6LzATmE57mlkDvD1xmT51ULBeqyupWtnmw0VPaVxxC61/HjkWE9kna6K
   eYCwiMpNcoiIdq516y25seGCIATpM6in5kCMxS8KwLnPQPvuzGOSoSNWX
   t07sYHYesITDCvaLsFgip1WcNp8EsgKLTzK94TClR8zZ5CGhG9r8INqyB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="235531271"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="235531271"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:46:07 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="537919937"
Received: from byrnec1x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.29.235])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:46:03 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     cgel.zte@gmail.com, joonas.lahtinen@linux.intel.com
Cc:     tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, lucas.demarchi@intel.com,
        deng.changcheng@zte.com.cn, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        rodrigo.vivi@intel.com, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drm/i915/vlv_dsi_pll: use min_t() to make code cleaner
In-Reply-To: <20220308091655.2078825-1-deng.changcheng@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220308091655.2078825-1-deng.changcheng@zte.com.cn>
Date:   Wed, 09 Mar 2022 10:46:01 +0200
Message-ID: <87a6dz1pkm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Use min_t() in order to make code cleaner.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Thanks, pushed to drm-intel-next.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/vlv_dsi_pll.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
> index df880f44700a..f801f7ec3f9a 100644
> --- a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
> +++ b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
> @@ -393,10 +393,7 @@ static void glk_dsi_program_esc_clock(struct drm_device *dev,
>  	/* Calculate TXESC2 divider */
>  	div2_value = DIV_ROUND_UP(div1_value, txesc1_div);
>  
> -	if (div2_value < 10)
> -		txesc2_div = div2_value;
> -	else
> -		txesc2_div = 10;
> +	txesc2_div = min_t(u32, div2_value, 10);
>  
>  	intel_de_write(dev_priv, MIPIO_TXESC_CLK_DIV1,
>  		       (1 << (txesc1_div - 1)) & GLK_TX_ESC_CLK_DIV1_MASK);

-- 
Jani Nikula, Intel Open Source Graphics Center
