Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23C350A60B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiDUQpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiDUQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:45:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DA4488BB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:42:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u15so2006976ple.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qbXJR1djQgxa6TrlOtwgsjSJ8tDtC1+6qifGCseQujY=;
        b=p/qcBQ024iPBDy86b29SfnQ6QDHnFxMHbW90KQv5gXjXBOH9/QUu2PFZNzPNVhufIj
         61mRVy4hfTcqTikxY4XMY+pjlkAryLHlo2lc7xq9kncDQygFZggRa/94EyYICbA91mN8
         EXJVIIvyD3ZjTqKJetM0Gl4snDpuGBqmvOQDxndIj7iU96hY3ytHrPkzk68fAUiARHs2
         lbW0Ep7LD7+vcg6flzZKG+khPSTjsbr5cPs1Q02D40m5643W0jeRGBKl/trmBwZfKuBe
         vdn1pmW+RwCYQHF6nEZ3DrYw5YAPOrR2/z6SOSDz/+HsXoj5hYhelAZ6jnCbbGiymW2J
         39UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qbXJR1djQgxa6TrlOtwgsjSJ8tDtC1+6qifGCseQujY=;
        b=uVr1ZDNElh/J4q7TGOpgmkx+eu9W5G8wo0g8WYPWfW1k0JvmtfqYPyuNrteiesdnLL
         RtejmkT+0Vxauw9HXwQT8uVhuJjCt2FuF6WlSl/VNSO+VK6nL19NWE7rYeaZcWYIx5FK
         DvJaXZ15lUBst3KpH6cNPJZmMFMwpge1Xz8YDUqo2/6gI2P2rEvaRqFckzdm+/NOK6fq
         unk/+suKUtKwBssPOOlZr29Z4X9t+EMi/mJr9OVTIkUPfjtP03T2Y1WBlkyvtDoD3Bpr
         l4xGMqZ5/EFJLPATyYQOsdJR+7/LnoYNeHi4/JwCvmu/fSYiYewDh1HBgZr4zrkSiMEs
         qoiA==
X-Gm-Message-State: AOAM531JnVuVT91oa7exDDx7uOehkICrhrNeECYcPOFXRAqIfWjvqE91
        l9kq5mJgDU3muFH1rAeTlSDsD31IRyDkSg==
X-Google-Smtp-Source: ABdhPJw9Xvi5hFFoEgJBfd/Sp7l2Sz62ZvlWYSyCVwqgD7TERHSH/X8WTURN9/JGHznOjRwiZWH//A==
X-Received: by 2002:a17:902:bc8b:b0:158:ac00:cca0 with SMTP id bb11-20020a170902bc8b00b00158ac00cca0mr407519plb.102.1650559340291;
        Thu, 21 Apr 2022 09:42:20 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm26691762pfj.152.2022.04.21.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:42:19 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:42:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: etm4x: return 0 instead of using local ret
 variable
Message-ID: <20220421164217.GB1596562@p14s>
References: <20220420052831.78566-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420052831.78566-1-shile.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shile,

On Wed, Apr 20, 2022 at 01:28:31PM +0800, Shile Zhang wrote:
> The etm4_remove function (now it's rename to etm4_remove_dev) always
> return 0, and it has been changed to void in commit 4fd269e74f2f
> ("amba: Make the remove callback return void"). But its weird that the
> changes is gone in mainline. which is remained in 5.10.y branch.

Commit 4fd269e74f2f is not valid upstream.  Changes that don't have a critical
impact on user experience or fix a bug aren't backported to longterm kernels. 

> 
> Just backport the changes of etm4_remove_dev and return 0 directly in it's
> caller function etm4_remove_platform_dev.

I'm not sure why the work "backport" is used here since this patch is destine
for mainline.

> 
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 7f416a12000e..141f8209a152 100644
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

I'm fine with the code but the changelog needs to be re-worked.  The only
rational for this patch is that the return value for function etm4_remove_dev()
is never used and as such being removed. 

Thanks,
Mathieu

>  }
>  
>  static const struct amba_id etm4_ids[] = {
> -- 
> 2.33.0.rc2
> 
