Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1D4C0154
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiBVScG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiBVScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:04 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE13C7C2E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:31:37 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so18860074ooi.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0eQyxholJjBEMSQZWDFEm2M/Fwxq/JEZfGHCPfXfVx8=;
        b=thYh2iioevpyO45vzlZllF8/uQycsw5qB0AzyDTe8QlJze9noS9xsmGOXfKGboW3r3
         c0ok3dv5hPdiR2CSjzMMaqeCbB2HsDDTY+SsOC0AoUySifZZxYovcu6hcu48SQd2T8o9
         fj4spOik4Pn6arfwgGudjfXt19jgURL5QutrZAyuMRZqqsPDLOm1PM5odlUalYIsVV0h
         hBv+mwavegmmIHuDZ1BM3YHQzMxSYnLa7F/i6H1SfR0xcxod4XYm0P0DDT5I2oEKlSOV
         ab1zDYCmhjDnHl5RTW56/I/w0sFdrVpRVYy3N57IWtQ515LmcJsmqUekdB8JcybLBa1u
         HraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eQyxholJjBEMSQZWDFEm2M/Fwxq/JEZfGHCPfXfVx8=;
        b=Hct9iZSyQxWaquFx63efSQPpU3jLSbgZH+5Rp/uMLkhCI6y7Y7+JZ/+kH43U7VyfF3
         0cw+At4qYfgiai0w+cw5L/24I/ogzSMJvn9/XUi/Xne3sP8s2HdFIMLb+aK7ZHGPvWj/
         8/tD7gRrCOVc27Ke5CQFzirK79ZkBmwgZRprgxSKNPlOhBoFAAW6/ze3HUL9NhlQX3kF
         tv3fSN56GdYC+RRlwqvuahsJezHBctKVcS4yVuXcYi2qb1dzD8OH1uyR35yrA6zZxW8s
         Yu0WrnpX9oyeBIWqa8Si+icqY2119Nk2daGOBNTSvxMelWa5q+BoF1grXI3BE810gzJY
         2DjQ==
X-Gm-Message-State: AOAM531tuAPcMsD/fejwAdUw5wFhPrtVubfheYHEk+5onmwcv3p91Ti5
        Gq/lCrWfyZ+7RIF9eD1N7bpisQ==
X-Google-Smtp-Source: ABdhPJzi3P1ahgtmbW5BDgyO3RTaYuowS42Lg/e49loUlZZ9lvfcpXXgGyzz8pMAJZgBO55dNtdQrw==
X-Received: by 2002:a05:6870:d915:b0:d3:dc7f:9dd0 with SMTP id gq21-20020a056870d91500b000d3dc7f9dd0mr2256041oab.138.1645554696895;
        Tue, 22 Feb 2022 10:31:36 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id x22sm5704272ooo.20.2022.02.22.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:31:36 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:33:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     robh+dt@kernel.org, ohad@wizery.com, agross@kernel.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, mka@chromium.org,
        krzysztof.kozlowski@canonical.com
Subject: Re: [PATCH 2/3] remoteproc: qcom_q6v5_mss: Add support for
 interconnect bandwidth voting
Message-ID: <YhUsgVWJo8emK3bj@ripper>
References: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
 <1644813252-12897-3-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644813252-12897-3-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Feb 20:34 PST 2022, Sibi Sankar wrote:

