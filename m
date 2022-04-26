Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750F35104B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353439AbiDZQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348677AbiDZQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:59:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE41165BF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:56:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso3063419pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9/wPbaS/ygwe2xLBOnnhPg4uqAnSA4Ct48vVffLTDVk=;
        b=hZPxikBFzuALeYibUcgzooE8Ee5esUOwPQJ6q0UuvlqDLESH8Z2e5tYT7/MyW3I5WX
         FRVk5Xm+BS3Qw7A7pfpPUzEYfffDbpRSVZnu07KOVIQBbDaVSp9OngGzLHpSkokmmklp
         kHRKtJVKraTQQ6moUg7xXW4ACY74gjxeqQN0Oyt3OWwGV45aISYmcVIkazDA/u0xG2hC
         IqZnCGqdylLWMkBESaGoaRgF2bGiZuQcgE5vxUIlczQQFXW66SPlWB8bylT3qaeAAahY
         ys7mm5qYG8TP1OkGlW6slaZpRBSRsS8p1HbrZVqL459ksU1VxgL6ZvPOMaEKJ8zULgFm
         /iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/wPbaS/ygwe2xLBOnnhPg4uqAnSA4Ct48vVffLTDVk=;
        b=CcDqq196++qlnSW8kfTEsENmvztLJGhi4O5rfTkOSO+fMZP/sIWzB1fRhRs/jsk7x5
         gx2fS3qv8IfPxeXspyXrOxa5KUER+ipO7YqmdyJJEogCiwZJb9oTzcXOeNAQvCkylGpY
         4PNs5e8VQh49qjISjAAkZ8BA3Zme9pViL2YUgMZ9cZ189UsrvHHEV0XHKxjdfwPlgnAP
         ZkCGwD+LDIhoINTf6QfT+hdISFYnr2P9ZUfnFh02CmTbJG0h0TDK6NiplUD5m5A8xuGe
         q+VtZw3J0oK3diCrSB3MsRkVmvLKMsdp7LYELNM2X1cfPXEmdCfd0VQ9HlZ7IIRl0Jvb
         CCPA==
X-Gm-Message-State: AOAM532n/NYfcRiAKhUlkfRPT0Fxybv8FwTyXgCMG6bzA44LTy9y7hXE
        AvUxK87ahyp2FF5xgMCiE6/n6Q==
X-Google-Smtp-Source: ABdhPJzReXLu8whTnXO3okAQP1g2oztP+w1K6RI4bZECU5UzqUuJkBgUHXuvsNEMPtVPgC27uVfczQ==
X-Received: by 2002:a17:90a:9109:b0:1cb:a814:8947 with SMTP id k9-20020a17090a910900b001cba8148947mr38074528pjo.52.1650992176468;
        Tue, 26 Apr 2022 09:56:16 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm17074509pfu.76.2022.04.26.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:56:15 -0700 (PDT)
Date:   Tue, 26 Apr 2022 10:56:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rpmsg: virtio: Fix the unregistration of the
 device rpmsg_ctrl
Message-ID: <20220426165613.GA2007637@p14s>
References: <20220426060536.15594-1-hbh25y@gmail.com>
 <20220426060536.15594-4-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426060536.15594-4-hbh25y@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:05:36PM +0800, Hangyu Hua wrote:
> Unregister the rpmsg_ctrl device instead of just freeing the
> the virtio_rpmsg_channel structure.
> This will properly unregister the device and call
> virtio_rpmsg_release_device() that frees the structure.
> 
> Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Hangyu Hua <hbh25y@gmail.com>
> Reviewed-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 291fc1cfab7f..485e95f506df 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -862,7 +862,7 @@ static void rpmsg_virtio_del_ctrl_dev(struct rpmsg_device *rpdev_ctrl)
>  {
>  	if (!rpdev_ctrl)
>  		return;
> -	kfree(to_virtio_rpmsg_channel(rpdev_ctrl));
> +	device_unregister(&rpdev_ctrl->dev);

The author of this patch should have been Arnaud, something I have fixed before
applying this set.

Thanks,
Mathieu

>  }
>  
>  static int rpmsg_probe(struct virtio_device *vdev)
> -- 
> 2.25.1
> 
