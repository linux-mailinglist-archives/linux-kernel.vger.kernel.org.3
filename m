Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748E1521676
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiEJNNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbiEJNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:13:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55B753B4B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:09:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z2so31263311ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GY+8CojCMdOqBSOFBIYghZE3p4uLJiwb7g8ImRgX/dU=;
        b=qLsqWbFt7LCQx0MaLfgYA2s8hsAyOOpVW5rh9DzwWbCQLNbIGdXf+F5JAY+grnNJgF
         sBb+zqwdE6bmq3okeUZuIzZcXNrdkJXOXN+krDKNhSROug7uv2bkRgdVwR8cANiD9kk9
         BLfNHSChZRjoUi6DlTO96a5lvuqCRTd36KWMWg3SESso0kbRMIFxUgPqiB3VTABTkQwW
         137KeyzjeGxXgJh1BBCMMJxYMNpzVQT5QI8bPIWcGLxEv6TjCxvjpmjZcxB6sZU+2Rsu
         HVwaN8RSnozbhzp3UBfq4nG6jZLC8bbH4yImCfFr6ChuFmcx5MUDpvqyVKF1VYgZGdLl
         7uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GY+8CojCMdOqBSOFBIYghZE3p4uLJiwb7g8ImRgX/dU=;
        b=eC2Zja3p9sq+0QY81exT9JPb0N7wDdSv4RkNjT8tp2MXP0ls0Bp9DbdZviUgpXYLOW
         saOWwV7p0ewzLPWUXgBjI9PW3TbsKBcpgPkClKX/iy4RhOXKl6NjNS1EoqM2EprIEB31
         5tqO+878ZfCfjAqE+53ojDXjQLzTdykfKHxRj5Wsce3ty9eiFPd3tRQRsbHBKvgU2sCf
         qc3b2WXH8seIlfgim2NYMEYy+cG+Yw8wyUl9m32DGu46LZbSFpxH8iYT2HvABrE/2e0D
         bYPxLTwWPVN1+TbJ5XDndEVLwki5lv1eTVvjIcqRs6myyNhSiuhQQDswLXxggCILrW2q
         OotA==
X-Gm-Message-State: AOAM5320akcZfo0S1RVs1qULOy6pLkYoiCYLGZgETZeNvGVlgGzqxkeR
        CsAq3np5RwIPW53CxzOOduwenw==
X-Google-Smtp-Source: ABdhPJyeV9V1iJhHLhwfC6K1BZ5EadKgzzBkTD1pVb1eEmEusgki6rRs5oqhoRfmG7wEJ9obJwywHg==
X-Received: by 2002:a17:907:7d92:b0:6fd:bd33:f00f with SMTP id oz18-20020a1709077d9200b006fdbd33f00fmr1956321ejc.467.1652188165022;
        Tue, 10 May 2022 06:09:25 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jy15-20020a170907762f00b006f3ef214e54sm6055980ejc.186.2022.05.10.06.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:09:23 -0700 (PDT)
Message-ID: <1e533194-7047-8342-b426-f607fddbfaa3@linaro.org>
Date:   Tue, 10 May 2022 15:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
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
 <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
 <dea39b1f-0091-2690-7f07-108d07ef9f3c@linaro.org>
 <20220510044053.ykn6ygnbeokhzrsa@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510044053.ykn6ygnbeokhzrsa@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 06:40, Viresh Kumar wrote:
> On 09-05-22, 12:38, Krzysztof Kozlowski wrote:
>> On 25/04/2022 09:27, Viresh Kumar wrote:
>>> This is tricky as the OPP core can't really assume the order in which the clocks
>>> needs to be programmed. We had the same problem with multiple regulators and the
>>> same is left for drivers to do via the custom-api.
>>>
>>> Either we can take the same route here, and let platforms add their own OPP
>>> drivers which can handle this, Or hide this all behind a basic device clock's
>>> driver, which you get with clk_get(dev, NULL).
>>
>> For my use case, the order of scaling will be the same as in previous
>> implementation, because UFS drivers just got bunch of clocks with
>> freq-table-hz property and were scaling in DT order.
>>
>> If drivers need something better, they can always provide custom-opp
>> thus replacing my method. My implementation here does not restrict them.
>>
>> For the drivers where the order does not matter, why forcing each driver
>> to provide its own implementation of clock scaling? Isn't shared generic
>> PM OPP code a way to remove code duplication?
> 
> Code duplication is a good argument and I am in favor of avoiding it,
> but nevertheless this shouldn't be something which platforms can pick
> by mistake, just because they didn't go through core code. In other
> words, this shouldn't be the default behavior of the core.
> 
> If we want, core can provide a helper to get rid of the duplication
> though, but the user explicitly needs to use it.

