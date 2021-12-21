Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9E47B92B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 05:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhLUE0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 23:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhLUE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 23:26:15 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04279C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 20:26:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z6so10548186pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 20:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o5xgDMJ+wA2AyFoIMAcbqy3DgLh40+fFYdFo8qBjJE8=;
        b=fkWX4FE2fKrGc6jIjzKBmNKopUVPnx18uxX1pok12ZjhvxhROZb1GWoV7T1MvpBudt
         6LHtXXg3Dpq54L43Wbbh0IFlLECarR9vn4gzWVGlxCL+05x4ZUchsuSf3HtjEwXEchJs
         wT7cfIKPEEchrPfwStWJcDb16pM6OULVQjtxnhl1hCls1CblwwWetho8UJoQwN/7K52j
         teHRSPOW+R8nb61KTxIg/N8XuATrU4Mikrjzst6vSYHd/ixBwH27C4ih/CH+CvTDWPoi
         aCQGd31zo9gDEYXil4snjCsnNhQUDrRrTevLWe2cnYL1SEus0alZW3o1AHN+QGcuodXS
         DAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o5xgDMJ+wA2AyFoIMAcbqy3DgLh40+fFYdFo8qBjJE8=;
        b=8Ntuvd+74demhFfRrJh0WOkUL57KnCeHXwb6WCJStidr4Tv1r8PKq53vO+0YcH6zsv
         5mXb+Qx450qGJaVjRJ1IzfXticLfmpmDklLRXyiwe7j4YoBf4w8l0WcNPFaHFUSOy9Di
         NvXTVAgwyN5Em/iXQ/DRfmOJ0FnsPnXXgr6tqu4weuK8cejMA+b4CdRlGJtgb8ceL4CT
         6uJPu/MCwsYWIQvV350giTQips5NWbkQGTPvZkRzueaXZWFkVmlRNPhMHMrnJEY99D2M
         o94Vf+keGNmPZxAu915DIDKzpTXbKyQYvkiTJlm2Bii3W/m5vDrC6C4jkTS5HcccByT2
         Y6MA==
X-Gm-Message-State: AOAM532eSTa4Pr27WnZ6yixChptJbYaTBNoojKlrTADGpcL/dqZHdyhX
        JcNgtl+dptLFykSqZzW8BcLIZQ==
X-Google-Smtp-Source: ABdhPJztA7MLr2E6odObLfxQK6j2NDLvXaQUVbwCfwZV8inZmomln2BM1g3CwJ4xazgwkg1+6VwdeQ==
X-Received: by 2002:a05:6a00:1792:b0:4ba:c60b:a63a with SMTP id s18-20020a056a00179200b004bac60ba63amr1422411pfg.0.1640060774320;
        Mon, 20 Dec 2021 20:26:14 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id ls6sm986959pjb.33.2021.12.20.20.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 20:26:13 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:56:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@axis.com,
        mst@redhat.com, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: virtio: remove timeout
Message-ID: <20211221042609.zeo6ci45sxzjxgrt@vireshk-i7>
References: <20211220130656.16900-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220130656.16900-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-21, 14:06, Vincent Whitchurch wrote:
> The driver imposes an arbitrary one second timeout on virtio requests,
> but the specification doesn't prevent the virtio device from taking
> longer to process requests, so remove this timeout to support all
> systems and device implementations.
> 
> Fixes: 3a29355a22c0275fe86 ("gpio: Add virtio-gpio driver")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/gpio/gpio-virtio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 84f96b78f32a..9f4941bc5760 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -100,11 +100,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
>  	virtqueue_kick(vgpio->request_vq);
>  	mutex_unlock(&vgpio->lock);
>  
> -	if (!wait_for_completion_timeout(&line->completion, HZ)) {
> -		dev_err(dev, "GPIO operation timed out\n");
> -		ret = -ETIMEDOUT;
> -		goto out;
> -	}
> +	wait_for_completion(&line->completion);
>  
>  	if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
>  		dev_err(dev, "GPIO request failed: %d\n", gpio);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
