Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE1054B2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbiFNOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiFNOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:14:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A892C106
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:14:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i64so8676855pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EEofKDw4c+3KYJpmhYr5DO8YGIRsl7tk3TGnQLh0NKs=;
        b=Rbtb/30uLf9QMQYK/Iy4cOLR0SKmlvSaSP8h94/Lv78jLnHt2sYxIoMFVbqtuLibAK
         UdHOZNkOHdZJ2aopKY0PpPbARcsJJHZ3NBYT5b0vgb0VlFo4cAA9mUxabTFh+CmiU0Mp
         2tlYm9LL0COJt9Wi7LNBxwnigBKCLbEII1OhBGvFtfC4uHIJRpxqtz16keqiBVCBKlXf
         QQuA+Rv+T8MpFeLCKVRcVb0dV9Ai48LthU3FVGgNPi4ViS7Ee9JMAkBbTPW4Dk4yKdT5
         GYPaZn9rEULOgHkbFrh7eUxzfARv+0rYVM1925TIlzhDVYwXOfSoAV2gq2TfvA/QRJOi
         xIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EEofKDw4c+3KYJpmhYr5DO8YGIRsl7tk3TGnQLh0NKs=;
        b=4HSpq4rxlnzNecb1YvdrgMm3+89AIaEW+mVDCuL4kIIqhv7JPPn0aPrAM2mY9SSMHi
         BPwVTZJ24YqR0viklx8So1us9DT2gUhylUFToHtEJLfI3oTcr6xFDEZ5UdB+0mm+jecf
         C9u1SM6Biw9Rk49HatFJpjDvhgBXvsCWSZkkJ4LtWbVm9E38fQmm+G+7LcrFLEN4QikU
         hxxLPCXmMfPYuaP3kFwMlMW49dwZ3tNCoBfouf6ic5umU69jv676JV1xd6r4OXRHkGaW
         nzmwxKey32doAWSaQiebIjY9Lruic1K8IaWAND7b1BAg5zxc++AeKIOCM20YpPnpZqIh
         sfyA==
X-Gm-Message-State: AOAM5333FqgbVwk3E1shNQRwybf3RSbaZrEj9y6juCkVU3oSL3Mmwhhi
        7tPaTHUjyEEq7QTsNPr0Tq2PzA==
X-Google-Smtp-Source: ABdhPJzIgnJpMgvFzFqlwq/947R6ZtySbDRGFzkyrCmQlC3cKHBBt/qYiLpD6IicLJGhVcrSnmCMOg==
X-Received: by 2002:aa7:83d0:0:b0:50c:eb2b:8e8a with SMTP id j16-20020aa783d0000000b0050ceb2b8e8amr4992915pfn.31.1655216083155;
        Tue, 14 Jun 2022 07:14:43 -0700 (PDT)
Received: from [10.20.0.186] ([199.101.192.9])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b00167804a044fsm7299458plb.56.2022.06.14.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 07:14:42 -0700 (PDT)
Subject: Re: [PATCH 1/3] uacce: supports device isolation feature
To:     Kai Ye <yekai13@huawei.com>, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        wangzhou1@hisilicon.com
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-5-yekai13@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <452a54f0-27ce-6c0d-da56-883b0204f57c@linaro.org>
Date:   Tue, 14 Jun 2022 22:14:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220614122943.1406-5-yekai13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 下午8:29, Kai Ye wrote:
> UACCE add the hardware error isolation API. Users can configure
> the error frequency threshold by this vfs node. This API interface
> certainly supports the configuration of user protocol strategy. Then
> parse it inside the device driver. UACCE only reports the device
> isolate state. When the error frequency is exceeded, the device
> will be isolated. The isolation strategy should be defined in each
> driver module.
>
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>   drivers/misc/uacce/uacce.c | 51 ++++++++++++++++++++++++++++++++++++++
>   include/linux/uacce.h      | 15 ++++++++++-
>   2 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index b6219c6bfb48..4d9d9aeb145a 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -12,6 +12,20 @@ static dev_t uacce_devt;
>   static DEFINE_MUTEX(uacce_mutex);
>   static DEFINE_XARRAY_ALLOC(uacce_xa);
>   
> +static int cdev_get(struct device *dev, void *data)
> +{
> +	struct uacce_device *uacce;
> +	struct device **t_dev = data;
> +
> +	uacce = container_of(dev, struct uacce_device, dev);
> +	if (uacce->parent == *t_dev) {
> +		*t_dev = dev;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>   static int uacce_start_queue(struct uacce_queue *q)
>   {
>   	int ret = 0;
> @@ -346,12 +360,47 @@ static ssize_t region_dus_size_show(struct device *dev,
>   		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>   }
>   
> +static ssize_t isolate_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
Are these two isolate ops  required or optional?
Do we need consider NULL pointer?

Thanks
