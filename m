Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B056C4D8EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbiCNVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 17:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbiCNVlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 17:41:37 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934FD1DA54
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:40:26 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so22169240ooh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CH4PnxS5OBdq/D6Vp76lpnMDoAzcsxnrc14ncEtoegU=;
        b=xebXMdKQRsxXOA7mx5JtV5zjLWaAZEH3jQiH8bLmEct6J+cbDMWpl6BEFRd4oEwx7C
         aNHPC/DfZCpmFfU5qnKNnH9lLrZF0XsLRJadbQpFW5uHwvK1DyvQ7Ng9Wbst8nLe1qsR
         Ft6GfQv4BPrC35S2TRP1ZBPhmcGSWrRLMGDXZIAdoA59r7bRWYD/W+k+4zIg/fhSzMzq
         /2zrpUqXcbxsW4RumT0k8RSdI/Ja2wI5dBCudbU4qTij+ePaky/5R+yCovnVJr6c33D+
         cUQgZOdC7qOyeFKfbd74gFwiJOa59Kf3ihQjT//XQ8aIRBETqhBdm4lOg+iDeP32JHMs
         3GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CH4PnxS5OBdq/D6Vp76lpnMDoAzcsxnrc14ncEtoegU=;
        b=qVk+Spu2D3odljnYBMBfmh5znJz6vTUvWOYctTwSY0WtixrGhNs75oDQXu/A3nQgh3
         RrWCquZyjfE3A7Uxnbw5PvOoxCWzvRvk2C9lwBu4XHOplqQmlkzWRYrkHq6OXFNroYr0
         4/EOer5v6CAybM/7+zcDpIcAaENWnKfUM1JkIu80zmxXT0MgN6ElXOhM7RYwxZUgAZSo
         jRbSMHSnlAKdT6cleuofBeFCaU8WryQGzF1Dc4VNU42oL6L8jlQs/B9OAcMmtrVRRK6Z
         v5HxPwtQ267oF4wyh9G+EV5Ton751Epr8CjD2szZ0GDl3i8w+Hywr3sAGN3d+pRruVCE
         SpCQ==
X-Gm-Message-State: AOAM530rL4+mt5ZnCgIvWvww57N5M9K1epAtJpVPPADicBOGGzH/Z/kL
        S/S/7cMQW8okdKiPzR4GqvnxHg==
X-Google-Smtp-Source: ABdhPJx9ShNGhKeS4XKWob97GViwdgXKmKriwSN7lAV2IHVCc/GNGiM8uDLrubhREgewA0JXe92OxQ==
X-Received: by 2002:a05:6870:d685:b0:da:b3f:2b84 with SMTP id z5-20020a056870d68500b000da0b3f2b84mr402796oap.291.1647294025542;
        Mon, 14 Mar 2022 14:40:25 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y8-20020a544d88000000b002d525da014bsm8244544oix.42.2022.03.14.14.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:40:24 -0700 (PDT)
Date:   Mon, 14 Mar 2022 16:40:23 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yogesh Lal <quic_ylal@quicinc.com>
Cc:     quic_sibis@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Add elf64 support to coredump
Message-ID: <Yi+2Rylfx6mOHHOK@builder.lan>
References: <1647252013-7794-1-git-send-email-quic_ylal@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647252013-7794-1-git-send-email-quic_ylal@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Mar 05:00 CDT 2022, Yogesh Lal wrote:

> Add support to use elf64 coredumps to remote processors.

The commit message does not describe _this_ patch and it fails to
explain _why_ sm8450 should have 64-bit coredumps.

Please correct this.

Thanks,
Bjorn

> 
> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 67 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 1ae47cc..58c335e 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -34,6 +34,7 @@ struct adsp_data {
>  	const char *firmware_name;
>  	int pas_id;
>  	unsigned int minidump_id;
> +	bool uses_elf64;
>  	bool has_aggre2_clk;
>  	bool auto_boot;
>  
> @@ -450,7 +451,11 @@ static int adsp_probe(struct platform_device *pdev)
>  	}
>  
>  	rproc->auto_boot = desc->auto_boot;
> -	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> +
> +	if (desc->uses_elf64)
> +		rproc_coredump_set_elf_info(rproc, ELFCLASS64, EM_NONE);
> +	else
> +		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
>  	adsp = (struct qcom_adsp *)rproc->priv;
>  	adsp->dev = &pdev->dev;
> @@ -617,6 +622,24 @@ static const struct adsp_data sm8350_adsp_resource = {
>  	.ssctl_id = 0x14,
>  };
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
>  static const struct adsp_data msm8996_adsp_resource = {
>  		.crash_reason_smem = 423,
>  		.firmware_name = "adsp.mdt",
> @@ -721,6 +744,24 @@ static const struct adsp_data sm8350_cdsp_resource = {
>  	.ssctl_id = 0x17,
>  };
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
>  static const struct adsp_data mpss_resource_init = {
>  	.crash_reason_smem = 421,
>  	.firmware_name = "modem.mdt",
> @@ -755,6 +796,25 @@ static const struct adsp_data sc8180x_mpss_resource = {
>  	.ssctl_id = 0x12,
>  };
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
>  static const struct adsp_data slpi_resource_init = {
>  		.crash_reason_smem = 424,
>  		.firmware_name = "slpi.mdt",
> @@ -879,10 +939,11 @@ static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,sm8350-cdsp-pas", .data = &sm8350_cdsp_resource},
>  	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm8350_slpi_resource},
>  	{ .compatible = "qcom,sm8350-mpss-pas", .data = &mpss_resource_init},
> -	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
> -	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
> +	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8450_adsp_resource},
> +	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8450_cdsp_resource},
>  	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
>  	{ .compatible = "qcom,sm8450-mpss-pas", .data = &mpss_resource_init},
> +	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adsp_of_match);
> -- 
> 2.7.4
> 
