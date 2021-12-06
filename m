Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4600D46A5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348482AbhLFTaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348473AbhLFTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:30:04 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E7DC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:26:35 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso14924356otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwqTA7sQYf8xpac6AilPkHwdcgSbiu32CvJYi480RsI=;
        b=FYHtHc5UGLNmKp1G5mrPrFMktid2lyzAT2kpnDND1Zwvg6Z0zoylL7mzLrYceoFnyH
         on+lGWMozyPcEHjGpe2uTdUGBlivfATLnNV2RphCFvRtv1k0xwXi2uDoVtHgv5Da2Lt2
         S/bpK0u1xNcsSzVLn4Xxf+3m0NU2b/um74rpkYBXhSSPJANBrQY0UsFtfTLaLui2ylr6
         DzBvKbrdg9UcvxbGXm7pEm/XMRMQC3e5+3xnWcR+CUp2L1by60biCF54HYNgibEd+Btr
         ZkxwmJclf02PuSngswN/bj8S+hqDpAfF+d8dTwDILCukgCxiPpxb2vhMguWADDtTZE9b
         LzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwqTA7sQYf8xpac6AilPkHwdcgSbiu32CvJYi480RsI=;
        b=R5nRTwTosNdS33I1P/I4Y0xS1eAD2JoDVLOW+7P/FvQG/1X3BerYOZriHZQtSf8ki8
         mnUtpWCIUaOhuP16GiT0M7GTSj1vKpO8BkR6hunjnWyz6/MGWNL0LOvMMuvZpn5ofMCc
         AIwkH1N3EQOJah/uDStwZdXGXf9KviARZtEltVVyX7eKQ1ftPq/jVsByhziy/Bz42lry
         pbmPuj8NlLSdqUcnRvoJ1f3LzpLxqA1nCxXxmiQrokQVDITcTcRynlcZmMc03Zis44Xu
         61+3JaRLAJa35LZzdtXhs+2wNIdjfqfYDfw4b4RnIho12bI5siyTqi5l+WZnOdbQmUIP
         Vz9Q==
X-Gm-Message-State: AOAM531Q3jgS4/rEvXGBkH4yflPmBZ6ufe7qwMPWN5MnHud712A0m9Te
        LdmdvcJokvR6TMAxbpBSkGyfjg==
X-Google-Smtp-Source: ABdhPJwJL6uhitz9DTb0wdVgXt9MqFimGDKfjzroarL7wqEJVMshws/SxADnwXdThrKiosCkI/kpGg==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr31292882otq.173.1638818794435;
        Mon, 06 Dec 2021 11:26:34 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g2sm2677566oic.35.2021.12.06.11.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:26:33 -0800 (PST)
Date:   Mon, 6 Dec 2021 13:26:31 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: core: Clean up resources on announce_create
 failure.
Message-ID: <Ya5j55sgDNr/sdJW@builder.lan>
References: <20211206190758.10004-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206190758.10004-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Dec 13:07 CST 2021, Arnaud Pouliquen wrote:

> During the rpmsg_dev_probe, if rpdev->ops->announce_create returns an
> error, the rpmsg device and default endpoint should be freed before
> exiting the function.
> 
> Fixes: 5e619b48677c ("rpmsg: Split rpmsg core and virtio backend")
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn

> ---
>  drivers/rpmsg/rpmsg_core.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 27aad6baf7c5..12d7b7c6e5f9 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -612,13 +612,25 @@ static int rpmsg_dev_probe(struct device *dev)
>  	err = rpdrv->probe(rpdev);
>  	if (err) {
>  		dev_err(dev, "%s: failed: %d\n", __func__, err);
> -		if (ept)
> -			rpmsg_destroy_ept(ept);
> -		goto out;
> +		goto destroy_ept;
>  	}
>  
> -	if (ept && rpdev->ops->announce_create)
> +	if (ept && rpdev->ops->announce_create) {
>  		err = rpdev->ops->announce_create(rpdev);
> +		if (err) {
> +			dev_err(dev, "failed to announce creation\n");
> +			goto remove_rpdev;
> +		}
> +	}
> +
> +	return 0;
> +
> +remove_rpdev:
> +	if (rpdrv->remove)
> +		rpdrv->remove(rpdev);
> +destroy_ept:
> +	if (ept)
> +		rpmsg_destroy_ept(ept);
>  out:
>  	return err;
>  }
> -- 
> 2.17.1
> 
