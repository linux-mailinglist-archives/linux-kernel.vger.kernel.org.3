Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18742467AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382084AbhLCQNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382071AbhLCQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:12:48 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49127C061359
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:09:22 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so3854824otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BKBDLL0Pg+6Be9p1WaSktay52T0y6mFUaQvtWCJbSMY=;
        b=OAIncqtMT/0scZLU2/Ve9TW4YlALP3eX2kqcFI2dVzOsrl+AZ6q8pHZ06mPBgho/Vr
         qjJ/T0TIm3neKK/2Hk6fXlFiRYa4RAnR9VcKY7d5ZGdnvTGP7GckpkoTOszLJAul9Hv3
         Xq6jUGzRhb30NNs5LxnIEniqTw2eTalhG7CV42MoyU1BEBPiE9UbZx5tt6baxR4HCbXn
         Fr3ldoIOA3VOSSd9ubeR+Ae4Oyucm41LP2RmyXQgQTZZidlYWV158BXniH168Ouqn2W0
         rfNX1X42gZx9mhnQDhHesGeYt6axyqYAR9CEdGRuGbL3JD7SbM3I4nAcTYG95hUm7wAZ
         7Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKBDLL0Pg+6Be9p1WaSktay52T0y6mFUaQvtWCJbSMY=;
        b=aKmBv/aQl8Md9eMkyaHUxswQ75LS0kxcr7XJKafS8MB/dx0TAyzvGuavECTV/iuPtl
         agOTQV778Ws0kO78VQxEKH1bfv2lwQzsoXJ3tQwjlvFXoUP32U5XyMLSA5Ayv3g3n1Gz
         74emCR0lOlZSOnjpLgXkCxW9WNsRIWhbHs5KA7PE/8DTX70ZlFPJTrYPf98wJ/337YUk
         7mgilkQFSz/awVG0Y5E2R9GVaGwpnP6t3PAS3m0TRosqdgkL6iS1tv5tYk60/z+UEcCG
         +bKgssdBjIGl4XIaCpSMb/weOx6qia7BWA0252tL8SFefDStPeWsvvPV4UnZyWUPw3LP
         sSWw==
X-Gm-Message-State: AOAM531YFNEF5r3DCcGfac82PM63C15Qtl/pxHYkz/z7FU7BJVMM8rU5
        gH9PbOuVGdEG8TWfD1skmm6jLg==
X-Google-Smtp-Source: ABdhPJx4AjNs6LMs4LnJVhhw+WDzmH+OPWF5FL9a4YiirmlcQkf0Z8zzZLQsjZ6nLcobpwTP8PufAQ==
X-Received: by 2002:a05:6830:1494:: with SMTP id s20mr17149352otq.172.1638547761473;
        Fri, 03 Dec 2021 08:09:21 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f20sm840505oiw.48.2021.12.03.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 08:09:20 -0800 (PST)
Date:   Fri, 3 Dec 2021 10:09:16 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: sm6125-gcc: Swap ops of ice and apps on sdcc1
Message-ID: <YapBLN4b01E9Iz9F@builder.lan>
References: <20211130212015.25232-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130212015.25232-1-martin.botka@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Nov 15:20 CST 2021, Martin Botka wrote:

> Without this change eMMC runs at overclocked freq.
> Swap the ops to not OC the eMMC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

Fixes: 4b8d6ae57cdf ("clk: qcom: Add SM6125 (TRINKET) GCC driver")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/gcc-sm6125.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
> index 543cfab7561f..431b55bb0d2f 100644
> --- a/drivers/clk/qcom/gcc-sm6125.c
> +++ b/drivers/clk/qcom/gcc-sm6125.c
> @@ -1121,7 +1121,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
>  		.name = "gcc_sdcc1_apps_clk_src",
>  		.parent_data = gcc_parent_data_1,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> @@ -1143,7 +1143,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
>  		.name = "gcc_sdcc1_ice_core_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_floor_ops,
> +		.ops = &clk_rcg2_ops,
>  	},
>  };
>  
> -- 
> 2.34.0
> 