OK, that sounds like a solution.

> 
>>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>>
>>>> +static int _generic_set_opp_clks_only(struct device *dev,
>>>> +				      struct opp_table *opp_table,
>>>> +				      struct dev_pm_opp *opp)
>>>> +{
>>>> +	int i, ret;
>>>> +
>>>> +	if (!opp_table->clks)
>>>> +		return 0;
>>>> +
>>>> +	for (i = 0; i < opp_table->clk_count; i++) {
>>>> +		if (opp->rates[i]) {
>>>
>>> This should mean that we can disable that clock and it isn't required.
>>
>> No, it does not mean that. The DT might provide several clocks which
>> only some are important for frequency scaling. All others just need to
>> be enabled.
>>
>> Maybe you prefer to skip getting such clocks in PM OPP?
> 
> They shouldn't reach the OPP core then. What will the OPP core do if a
> clock has a value for one OPP and not the other ?

That would be the same mistake as providing one voltage as 0 or with
something outside of a spec (but still within regulators min/max).
Mistakes in DTS create undesirable behavior and this part is no different.

However I understand your point - since the driver provides the list of
clocks to OPP, it should not provide ones which are irrelevant.

> 
>>>> @@ -969,8 +1008,8 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>>>
>>> I think this routine breaks as soon as we add support for multiple clocks.
>>> clks[0]'s frequency can be same for multiple OPPs and this won't get you the
>>> right OPP then.
>>
>> I don't think so and this was raised also by Stephen - only the first
>> clock is considered the one used for all PM OPP frequency operations,
>> like get ceil/floor.
> 
> IMHO, this is broken by design. I can easily see that someone wants to
> have few variants of all other frequencies for the same frequency of
> the so called "main" clock, i.e. multiple OPPs with same "main" freq
> value.  I don't think we can mark the clocks "main" or otherwise as
> easily for every platform.
> 
> Stephen, any inputs on this ?

In such case, matching opps by frequency would be a quite different API.
The drivers can use now:
https://github.com/krzk/linux/commit/ebc31798494fcc66389ae409dce6d9489c16156a#diff-b6370444c32afa2e55d9b6150f355ba6f4d20c5ed5da5399ea8295d323de8267R1200

If you assume that this frequency can be used for multiple OPPs, then
the API should be different. Something like:
int dev_pm_opp_set_rate(struct device *dev, unsigned long *target_freqs,
                        size_t num_freqs);

Finding right opp for given frequencies would be also quite much more
complicated task. Not a simple ceil/floor search by one frequency.

I don't need that use-case and my implementation does not prevent anyone
from implementing it in the future. IOW, why developing now complex
solution which no one currently needs? If anyone needs such scaling by
multiple-frequencies, the PM OPP can be reworked/extended/improved again.

Additionally let me point also that my implementation targets not a
specific one driver, but actually entire subsystem of drivers - all UFS
drivers.

> 
>> The assumption (which might need better documentation) is that first
>> clock frequency is the main one:
>> 1. It is still in opp->rate field, so it is used everywhere when OPPs
>> are compared/checked for rates.
>> 1. Usually is used also in opp-table nodes names.
>>
>> The logical explanation is that devices has some main operating
>> frequency, e.g. the core clock, and this determines the performance. In
>> the same time such device might not be able to scale this one core clock
>> independently from others, therefore this set of patches.
> 
> I understand what you are saying, but I can feel that it will break or
> will force bad bug-fixes into the core at a later point of time.
> 
> I think it would be better to take it slowly and see how it goes. Lets
> first add support for the OPP core to parse and store this data and
> then we can add support to use it, or at least do all this in separate
> patches so they are easier to review/apply.

Sure, I'll split the patch to smaller chunks.

Best regards,
Krzysztof
