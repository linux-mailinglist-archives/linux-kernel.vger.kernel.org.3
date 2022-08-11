Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7A58FAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiHKKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiHKKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:55:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056654E874
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:55:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so20957204wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ExWCBl9fGhDCvIPcALkvbkYwWxvYBhGNNpEf1C/2uYM=;
        b=MjCrpIJwRF3mtM8eZrwAkvOwP1K2yUavT0ot02kC7xWyEhWIwwEuN09UkT4uOVGkmP
         a2jH3WW7Fdn8pqLkX3o8cZsFNACShqPDC0WbBxTau00kHhOr0xzqIjpoYW5fIVzcGZFr
         jwN3h062jn8nP8xZlqS9on6EwQ0I2SqUFlVrgyKLxyWnym8o5/xaLzfgb64lI1iVPCII
         Lu8Od7qDn8rw+ZKe4SKFk57RatY4xYCSI630ZHxBMwUQfTmCpZqnE6TVNQG1lqa5SDto
         ywwAlvvrekK7TRoKpVHSXZ9MWC5NWH6kPl858eJYqsWTk2zrLlCcOFHekAd8+OeVQAwi
         RIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ExWCBl9fGhDCvIPcALkvbkYwWxvYBhGNNpEf1C/2uYM=;
        b=b6d6oGo4OZ2+ryt+XbxE6UDDg8ZjEyeQHEv3C5o7CyPYS9h2d2M+1OCOEKMUBQAMIw
         ClUrvh2FEShpFN5EC4uJTlIIu6RaEMbQ9mp4YuIcTwX1nBXtoKkfiVry7c6wpE6NUiG5
         3LjPLS5ziClV62KBtERbdfkCXQCTjU5PqyPzyxnF8XpqLl+KX580Bf58gsNDbRUahFbx
         5g0jN0V5Q49jgTMOEucOF1OBADUR7QcQARfwJr722SsPevl/W65AqHaDoxeo6FW8Hlzc
         IiBryYU9g/caCV1eumev2Pk+GdrZ6mYAJV+K3kgYlPgs3Hpx8Z3eQ+07Z/ZIyRK3rISr
         hqww==
X-Gm-Message-State: ACgBeo1iq1Zs7/ytJNVdDFvo8QB5MFlgIQK1twTok1kUWCM+xGe/RkOL
        kwpRrQgX1eMmeGw/uW/yQSMoRQ==
X-Google-Smtp-Source: AA6agR47HAxdt2d6bM0ytPKlu0xhF0jZ7swMy/rEsF1Fkq2mVzRpN2f4mlNPs/ALYeLNgRFmBWU31w==
X-Received: by 2002:a5d:6da8:0:b0:221:7db8:de0a with SMTP id u8-20020a5d6da8000000b002217db8de0amr15358016wrs.405.1660215323573;
        Thu, 11 Aug 2022 03:55:23 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c2ca700b003a4f08495b7sm5973089wmc.34.2022.08.11.03.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 03:55:23 -0700 (PDT)
Message-ID: <03ba7601-12dd-befc-eab1-14c3e9931519@linaro.org>
Date:   Thu, 11 Aug 2022 11:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal: qcom: tsens-v0_1: Fix MSM8939 fourth sensor
 hw_id
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        mchen@squareup.com
References: <20220811105014.7194-1-vincent.knecht@mailoo.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20220811105014.7194-1-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 11:50, Vincent Knecht wrote:
> Reading temperature from this sensor fails with 'Invalid argument'.
> 
> Looking at old vendor dts [1], its hw_id should be 3 instead of 4.
> Change this hw_id accordingly.
> 
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/master/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L511
> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
> Fixes reading GPU temperature on msm8939 idol3 with current WIP dtsi
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index f136cb350238..327f37202c69 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -604,7 +604,7 @@ static const struct tsens_ops ops_8939 = {
>   struct tsens_plat_data data_8939 = {
>   	.num_sensors	= 10,
>   	.ops		= &ops_8939,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 },
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
>   
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,

ACK we have this change in our shipping 4.19 kernel

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
