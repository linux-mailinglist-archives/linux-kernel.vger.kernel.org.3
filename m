Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E656231D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiF3T2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiF3T2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:28:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0681163
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:28:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s188so355114oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Be8QNcCzBh2OVJvduXkHkZHJYzkPyNZW5yQHcwTAmSA=;
        b=N8ycTjRtAbg+TjfoZ3hOkQeAn7uV7hJlsVLOghZ6Wb4Yinwr16MSGOs3SR4SaiK2+t
         Su/ejV+XTyD5m+P3z3ljjkJ9PfVuxyhz3tdUikcPG5vx9OIviqPgUc80uh6jHC8yHnaW
         MpgAIjrYyN4v8h5DAtTvj5AwK34NoOifFHyXryAnf9Ei6pWo5xe8zQ25NP7LvChQzeyl
         1hqgq1ukI6y1ssU1yCz6kyjXyCOpCzMs/0KIrbXhxsnEpNl76H3PBv1fm7U7D2yOp8Ri
         Jyju2aFUTnzG7iE0C/Du9maCuMPgwWrdpbaqDo7Z/fWp+sT+obzdTe1V9ALUh7oQVooj
         VcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Be8QNcCzBh2OVJvduXkHkZHJYzkPyNZW5yQHcwTAmSA=;
        b=Pyy8irK+xFFeccJ8rhzZ4JTQAKNSHhExiFv66fYnvwg3s0exuqE4pFLv/Bb0qvSkX2
         FHmG12Og3/xNC/wkK5hpxEHwF2coH6kMcWY3YaeepzHtnt2buaoO4Sn5yOlKmDEHmCyM
         TlyvKuviQfUzbSherlmbk8VJHBqKlLlSPiyn4APBTncYmLn/trWee9iJ1UI7Wp9f5q2r
         LtrjFdY2l7RiG4Szpw4xsRjxhuqmm2Y5kv4zioZwVvngGt4GPgN49SKOcUYQqPmOJHH7
         unzceeb5CIgNkbK9CGyWF4tVayHX/LTA+tI1w7F2c5L6y9bkLCgpLNXGpmAVUADDR7hk
         5AQg==
X-Gm-Message-State: AJIora+39bWqG+uyLQfeHxBq+hPPb2ihfnxuo2vVnW0naG3zeraba+d7
        +ZZkyUafLPsjWZgdNxmD+90Odw==
X-Google-Smtp-Source: AGRyM1tKrtGPmsIuyjwRTsLjKZZHCHYFwdBQOxt+vzmBA0QSvpywqAo9YWprSidSqREkAOzK7SGvSQ==
X-Received: by 2002:a05:6808:1490:b0:335:b325:7ae7 with SMTP id e16-20020a056808149000b00335b3257ae7mr5658305oiw.154.1656617286095;
        Thu, 30 Jun 2022 12:28:06 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 38-20020a9d0c29000000b0060bf6213084sm5354954otr.27.2022.06.30.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:28:05 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:28:03 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     dmitry.baryshkov@linaro.org, agross@kernel.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Add decrypt shutdown support for
 modem
Message-ID: <Yr35Q2G8NNvYaI8M@builder.lan>
References: <1653031684-14771-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653031684-14771-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 May 02:28 CDT 2022, Sibi Sankar wrote:

> The initial shutdown request to modem on SM8450 SoCs would start the
> decryption process and will keep returning errors until the modem shutdown
> is complete. Fix this by retrying shutdowns in fixed intervals.
> 
> Err Logs on modem shutdown:
> qcom_q6v5_pas 4080000.remoteproc: failed to shutdown: -22
> remoteproc remoteproc3: can't stop rproc: -22
> 
> Fixes: 5cef9b48458d ("remoteproc: qcom: pas: Add SM8450 remoteproc support")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Looks reasonable, just two inquiries below.

> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 67 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6ae39c5653b1..d04c4b877e12 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/firmware.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -29,6 +30,8 @@
>  #include "qcom_q6v5.h"
>  #include "remoteproc_internal.h"
>  
> +#define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
> +
>  struct adsp_data {
>  	int crash_reason_smem;
>  	const char *firmware_name;
> @@ -36,6 +39,7 @@ struct adsp_data {
>  	unsigned int minidump_id;
>  	bool has_aggre2_clk;
>  	bool auto_boot;
> +	bool decrypt_shutdown;
>  
>  	char **proxy_pd_names;
>  
> @@ -65,6 +69,7 @@ struct qcom_adsp {
>  	unsigned int minidump_id;
>  	int crash_reason_smem;
>  	bool has_aggre2_clk;
> +	bool decrypt_shutdown;
>  	const char *info_name;
>  
>  	struct completion start_done;
> @@ -128,6 +133,20 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
>  	}
>  }
>  
> +static int adsp_decrypt_shutdown(struct qcom_adsp *adsp)
> +{
> +	int retry_num = 50;

Seems unsigned to me.

> +	int ret = -EINVAL;
> +
> +	while (retry_num && ret) {
> +		msleep(ADSP_DECRYPT_SHUTDOWN_DELAY_MS);
> +		ret = qcom_scm_pas_shutdown(adsp->pas_id);
> +		retry_num--;
> +	}

Will qcom_scm_pas_shutdown() ever return any other errors than -EINVAL?

Would it make sense to make this:

	do {
		...;
	} while (ret == -EINVAL && --retry_num);

> +
> +	return ret;
> +}
> +
>  static int adsp_unprepare(struct rproc *rproc)
>  {
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> @@ -249,6 +268,9 @@ static int adsp_stop(struct rproc *rproc)
>  		dev_err(adsp->dev, "timed out on wait\n");
>  
>  	ret = qcom_scm_pas_shutdown(adsp->pas_id);
> +	if (ret && adsp->decrypt_shutdown)
> +		ret = adsp_decrypt_shutdown(adsp);
> +
>  	if (ret)
>  		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
>  
> @@ -459,6 +481,7 @@ static int adsp_probe(struct platform_device *pdev)
>  	adsp->pas_id = desc->pas_id;
>  	adsp->has_aggre2_clk = desc->has_aggre2_clk;
>  	adsp->info_name = desc->sysmon_name;
> +	adsp->decrypt_shutdown = desc->decrypt_shutdown;
>  	platform_set_drvdata(pdev, adsp);
>  
>  	device_wakeup_enable(adsp->dev);
> @@ -533,6 +556,7 @@ static const struct adsp_data adsp_resource_init = {
>  		.pas_id = 1,
>  		.has_aggre2_clk = false,
>  		.auto_boot = true,
> +		.decrypt_shutdown = false,

With all these booleans, I would prefer if we cleaned it up to not list
the disabled options. That would make it quicker to spot which features
are actually enabled for each remoteproc.

Regards,
Bjorn