> Add support for proxy interconnect bandwidth votes during modem bootup on
> SC7280 SoCs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 95 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index a2c231a17b2b..5a37628311c6 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -12,6 +12,7 @@
>  #include <linux/devcoredump.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
> +#include <linux/interconnect.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> @@ -125,6 +126,18 @@
>  #define QDSP6SS_BOOT_CMD                0x404
>  #define BOOT_FSM_TIMEOUT                10000
>  
> +struct interconnect_info {

This is a rather generic name.

> +	struct icc_path *path;
> +	u32 average_bandwidth;
> +	u32 peak_bandwidth;
> +};
> +
> +struct qcom_mss_icc_res {
> +	const char *name;
> +	u32 average_bandwidth;
> +	u32 peak_bandwidth;
> +};
> +
>  struct reg_info {
>  	struct regulator *reg;
>  	int uV;
> @@ -142,6 +155,7 @@ struct rproc_hexagon_res {
>  	struct qcom_mss_reg_res *proxy_supply;
>  	struct qcom_mss_reg_res *fallback_proxy_supply;
>  	struct qcom_mss_reg_res *active_supply;
> +	struct qcom_mss_icc_res *proxy_path;
>  	char **proxy_clk_names;
>  	char **reset_clk_names;
>  	char **active_clk_names;
> @@ -202,6 +216,9 @@ struct q6v5 {
>  	int proxy_reg_count;
>  	int fallback_proxy_reg_count;
>  
> +	struct interconnect_info interconnect[1];

If there is only one, then I think it's perfectly fine that we postpone
the introduction of an array and the loops etc.

But if you see a reason to support multiple paths, I think we should
utilize the icc bulk API.

> +	int proxy_path_count;
> +
>  	bool dump_mba_loaded;
>  	size_t current_dump_size;
>  	size_t total_dump_size;
> @@ -267,6 +284,29 @@ static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
>  	return i;
>  }
>  
> +static int q6v5_interconnect_init(struct device *dev, struct interconnect_info *interconnect,
> +				  const struct qcom_mss_icc_res *icc_res)
> +{
> +	struct icc_path *path;
> +	int i;
> +
> +	for (i = 0; icc_res[i].name; i++) {
> +		path = devm_of_icc_get(dev, icc_res[i].name);
> +		if (IS_ERR(path)) {
> +			int ret = PTR_ERR(path);
> +
> +			dev_err_probe(dev, ret, "Failed to get %s interconnect\n", icc_res[i].name);
> +			return ret;
> +		}
> +
> +		interconnect[i].path = path;
> +		interconnect[i].average_bandwidth = icc_res[i].average_bandwidth;
> +		interconnect[i].peak_bandwidth = icc_res[i].peak_bandwidth;
> +	}
> +
> +	return i;
> +}
> +
>  static int q6v5_regulator_enable(struct q6v5 *qproc,
>  				 struct reg_info *regs, int count)
>  {
> @@ -364,6 +404,36 @@ static void q6v5_clk_disable(struct device *dev,
>  		clk_disable_unprepare(clks[i]);
>  }
>  
> +static int q6v5_icc_enable(struct device *dev, struct interconnect_info *interconnect, int count)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = icc_set_bw(interconnect[i].path, interconnect[i].average_bandwidth,
> +				 interconnect[i].peak_bandwidth);
> +		if (ret)
> +			dev_err(dev, "Failed enabling %s interconnect\n",
> +				icc_get_name(interconnect[i].path));
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	for (i--; i >= 0; i--)
> +		icc_set_bw(interconnect[i].path, 0, 0);

devm_of_icc_get() will return an "enabled" path, but from that point we
can use icc_enable() and icc_disable() to toggle if our vote should be
taking part in the aggregation.

By using that we should be able to just icc_set_bw() in
q6v5_interconnect_init(), call icc_disable() and from there on we can
wrap our proxy vote in icc_enable() and icc_disable(). That way you
don't need to copy average_bandwidth and peak_bandwidth into the
interconnect_info.

Regards,
Bjorn

> +
> +	return ret;
> +}
> +
> +static void q6v5_icc_disable(struct device *dev, struct interconnect_info *interconnect, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		icc_set_bw(interconnect[i].path, 0, 0);
> +}
> +
>  static int q6v5_pds_enable(struct q6v5 *qproc, struct device **pds,
>  			   size_t pd_count)
>  {
> @@ -1011,10 +1081,14 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>  	if (ret)
>  		return ret;
>  
> +	ret = q6v5_icc_enable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
> +	if (ret)
> +		goto disable_irqs;
> +
>  	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
>  	if (ret < 0) {
>  		dev_err(qproc->dev, "failed to enable proxy power domains\n");
> -		goto disable_irqs;
> +		goto disable_path;
>  	}
>  
>  	ret = q6v5_regulator_enable(qproc, qproc->fallback_proxy_regs,
> @@ -1158,6 +1232,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>  			       qproc->fallback_proxy_reg_count);
>  disable_proxy_pds:
>  	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
> +disable_path:
> +	q6v5_icc_disable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
>  disable_irqs:
>  	qcom_q6v5_unprepare(&qproc->q6v5);
>  
> @@ -1232,6 +1308,7 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
>  				       qproc->fallback_proxy_reg_count);
>  		q6v5_regulator_disable(qproc, qproc->proxy_regs,
>  				       qproc->proxy_reg_count);
> +		q6v5_icc_disable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
>  	}
>  }
>  
> @@ -1611,6 +1688,7 @@ static void qcom_msa_handover(struct qcom_q6v5 *q6v5)
>  	q6v5_regulator_disable(qproc, qproc->fallback_proxy_regs,
>  			       qproc->fallback_proxy_reg_count);
>  	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
> +	q6v5_icc_disable(qproc->dev, qproc->interconnect, qproc->proxy_path_count);
>  }
>  
>  static int q6v5_init_mem(struct q6v5 *qproc, struct platform_device *pdev)
> @@ -1942,6 +2020,13 @@ static int q6v5_probe(struct platform_device *pdev)
>  	}
>  	qproc->active_reg_count = ret;
>  
> +	ret = q6v5_interconnect_init(&pdev->dev, qproc->interconnect, desc->proxy_path);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to get proxy interconnects.\n");
> +		goto free_rproc;
> +	}
> +	qproc->proxy_path_count = ret;
> +
>  	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
>  			      desc->proxy_pd_names);
>  	/* Fallback to regulators for old device trees */
> @@ -2077,6 +2162,14 @@ static const struct rproc_hexagon_res sc7280_mss = {
>  		"mss",
>  		NULL
>  	},
> +	.proxy_path = (struct qcom_mss_icc_res[]) {
> +		{
> +			.name = "imem",
> +			.average_bandwidth = 0,
> +			.peak_bandwidth = 8532000,
> +		},
> +		{}
> +	},
>  	.need_mem_protection = true,
>  	.has_alt_reset = false,
>  	.has_mba_logs = true,
> -- 
> 2.7.4
> 
