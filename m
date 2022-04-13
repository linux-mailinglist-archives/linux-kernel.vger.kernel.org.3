Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB544FFF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiDMTnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiDMTnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:43:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3CF75E7C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:40:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b21so3484152ljf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=KSvbPWcgC+EYpvQJgWFy6k/bppn4PjhiXHZYOLmzGZQ=;
        b=DK7W1eF1DVRunhPz52c10Omi5ui/jCBWO3zXXAdXz7MqXfF5mpI+5WnAjjMheHwPqy
         4gVXjPksWYf5suZpky6ntZ6YExRxIjvudoMs6GMYc5X2Ot+zQk6IcUx4WG7bBjEHQjuD
         qLdqLNoOH0vL/eug7Q8pdk6DiyYEWzNAfwRqNYZJ+CXC8oYggOSPoJ7XJGztKDxxqmVj
         rOrhvNB9dFz62OkS7B9brZQ04qm9OmR7bzs393IIGxCKi49IbRz3uVV384VKpPsaFKRH
         AMjrRmE6EAVyhQ/yN1wPGfn15z+pxkYErUC5JmJeAcgHASQw09I3wTVOHy/vTqiva9bC
         260A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KSvbPWcgC+EYpvQJgWFy6k/bppn4PjhiXHZYOLmzGZQ=;
        b=ZGCN6rnhx2Oi3gRR0EWohAJPbPO3RqTM9TVnrvVsOakD7SrvBOfifRLkkUpANUWMZk
         yU7JkGxnywi1NX1OvcrjRWBac0wo+bAeGSGKrkCxrVLxl/z7llBy1RX4jA1w3Zvnp3vm
         OAsbUdku7qmSRm95m/0taPLR4wkp2Hci3EWSBzsG2U2g/pNRyJ05dcwwK29zJDQyzNkm
         q24Ku5YBBKMeIw3day+0O02/ypICRcDTOW7E66JHEDBwen49Qc+uLaHcrXY0XFhi5eRq
         ty9ahHEEz4RuD3osPxvqcH1e3/A7rpUCiX9kWmU/sEXn6ZycoTuROI2iZlaZzolZWV8C
         X8Gw==
X-Gm-Message-State: AOAM531xOnzzPtBRAx2cOHgEtbvJPjcvkiFtavKlYnBmthuSopsUAO9p
        1mYExRcvysabG/HFa3BVg7b6sw==
X-Google-Smtp-Source: ABdhPJw+fve7UmoJNDguXxV9w1RErcG8dtgyNN+2QOCsDgx6W/GK+8oz5oPqQhagCy7aKKYdw9TPrA==
X-Received: by 2002:a2e:bd13:0:b0:246:1ff8:6da1 with SMTP id n19-20020a2ebd13000000b002461ff86da1mr27104815ljq.219.1649878840486;
        Wed, 13 Apr 2022 12:40:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s13-20020ac2464d000000b0046cff822d0fsm406876lfo.225.2022.04.13.12.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 12:40:39 -0700 (PDT)
Message-ID: <e50de775-731b-d8e5-ad0f-794903fbed92@linaro.org>
Date:   Wed, 13 Apr 2022 22:40:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 09/18] clk: qcom: krait-cc: drop pr_info and register
 qsb only if needed
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-10-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220321231548.14276-10-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 02:15, Ansuel Smith wrote:
> Replace pr_info() with dev_info() to provide better diagnostics.
> Register qsb fixed clk only if it's not declared in DTS.

This can be split into two patches

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/clk/qcom/krait-cc.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
> index 645ad9e8dd73..e9508e3104ea 100644
> --- a/drivers/clk/qcom/krait-cc.c
> +++ b/drivers/clk/qcom/krait-cc.c
> @@ -308,7 +308,9 @@ static int krait_cc_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   
>   	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
> -	clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
> +	if (IS_ERR(clk_get(dev, "qsb")))
> +		clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
> +
>   	if (IS_ERR(clk))
>   		return PTR_ERR(clk);
>   
> @@ -363,25 +365,25 @@ static int krait_cc_probe(struct platform_device *pdev)
>   	cur_rate = clk_get_rate(l2_pri_mux_clk);
>   	aux_rate = 384000000;
>   	if (cur_rate == 1) {
> -		pr_info("L2 @ QSB rate. Forcing new rate.\n");
> +		dev_info(dev, "L2 @ QSB rate. Forcing new rate.\n");
>   		cur_rate = aux_rate;
>   	}
>   	clk_set_rate(l2_pri_mux_clk, aux_rate);
>   	clk_set_rate(l2_pri_mux_clk, 2);
>   	clk_set_rate(l2_pri_mux_clk, cur_rate);
> -	pr_info("L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
> +	dev_info(dev, "L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
>   	for_each_possible_cpu(cpu) {
>   		clk = clks[cpu];
>   		cur_rate = clk_get_rate(clk);
>   		if (cur_rate == 1) {
> -			pr_info("CPU%d @ QSB rate. Forcing new rate.\n", cpu);
> +			dev_info(dev, "CPU%d @ QSB rate. Forcing new rate.\n", cpu);
>   			cur_rate = aux_rate;
>   		}
>   
>   		clk_set_rate(clk, aux_rate);
>   		clk_set_rate(clk, 2);
>   		clk_set_rate(clk, cur_rate);
> -		pr_info("CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
> +		dev_info(dev, "CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
>   	}
>   
>   	of_clk_add_provider(dev->of_node, krait_of_get, clks);


-- 
With best wishes
Dmitry
