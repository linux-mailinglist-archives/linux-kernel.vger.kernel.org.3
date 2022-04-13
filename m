Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D74FF2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiDMJJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiDMJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:09:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA764DF51
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:07:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t25so1545095edt.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z84tQ9PE482BMfOh0tGEWBbuxsfWf7PM713AXwUAt8U=;
        b=FI4d7X6SsxtqQKnRO595Rrvz+y7TCy5uSYJ1E4ffWmuz2lWCdWKO43S4bMqsVkOxGp
         ghHiStu6lESL6/iYdJXXxzZYobNuJsIrC1KdLa8PVUStA5DZKFsPrQT8BYrXyhomp21y
         VSsGIkMvmt3feVHT8TrQzjGBp/5d4bX/0M29dI3FiNAKQmPUT7PD41ZHwWSaslZ/AxrY
         B0ueTpkUhXjcKuyJ7AnqLgZ0c21j82tT1uVZEeG7Djp64Jfp9EVMsq7Kryz8I4jbiSH4
         Uo7QMxUVhOzx9CgUOY4N5Tgb0whGI5vAc03PdQWoKlsLvIFHgQgv+V6nQeauHa4eT7Nr
         tQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z84tQ9PE482BMfOh0tGEWBbuxsfWf7PM713AXwUAt8U=;
        b=wsh9jVMmpA6qnfB++PZNLsJGkpi0ReEOGSg7fE7T656K5OLGzfarwkz+wt8l6yFHpW
         gBUc3e+C7Ws81w3+tnEthAg1qO9ffXY2/3D0XlK/Z7UzcYwcRCq/EFrdxpI1k7uz0eBX
         UI7o8rGE/4i015CH3RDuUZaHBG/NschlkXtXqWH2bxILl18VXtqr7y3PTMbaelGha7WX
         dS7OJDcrP6r6qSN/xm6RUa7N5+iRfhLtggz4kAncCtqF/7/QvcoUHpFDfBe8bwM+4mC3
         4KTiMEhf8TRb6pLLP+C63DtAv92thc34blZ5WVwzsk8VTUkJBKcVqUUfSNeIq0sv19Nq
         P3Fg==
X-Gm-Message-State: AOAM530Sdhl1AMIfLbqIBHMYfzXGRcmpAkcLGDpEBhuABJfaubPfE+3s
        sdWLA4AaUXZ16RKwzrqa1X1pRA==
X-Google-Smtp-Source: ABdhPJybTYoB6hFzkTnGzb9M3CRBUVTSHcKTnFZfrgqbnaYoSiDSY2iH30hdSK5/Q287fVX6yfQFbQ==
X-Received: by 2002:a50:d4d2:0:b0:410:9fa2:60d6 with SMTP id e18-20020a50d4d2000000b004109fa260d6mr43074728edj.35.1649840838413;
        Wed, 13 Apr 2022 02:07:18 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm908162edu.96.2022.04.13.02.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:07:17 -0700 (PDT)
Message-ID: <02fc797a-190f-3558-5ee1-c9c3320f3d57@linaro.org>
Date:   Wed, 13 Apr 2022 11:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
 <YlWztZknl4OBmekp@ripper>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YlWztZknl4OBmekp@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 19:15, Bjorn Andersson wrote:
>>  
>> +	opp_table->clks = kmalloc_array(1, sizeof(*opp_table->clks),
>> +					GFP_KERNEL);
> 
> This seems to be 81 chars long, perhaps worth not line breaking?

I doubt that it will increase the readability:

	opp_table->clks = kmalloc_array(1,
					sizeof(*opp_table->clks),
					GFP_KERNEL);

80-character is not anymore that strict hard limit and in such case
using 1-2 characters longer improves the code.

