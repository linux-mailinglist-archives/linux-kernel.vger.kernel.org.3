Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007A54A8A34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiBCRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbiBCRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:35:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E9C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:35:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so6202681pjy.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9e0oxCku0Awg8Sfq6RwVv/SH5AvdTEcLXDJ8KHAWSBI=;
        b=taFBh+thCKl5Jv/LEOX1LgoAt1cWwIlDf2gcDD57Hl8dOAegKbyMp4wwejfdITEY6n
         aRhE9cCKXTHjAjDxE2ms/2VVej2/Z3Nal7SC6V0aVlyjoQRfTYQkTWolE3o94pJppD33
         4DIBpeM8/8m4dD9OyiuPIyS6tXloCSJrPvkvcbaffucKQ+ullmkKYeCdT8k5yzOM4Cef
         OU2QLpM8gynxD27x9GvTAXlQOaqufYtIfqGAKfaeZiBmPYYJuWLWjapuJ9f8ozDMgYE+
         5LjhCpz2B84WMwZ/W4+EcqCMDKr6kqpVgf3UUpvNfbrOKc9ncVSuX7Pds/rggeqYYwdW
         PQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9e0oxCku0Awg8Sfq6RwVv/SH5AvdTEcLXDJ8KHAWSBI=;
        b=cWHFtvqh+YbyJaPQhIbL9h64HIi+TZ73ExbVmfWFTy8Uv+/KrsAya8iPOaApicfWvn
         bYkyL40UHSCpb0NNdvnygw3XztumQnIdj3bFIaMpr4i1TTtJCBFNl6JG39tP086E7ksS
         0azItEEeCnugum3jbANR0VG/Y8zCUJGUYWLLf/LU3p3GUZgmxNKTPtftd7B8RFFpA7Pa
         8iIqdb+hH6fVtbsLUDDa43hRcfUh0G17O70h5JXw8f9E+XlgZKVZhhQupTOsC5qVfjit
         ZRChx2iItzGqW/FjNfA10LsLeQ4z6jz8Ex2kFb00cQmqixDQHt4V2/AUCb+uAOkZDYp1
         jW9w==
X-Gm-Message-State: AOAM531luGF3hT2mqukEw6nmHut2+lJyBL4X+0T2hS1ph3Vum+QKiLZQ
        4Z9L7tvUde6VKz2B5HxnPONoLw==
X-Google-Smtp-Source: ABdhPJzVjXtIyaIqU4Iftz/N5PHRDNQvMN/XP/gzP+j0ZLSMhFFIngn16sdHfs8mtnP17sR4rnss+w==
X-Received: by 2002:a17:903:22d1:: with SMTP id y17mr36826313plg.107.1643909715150;
        Thu, 03 Feb 2022 09:35:15 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id me4sm11085727pjb.26.2022.02.03.09.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:35:13 -0800 (PST)
Date:   Thu, 3 Feb 2022 10:35:10 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     bjorn.andersson@linaro.org, swboyd@chromium.org,
        quic_clew@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH V1 1/3] rpmsg: glink: Free device context only when cdev
 not in use
Message-ID: <20220203173510.GA2982815@p14s>
References: <1643223886-28170-1-git-send-email-quic_deesin@quicinc.com>
 <1643223886-28170-2-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643223886-28170-2-git-send-email-quic_deesin@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

On Thu, Jan 27, 2022 at 12:34:44AM +0530, Deepak Kumar Singh wrote:
> Struct device holding cdev should not be freed unless cdev
> is not in use. It is possible that user space has opened
> char device while kernel has freed the associated struct
> device context.
> 
> Mark dev kobj as parent of cdev, so that chardev_add gets
> an extra reference to dev. This ensures device context is not
> freed until cdev is is not in uses.
> ---
>  drivers/rpmsg/rpmsg_char.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index c03a118..72ee101 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -417,6 +417,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>  	dev->id = ret;
>  	dev_set_name(dev, "rpmsg%d", ret);
>  
> +	cdev_set_parent(&eptdev->cdev, &dev->kobj);
>  	ret = cdev_add(&eptdev->cdev, dev->devt, 1);

This issue should have been fixed when cdev_add() was replaced by
cdev_device_add(), something you will find on v5.17-rc2.

Also, this set is generating checkpatch warnings and as such I will not review
the other patches in it. 

Thanks,
Mathieu

>  	if (ret)
>  		goto free_ept_ida;
> @@ -533,6 +534,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>  	dev->id = ret;
>  	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
>  
> +	cdev_set_parent(&ctrldev->cdev, &dev->kobj);
>  	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
>  	if (ret)
>  		goto free_ctrl_ida;
> -- 
> 2.7.4
> 
