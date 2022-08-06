Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC37458B841
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiHFUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiHFUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:39:14 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61713DF20
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:39:12 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KQZgoofew9RnzKQZho5L2z; Sat, 06 Aug 2022 22:39:10 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 22:39:10 +0200
X-ME-IP: 90.11.190.129
Message-ID: <2729cd6f-17ff-70d8-52c5-3dceb93e6a82@wanadoo.fr>
Date:   Sat, 6 Aug 2022 22:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: fr
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-8-git-send-email-quic_srivasam@quicinc.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org,
        swboyd@chromium.org, tiwai@suse.com
In-Reply-To: <1659536480-5176-8-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the error handling below looks odd.

Le 03/08/2022 à 16:21, Srinivasa Rao Mandadapu a écrit :
> Add memory sandbox support for ADSP based platforms secure booting.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/remoteproc/qcom_q6v5_adsp.c | 101 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 3dbd035..f81da47 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c

>   static int adsp_start(struct rproc *rproc)
>   {
>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> @@ -341,7 +429,13 @@ static int adsp_start(struct rproc *rproc)
>   	ret = qcom_q6v5_prepare(&adsp->q6v5);
>   	if (ret)
>   		return ret;
> -
> +	if (!adsp->is_wpss) {
> +		ret = adsp_map_smmu(adsp, rproc);
> +		if (ret) {
> +			dev_err(adsp->dev, "ADSP smmu mapping failed\n");
> +			goto adsp_smmu_unmap;
goto disable_irqs;?

> +		}
> +	}
>   	ret = clk_prepare_enable(adsp->xo);
>   	if (ret)
>   		goto disable_irqs;

goto adsp_smmu_unmap;?

> @@ -402,6 +496,9 @@ static int adsp_start(struct rproc *rproc)
>   	clk_disable_unprepare(adsp->xo);
>   disable_irqs:
>   	qcom_q6v5_unprepare(&adsp->q6v5);
> +adsp_smmu_unmap:
> +	iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
> +	iommu_domain_free(adsp->iommu_dom);

Should this new hunk be above disable_irqs?
And I think that it should be guardd with a "if (!adsp->is_wpss)".

CJ

>   
>   	return ret;
>   }

