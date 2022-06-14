Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F654BDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355285AbiFNW4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiFNW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:56:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66D1BE94
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:56:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x4so9826336pfj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3IusMXHsX8HYuqKFhVAp//8FffUIb5+m4kqYcQhh3jg=;
        b=RxGqPWG4PLu3NM7G1OGJljdNFzCExbfYbHK0F3QfUj1AlqNl14KHAaObsvlHet4+oS
         x9VmUWFGotqq93PIhB4uIrDavQHnyGEIlTtHGhytL5VGpCcPwi6nQrHMU3+APZLTwZRq
         89V3DSJMPpkL6yCJT27icAhF2DbnOLs2ezpp4telLSVl3K6+TzV6Uo8LBHL6A3EyQPOY
         5AxYEpzRYPWkw/lPYe22uziM1qC8SG9TIXICerSzuFToms2h+Cmc2A90ofILLIBKPoR1
         WbmNzt29EC3IoKHi3Dc9MPCLP63kvHZeG9uqbxpptSfbkOXScISb7NriHvfMCuEFdVXo
         KCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3IusMXHsX8HYuqKFhVAp//8FffUIb5+m4kqYcQhh3jg=;
        b=r7rGZ2W4NO3W75Z7HGD3Uzk0GsdI5/5pUqEJrHGF5vKrgpAsnw1A+dZZ+AYYznlrIV
         nyPku0RSvBxH/4HKQhmvmuZqGp0HhebuHh6aymi9NYKPUpwwMH4wBGIO/ZuY+DC56noG
         kcBtihbM8s74ZJKkqaAi0pmcyyYjgTw0FuY7nU1/wDRVAisdB++G8sN2A+QstkJyUdsz
         YkhQtF8t1Efdqi9M2CijpSYLnasrrpIyeqBrAnFsMpJskxiAmsOFsCf0G3Du9XtCA3ex
         dO416jQD5diL7CkO3mZ77b6xf4f0rsrz7DV98dJQZR1gFkSwg8qwnYRy7NpIwPoekOyT
         YFUw==
X-Gm-Message-State: AOAM531TO1NJltZhqhSTWWLkxqzy45YheMqrlhIHPCdIHI0LVEegpdnz
        DKzOUtIBNzZCC9DV2IBm5HlKjg==
X-Google-Smtp-Source: ABdhPJzQWALnoEZmwEIMpTXToHtePoOxJuJdOybO+zv45861A0QgmqxZOSNHez+b33q+mm6rS+sBAA==
X-Received: by 2002:a63:4387:0:b0:3c6:9490:4e4b with SMTP id q129-20020a634387000000b003c694904e4bmr6264286pga.438.1655247360793;
        Tue, 14 Jun 2022 15:56:00 -0700 (PDT)
Received: from p14s ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id z1-20020a626501000000b0050dc7628183sm8366937pfb.93.2022.06.14.15.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:55:59 -0700 (PDT)
Date:   Tue, 14 Jun 2022 16:55:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: k3-r5: Fix refcount leak in
 k3_r5_cluster_of_init
Message-ID: <20220614225557.GB1236509@p14s>
References: <20220605083334.23942-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605083334.23942-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 12:33:34PM +0400, Miaoqian Lin wrote:
> Every iteration of for_each_available_child_of_node() decrements
> the reference count of the previous node.
> When breaking early from a for_each_available_child_of_node() loop,
> we need to explicitly call of_node_put() on the child node.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 2 ++
>  1 file changed, 2 insertions(+)

I have applied this patch.

Thanks,
Mathieu

> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 4840ad906018..0481926c6975 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -1655,6 +1655,7 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
>  		if (!cpdev) {
>  			ret = -ENODEV;
>  			dev_err(dev, "could not get R5 core platform device\n");
> +			of_node_put(child);
>  			goto fail;
>  		}
>  
> @@ -1663,6 +1664,7 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
>  			dev_err(dev, "k3_r5_core_of_init failed, ret = %d\n",
>  				ret);
>  			put_device(&cpdev->dev);
> +			of_node_put(child);
>  			goto fail;
>  		}
>  
> -- 
> 2.25.1
> 
