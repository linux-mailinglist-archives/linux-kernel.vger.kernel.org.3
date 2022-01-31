Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC804A522A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiAaWOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiAaWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:14:42 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71FBC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:14:42 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id x193so29711924oix.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kX4vv41O521cqb/Mmwr+SoFy/57SVrz0KMGJ5f1fPRE=;
        b=wf/6iZqCoedJnvxF79ng3qS6/4Z/jyUagYvpSeL5nM2YSKno3QUY7NUPBUTO7BWHxR
         ALnUrXUHMIXd0JVmcBcqoZnB8WqfMCAxh4xp4CjLv1+HqrCD06tdzq/4U6lXA88R7ysH
         YNZN+p6oOArJkbBEEGFcRc4aYrcAyWjYnLDUP7NgZaeWgsfIZAtzXCwZgSkmGBwHUjIn
         6sXGZOSpgdKyzJzSMqdSO5OjOsAcV747d1RKX83opf1GeNyUTfrGUy9IoqRLAdGpHmho
         /ftlOL74Hv4HZAZ4ClR6LwCOWKkWvNn2xKOU/zjumXj8X60VMtZzZomU3NaQVRDq6JPu
         1WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kX4vv41O521cqb/Mmwr+SoFy/57SVrz0KMGJ5f1fPRE=;
        b=YVo7OjHw6unTdZbnwMt4k+YYjMp8EvnMN1+CMfSa5NVrRHHZWKqCg2y6fXzJYxA9TM
         u0Glk7ycVujxxLMFQhsqC40xzYjqfZZlJJxDsF9+rQiYWS10Ntzfcyb5Zwcg2lAB6zC+
         Um7AFZHuAniTqGPbdXCkfHKYtXQ6tSrtC5eVY9rQ8q990bsLnDhYaPH1Z4xzGw0W+OGn
         /DU0KbiRosPM9lEBaCdVv+ymZV2jClVf4cSWFZl49YTLym5777x51kHn2gmv8sP/Dr6V
         I9sZovYgS3LCH9FoGprOT+Ha3Vwtyh/UG7fARqgqRXzddCSw6XsWkUGC1/OJDnqJoTRA
         17nA==
X-Gm-Message-State: AOAM531D44fetO0rFReYr3VLlJ05xDtB/yNw+gQoLdvsAgu63ILlqpfk
        khwWS8ENV8GmSW7DcQBBCkrc6w==
X-Google-Smtp-Source: ABdhPJw9+6wJu8RmraUx7H9QDDjBebC5U0a57nzJ3ZyXK9TbFdn3cQkVSYOloKkrpZQDH6CClBQntg==
X-Received: by 2002:a05:6808:219d:: with SMTP id be29mr18881055oib.77.1643667282197;
        Mon, 31 Jan 2022 14:14:42 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id j6sm3945195otq.76.2022.01.31.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:14:41 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:14:39 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: ocmem: Fix missing put_device() call in
 of_get_ocmem
Message-ID: <YfhfT0EC393GxSRd@builder.lan>
References: <20220107073126.2335-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107073126.2335-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jan 01:31 CST 2022, Miaoqian Lin wrote:

> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
> 
> Fixes: 01f937ffc468 ("soc: qcom: ocmem: don't return NULL in of_get_ocmem")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Your patch solves the particular problem, so I'm applying it.

But it seems that we never release pdev in the case of successfully
return the ocmem object either... So there's more to improve here.

Regards,
Bjorn

> ---
>  drivers/soc/qcom/ocmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> index d2dacbbaafbd..97fd24c178f8 100644
> --- a/drivers/soc/qcom/ocmem.c
> +++ b/drivers/soc/qcom/ocmem.c
> @@ -206,6 +206,7 @@ struct ocmem *of_get_ocmem(struct device *dev)
>  	ocmem = platform_get_drvdata(pdev);
>  	if (!ocmem) {
>  		dev_err(dev, "Cannot get ocmem\n");
> +		put_device(&pdev->dev);
>  		return ERR_PTR(-ENODEV);
>  	}
>  	return ocmem;
> -- 
> 2.17.1
> 
