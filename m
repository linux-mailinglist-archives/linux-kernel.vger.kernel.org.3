Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88818473821
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbhLMWz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbhLMWzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:55:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AA8C0617A1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:55:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t5so56924776edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/nvhxeMTi05OGmz1DsmtB7RmMc0RwaHnCA/LhMCRmZs=;
        b=HrJDI8IX0mMlJsutIPoMjb+Oc6sUOW4+n6t8+j0m7VBiYBUYJzZllbSW2pZyEEpsT9
         rTGVg4xUaLUsYajEll9J6CRYLXMG5ephiRE/Y697Quu56dy1kJUEh1PCpGjQd1SEtuIO
         jyFid9OUZE87cBCbgQFFu0713nbb0y9ssTyyb9FEjhzu/lC8D8nAjCtKjeHwW8N+t7rL
         nOM0Okjaaf4oA14Rrr8g2bHgVBnUeRFX8EpMH5hHaeqNjEJE7mcFHHTKAAIvbCY05fap
         YVG6TU6NuMHdYO949vw5cwp1LGCnyA98gIGuDUqiXRC4g/O+cZRV0GRVYfBdf/PA1E6W
         KedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/nvhxeMTi05OGmz1DsmtB7RmMc0RwaHnCA/LhMCRmZs=;
        b=SWX3qF29nww80r9NcEbL+4sYKzz7jsL1yuqJksgEYVDQGpWYesbtfXYsjU+2L//0ZO
         wzSDyLUDhFWVS8v++dOOtT8RQko7b7BZgWzSaWJ7W/zaSbjdrYsS7q8HZb6u/T7LQL5D
         qBTe5fGdgmzFo7Fwa3r9IZB3SfMkd+IGrF9035IYkKgZuOOjmNC1qzrDRdz5+IeEXOqu
         pcDUbtnKOBIy0TAh3s9BCIUKvRW5uQbByE59Ew4e9O4VA8rUYAmFuh/ogOwXSv/Gea+b
         RvYuQQfSDHUyqrv8IHXpENGBVq+wXQ8GQmVjzUvOSVmTWOjaVm7bcn+puKL5xEO5Zgg+
         cTOQ==
X-Gm-Message-State: AOAM532rxSWWrWmKIlbCLuWCtMOPyHHY8WcLJjDgStui9pr2kJJOJ67D
        ncFzLbsoKBoMENv+38hoNMZ9ABfmnqFE4Q==
X-Google-Smtp-Source: ABdhPJyOuKQfGjttoEpTXUX47uqhRj3Qnn0Z9g70ETG9oc780+wOIHeV4mG3irsYY0uFJAP8XiurHA==
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr1516948ejc.330.1639436145433;
        Mon, 13 Dec 2021 14:55:45 -0800 (PST)
Received: from [192.168.1.15] (hst-221-97.medicom.bg. [84.238.221.97])
        by smtp.googlemail.com with ESMTPSA id a13sm6882861edk.29.2021.12.13.14.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 14:55:45 -0800 (PST)
Subject: Re: [PATCH v2] media: venus: Synchronize probe() between venus_core
 and enc/dec
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     John Stultz <john.stultz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211029214833.2615274-1-tadeusz.struk@linaro.org>
 <YZ2x+xuvnHC48MHg@ripper>
 <CALAqxLV7YzuHLzNFSWawjpoJGb3WwO4bgnMN_5mWoHmB582kZw@mail.gmail.com>
 <CALAqxLWjK4h-ghF5s8qV6Q3Wp3K1N816dTfiLNatBTms6NDe3A@mail.gmail.com>
 <fee96315-28cb-58a1-7f2d-eb82d9ecb56a@linaro.org>
