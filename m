Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254C511F24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiD0PiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiD0PiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:38:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2C1816A7;
        Wed, 27 Apr 2022 08:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4169AB8285F;
        Wed, 27 Apr 2022 15:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9D1C385A7;
        Wed, 27 Apr 2022 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651073698;
        bh=AY0M6MiJp4yABlTT36iztg/uwDJL1rZ8nO+etu2NN5k=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dNn2o7iv3UOzfnVpz12chMS2Vu3hNyqvCho+mP+Sppo9FCUA9rUgm8UIZ5xTH/3dm
         ObdB5J89Yp7d4BXhFpDoluPd7FNemcKpGE9LwRRyC00mNwBphFkUszDGLRZRFkoRWE
         uwbQf82txbG0c0qL3fn5BT/yO8ZMlOhD93gM0W0iCCNumygEX9VjL3dt09sNxtn8TJ
         aOuhT+mJrvWHJG41QeoYoZamVNb77oD3fqABjur0Z+wRT5K3yXw9xlrB4Ro1/nZ0S2
         16zRf69wemBadJ59SOSMthDxq1UWGFwVcPviQiCGfNXvZYIHfbFbkcqGkDiqRHBvbz
         A8Sb4HXMO80VQ==
Message-ID: <4769c796-6edd-c23a-ee2a-ce54495548f7@kernel.org>
Date:   Wed, 27 Apr 2022 18:34:53 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] interconnect: qcom: use icc_sync_state
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427145616.523557-1-krzysztof.kozlowski@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220427145616.523557-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.22 17:56, Krzysztof Kozlowski wrote:
> Use icc_sync_state for interconnect providers, so that the bandwidth
> request doesn't need to stay on maximum value.

Did you test this? In general, we should not enable this on boards that
do not have full interconnect scaling support in consumer drivers yet.
Some of the interconnects could be enabled by default by the bootloader
and usually later during boot the consumer drivers request the bandwidth
that they need. But if the requests are missing, the interconnects
without bandwidth users will be disabled when we reach sync state. So
this may (or not) cause issues...

Thanks,
Georgi

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/interconnect/qcom/msm8916.c | 1 +
>   drivers/interconnect/qcom/qcm2290.c | 1 +
>   drivers/interconnect/qcom/qcs404.c  | 1 +
>   drivers/interconnect/qcom/sdm660.c  | 1 +
>   drivers/interconnect/qcom/sm8150.c  | 1 +
>   drivers/interconnect/qcom/sm8250.c  | 1 +
>   drivers/interconnect/qcom/sm8350.c  | 1 +
>   drivers/interconnect/qcom/sm8450.c  | 1 +
>   8 files changed, 8 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
> index 2f397a7c3322..811370fcd211 100644
> --- a/drivers/interconnect/qcom/msm8916.c
> +++ b/drivers/interconnect/qcom/msm8916.c
> @@ -1347,6 +1347,7 @@ static struct platform_driver msm8916_noc_driver = {
>   	.driver = {
>   		.name = "qnoc-msm8916",
>   		.of_match_table = msm8916_noc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(msm8916_noc_driver);
> diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
> index 74404e0b2080..6cf75da91428 100644
> --- a/drivers/interconnect/qcom/qcm2290.c
> +++ b/drivers/interconnect/qcom/qcm2290.c
> @@ -1355,6 +1355,7 @@ static struct platform_driver qcm2290_noc_driver = {
>   	.driver = {
>   		.name = "qnoc-qcm2290",
>   		.of_match_table = qcm2290_noc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(qcm2290_noc_driver);
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> index 416c8bff8efa..d82f9add4933 100644
> --- a/drivers/interconnect/qcom/qcs404.c
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -1086,6 +1086,7 @@ static struct platform_driver qcs404_noc_driver = {
>   	.driver = {
>   		.name = "qnoc-qcs404",
>   		.of_match_table = qcs404_noc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(qcs404_noc_driver);
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index 274a7139fe1a..706b49a4bb70 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -1716,6 +1716,7 @@ static struct platform_driver sdm660_noc_driver = {
>   	.driver = {
>   		.name = "qnoc-sdm660",
>   		.of_match_table = sdm660_noc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(sdm660_noc_driver);
> diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
> index 745e3c36a61a..2a85f53802b5 100644
> --- a/drivers/interconnect/qcom/sm8150.c
> +++ b/drivers/interconnect/qcom/sm8150.c
> @@ -535,6 +535,7 @@ static struct platform_driver qnoc_driver = {
>   	.driver = {
>   		.name = "qnoc-sm8150",
>   		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(qnoc_driver);
> diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
> index aa707582ea01..8dfb5dea562a 100644
> --- a/drivers/interconnect/qcom/sm8250.c
> +++ b/drivers/interconnect/qcom/sm8250.c
> @@ -551,6 +551,7 @@ static struct platform_driver qnoc_driver = {
>   	.driver = {
>   		.name = "qnoc-sm8250",
>   		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(qnoc_driver);
> diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
> index c79f93a1ac73..3e26a2175b28 100644
> --- a/drivers/interconnect/qcom/sm8350.c
> +++ b/drivers/interconnect/qcom/sm8350.c
> @@ -531,6 +531,7 @@ static struct platform_driver qnoc_driver = {
>   	.driver = {
>   		.name = "qnoc-sm8350",
>   		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(qnoc_driver);
> diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
> index 8d99ee6421df..d573018a6324 100644
> --- a/drivers/interconnect/qcom/sm8450.c
> +++ b/drivers/interconnect/qcom/sm8450.c
> @@ -1968,6 +1968,7 @@ static struct platform_driver qnoc_driver = {
>   	.driver = {
>   		.name = "qnoc-sm8450",
>   		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   

