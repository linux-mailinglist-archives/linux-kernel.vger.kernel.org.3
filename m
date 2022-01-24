Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94D349A7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315743AbiAYCyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3407930AbiAYAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:21:13 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F14C036BC9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:05:19 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 128so17400755pfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=t2/pVCkMGUvGOAzHtcsjzXK8+5zE14NO4NddvkDqj9w=;
        b=zgQsj3L6OSg50dgEyhI8VbLJQG2U1v8YozGt0iCNFUM1VD44MdEEHw1TSHFiiFusYm
         KDxrEiMMuxae+sOtjt1EAf0QRiHYPBqrWfrqeoKDDcS9C6HEE8Yc+eiMecOXPMVj7yBn
         vR6x7/Nxu9rUwbIaPs6BeMj7O0HmKhccqmGffa7QrvZQpq6IeST+8ublmUmvRAE0oJYn
         AdMckgD861YXcZiqZQjGz7k0XtXBU9eYrbKNJx0axcLK9lsZTYS39AsDHHQjpRxksUAV
         NzMsZ/b68MBEQWFupMhFjbLnuTikjDakneYKyipvasoYBv/IYV2UBa0nLqwjNKUeungZ
         2D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t2/pVCkMGUvGOAzHtcsjzXK8+5zE14NO4NddvkDqj9w=;
        b=jHpqOVxh4bax0Fs1BuATblyVK8EK4MP1o/zz8cZ2JPwzIWICaN6yWM7LyKD++ZgyAY
         DweXyzEmNGlTAydm1+favtmZXb5peYnyHuGoOolk5zWjnkThOHK+cpB1qEaS0xylqVGG
         ofV7a31Vpa7nY/K53LbrdUVA6huZwv+TbrbQTSKZYg8E1Afxu0OCHJLzArktSzuQBsDw
         sXJQiPj8kkPGYHlr1A674WqipBY19GTI/gBLQMzsc8d/OzODbuCFzd3eBgYYnH3g11lq
         xgzAmM+CJCrmcKCtGnIzCqG683yoeu1KX0kIZlzVBeKaxEV+wuAuE+U7i44v7aS1GUYf
         DAHg==
X-Gm-Message-State: AOAM5318tkAAN5tPQ0rTY0qvYw0/fxziD5XlyDTdcCua+SHFXzaNO6GX
        UEE5LsNQzXQjomYqMdrULQJEgQ==
X-Google-Smtp-Source: ABdhPJxjC87yai3OmklySQg2guTsUaM+Gp8LsOyFaNfbg6oSqG4pZdEJrXLL3UYim1KqqbXZDdEcOw==
X-Received: by 2002:a05:6a00:114f:b0:4c5:72f6:d0b5 with SMTP id b15-20020a056a00114f00b004c572f6d0b5mr15521818pfm.61.1643061918766;
        Mon, 24 Jan 2022 14:05:18 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g12sm16231227pfm.119.2022.01.24.14.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:05:18 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rong Chen <rong.chen@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        1131046452@qq.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     45581586@qq.com, Rong Chen <rong.chen@amlogic.com>
Subject: Re: [PATCH] mmc: meson: Fix usage of meson_mmc_post_req()
In-Reply-To: <20220106105453.3875119-1-rong.chen@amlogic.com>
References: <20220106105453.3875119-1-rong.chen@amlogic.com>
Date:   Mon, 24 Jan 2022 14:05:17 -0800
Message-ID: <7htudsx00y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rong,

First, thank you finding the issue and for submitting a fix!

Rong Chen <rong.chen@amlogic.com> writes:

> To ensure the DMA moves data correctly from memory to
> peripherals, DMA unmapping when the MMC request done
> with calls meson_mmc_post_req().
>
> Signed-off-by: Rong Chen <rong.chen@amlogic.com>

The patch looks correct, but I think I think the changelog could be
improved.  If I understand the code correctly, I think what you're doing
is:

"""
Currently meson_mmc_post_req() is called in meson_mmc_request() right
after _start_cmd().  This could lead to DMA unmapping before the request
is actually finished.

To fix, ton't call meson_mmc_post_req() until _request_done().
"""

Kevin

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 8f36536cb1b6..6a9554ae4b1c 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,7 @@ struct meson_host {
>  	int irq;
>  
>  	bool vqmmc_enabled;
> +	bool needs_pre_post_req;
>  };
>  
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -663,6 +664,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>  	struct meson_host *host = mmc_priv(mmc);
>  
>  	host->cmd = NULL;
> +	if (host->needs_pre_post_req)
> +		meson_mmc_post_req(mmc, mrq, 0);
>  	mmc_request_done(host->mmc, mrq);
>  }
>  
> @@ -880,7 +883,7 @@ static int meson_mmc_validate_dram_access(struct mmc_host *mmc, struct mmc_data
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> -	bool needs_pre_post_req = mrq->data &&
> +	host->needs_pre_post_req = mrq->data &&
>  			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>  
>  	/*
> @@ -896,22 +899,19 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		}
>  	}
>  
> -	if (needs_pre_post_req) {
> +	if (host->needs_pre_post_req) {
>  		meson_mmc_get_transfer_mode(mmc, mrq);
>  		if (!meson_mmc_desc_chain_mode(mrq->data))
> -			needs_pre_post_req = false;
> +			host->needs_pre_post_req = false;
>  	}
>  
> -	if (needs_pre_post_req)
> +	if (host->needs_pre_post_req)
>  		meson_mmc_pre_req(mmc, mrq);
>  
>  	/* Stop execution */
>  	writel(0, host->regs + SD_EMMC_START);
>  
>  	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -	if (needs_pre_post_req)
> -		meson_mmc_post_req(mmc, mrq, 0);
>  }
>  
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>
> base-commit: 356f3f2c5756bbb67a515760966a40fc7043cdda
> -- 
> 2.25.1
