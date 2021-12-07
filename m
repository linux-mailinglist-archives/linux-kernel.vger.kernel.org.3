Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0F46BDD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhLGOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237943AbhLGOig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:38:36 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F7C061574;
        Tue,  7 Dec 2021 06:35:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z8so27755603ljz.9;
        Tue, 07 Dec 2021 06:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SuFyxr/7dnNItpWRDLc4VXiPbAiF5MgQk734KTvizFc=;
        b=gaEha2TS7Y3zGJZ8QdeuQLLileAK9Sjrr/Oi3pGhR2/TH4c/KMEN76GEvZi+LG0pcj
         IdmvLV/PuvEShtltY0Tk/H1uRGDIQiQZ5gUIDVU9dxD00u+MwRpfelvNM9r9/o223598
         jF9J73QSdnxrDUVIgkOzi785PTvQezxBrKDvyPoZiIPK93GDOSmI1XlX0mzmeQ1g4ABB
         MN0rOh7AbwjZ5o+jwNqQ/+fo/g+TEPIXhq2UUjikF+0GhysLlauisxiENjJ9pZRZUY4g
         336+YNnTUPyubGpr5/HRY2DCi12RuhNqGsyF8IfDCjQ3dcCYBXTOVJAOPVcEEGf6KZxo
         W2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SuFyxr/7dnNItpWRDLc4VXiPbAiF5MgQk734KTvizFc=;
        b=T7MtFYEReTYMrrquDEO+D/BS7DG39Avykm3SnyA4fczfXL/6X/yeTGvh+Y09mHiEcs
         W/XrYieoj6z050qN3xnlPhBXAiJv5fNCY5mTwnHan93SxRgIHY7bkyYEcCi0un+iI7lB
         6pV74ggM+mQypoX/eYeQX4c19sXr4BCMjvJR+vQUupfHzwKCfC1/YOcjNnqrC+mWnvth
         FnEwbBwjDjg5dGFSOkNzSw8jaAdXn9a3MdyM56Voqy+gOITR0GuTQGVVY/OKFMg8t2Zd
         ulheoRk1vEg142+ikefPWpdsvvHInVHLFnKkstvwZz0QoWdzSqo+SaF8qJLeT0S5dtPf
         ewkQ==
X-Gm-Message-State: AOAM531eUMqXd0zPdrcwYHhbrb6gVVvY3zkDA9Agp4XQZyVnokSWBYM/
        vbzBh7aO0yXwkkpHEs/WWfMYiyv4pNk=
X-Google-Smtp-Source: ABdhPJyPwFkf34m4EXALN2Gz+aIAxU89K6YqR+pL9+eWborz/W9yqp7d6SfeTg8EGvmwKRxXJAKrRg==
X-Received: by 2002:a2e:99cf:: with SMTP id l15mr43253417ljj.111.1638887703840;
        Tue, 07 Dec 2021 06:35:03 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id f35sm1709226lfv.98.2021.12.07.06.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:35:03 -0800 (PST)
Subject: Re: [PATCH] phy: tegra: add missing put_device() call in
 tegra210_xusb_padctl_probe()
To:     Qing Wang <wangqing@vivo.com>, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638881776-3308-1-git-send-email-wangqing@vivo.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b56a0b92-cf64-570c-08f8-e7a54fc55946@gmail.com>
Date:   Tue, 7 Dec 2021 17:35:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638881776-3308-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2021 15:56, Qing Wang пишет:
> From: Wang Qing <wangqing@vivo.com>
> 
> of_find_device_by_node() takes a reference to the embedded struct device 
> which needs to be dropped when error return.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
> index eedfc7c..05a0800
> --- a/drivers/phy/tegra/xusb-tegra210.c
> +++ b/drivers/phy/tegra/xusb-tegra210.c
> @@ -3170,8 +3170,10 @@ tegra210_xusb_padctl_probe(struct device *dev,
>  		goto out;
>  	}
>  
> -	if (!platform_get_drvdata(pdev))
> +	if (!platform_get_drvdata(pdev)) {
> +		put_device(&pdev->dev);
>  		return ERR_PTR(-EPROBE_DEFER);
> +	}
>  
>  	padctl->regmap = dev_get_regmap(&pdev->dev, "usb_sleepwalk");
>  	if (!padctl->regmap)
> 

What if dev_get_regmap() fails? What if driver is removed?

Please either fix it properly or don't fix it.
