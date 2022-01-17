Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB81C49103A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiAQSZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbiAQSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:25:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:25:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso549558pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s8JBuoZ641S86dciUWb+q82uqO3uCSnRWiB4MWHK+xI=;
        b=oqKo55kQCTJyFrCgpgAmfiX9BGfzBQJxezjlffxGmoOCocowd7ghAEstvHPfFzsBEt
         OiwBDIb+g/sLzSyjEwqm1jKzMrZmdRRiDAxFQWk7jWm46oLzXz2O1XpOC9EkyRnO1cEN
         LcPFuf9lYOIOt6zjRbHO/msfXuGxZHpWCeW4k8PLVCwepFBkpGrgBVW8z3WIFElTZzrL
         wqGIUTXdk/jteFlLK+jv0cYwjrlJx2QGXWfR0cHP62QqjH60ZrM5ZpBcpTZOmek24kUe
         m1qLqmKK2HYN6C06qxMILyNg81FPnXWYMIfzJZFex0f1yeuKf6dK8ebv9gw0/ko3JKbN
         1Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8JBuoZ641S86dciUWb+q82uqO3uCSnRWiB4MWHK+xI=;
        b=X79RZmw8I/VYJVjfENPzYGjYmJpVUDT74PHSop3MRgPXLpLtBoDQWAB2x2pBhfwQc8
         qJzn56OIV2WDrpj3SZf5xd8HO16zH47haKfqOVDDoY8kIzHOW06QBJjd+Y4nOJTJKpxl
         r/RFjB1TuW5crr5CVNaDLJRsSK8rxllj3ffyjgSsaQdKmOxGoGerSCUGlq2eQ9hhpBnD
         NdxhUsbSFM43/G8zP9cx2NmHxj4zMs5P3g2gFn8elO6ykwDDkq6RpFB0o8iIn+LUJsBV
         AR/nJFQ9bV+2E2LOJ/Ex4tpF5FW7iEmdEXzRre9QBeJpq02oxo02okxILNVQfu/3MQ8Y
         fOjg==
X-Gm-Message-State: AOAM531eh85PKHNr+g0xlIHY26hryHlg2jNUVyNIwH0ads/30dJCUulh
        /WKAAmXiqQV5JzgJNwzH8JjB4wLmqLQU2w==
X-Google-Smtp-Source: ABdhPJxvrGQl2x1vsrIL8aGdK+/fB0RQgMpZfHxL8kDefayeQ4Co3huvhWIj4IRnDKUPObsF2JDUiA==
X-Received: by 2002:a17:902:b784:b0:14a:2fec:dda2 with SMTP id e4-20020a170902b78400b0014a2fecdda2mr23898376pls.118.1642443955114;
        Mon, 17 Jan 2022 10:25:55 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m1sm12394066pgb.13.2022.01.17.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 10:25:53 -0800 (PST)
Date:   Mon, 17 Jan 2022 11:25:51 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] remoteproc: imx_rproc: validate resource table
Message-ID: <20220117182551.GC1119324@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111033333.403448-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Tue, Jan 11, 2022 at 11:33:23AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Currently NXP use one device tree to support all NXP released Cortex-M
> demos. There is one simple demo that not need to communicate with
> Linux, thus it will not update the resource table. So there maybe
> garbage data in it. In such case, Linux should directly ignore it.
> 
> It is hard to decide what data is garbage data, NXP released SDK use
> ver(1), reserved(0) in a valid resource table. But in case others
> use different value, so here use 0xff as a max value for ver and num.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 0bd24c937a73..75fde16f80a4 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -490,11 +490,19 @@ static int imx_rproc_attach(struct rproc *rproc)
>  static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>  {
>  	struct imx_rproc *priv = rproc->priv;
> +	struct resource_table *table;
>  
>  	/* The resource table has already been mapped in imx_rproc_addr_init */
>  	if (!priv->rsc_table)
>  		return NULL;
>  
> +	table = priv->rsc_table;
> +	/* Gabage data check */
> +	if (table->ver >= 0xff || table->num >= 0xff || table->reserved[0] || table->reserved[1]) {
> +		dev_err(priv->dev, "Ignore invalid rsc table\n");
> +		return NULL;
> +	}
> +

This seems like the wrong fix to me.  Either use different DTs or update the
resource table for all demos - efficiency should not be a problem since they are
demos.  With the above it is only a matter of time before the pattern
associated with valid resource tables changes, leading to more hacks that will be
impossible to maintain over time.

Thanks,
Mathieu

>  	*table_sz = SZ_1K;
>  	return (struct resource_table *)priv->rsc_table;
>  }
> -- 
> 2.25.1
> 
