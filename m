Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D849FE3A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350227AbiA1Qhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350238AbiA1Qhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:37:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC050C061749;
        Fri, 28 Jan 2022 08:37:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b9so12863114lfq.6;
        Fri, 28 Jan 2022 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=B8h6z6vTvVv45oAmrgyCfcqvjrGp2v2Mo2IW1UAzWUo=;
        b=AuvLkQ2XhwREP3BMZ5G5PyOAJoQFrg6OgvMBnZFdE+44Jb5XKut/AEm3vDJV67T0MS
         LPatbl97xNvyzmQCwjRmOEyAzKDmoj0WPKTq7wYG6WeciqKeP+rT+fc8mRzV8Q1NWgi4
         oezaNE9tNeEBJoyyeejKwfeWoL0i3hVdw72a77Ut9R0H5wDsSYbFeLqItukGbtrSI/4N
         Wq0Jq3gaafv/SULC6zviIdlZQwPdTrAoM+P3lYvyVGKU/Um8urgo4+KXeI61N9ge1H9r
         9YCFuR3WEqWU4IUxmrEZuN4vqw10NrAWwhRRcroxl+x7gDri0Lr81ojW3kOyJDa96NgH
         sHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B8h6z6vTvVv45oAmrgyCfcqvjrGp2v2Mo2IW1UAzWUo=;
        b=RxnkVrDZr7g3EjdQxo6mV70075IWyJwYPbdODjyas8iSpjyEvBu16fDZbG7aJHJj8x
         ot5hJksnxTGLs6W8S4LVOkUlxI0IRDYDmA1Y2Rx5ko6xz7Iwb7qlAQvk9iZFr5IYolQx
         qi38az8LEOpA2LIeK70OX0Snk1g50yiTXiRFLf6ucwgYKzKXjaDiIqO5F+rMNM2Sczp+
         NvpJVtZXK/8+IjLYt5viMAr4NCOb32uAEyRg5coRVxZx5auPs8k29xuMDtvjh+hL9jyz
         /e97oYO6NDb0FHnRrYKYyT9S5NACYoQPiG6HJPXehXqKBpm99oC3EJQYHSVciAAspsCd
         U+xg==
X-Gm-Message-State: AOAM530jWg2wRhRAvSWVjiYHFfUbPBU8Tqv4vHiqaNatecP6W97pEzL9
        RQZd5fDfsNaYgMa3khYJleE=
X-Google-Smtp-Source: ABdhPJwepF/k8wrz+uM6ysOf7kCdxjxF5vPSds8cOovFJXDNhG6OinULhJx36HBmNYE4wX6E87FWiA==
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr1863288lfr.356.1643387862769;
        Fri, 28 Jan 2022 08:37:42 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id p16sm1941350ljn.55.2022.01.28.08.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 08:37:42 -0800 (PST)
Message-ID: <adfcf465-cff1-e15e-89fa-fdc573b7820f@gmail.com>
Date:   Fri, 28 Jan 2022 19:37:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] spi: tegra20: Fix missing IRQ check in
 tegra_slink_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220128161807.10145-1-linmq006@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220128161807.10145-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.01.2022 19:18, Miaoqian Lin пишет:
> This func misses checking for platform_get_irq()'s call and may passes the
> negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
> causing it to fail with -EINVAL, overriding an original error code.
> Stop calling request_threaded_irq() with invalid IRQ #s.
> 
> Fixes: e4bb903fda0e ("spi: tegra20-slink: Improve runtime PM usage")

I don't see how this patch is related to e4bb903fda0e. This tag is
incorrect and should be removed.

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - fix wrong func name in commit message.
> ---
>  drivers/spi/spi-tegra20-slink.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index 2a03739a0c60..0eea35882777 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1100,6 +1100,11 @@ static int tegra_slink_probe(struct platform_device *pdev)
>  	reset_control_deassert(tspi->rst);
>  
>  	spi_irq = platform_get_irq(pdev, 0);
> +	if (spi_irq < 0) {
> +		dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);

The "ret" isn't assigned to spi_irq in the error message.

Moreover, platform_get_irq() already prints error message [1] by itself.
The duplicated message is unnecessary and should be removed.

[1]
https://elixir.bootlin.com/linux/v5.17-rc1/source/drivers/base/platform.c#L256
