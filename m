Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63811539574
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346558AbiEaR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346551AbiEaR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:28:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09F93989
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:28:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d129so13431458pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tt/gOB9r37r5U7HxtgH6i80t5jbb5qgunubyztDkge0=;
        b=hkD/eBMGGcmdiFaBHu2BT3jb7UyDt9oVBtTZYhiizvoIp454sxeKhm8+MZKDbv5qFL
         ZK3rClkIYrmKjrTQ3GR3zWPw7A8PwXhkSr0llGzCp4uSt/YyXgQ2B2TfMu3F2r95GZic
         973EYm5DKFtaHEQHWfolFJc9yzYxhgHyg0dY24KEKLkZCIKUdh6seNpGH7VmmX6CQ4Fn
         zcIpW97bdp2OTI8bY4n/SkBR+hg+Q+4o8aL4iD9m8GvM0HpFcA0xRNZ2Ix7tdb0cnl6i
         Aosu07MgtKInzCiGImh4PiFPYbCRXVWQcIWd1l/jCL+BseXymrtdp40b1nm/K3tux1+r
         X5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tt/gOB9r37r5U7HxtgH6i80t5jbb5qgunubyztDkge0=;
        b=NLM6HpWVYSGa1/lpi7jW3wIGVClXMpD8W8ZcJqRL/jmKd8NCxejW5eS4zr7Lo8ofVj
         3Q1XnPEZ9LIH2hx+/gKgLA60BPEOMRv+VGaAg5rgIwGH4grTh/1ulyso9DiRb5ip9U+9
         87iB+N7OCOeZAARraN0Ts1vf6RqsH2PmB92+lrziaXPdbun8rtBEXaaE+PncyG1U+TWI
         EBeKTY2yGezPD7BKdqK/U5XP7E8wtkL4XNJ98XajxUtLDyJqbbnGy7Aihm2kvAb4l5yL
         aUH7ERJUW0zBBhpoImF3l/ZbWZlxH4aAjXGu5Py1YXjbI3qU/bVL4G1KIQA1aTuqdC+9
         ybkQ==
X-Gm-Message-State: AOAM531/cIEQlk9T2Thl4CPqJAyTixZBPHBWz1uYwmmLfRhZlJZDXjeY
        X1XPgBeBqQS8+UmBbYPi24RdgW2eKCxj0w==
X-Google-Smtp-Source: ABdhPJxJiEl0UN3htJFLD1rtPCD0VDVXM6DoSobHaUqlamwlJFqyA3DDWZsqoE+HBihfRIGzg5IRBg==
X-Received: by 2002:a63:e5d:0:b0:3aa:3c53:537e with SMTP id 29-20020a630e5d000000b003aa3c53537emr53612711pgo.622.1654018126567;
        Tue, 31 May 2022 10:28:46 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u21-20020a056a00099500b0050dc76281bcsm11202370pfg.150.2022.05.31.10.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:28:45 -0700 (PDT)
Date:   Tue, 31 May 2022 11:28:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [RESEND PATCH] rpmsg: char: Add mutex protection for
 rpmsg_eptdev_open()
Message-ID: <20220531172843.GA531268@p14s>
References: <1653104105-16779-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653104105-16779-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 11:35:05AM +0800, Shengjiu Wang wrote:
> There is no mutex protection for rpmsg_eptdev_open(),
> especially for eptdev->ept read and write operation.
> It may cause issues when multiple instances call
> rpmsg_eptdev_open() in parallel,the return state
> may be success or EBUGY.
> 
> Fixes: 964e8bedd5a1 ("rpmsg: char: Return an error if device already open")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

This looks good.  I will fix the above typo and apply the patch when the 5.19 cycle
starts.

Thanks,
Mathieu

> ---
> changes in resend:
> - add fixes tag
> 
>  drivers/rpmsg/rpmsg_char.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index b6183d4f62a2..4f2189111494 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -120,8 +120,11 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	struct rpmsg_device *rpdev = eptdev->rpdev;
>  	struct device *dev = &eptdev->dev;
>  
> -	if (eptdev->ept)
> +	mutex_lock(&eptdev->ept_lock);
> +	if (eptdev->ept) {
> +		mutex_unlock(&eptdev->ept_lock);
>  		return -EBUSY;
> +	}
>  
>  	get_device(dev);
>  
> @@ -137,11 +140,13 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	if (!ept) {
>  		dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
>  		put_device(dev);
> +		mutex_unlock(&eptdev->ept_lock);
>  		return -EINVAL;
>  	}
>  
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
> +	mutex_unlock(&eptdev->ept_lock);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
