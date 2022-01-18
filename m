Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB8492DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348308AbiARSrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348296AbiARSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:47:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9315C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:47:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so3556314pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Jn9UYmqn1MU8oZoANpiGDI/HV6NtIHAU4pHzcuqudU=;
        b=rUKHZ5t3ZMbmqVnFJKOYVBscAXvGlbZSE1FIl5HOb3xx3ECUjra5B+vvVHnZOG4CPp
         U0DeUVaQVCcCRaaqM08j8FoMhRdkBzpWWwyEy7hsNvMoRq5EyoyLQ+AUs5OlZkVjSda9
         gn2FRMQx4o1HDJbyqyS0E17olnOaXfjdGvLhTdqrH8ebVWERT5AzdNVMmPfjiqEHF4uA
         no675akiIV8mwPnuTfpKBc5uqOwnp+DmByQcbi6WtlpkbfHzJ4LIv0szkGIB4i/socfi
         BFotihWOwty+KiEEwSD6OLn8cZ4FgvH08gwMHZDgMiFPaxjqOHQoXtLqTm6NszxzJP22
         zQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Jn9UYmqn1MU8oZoANpiGDI/HV6NtIHAU4pHzcuqudU=;
        b=greJ+AAVBLipGa/cMJqcGGQuEXRmeWrbgPU94PNYv2BGW8cR7NbX1qccTnB/NVSnTp
         dTLk1jWSz20JImAxwkxBxKThc5j4GPGaSbOlj91Tijj+vjTA93oxodEn6hOeJ5SFFhtg
         n4M2/clgxudEKqG8mT1Bw2so4/twpqIIYLZHQlC2slqIBwagYS6+ggFEdrAkSnx/1ww6
         Azp/pCK59+SjTT2tjcN8n0D9vkLdXCbdgoeTlKArIy9EuN6ywT0eNwhZ1l61VCvfafQQ
         CW9diTA089AcmWgPJfLhAo3Uwo0KwAnopmiA7Y/WqCVxisqDcFdO0LghhczC91AiO1+7
         Czmw==
X-Gm-Message-State: AOAM530ozFoGgaeDnCy4toYDn+n7F1lySDbveB8UQNqBQER+gyJjJVQt
        t/NNqV3bgNkEYRqyNQ7wShnz2Q==
X-Google-Smtp-Source: ABdhPJxr222Dsjou7YxfibkN2rFexehTNUek1cmrCuCzHUnkEk9NQdzXT4ftHaoTdy1mhs5jkN81VA==
X-Received: by 2002:a17:902:e842:b0:14a:70dd:4d0d with SMTP id t2-20020a170902e84200b0014a70dd4d0dmr29725183plg.67.1642531633367;
        Tue, 18 Jan 2022 10:47:13 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y16sm9487217pfl.125.2022.01.18.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:47:12 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:47:10 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/9] remoteproc: imx_rproc: ignore create mem entry for
 resource table
Message-ID: <20220118184710.GF1119324@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111033333.403448-7-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33:28AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>

The "ignore" in the title should have a capital 'I'.

> resource table will not be used for memory allocation, no need to create

s/resource/Resource

> rproc mem entry.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 75fde16f80a4..7b2578177ea8 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
>  		if (!strcmp(it.node->name, "vdev0buffer"))
>  			continue;
>  
> +		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
> +			continue;
> +

This is a bug fix that should be in a separate patch with a "Fixes:" tag.

>  		rmem = of_reserved_mem_lookup(it.node);
>  		if (!rmem) {
>  			dev_err(priv->dev, "unable to acquire memory-region\n");
> -- 
> 2.25.1
> 
