Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E953512C99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbiD1HXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbiD1HXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:23:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FB9A9AC;
        Thu, 28 Apr 2022 00:20:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BB02B8268A;
        Thu, 28 Apr 2022 07:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62FFC385A9;
        Thu, 28 Apr 2022 07:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651130401;
        bh=wLTdfSyMFPXJOgaNVi2715ubE0a3ombPTT51o7FR0rE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=gx9e1ZcDA1zAv7mDdPcaw6pAEsWz5Z8xHOYCJPMqtHbzLG7UEzPbqRefQSe3BoAO6
         PWHS+iBb7MjFz/IuuKdqro5ftDapwfS1n7YD9zdjl9Jh03TDdrfaLTkpnDE4Lf5yQ9
         kocM+NgYI/Sqyig7dAJu9hlTwPY80rh5yGvIJpySKA6tF5PogBbikMj3IGowjhhiyV
         nLn7uMuCk/VIQ4khnD2MA8zzTRajZzi12IulBxAEsfWqiWwWTJOpB55oZKCH1zT9me
         0lgnbrVCDOhgO1qGMweEH3EVyPVMHuGEjLNhtzXDote01f/w8R1MRhWfCad/nhLO9u
         7JVefF0XNpypA==
Message-ID: <05a7c1cc-c8f4-9303-2498-ba8709c72b4b@kernel.org>
Date:   Thu, 28 Apr 2022 10:19:55 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] interconnect: qcom: msm8939: Use icc_sync_state
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220416012634.479617-1-leo.yan@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220416012634.479617-1-leo.yan@linaro.org>
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

On 16.04.22 4:26, Leo Yan wrote:
> It's fashion to use the icc_sync_state callback to notify the framework
> when all consumers are probed, so that the bandwidth request doesn't
> need to stay on maximum value.
> 
> Do the same thing for msm8939 driver.

I assume that you tested this with some out of tree DT? Is it public?
If the consumers are not described as such in DT and/or the support
in the client drivers is missing, paths might get disabled.

Thanks,
Georgi

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/interconnect/qcom/msm8939.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
> index f9c2d7d3100d..ca5f611d33b0 100644
> --- a/drivers/interconnect/qcom/msm8939.c
> +++ b/drivers/interconnect/qcom/msm8939.c
> @@ -1423,6 +1423,7 @@ static struct platform_driver msm8939_noc_driver = {
>   	.driver = {
>   		.name = "qnoc-msm8939",
>   		.of_match_table = msm8939_noc_of_match,
> +		.sync_state = icc_sync_state,
>   	},
>   };
>   module_platform_driver(msm8939_noc_driver);