Message-ID: <906cfb55-3f9a-e7ab-355c-ba4f02029f93@linaro.org>
Date:   Tue, 14 Dec 2021 00:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fee96315-28cb-58a1-7f2d-eb82d9ecb56a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/21 12:50 AM, Stanimir Varbanov wrote:
> From 9bfb69026374fa010d36680554e2634d5d435681 Mon Sep 17 00:00:00 2001
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> Date: Tue, 14 Dec 2021 00:45:18 +0200
> Subject: [PATCH] venus: WIP: Rework and reorder firmware load
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c     |  8 +++----
>  drivers/media/platform/qcom/venus/core.h     |  2 ++
>  drivers/media/platform/qcom/venus/firmware.c | 22 +++++++++++++++++++-
>  drivers/media/platform/qcom/venus/vdec.c     |  3 ++-
>  drivers/media/platform/qcom/venus/venc.c     |  3 ++-
>  5 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c
> b/drivers/media/platform/qcom/venus/core.c
> index 877eca125803..7f65b08b2bac 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -344,10 +344,6 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_runtime_disable;
> 
> -	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> -	if (ret)
> -		goto err_runtime_disable;
> -
>  	ret = venus_firmware_init(core);
>  	if (ret)
>  		goto err_of_depopulate;
> @@ -372,6 +368,10 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_venus_shutdown;
> 
> +	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	if (ret)
> +		goto err_venus_shutdown;
> +
>  	ret = pm_runtime_put_sync(dev);
>  	if (ret) {
>  		pm_runtime_get_noresume(dev);
> diff --git a/drivers/media/platform/qcom/venus/core.h
> b/drivers/media/platform/qcom/venus/core.h
> index 7c3bac01cd49..6455efb35168 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -182,6 +182,8 @@ struct venus_core {
>  	atomic_t insts_count;
>  	unsigned int state;
>  	struct completion done;
> +	struct completion fwload_done;
> +	bool fwload_success;
>  	unsigned int error;
>  	unsigned long sys_error;
>  	wait_queue_head_t sys_err_done;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c
> b/drivers/media/platform/qcom/venus/firmware.c
> index 14b6f1d05991..d523fbeb9d56 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -76,6 +76,14 @@ int venus_set_hw_state(struct venus_core *core, bool
> resume)
>  	return 0;
>  }
> 
> +static void firmware_async_load(const struct firmware *fw, void *context)
> +{
> +	struct venus_core *core = context;
> +
> +	core->fwload_success = true;

this should be

	if (fw)
		core->fwload_success = true;

> +	complete(&core->fwload_done);
> +}
> +
>  static int venus_load_fw(struct venus_core *core, const char *fwname,
>  			 phys_addr_t *mem_phys, size_t *mem_size)
>  {
> @@ -101,10 +109,22 @@ static int venus_load_fw(struct venus_core *core,
> const char *fwname,
>  	if (ret)
>  		goto err_put_node;
> 
> -	ret = request_firmware(&mdt, fwname, dev);
> +	init_completion(&core->fwload_done);
> +	core->fwload_success = false;
> +
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOUEVENT, fwname,
> +				      dev, GFP_KERNEL, core,
> +				      firmware_async_load);
>  	if (ret < 0)
>  		goto err_put_node;
> 
> +	wait_for_completion(&core->fwload_done);
> +
> +	if (!core->fwload_success) {
> +		ret = -ENOENT;
> +		goto err_put_node;
> +	}
> +
>  	fw_size = qcom_mdt_get_size(mdt);
>  	if (fw_size < 0) {
>  		ret = fw_size;
> diff --git a/drivers/media/platform/qcom/venus/vdec.c
> b/drivers/media/platform/qcom/venus/vdec.c
> index 91da3f509724..0e718d24a3b3 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1718,6 +1718,8 @@ static int vdec_probe(struct platform_device *pdev)
>  	if (!vdev)
>  		return -ENOMEM;
> 
> +	core->dev_dec = dev;
> +
>  	strscpy(vdev->name, "qcom-venus-decoder", sizeof(vdev->name));
>  	vdev->release = video_device_release;
>  	vdev->fops = &vdec_fops;
> @@ -1731,7 +1733,6 @@ static int vdec_probe(struct platform_device *pdev)
>  		goto err_vdev_release;
> 
>  	core->vdev_dec = vdev;
> -	core->dev_dec = dev;
> 
>  	video_set_drvdata(vdev, core);
>  	pm_runtime_set_autosuspend_delay(dev, 2000);
> diff --git a/drivers/media/platform/qcom/venus/venc.c
> b/drivers/media/platform/qcom/venus/venc.c
> index 84bafc3118cc..1b3fb927eb16 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1448,6 +1448,8 @@ static int venc_probe(struct platform_device *pdev)
>  	if (!vdev)
>  		return -ENOMEM;
> 
> +	core->dev_enc = dev;
> +
>  	strscpy(vdev->name, "qcom-venus-encoder", sizeof(vdev->name));
>  	vdev->release = video_device_release;
>  	vdev->fops = &venc_fops;
> @@ -1461,7 +1463,6 @@ static int venc_probe(struct platform_device *pdev)
>  		goto err_vdev_release;
> 
>  	core->vdev_enc = vdev;
> -	core->dev_enc = dev;
> 
>  	video_set_drvdata(vdev, core);
>  	pm_runtime_set_autosuspend_delay(dev, 2000);
> -- 2.25.1

-- 
regards,
Stan
