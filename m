Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6C46510A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbhLAPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:14:53 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:29514 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239651AbhLAPOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:14:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638371485; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=hzfR5Iy/ZH4JZgmh+ej8VUvwQgSQ07CnUGKU2GOo0f0=; b=DarWwyXS721nLyZZZGYfkCVLJ/s6aWB7ZYEvQ1p5Qjx24aquaZU1Jb72u4aEArYEXWPsymX7
 VL7mWqoHZ58Qg/C2Q/RexvruMvIqJapz8KQAmbcSfkeoT5Agg/p9BtFABlqeEkdoaQ0H1G2A
 vU833ygsCSQw2L5p4mWbuOWfcx0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61a7909d86d0e4d88862b845 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Dec 2021 15:11:25
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9327FC43638; Wed,  1 Dec 2021 15:11:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.242.143.72] (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44557C4338F;
        Wed,  1 Dec 2021 15:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 44557C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v3 3/5] pinctrl: qcom: Move chip specific functions to
 right files
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1638179932-3353-1-git-send-email-srivasam@codeaurora.org>
 <1638179932-3353-4-git-send-email-srivasam@codeaurora.org>
 <bb08af7e-3b90-2d64-3bb1-f82cc6686184@linaro.org>
 <342898d1-59ef-9104-658d-d992c0126361@codeaurora.org>
 <a9e561cc-67f7-450b-fc08-61ece48e9070@linaro.org>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <c05aee0c-9cd7-38e0-61cf-eaf138185b00@codeaurora.org>
Date:   Wed, 1 Dec 2021 20:41:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a9e561cc-67f7-450b-fc08-61ece48e9070@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/2021 8:37 PM, Srinivas Kandagatla wrote:
Thanks for clarification Srini!!
>
> On 01/12/2021 14:33, Srinivasa Rao Mandadapu wrote:
>>>
>>>
>>>> +enum lpass_lpi_functions {
>>>> +    LPI_MUX_dmic1_clk,
>>>> +    LPI_MUX_dmic1_data,
>>>> +    LPI_MUX_dmic2_clk,
>>>> +    LPI_MUX_dmic2_data,
>>>> +    LPI_MUX_dmic3_clk,
>>>> +    LPI_MUX_dmic3_data,
>>>> +    LPI_MUX_i2s1_clk,
>>>> +    LPI_MUX_i2s1_data,
>>>> +    LPI_MUX_i2s1_ws,
>>>> +    LPI_MUX_i2s2_clk,
>>>> +    LPI_MUX_i2s2_data,
>>>> +    LPI_MUX_i2s2_ws,
>>>> +    LPI_MUX_qua_mi2s_data,
>>>> +    LPI_MUX_qua_mi2s_sclk,
>>>> +    LPI_MUX_qua_mi2s_ws,
>>>> +    LPI_MUX_swr_rx_clk,
>>>> +    LPI_MUX_swr_rx_data,
>>>> +    LPI_MUX_swr_tx_clk,
>>>> +    LPI_MUX_swr_tx_data,
>>>> +    LPI_MUX_wsa_swr_clk,
>>>> +    LPI_MUX_wsa_swr_data,
>>>> +    LPI_MUX_gpio,
>>>> +    LPI_MUX__,
>>>> +};
>>>> +
>>>> +static const unsigned int gpio0_pins[] = { 0 };
>>>> +static const unsigned int gpio1_pins[] = { 1 };
>>>> +static const unsigned int gpio2_pins[] = { 2 };
>>>> +static const unsigned int gpio3_pins[] = { 3 };
>>>> +static const unsigned int gpio4_pins[] = { 4 };
>>>> +static const unsigned int gpio5_pins[] = { 5 };
>>>> +static const unsigned int gpio6_pins[] = { 6 };
>>>> +static const unsigned int gpio7_pins[] = { 7 };
>>>> +static const unsigned int gpio8_pins[] = { 8 };
>>>> +static const unsigned int gpio9_pins[] = { 9 };
>>>> +static const unsigned int gpio10_pins[] = { 10 };
>>>> +static const unsigned int gpio11_pins[] = { 11 };
>>>> +static const unsigned int gpio12_pins[] = { 12 };
>>>> +static const unsigned int gpio13_pins[] = { 13 };
>>> >>>
>>> to here are specific to sm8250, so it should not be in header file 
>>> to start with.
>>
>> As these are common to all lpass variants.. I feel it's better to 
>> keep in Header file.
>
> You realize that every include of this file will add these static 
> variables to file, in this case to pinctrl-lpass-lpi.c, 
> pinctrl-sm8250-lpass-lpi.c and pinctrl-sc7280-lpass-lpi.c
> so in first file(pinctrl-lpass-lpi.c) you never use those variables in 
> second file (pinctrl-sm8250-lpass-lpi.c)you only use up to gpio13 and 
> in third file pinctrl-sc7280-lpass-lpi.c you could use them.
>
> so its really bad idea to add static variables in header files.
>
Okay. Understood. will move it SoC specific files.
> --srini
>
>>
>> And if new pins comes in later variants, we can add them 
>> incrementally, and they will not impact existing pin numbers.
>>
>> I think in upcoming variants number of pins will not decrease.
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

