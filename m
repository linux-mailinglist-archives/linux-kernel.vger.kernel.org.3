Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B264D6865
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiCKSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbiCKSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:21:53 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC529BD2E3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:20:49 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so6801059otq.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0XCZSSYUxWjjomwnD2lYhbaRZ7zlD7qdfMOSwCQW09s=;
        b=kHEPz0z7I7YdLzYk85vXvqchzpmoZwlqoWPvcV2+BaluB1OfX+kOGhpYd2j/KddU4m
         qjRn/G1N3B2vja2ivGtvs4TETE3JVjjO8pLaJ7e1dW72zQatLr3VUNJ8EHDNR44a5vVV
         GYr9ywtSB/boUN+35ZDjRF8aa6Pen6Zm+DaFHceR42V4HzXO+Kughg16fU+KcbccfQXB
         xkmledf3aV+2Re5azWXmv54ti0E0n3TfaXV7vmXZAIbvi45vqyZMXy9YtmqBuUA48HXD
         ApacltuXr4jhv1yO4wx21vOPBLlUz29h6AO50OGlD9Mbf7/X6yNSQ5JbYb9vfMtWZtTT
         REQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XCZSSYUxWjjomwnD2lYhbaRZ7zlD7qdfMOSwCQW09s=;
        b=mo6q7vAHiBhQ2AIOciWmF4XGrTzdRMnWJcUxJavLBBTySIxv6P4CoFZ1R3YPklTkNA
         9Mm66BifP+1QoZjL54HOHH2dEgn402nrxsnrBez1umuegkImtLvDZ7IUXxB/907aDixI
         10MdlrlVazpGHw5JBq1MiCRjFgbA9m+Gu9Nt7JF1ldKdBJkDPAAS8IK55g7fgIpM0YWy
         f16arvGl3c0V1G/B/ykhQQhN63hFxs2Bnh5qoIUO33iqaghmVTBeUFzYa3oR/M0bYVjw
         Ue5s0yjy5OGGOlHSu2ncwJpQPnApC7zR++Xc9vXMiBg4nVkdHR4TAlfWR11hTFIjabXd
         34/Q==
X-Gm-Message-State: AOAM532CCMNLAcgAEMFyRc34GK6wad2X7F0xzzzQLaTCOaqO/fz/76Se
        KifYCLoSEnO4NgzFGdyn0pEiAA==
X-Google-Smtp-Source: ABdhPJys4u6YxWXymBZmswZzl4L8tNx1NsVBadm2bVHFPU2mgJp3qwIQkLI+5i6YhRQsTFerFhScqA==
X-Received: by 2002:a05:6830:34f:b0:5b1:f8fe:f957 with SMTP id h15-20020a056830034f00b005b1f8fef957mr5499792ote.153.1647022848767;
        Fri, 11 Mar 2022 10:20:48 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000d6bd82a92fsm4167829oab.18.2022.03.11.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 10:20:48 -0800 (PST)
Date:   Fri, 11 Mar 2022 12:20:46 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mathieu.poirier@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
Message-ID: <YiuS/pVVdqFXy9mA@builder.lan>
References: <20220308065754.3355-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308065754.3355-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Mar 00:57 CST 2022, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Resource table will not be used for memory allocation, no need to create
> rproc mem entry.

Can you please expand this to cover why the "resource table will not be
used for memory allocation"?

Regards,
Bjorn

> 
> Fixes: b29b4249f8f0c ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Add Fixes tag
>  Separate the patch from https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-7-peng.fan@oss.nxp.com/
>  Address typo
> 
>  drivers/remoteproc/imx_rproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 7a096f1891e6..f2bfc9077c19 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
>  		if (!strcmp(it.node->name, "vdev0buffer"))
>  			continue;
>  
> +		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
> +			continue;
> +
>  		rmem = of_reserved_mem_lookup(it.node);
>  		if (!rmem) {
>  			dev_err(priv->dev, "unable to acquire memory-region\n");
> -- 
> 2.30.0
> 
