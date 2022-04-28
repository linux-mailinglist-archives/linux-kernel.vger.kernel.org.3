Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585AE513AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350562AbiD1RfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiD1RfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:35:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9F67D05
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:31:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u6-20020a17090a1f0600b001d86bd69427so5015611pja.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4oxf671PX/b/5YLLWBM8S/3ylJrxHqVxe323lh/h3FQ=;
        b=n0tbH4XbRXNmX0pG3Dadr/bXh5a2HX6a9+K1mtMJa42hf2a79qQ++Vd+aSEd6qrWdJ
         /t+OQbBesdE/dnniWLn3mYbFD/o+MkgeHMJXjJR5F40fSxLxPHfq3DVe4xIk0ezkc8Me
         /bJbEMMa5supZWWaPlyALzVGvg5j9m/lGHaKr6DSpHIDkTgU1VR7jA+K2os8BCi9G1Ab
         OBnNJjSAxqi/3debNrG4NdC5JdqZkTo3DbYxVCYQsQ0qCeiWclZfH8l0GA03vXq2qFKr
         jbNDdy6MX3m5tegL4SGS09tJA/c0uUH1Jrv8yvIXJBcAAkGgnb9M7AOGWDR9XGl42sLO
         4GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4oxf671PX/b/5YLLWBM8S/3ylJrxHqVxe323lh/h3FQ=;
        b=8KW10IgF4qDPfGC0Oie+ClVHpWHnn7ettDbA3uX2nFyZ2a4yEkDyYWT2MM/j3tZVez
         MopdC5tv/p322MMzzOz64y8Ocq9P/XvCrLy0m0P62+vZgnGpcrhUTT+mtJ2uebYZUr1G
         jM6KFwgdz0jg2geYBHHJRewhiTb4ZH5sKhZ3g7aZzwGIQf/39X/hgrBFyjVtNtKUo5UF
         awjaPOvcwC3+YdOpEtj/dUiINIhMk1wYvJXqT3QokSjU7GqewSxXmCcE/qQm8+AsGX9p
         60VhQ/28mJVnExDK5ODFcEG38OBv7b9B9Oe4jBxOxgYLRrhag1dQ1CGTuv3bFbF2GhPJ
         S7IA==
X-Gm-Message-State: AOAM530TgTSuTAEehyYo6pz5Bn3b70TIeRZFyLwJ8DSrPQ6utMj/XcNs
        IkIQe5Pkuv/k9qHFvv3uD+YQmNLEelOf9A==
X-Google-Smtp-Source: ABdhPJxIerott8Cy7D5882uOAWxFbbVSilYSlujg9dCoKfmkpgRndxCK5//0UxB36McM5Z8WP4F4JA==
X-Received: by 2002:a17:90b:1b03:b0:1d2:a338:c568 with SMTP id nu3-20020a17090b1b0300b001d2a338c568mr51409101pjb.129.1651167111951;
        Thu, 28 Apr 2022 10:31:51 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm439830pfv.48.2022.04.28.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:31:50 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:31:48 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        pihsun@chromium.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] rpmsg: mtk_rpmsg: Fix circular locking dependency
Message-ID: <20220428173148.GA2268704@p14s>
References: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:47:37PM +0100, AngeloGioacchino Del Regno wrote:
> During execution of the worker that's used to register rpmsg devices
> we are safely locking the channels mutex but, when creating a new
> endpoint for such devices, we are registering a IPI on the SCP, which
> then makes the SCP to trigger an interrupt, lock its own mutex and in
> turn register more subdevices.
> This creates a circular locking dependency situation, as the mtk_rpmsg
> channels_lock will then depend on the SCP IPI lock.
> 
> [   18.014514]  Possible unsafe locking scenario:
> [   18.014515]        CPU0                    CPU1
> [   18.014517]        ----                    ----
> [   18.045467]   lock(&mtk_subdev->channels_lock);
> [   18.045474]                                lock(&scp->ipi_desc[i].lock);
> [   18.228399]                                lock(&mtk_subdev->channels_lock);
> [   18.228405]   lock(&scp->ipi_desc[i].lock);
> [   18.264405]

I finally understand the problem, something that would have been impossible
without the pastebin you provided in your latest email.  Please add the content
of that pastebin to the changelog and send another revision (checkpatch
warnings can be ignored).

> 
> To solve this, simply unlock the channels_lock mutex before calling
> mtk_rpmsg_register_device() and relock it right after, as safety is
> still ensured by the locking mechanism that happens right after
> through SCP.

The integrity of the subdev->channels list is guaranteed by relocking the
mutex, I'm not sure what "through SCP" adds to the sentence. 

> Notably, mtk_rpmsg_register_device() does not even require locking.
>

I don't agree with the above sentence - if locking doesn't happen in
mtk_rpmsg_create_device(), there can be two CPUs accessing the list at the same
time.

Thanks,
Mathieu

> Fixes: 7017996951fd ("rpmsg: add rpmsg support for mt8183 SCP.")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/rpmsg/mtk_rpmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
> index 5b4404b8be4c..d1213c33da20 100644
> --- a/drivers/rpmsg/mtk_rpmsg.c
> +++ b/drivers/rpmsg/mtk_rpmsg.c
> @@ -234,7 +234,9 @@ static void mtk_register_device_work_function(struct work_struct *register_work)
>  		if (info->registered)
>  			continue;
>  
> +		mutex_unlock(&subdev->channels_lock);
>  		ret = mtk_rpmsg_register_device(subdev, &info->info);
> +		mutex_lock(&subdev->channels_lock);
>  		if (ret) {
>  			dev_err(&pdev->dev, "Can't create rpmsg_device\n");
>  			continue;
> -- 
> 2.33.1
> 
