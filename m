Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500A54A61C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiBARA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiBARA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:00:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5700AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:00:28 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id g20so15819005pgn.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hjKjHV9jnubwu+acQPJiuHlQvZVGX3FfOdn2hBSEEIg=;
        b=wWsrHSI4TFapagsKin/t7I8V5DxVRf4KxL09EtZobtavB0WyT+/h9YbDxpsS9dfAh9
         4pJlN+uE6qXk5OaPIZDhm4jIRBWsUfaNkB9NZQdlKF1vlhcB+PTq6yCBXBmHwDtvaPkS
         eRFN1xO9UEvfOqH9kV5ONONZ1MXEdV3ModvL1Qbe8mvFzLupyytljN6Sc2rESRXQUJ8T
         TKZ0GzBp4P8u6jidrGYUQHHweanphnXK06LQbRgRVT+aYFaHSNmO1sUHoITMZ9ELKxfj
         BVPeUVn6GLo/Jh/2iYcMBi3sO+7UN8Da4C5Vaz8Jq2rLe4uP0gFi+6+K7M3elxj7imAZ
         ga+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjKjHV9jnubwu+acQPJiuHlQvZVGX3FfOdn2hBSEEIg=;
        b=tDGeqK+AEugJm/Tnt3A9iI4YyZzhGo+B3GrsHxt2NmlvIeTRLcNC0H6LuvzgSHlkKq
         Nya92x1/KZUNPUMJbSes8uk3j04qvxeD4a7TwZz+2Xb6X8rMTynENXoz3o3nyI/HJJYS
         K4UH3eKjkMVZiCeaPnC7JTwsOMCtlg2kN9EqwMimSYFp6eA0RoZRwQl5zTIKxw0L248x
         wBBb0VPf0EX9Z5EtavJL2tgXbPSpwz3z4jStY1m4lpAUZxLCeGRM7RLszhDWUUBnuh6w
         trCO5Dcqdzk/grQ6nfVCkHzgfSzMYjr0pzayxCb/zMdixkBNrPqedMOGxBMZxCBZsJjb
         fczw==
X-Gm-Message-State: AOAM530KtQeWlx2hbMN8AGMO3IeK3np3A0ftoIW8an7S0Qcu7pUpYEth
        KtcbZhdn+kY4LaQ8v0J42IXMU2XSGnbLqQ==
X-Google-Smtp-Source: ABdhPJzttNxVYjZaJe1dgUCltOYJ1fvIsjiIHcV6+nOXXp/1rIMiSoHkylDOKHr9pJy5EJUEGWs9Bg==
X-Received: by 2002:a63:cf0b:: with SMTP id j11mr21178673pgg.5.1643734827655;
        Tue, 01 Feb 2022 09:00:27 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s14sm23347006pfk.174.2022.02.01.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:00:25 -0800 (PST)
Date:   Tue, 1 Feb 2022 10:00:23 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, mike.leach@linaro.org,
        suzuki.poulose@arm.com, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] coresight: Fix TRCCONFIGR.QE sysfs interface
Message-ID: <20220201170023.GA2490199@p14s>
References: <20220120113047.2839622-1-james.clark@arm.com>
 <20220120113047.2839622-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120113047.2839622-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:30:47AM +0000, James Clark wrote:
> It's impossible to program a valid value for TRCCONFIGR.QE
> when TRCIDR0.QSUPP==0b10. In that case the following is true:
> 
>   Q element support is implemented, and only supports Q elements without
>   instruction counts. TRCCONFIGR.QE can only take the values 0b00 or 0b11.
> 
> Currently the low bit of QSUPP is checked to see if the low bit of QE can
> be written to, but as you can see when QSUPP==0b10 the low bit is cleared
> making it impossible to ever write the only valid value of 0b11 to QE.
> 0b10 would be written instead, which is a reserved QE value even for all
> values of QSUPP.
> 
> The fix is to allow writing the low bit of QE for any non zero value of
> QSUPP.
> 
> This change also ensures that the low bit is always set, even when the
> user attempts to only set the high bit.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a0640fa5c55b..57e94424a8d6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -367,8 +367,12 @@ static ssize_t mode_store(struct device *dev,
>  	mode = ETM_MODE_QELEM(config->mode);
>  	/* start by clearing QE bits */
>  	config->cfg &= ~(BIT(13) | BIT(14));
> -	/* if supported, Q elements with instruction counts are enabled */
> -	if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
> +	/*
> +	 * if supported, Q elements with instruction counts are enabled.
> +	 * Always set the low bit for any requested mode. Valid combos are
> +	 * 0b00, 0b01 and 0b11.
> +	 */
> +	if (mode && drvdata->q_support)
>  		config->cfg |= BIT(13);

Interesting brain gymnastic - applied.

Thanks,
Mathieu

>  	/*
>  	 * if supported, Q elements with and without instruction
> -- 
> 2.28.0
> 
