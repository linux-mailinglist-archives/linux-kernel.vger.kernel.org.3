Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFB50BBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiDVPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiDVPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:48:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E95BD02
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:46:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so11699426plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FtnwU85lnk8sSVybc4V8F5kwU+53RMkF858SpDu4W4c=;
        b=dho5RsqambxA38U/b8dtZxHYePuXRkM5VG38erLwn98MAIanO0ERA8V0D0EBmRKdc4
         6C3dExRddMz3AnZz38Rdw7W0kSyMOSIYvn3Z8BFarKpFWEYkQ0xVwLniVQaDOekIhtBk
         fb6KAaoaPymk0FOlwfvjxx04pQG2Qe63OIh62EW0bJ6Wr5mh2ooxayMqK4zoceF6Jluw
         1xFfUtB9Ih912Zp1w6bD2uO1qT1Rd3Yn4cBmhCB9hABRR918VMLRUr0Jt0YIwSUvWbXS
         JnnGCgywmlzjCu0ygDzOux8GzcUF2VCfCOt20cDkqQ+DsOsUHdMpksCJHqWjagET8KzK
         MsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FtnwU85lnk8sSVybc4V8F5kwU+53RMkF858SpDu4W4c=;
        b=2XhjAxdpRuqXIfC6njaIt0Mbrf9AN1ksOXa/x3t8jljYNu4Co7Vm14pEpBV+Vx/0zN
         jQbW8JaSjHsmH1dTfB8kgGLc+eWW6w/9+CNaB5SI8numVXV63ff0nQy24rrho6J26HH6
         MMg2vZXFTapmpz7TTd0fQpL5Y8lT6zuT2phBg0ym5FbEKKrGCTRi3GQPS3KRPx2OxRXG
         sqZFSSEQiDY6pFncR/uB+w0ulzM/p6IFP2w/toRBa06G9IfoGFavOs+tChPut0bQkC/5
         JrbGO1g9+gRbCN7Fmt6rdaYiPtFpT5++VvwTuEDdhgQdRou7arEPeGZr3O7345C52tvh
         5RqQ==
X-Gm-Message-State: AOAM530k4lQfJ361awUA5F7h1HKc5QWsFlqVCU5JCJtYLZOHeH7c0eGL
        BcZzutXKnMpw1iOzojle7P15pQ==
X-Google-Smtp-Source: ABdhPJyCaufYMGfH49S9tJ9BFjQjU1VO/TTxeD5SbwIuD/iC2w8QBWfaKvbB+ittwN0L/nqbcIEAeQ==
X-Received: by 2002:a17:90a:5d08:b0:1d7:9587:9288 with SMTP id s8-20020a17090a5d0800b001d795879288mr6296218pji.204.1650642361964;
        Fri, 22 Apr 2022 08:46:01 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 16-20020a621410000000b0050aca5f79f5sm2997037pfu.97.2022.04.22.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:46:00 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:45:58 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: etm4x: return 0 instead of using local ret
 variable
Message-ID: <20220422154558.GA1713394@p14s>
References: <20220422020239.37186-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422020239.37186-1-shile.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:02:39AM +0800, Shile Zhang wrote:
> The function etm4_remove_dev() always return 0, and the former function
> etm4_remove has been changed to void in commit 3fd269e74f2fe ("amba: Make
> the remove callback return void"). But now its changed back to int type
> for some reason, which is different to the stable branch linux-5.10.y.

Please spend time understanding why function etm4_remove_dev()'s return value
has been changed back to an "int".  From there you will likely come to the
conclusion that adding the above to the changelog doesn't make sense.

> 
> Just let it return void and return 0 directly in it's caller function
> etm4_remove_platform_dev.

The only rational for this patch is that etm4_remove_dev() always returns '0'.
And even if it was to return anything else, the return value it not checked.
And even if the return value was checked, there is nothing to do about an error
condition since the driver is being removed.

> 
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
> v2: re-work the commit log from Mathieu's suggestion.
> v1: https://lore.kernel.org/linux-arm-kernel/20220421164217.GB1596562@p14s/T/
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 7f416a12000eb..141f8209a152a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2104,7 +2104,7 @@ static void clear_etmdrvdata(void *info)
>  	etmdrvdata[cpu] = NULL;
>  }
>  
> -static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
> +static void __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
>  {
>  	etm_perf_symlink(drvdata->csdev, false);
>  	/*
> @@ -2125,8 +2125,6 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
>  
>  	cscfg_unregister_csdev(drvdata->csdev);
>  	coresight_unregister(drvdata->csdev);
> -
> -	return 0;
>  }
>  
>  static void __exit etm4_remove_amba(struct amba_device *adev)
> @@ -2139,13 +2137,14 @@ static void __exit etm4_remove_amba(struct amba_device *adev)
>  
>  static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
>  {
> -	int ret = 0;
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
>  
>  	if (drvdata)
> -		ret = etm4_remove_dev(drvdata);
> +		etm4_remove_dev(drvdata);
> +
>  	pm_runtime_disable(&pdev->dev);
> -	return ret;
> +
> +	return 0;
>  }
>  
>  static const struct amba_id etm4_ids[] = {
> -- 
> 2.33.0.rc2
> 
