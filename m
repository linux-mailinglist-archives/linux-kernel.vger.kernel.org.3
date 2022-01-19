Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019C9493F59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356523AbiASRtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350491AbiASRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:49:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:49:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c9so2876882plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m2jEv1T9iOrxqYTw18pKQSL30EzBZlle4dn9cK+DSqw=;
        b=yYC/dxsoRFYYCmHQLUxvN9S6Rv06g14VEcDuzt4uz0F2KjwW1iRdeYUMBbaD6CNfWr
         vGjuX5PoTNyF/MZkmPqlf33YZ7E5i4xXgmgCoIOHQ837W9l8Y2+qb8QXOF3gjGX5OJtH
         cGb7/d6iQoFC82KaDydcPa4Kpaxm3dVjbY9+CKCMXd1YOIBxvuRPcTVCIDn1f1DcVHcR
         KdvkiSBn9iDs1G7Cq4mcPUWahx+wTKMOqIQQWKuOZw7Q+tQW6nzhDfdU74gTDWRtl01h
         aFNbRI3ZwzsK0r6I2N/NXKOkDetbIpEXZ+lBFniKWejE9KRAYslDjl8zBYJ8TQBKyLUT
         3RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m2jEv1T9iOrxqYTw18pKQSL30EzBZlle4dn9cK+DSqw=;
        b=upKpXkWJEUSGUZ4pEO9+KNGHSvfn3YosiaH71Nk3XjdZyPBmtr+t5t/UsqN/9NfjuE
         fBM0RBU3L+Lz4N3wLXoFuOGF2xL8kaMw379nL9nIvTaztDoqm/KLprPsJDg0ni7y0w3m
         DtPgnWa+nZDJopIfQLZdhcCdE2KFAexjPAdCbAjk6N27SXoy6kYCptlG7d+f8TsAtYW4
         tjiipw5zK0cnCYvN2ESFf3g5PklsYHI+zYnwYDTjJVHAebG7lcfuj9gVB07Yb05yR973
         v92z9B6DrDi5QdLuUUMBZ3QXznrflw0f1DvlJfQq8u9F9xXTkqvwTLf7EKSTs2EF2EVd
         Eo3g==
X-Gm-Message-State: AOAM533TU8Dlutd0vieDaUJbOH8Mx3U+X8OTRpRnA/RrYcMxxzR0R4E4
        rme9qGlVnbHzTPCon3QxVllw9Q==
X-Google-Smtp-Source: ABdhPJw6QwCwyN0MLYbe0U5pzmVmTRgRp/n4pJ+Hy1u2Aykbx4Kawx2ncMpzUtvyGtt1RmXiGXfsOQ==
X-Received: by 2002:a17:902:ecc6:b0:14a:fba3:168d with SMTP id a6-20020a170902ecc600b0014afba3168dmr1989056plh.8.1642614592561;
        Wed, 19 Jan 2022 09:49:52 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k16sm319644pff.39.2022.01.19.09.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:49:50 -0800 (PST)
Date:   Wed, 19 Jan 2022 10:49:47 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] remoteproc: imx_rproc: make clk optional
Message-ID: <20220119174947.GA1282028@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-8-peng.fan@oss.nxp.com>
 <20220118185019.GG1119324@p14s>
 <DU0PR04MB9417B0AC80F41D425F43277C88599@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417B0AC80F41D425F43277C88599@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:25:48AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 5/9] remoteproc: imx_rproc: make clk optional
> > 
> > On Tue, Jan 11, 2022 at 11:33:29AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > To i.MX8QXP/QM/ULP and i.MX7ULP, Mcore maybe out of control of Linux.
> > > And in such case, no need clk, so make clk optional with has_clk.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index 7b2578177ea8..0e99a3ca6fbc
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -89,6 +89,7 @@ struct imx_rproc {
> > >  	struct work_struct		rproc_work;
> > >  	struct workqueue_struct		*workqueue;
> > >  	void __iomem			*rsc_table;
> > > +	bool				has_clk;
> > 
> > I am usually weary of bloating structures with flags.  I suggest achieving the
> > same functionality with a macro that compares priv->dcfg with the right
> > imx_rproc_dcfg structure.
> 
> priv->dcfg is some kind fixed settings, however has_clk could be runtime changed,
> because i.MX platform M-core support multiple booting method and it
> could work w/o clk handled by Linux depending on some pre-configuration
> such as moving M-core in an separate hardware partition.

Unless there is an FPGA in the mix, clocks and power domains should not change.
Either clocks are handled by the remote processor or the application processor,
regardless of the mode (attached or detached) the platform is booting into.

> 
> Thanks,
> Peng. 
> 
> > 
> > >  };
> > >
> > >  static const struct imx_rproc_att imx_rproc_att_imx8mn[] = { @@
> > > -724,6 +725,9 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
> > >  	if (dcfg->method == IMX_RPROC_NONE)
> > >  		return 0;
> > >
> > > +	if (!priv->has_clk)
> > > +		return 0;
> > > +
> > >  	priv->clk = devm_clk_get(dev, NULL);
> > >  	if (IS_ERR(priv->clk)) {
> > >  		dev_err(dev, "Failed to get clock\n"); @@ -768,6 +772,7 @@ static
> > > int imx_rproc_probe(struct platform_device *pdev)
> > >  	priv->rproc = rproc;
> > >  	priv->dcfg = dcfg;
> > >  	priv->dev = dev;
> > > +	priv->has_clk = true;
> > >
> > >  	dev_set_drvdata(dev, rproc);
> > >  	priv->workqueue = create_workqueue(dev_name(dev));
> > > --
> > > 2.25.1
> > >
