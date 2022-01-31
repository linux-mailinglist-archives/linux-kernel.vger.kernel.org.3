Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2EB4A4B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380181AbiAaQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380155AbiAaQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:15:58 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA4C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:15:58 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t9so20066881lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PAJsiarXhqLynLw8D9oX/LriyOgm/RU72Cl9jucAmp4=;
        b=v3ZkRrFDlZs2mIz3bFyv/Y0d/v3qLb1rif8VBO0qXmQwMjhx+gev5Dlw3gDkpaeJRe
         8dnrQCXDqCdM5WRwH3QrJo2hPz5WLW5lSixO+zoWOzhcpFMyduzdBl/k2TIOgnnUy6qp
         L2d4t6zyfkAvzI4LaRR7utS9BtQSwYTsMZTF5CYcYlx7eeKC+b4A2ddw13I1TQvF4RQT
         A4uZg7pqYZbqvGGHHqtp/PB2iyQE4z/QLGC3BNdcgM3evN74/4mRmT/5wdoizV8EIZQR
         166XKN+zyZ2M4+Z3JYoNuMtasqtm+1czdarWcqRJc/vjDH2LuqM7juCVsHYaMCDPWofi
         ierg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PAJsiarXhqLynLw8D9oX/LriyOgm/RU72Cl9jucAmp4=;
        b=kpfRs8kX/q3FCtUNqZwfYziyBxk3DaSBhca8lZ3wQUCC+OxNRwxMX82XlGq99H4h4f
         D2VorS7x5glXMfxKzgy5OffEHBaJt4QjpmJ1NjfiTvSPHVU4mBvfM5nUv3f+ahe0k3db
         VIcc0Khew+4TI7PQdm6kDvhOAS2msks8ZGP3761uEGglrOqfFYn51TkUfETPNyBVnpsy
         4wrtzk8fv3NW6BVPrYKnOMHzKdEpNh2ut29VUQ1pRtjPo2JEyGh1tK64z2fjxoSS7apH
         stogNiJs427ek30b7hgYAvsdGlfPGkvmyKyWG3+Z0OQpBI0Kfkc2Vcl/LEScDc3VsZ7M
         DG2w==
X-Gm-Message-State: AOAM533AcYCLZKC32w+ZGv6D5CbeOSoAzgpP/xK9mZ3Nf9unIO1hGSRK
        n9Q3tjrF+jl9t6npOPVaAsdIRVIpj75wXQ==
X-Google-Smtp-Source: ABdhPJwewMmRrBwkubc+o6bfPzhnxUBAGcHo8KgbJc+QrmnKzTqWfh0QHTVz5P55+AvuKi8MkqGljQ==
X-Received: by 2002:a2e:b7d6:: with SMTP id p22mr13954610ljo.182.1643645756531;
        Mon, 31 Jan 2022 08:15:56 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a7sm3158253lff.44.2022.01.31.08.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 08:15:55 -0800 (PST)
Message-ID: <266f6609-94c9-704c-548c-14351a05679e@linaro.org>
Date:   Mon, 31 Jan 2022 19:15:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 7/8] clk: qcom: dispcc-sm8250: stop using mmcx
 regulator
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
 <20210829154757.784699-8-dmitry.baryshkov@linaro.org>
 <YV8WsQb9H7+CaLjP@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YV8WsQb9H7+CaLjP@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 18:48, Bjorn Andersson wrote:
> On Sun 29 Aug 08:47 PDT 2021, Dmitry Baryshkov wrote:
> 
>> Now as the common qcom clock controller code has been taught about power
>> domains, stop mentioning mmcx supply as a way to power up the clock
>> controller's gdsc.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Once we merge these, I expect that the boards will start crashing if
> the kernel is booted using an existing DTB?
> 
> Is it okay to just merge the first 6 patches in the series now and
> postpone these two until we've had the dts change sitting for a while?

Bjorn, the changes 1-6 went into 5.15. I suppose it's time to merge the 
last two patches?

> 
> Regards,
> Bjorn
> 
>> ---
>>   drivers/clk/qcom/dispcc-sm8250.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
>> index 108dd1249b6a..cf0bb12eb6e1 100644
>> --- a/drivers/clk/qcom/dispcc-sm8250.c
>> +++ b/drivers/clk/qcom/dispcc-sm8250.c
>> @@ -1129,7 +1129,6 @@ static struct gdsc mdss_gdsc = {
>>   	},
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   	.flags = HW_CTRL,
>> -	.supply = "mmcx",
>>   };
>>   
>>   static struct clk_regmap *disp_cc_sm8250_clocks[] = {
>> -- 
>> 2.33.0
>>


-- 
With best wishes
Dmitry