> 
>> +	if (!opp_table->clks)
>> +		return ERR_PTR(-ENOMEM);
>> +
>>  	/* Find clk for the device */
>> -	opp_table->clk = clk_get(dev, NULL);
>> +	opp_table->clks[0] = clk_get(dev, NULL);
>>  
>> -	ret = PTR_ERR_OR_ZERO(opp_table->clk);
>> -	if (!ret)
>> +	ret = PTR_ERR_OR_ZERO(opp_table->clks[0]);
>> +	if (!ret) {
>> +		opp_table->clk_count = 1;
>>  		return opp_table;
>> +	}
> [..]
>> +struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
>> +					  const char * const names[],
>> +					  unsigned int count)
>>  {
>>  	struct opp_table *opp_table;
>> -	int ret;
>> +	struct clk *clk;
>> +	int ret, i;
>>  
>>  	opp_table = _add_opp_table(dev, false);
>>  	if (IS_ERR(opp_table))
>> @@ -2159,70 +2259,92 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
>>  	}
>>  
>>  	/* clk shouldn't be initialized at this point */
>> -	if (WARN_ON(opp_table->clk)) {
>> +	if (WARN_ON(opp_table->clks)) {
>>  		ret = -EBUSY;
>>  		goto err;
>>  	}
>>  
>> -	/* Find clk for the device */
>> -	opp_table->clk = clk_get(dev, name);
>> -	if (IS_ERR(opp_table->clk)) {
>> -		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
>> -				    "%s: Couldn't find clock\n", __func__);
>> +	opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
>> +					GFP_KERNEL);
>> +	if (!opp_table->clks) {
>> +		ret = -ENOMEM;
>>  		goto err;
>>  	}
>>  
>> +	for (i = 0; i < count; i++) {
>> +		clk = clk_get(dev, names[i]);
>> +		if (IS_ERR(clk)) {
>> +			ret =  dev_err_probe(dev, PTR_ERR(clk),
>> +					     "%s: Couldn't find clock %s\n",
>> +					     __func__, names[i]);
>> +			goto free_clks;
>> +		}
>> +
>> +		opp_table->clks[i] = clk;
>> +	}
> 
> Wouldn't it be convenient to make clks a struct clk_bulk_data array
> and use clk_bulk_get()/clk_bulk_put() instead?

I was thinking about this but clk_bulk_get() requires struct
clk_bulk_data, so the code in "get" is not actually smaller if function
receives array of clock names.

OTOH, usage of clk_bulk_get() would reduce code in: _put_clocks(). Rest
of the code would be more-or-less the same, including all corner cases
when clocks are missing.

> 
>> +
>> +	opp_table->clk_count = count;
>> +
>>  	return opp_table;
>>  
>> +free_clks:
>> +	while (i != 0)
>> +		clk_put(opp_table->clks[--i]);
>> +
>> +	kfree(opp_table->clks);
>> +	opp_table->clks = NULL;
>> +	opp_table->clk_count = -1;
>>  err:
>>  	dev_pm_opp_put_opp_table(opp_table);
>>  
>>  	return ERR_PTR(ret);
>>  }
>> -EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_clknames);
> [..]
>> +static int _read_clocks(struct dev_pm_opp *opp, struct opp_table *opp_table,
>> +			struct device_node *np)
>> +{
>> +	int count, ret;
>> +	u64 *freq;
>> +
>> +	count = of_property_count_u64_elems(np, "opp-hz");
>> +	if (count < 0) {
>> +		pr_err("%s: Invalid %s property (%d)\n",
>> +			__func__, of_node_full_name(np), count);
> 
> Wouldn't %pOF be convenient to use here, seems like it becomes short
> enough that you don't have to wrap this line then.

Yes, I forgot about %pOF.

> 
>> +		return count;
>> +	}
>> +
>> +	if (count != opp_table->clk_count) {
>> +		pr_err("%s: number of rates %d does not match number of clocks %d in %s\n",
>> +		       __func__, count, opp_table->clk_count,
>> +		       of_node_full_name(np));
>> +		return -EINVAL;
>> +	}
>> +
>> +	freq = kmalloc_array(count, sizeof(*freq), GFP_KERNEL);
>> +	if (!freq)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u64_array(np, "opp-hz", freq, count);
>> +	if (ret) {
>> +		pr_err("%s: error parsing %s: %d\n", __func__,
>> +		       of_node_full_name(np), ret);
>> +		ret = -EINVAL;
>> +		goto free_freq;
>> +	}
> 
> Regards,
> Bjorn


Best regards,
Krzysztof
