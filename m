Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FC5332E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbiEXVRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiEXVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:17:42 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA656F90
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:17:41 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 632B73F6BE;
        Tue, 24 May 2022 23:39:54 +0200 (CEST)
Message-ID: <37267214-5edb-add6-c601-6df93043a2b3@somainline.org>
Date:   Tue, 24 May 2022 23:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/7] remoteproc: qcom: pas: Fixup the elf class for SM8450
 remoteprocs
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mathieu.poirier@linaro.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yogesh Lal <quic_ylal@quicinc.com>
References: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
 <1653398017-28426-2-git-send-email-quic_sibis@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <1653398017-28426-2-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/2022 15:13, Sibi Sankar wrote:
> From: Yogesh Lal <quic_ylal@quicinc.com>
>
> The coredumps for the ADSP,CDSP and MPSS subsystems will be 64 bit from
> SM8450 SoCs onward. Update the elf class as elf64 accordingly.

Hi,


the "will be" got me thinking, whether you meant that SM8450 is the 
first SoC that features 64-bit coredumps, or it is going to come in a 
firmware update, but it was 32-bit in an earlier version.

If the latter is true, did the consumer-release BSP for hardware vendors 
include that change? Otherwise it may differ between devices, as some 
vendors are known not to update their firmwares very often if at all.


Konrad

>
> Fixes: 5cef9b48458d ("remoteproc: qcom: pas: Add SM8450 remoteproc support")
> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 68 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 64 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6ae39c5653b1..8ce68d0bb1bc 100644
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
> @@ -751,6 +774,24 @@ static const struct adsp_data sm8350_cdsp_resource = {
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
> @@ -785,6 +826,25 @@ static const struct adsp_data sc8180x_mpss_resource = {
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
> @@ -913,10 +973,10 @@ static const struct of_device_id adsp_of_match[] = {
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
