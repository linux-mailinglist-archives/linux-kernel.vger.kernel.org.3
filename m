Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3367505D56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbiDRRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbiDRRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593812BB28
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:13:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t184so6981742pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BvtRLSGlIqgoZJw83CHbKmm9w5RaBORQkePsPwp3Jcs=;
        b=X4HUkGNZmS19IamCaufLPwvkr3VU3muJTy0uqV5g7ZncQwXZXwPRIPzafxazChGNEO
         ybOPX5th1MG/Yh4Yz1AYYEXYUO1Km9yplsj4dJUgklqGMwCcUAJo+voR9rMmHwE28Lm/
         TIHSSMmO6CjeQWVmvdyA9zhyPjvF5wnXzN01hFDq8nqhN4iJW+KLB58OFFV91GkgEig8
         38brj/8xk4X5b7UkhN2nVvDuccfkk7KvvWk+JROL/vggq0uL2noWR2Zxih8fX6AdYzxh
         Iq4Ye/qp4Z4iCOcRuFSskjr57JNOXttTftidMDZGNvCaK3+CvUxVdqWpFHuQadh2LhUI
         GWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BvtRLSGlIqgoZJw83CHbKmm9w5RaBORQkePsPwp3Jcs=;
        b=pwjobDvfaJ/wKpd8OL3WZy7gQl7nGRHLxZKjsglwQSrSdyIhQjAjziHEs5+4Hz2UtI
         HG3ZVYhJbjFL7GyQ7ppDFdlnq84TTu3umjBN8QDEYGEQ60y7LqTI75Wcc4ahjOZHsbK4
         ISZ6SESV1+ebmFqMFvvlHctMElD/usTiy9Vmz8BgfE8Lfs7Ptj/9RcGaQSb5aCj5cWYh
         A0NXnubQgFWNl8z43QMwbqihI4op+Dq3n0VP+oW5v4dU1X0ibbhyYH47+tyf8dIZulhx
         Gb/vfDSTWnauAgeuq+NhcTGMItIlPKc+CfsmArPYNQZVX/x8+TvacwFLwkWPAp/ahGF+
         /g8Q==
X-Gm-Message-State: AOAM533/H+zVoBlSwAInJ3a48+CoHwdfGNV7g4z1rrHyAflWI09LhJDI
        xS79HAzStZOgtipct52ssdD7nQ==
X-Google-Smtp-Source: ABdhPJx+xxEgbzOInBcT6iUBxz+NtIWz/XvFoiE0lFt8D8qcoTK1TxWsyQtJDP8JzSBdLixiTYwdjw==
X-Received: by 2002:a62:1c8d:0:b0:4fa:8dcb:6da2 with SMTP id c135-20020a621c8d000000b004fa8dcb6da2mr13217641pfc.19.1650301992571;
        Mon, 18 Apr 2022 10:13:12 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u26-20020a63471a000000b003aa1ad643bdsm1809062pga.47.2022.04.18.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:13:10 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:13:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
Message-ID: <20220418171308.GA952787@p14s>
References: <20220415025737.1561976-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415025737.1561976-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:57:37AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Resource table is used by Linux to get information published by
> remote processor. It should be not be used for memory allocation, so
> not create rproc mem entry.
> 
> Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V4:
>  Typo fix
>  use strcmp, not strncmp
> 
> V3:
>  Update commit log
>  Update Fixes tag
> 
> V2:
>  Add Fixes tag
>  Separate the patch from https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-7-peng.fan@oss.nxp.com/
>  Address typo
> 
> 
>  drivers/remoteproc/imx_rproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 7a096f1891e6..91eb037089ef 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
>  		if (!strcmp(it.node->name, "vdev0buffer"))
>  			continue;
>  
> +		if (!strcmp(it.node->name, "rsc-table"))
> +			continue;
> +

Applied.

Thanks,
Mathieu

>  		rmem = of_reserved_mem_lookup(it.node);
>  		if (!rmem) {
>  			dev_err(priv->dev, "unable to acquire memory-region\n");
> -- 
> 2.25.1
> 
