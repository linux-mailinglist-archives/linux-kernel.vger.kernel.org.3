Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2B2562A18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiGAEDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiGAECh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:02:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16270AF0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:00:15 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so970747oty.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UIQbOmI3pL7SkABqDJH+080MonEhwBz+pt3xl6BVtfY=;
        b=VaIR2IHSPRPJ4kuxXmfzhrJ0wSULAztD2o7AVZAHEJ8Te02eO8QDQCGlIdZ5mYkpX6
         ylFuZoHqHx2+xfG4+1DRCC40gKFT8T8hvE+XDWCe7pWtdBWQ1lrrvtolJyrdefVkcN6F
         h9B9SR6lGywh1BjymSnUXOU83OnudKCp+hQGliBhjX+JaQkkzxpSsMT2Bgshljx+jPBS
         eO6ReqMUrYnvNXKzIdcRBmwzzIRdo9yQ+ETzjlew7HKujhn5mSfRy2+DZzNzFauNQMoB
         DpL3S+EZY0ZuLIUMNVCNc1ZEBxiA95yfKfFc5fuLxpCMw/8XaoiNOGaeUUBnMqTE69fY
         ft/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UIQbOmI3pL7SkABqDJH+080MonEhwBz+pt3xl6BVtfY=;
        b=DsrFlEPF+wuA9ANuBBP7sdzrkQZVXf9mEuXa2l9/XtEHJhzD+uXQZx+3C6lixgA0pU
         H5Cgdm6OjiX0cVr3EZOYzQ932yrkHSt/ieFJu1OJWmFRHr3dMyuVc6+rgg2kVW6VGQQC
         sjj3SEblOv5VWfQ7z7iQEGkTFsGpbzP/BSXuhZcmiDfjKnDNyb8LK0NuMQeduW8zNm+d
         nIN0L+KRlmM3u+K0HDp1xkVsdBdqzv3D1zWooHVIJHRFqqxfNvou2qGd72LWkvvaTajz
         lrmZ/GgT2LBUm/GRHAdNrIjE76mqDQZKYCG1rcXEUk5FkVFniAm54WHg1p5x5aWwlkql
         THaA==
X-Gm-Message-State: AJIora84/2Qj6zWlw2bf5ZhA4U8whT20JhQxBzL8NRgpCyIhNtjr9vS1
        4b3DjPweUgT60UzRUdmWLDCWHQ==
X-Google-Smtp-Source: AGRyM1uXeVOAg5ZEY1ZkjTbui+MlAXJH0K22EzbbOpufiKUlHPpw/tLNbnYPCH5I6VHR2KWyRNHqAA==
X-Received: by 2002:a05:6830:12cb:b0:616:b36b:e50b with SMTP id a11-20020a05683012cb00b00616b36be50bmr5751122otq.1.1656648014778;
        Thu, 30 Jun 2022 21:00:14 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s4-20020a056870ea8400b000f1bc45ba21sm15063247oap.14.2022.06.30.21.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 21:00:14 -0700 (PDT)
Date:   Thu, 30 Jun 2022 23:00:11 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH/RFC] clk: qcom: rpmh: Block system suspend if XO is
 enabled
Message-ID: <Yr5xS/HCrBuNrn9N@builder.lan>
References: <20220628201340.3981860-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628201340.3981860-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Jun 15:13 CDT 2022, Stephen Boyd wrote:

> Tracking down what RPMh resource is blocking XO shutdown in suspend is
> hard. Largely because we need external debug tools to dump the RPMh
> internal state to figure out what resource is enabled. Instead of doing
> that, let's just block system wide suspend in the kernel if the RPMh XO
> resource is enabled by something in the kernel. This will help us narrow
> down XO shutdown failures to the XO clk, and not something else like an
> interconnect or regulator RPMh resource.
> 
> I'm sending this as an RFC because it breaks suspend for me on Trogdor
> boards. I found out that the XO resource is always enabled on these
> devices because the audio driver leaves an audio clk always on. This
> means that the XO resource must not be used to determine if XO shutdown
> is achievable, or we're leaving power savings on the table.
> 
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> Please don't apply. It will break suspend on Trogdor boards.
> 

This seems like a useful debug feature for people outside of Qualcomm,
so I assume you're saying that we shouldn't merge it until someone has
fixed the audio driver? Or did you post it just as a debug tool?

Regards,
Bjorn

>  drivers/clk/qcom/clk-rpmh.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index aed907982344..ba0e0e4b9cf2 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -70,6 +70,14 @@ struct clk_rpmh_desc {
>  
>  static DEFINE_MUTEX(rpmh_clk_lock);
>  
> +/* XO shutdown will fail if XO is enabled across suspend */
> +static int clk_rpmh_suspend(struct device *dev)
> +{
> +	struct clk_rpmh *xo = dev_get_drvdata(dev);
> +
> +	return xo && xo->state ? -EBUSY : 0;
> +}
> +
>  #define __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,	\
>  			  _res_en_offset, _res_on, _div)		\
>  	static struct clk_rpmh _platform##_##_name_active;		\
> @@ -690,6 +698,10 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "failed to register %s\n", name);
>  			return ret;
>  		}
> +
> +		/* Stash CXO clk for XO shutdown tracking */
> +		if (i == RPMH_CXO_CLK)
> +			platform_set_drvdata(pdev, rpmh_clk);
>  	}
>  
>  	/* typecast to silence compiler warning */
> @@ -722,9 +734,12 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
>  
> +static SIMPLE_DEV_PM_OPS(clk_rpmh_pm_ops, clk_rpmh_suspend, NULL);
> +
>  static struct platform_driver clk_rpmh_driver = {
>  	.probe		= clk_rpmh_probe,
>  	.driver		= {
> +		.pm	= pm_ptr(&clk_rpmh_pm_ops),
>  		.name	= "clk-rpmh",
>  		.of_match_table = clk_rpmh_match_table,
>  	},
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> -- 
> https://chromeos.dev
> 
