Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6452F92D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 08:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354651AbiEUGHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 02:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiEUGG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:06:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA57166090;
        Fri, 20 May 2022 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653113217; x=1684649217;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7bhaqxDiFBknyai7yTBsu6ONxjwkZMnyE6Y5/QRSQGI=;
  b=LtXr2OXmKrm4BfuqBNW1dEfRN3sbWzlXxWa7tJ+v6+EZLC/jtaKsmfsX
   27Vjt78TLabxZKRK6j1vz2o4eldXnVh6JKlVWZ/D9LjVCPkkAEGx0y0p/
   2mkNmieRdU+scSOse3n2daSPWZ52DmU6dBE4X0dTnKogIuj7eY/v+EHqG
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2022 23:06:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 23:06:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 23:06:56 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 23:06:54 -0700
Subject: Re: [PATCH V2] remoteproc: qcom: pas: Add elf64 support to coredump
To:     Yogesh Lal <quic_ylal@quicinc.com>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1647355307-7612-1-git-send-email-quic_ylal@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <dc6d78d3-4c03-7422-d6c4-b0c7c5a5ae12@quicinc.com>
Date:   Sat, 21 May 2022 11:36:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1647355307-7612-1-git-send-email-quic_ylal@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/22 8:11 PM, Yogesh Lal wrote:
> This change adds elf64 coredump to the ADSP,CDSP and MPSS subsystems as
> they will be 64 bit from sm8450 onward.
> 
> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   Updating commit message and minor code change.
>   drivers/remoteproc/qcom_q6v5_pas.c | 68 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 1ae47cc..445ee3f 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -34,6 +34,7 @@ struct adsp_data {
>   	const char *firmware_name;
>   	int pas_id;
>   	unsigned int minidump_id;
> +	bool uses_elf64;
>   	bool has_aggre2_clk;
>   	bool auto_boot;
>   
> @@ -450,7 +451,11 @@ static int adsp_probe(struct platform_device *pdev)
>   	}
>   
>   	rproc->auto_boot = desc->auto_boot;
> -	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> +
> +	if (desc->uses_elf64)
> +		rproc_coredump_set_elf_info(rproc, ELFCLASS64, EM_NONE);
> +	else
> +		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>   
>   	adsp = (struct qcom_adsp *)rproc->priv;
>   	adsp->dev = &pdev->dev;
> @@ -617,6 +622,24 @@ static const struct adsp_data sm8350_adsp_resource = {
>   	.ssctl_id = 0x14,
>   };
>   
> +static const struct adsp_data sm8450_adsp_resource = {
> +	.crash_reason_smem = 423,
> +	.firmware_name = "adsp.mdt",
> +	.pas_id = 1,
> +	.uses_elf64 = true,
> +	.has_aggre2_clk = false,
> +	.auto_boot = true,
> +	.proxy_pd_names = (char*[]){
> +		"lcx",
> +		"lmx",
> +		NULL
> +	},
> +	.load_state = "adsp",
> +	.ssr_name = "lpass",
> +	.sysmon_name = "adsp",
> +	.ssctl_id = 0x14,
> +};
> +
>   static const struct adsp_data msm8996_adsp_resource = {
>   		.crash_reason_smem = 423,
>   		.firmware_name = "adsp.mdt",
> @@ -721,6 +744,24 @@ static const struct adsp_data sm8350_cdsp_resource = {
>   	.ssctl_id = 0x17,
>   };
>   
> +static const struct adsp_data sm8450_cdsp_resource = {
> +	.crash_reason_smem = 601,
> +	.firmware_name = "cdsp.mdt",
> +	.pas_id = 18,
> +	.uses_elf64 = true,
> +	.has_aggre2_clk = false,
> +	.auto_boot = true,
> +	.proxy_pd_names = (char*[]){
> +		"cx",
> +		"mxc",
> +		NULL
> +	},
> +	.load_state = "cdsp",
> +	.ssr_name = "cdsp",
> +	.sysmon_name = "cdsp",
> +	.ssctl_id = 0x17,
> +};
> +
>   static const struct adsp_data mpss_resource_init = {
>   	.crash_reason_smem = 421,
>   	.firmware_name = "modem.mdt",
> @@ -755,6 +796,25 @@ static const struct adsp_data sc8180x_mpss_resource = {
>   	.ssctl_id = 0x12,
>   };
>   
> +static const struct adsp_data sm8450_mpss_resource = {
> +	.crash_reason_smem = 421,
> +	.firmware_name = "modem.mdt",
> +	.pas_id = 4,
> +	.minidump_id = 3,
> +	.uses_elf64 = true,
> +	.has_aggre2_clk = false,
> +	.auto_boot = false,
> +	.proxy_pd_names = (char*[]){
> +		"cx",
> +		"mss",
> +		NULL
> +	},
> +	.load_state = "modem",
> +	.ssr_name = "mpss",
> +	.sysmon_name = "modem",
> +	.ssctl_id = 0x12,
> +};
> +
>   static const struct adsp_data slpi_resource_init = {
>   		.crash_reason_smem = 424,
>   		.firmware_name = "slpi.mdt",
> @@ -879,10 +939,10 @@ static const struct of_device_id adsp_of_match[] = {
>   	{ .compatible = "qcom,sm8350-cdsp-pas", .data = &sm8350_cdsp_resource},
>   	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm8350_slpi_resource},
>   	{ .compatible = "qcom,sm8350-mpss-pas", .data = &mpss_resource_init},
> -	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
> -	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
> +	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8450_adsp_resource},
> +	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8450_cdsp_resource},
>   	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
> -	{ .compatible = "qcom,sm8450-mpss-pas", .data = &mpss_resource_init},
> +	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, adsp_of_match);
> 
