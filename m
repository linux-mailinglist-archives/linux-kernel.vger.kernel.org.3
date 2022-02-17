Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601E54BA56B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiBQQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:09:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBQQJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:09:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0491178BC1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:08:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y18so4937530plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VD8H9XEccLJ1gEJ8HFd5QAYd/aMwLkrTq6BJhjDSisU=;
        b=F2rnoQOUj5vrdaK05HWLiQ7Dayy2FS/VLwwppCjteGUtmVGphPSPL1yNlR/PsVhO4Q
         SGeRoVRv5Uus+p4dn8QbXAGf80LP4h24IJAa0YKQc/bBrJA2mgvX6k6S+QaZhSinsQPe
         o216cTDDHjXReLeUyM4oLkcXFtL1l/32drgLI8Q3Ol851JV0AFiUSkZYV96ZmH6yoaRz
         AKOTAqvSoj03fN1c6IOu25o9+GmlKYmh8Tz/z/Z1zg3CfaJqHt1e0AWkINesw/Pf2V0l
         g76JZRFDHXvhz1CCgn1/99do97O3lEyvZTQa1XyJAFrLSbwg3bv9oVKn+Ugr30Tfha1B
         919w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VD8H9XEccLJ1gEJ8HFd5QAYd/aMwLkrTq6BJhjDSisU=;
        b=AeNas6HpI7/8Ol9jzD8NRE9EfERTGfZgKyGebecNqQaM4Q8KE2kQM66vzx3INMCNqk
         yby76lwD7DpOmbefErTqV4vvVTNSJ6XXWCiT21FqawklnGJ3PmYbET/Qwf/o4OLK+VNR
         ZiYi7p5m2Av6DP4l7Pm272C8z7/wya0h1RFD8DOS9hXmlgcqnZQjzqINDpw00YNyXGBh
         IRDfiCAKPmSjz/P74hRD9Z33k9ZUu7JjG+w19N5lNclGq9eOcWzS7YgRmHjg4orlLgN2
         Phzzvu3Ltjce0PBnFUxDsiRSFpRKI6s88T3UMwhH5DJ79mh7YbFk23NaCGaVrYbr7cMK
         V1PA==
X-Gm-Message-State: AOAM533uM9Uek4MnatfVHpQLFKSqRHtNae8L5M9UTVd+f8E3/7NlT0BL
        w6viVEPyEPNJMwXBF1+XTrTF/iUu7OKmaA==
X-Google-Smtp-Source: ABdhPJyFsjmnJxcyI3zQL+VFCRE3os2dZrHdxY5v38ChREUHcE+PvGbETp2COJG44FjB8IEmuf5tZQ==
X-Received: by 2002:a17:90a:4dc7:b0:1b9:ca2:311e with SMTP id r7-20020a17090a4dc700b001b90ca2311emr3717927pjl.175.1645114135171;
        Thu, 17 Feb 2022 08:08:55 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h9sm51611pfv.135.2022.02.17.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:08:53 -0800 (PST)
Date:   Thu, 17 Feb 2022 09:08:51 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        pihsun@chromium.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] rpmsg: mtk_rpmsg: Fix circular locking dependency
Message-ID: <20220217160851.GA474184@p14s>
References: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
 <b531eeca-40e8-d759-5579-59567eb5af84@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b531eeca-40e8-d759-5579-59567eb5af84@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 05:06:22PM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/01/22 15:47, AngeloGioacchino Del Regno ha scritto:
> > During execution of the worker that's used to register rpmsg devices
> > we are safely locking the channels mutex but, when creating a new
> > endpoint for such devices, we are registering a IPI on the SCP, which
> > then makes the SCP to trigger an interrupt, lock its own mutex and in
> > turn register more subdevices.
> > This creates a circular locking dependency situation, as the mtk_rpmsg
> > channels_lock will then depend on the SCP IPI lock.
> > 
> > [   18.014514]  Possible unsafe locking scenario:
> > [   18.014515]        CPU0                    CPU1
> > [   18.014517]        ----                    ----
> > [   18.045467]   lock(&mtk_subdev->channels_lock);
> > [   18.045474]                                lock(&scp->ipi_desc[i].lock);
> > [   18.228399]                                lock(&mtk_subdev->channels_lock);
> > [   18.228405]   lock(&scp->ipi_desc[i].lock);
> > [   18.264405]
> > 
> > To solve this, simply unlock the channels_lock mutex before calling
> > mtk_rpmsg_register_device() and relock it right after, as safety is
> > still ensured by the locking mechanism that happens right after
> > through SCP.
> > Notably, mtk_rpmsg_register_device() does not even require locking.
> > 
> > Fixes: 7017996951fd ("rpmsg: add rpmsg support for mt8183 SCP.")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Friendly ping for an important fix... :)
>

This seems to have slipped through the cracks...  I will take a look later
today.

Thanks,
Mathieu

> > ---
> >   drivers/rpmsg/mtk_rpmsg.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
> > index 5b4404b8be4c..d1213c33da20 100644
> > --- a/drivers/rpmsg/mtk_rpmsg.c
> > +++ b/drivers/rpmsg/mtk_rpmsg.c
> > @@ -234,7 +234,9 @@ static void mtk_register_device_work_function(struct work_struct *register_work)
> >   		if (info->registered)
> >   			continue;
> > +		mutex_unlock(&subdev->channels_lock);
> >   		ret = mtk_rpmsg_register_device(subdev, &info->info);
> > +		mutex_lock(&subdev->channels_lock);
> >   		if (ret) {
> >   			dev_err(&pdev->dev, "Can't create rpmsg_device\n");
> >   			continue;
> 
> 
