Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D0B468222
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 04:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384145AbhLDDUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 22:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384138AbhLDDUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 22:20:15 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5AC061354
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 19:16:50 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so5890666otl.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 19:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=YmLyXgmtxlMO+L5DYAu6LZZ3Lz1Tih5zRqjYLEDPQpE=;
        b=mY26ZkDvw5nZ7tN1moPi2UpMRaI7wJaNa0C2/TzJ0u7h4Hl0RPvqZsSO1PCEd8fyfC
         jXChgp2m1scwNWIqh3qC+k3IinN/v6jdGcq5FVbdejVWfdUdRgbacX8L7bOG6r3mCBCn
         v2pV1618UPGa0w8BJ4CAY3RIe27Ypo1x1mL5x2StyrEWh8dA+/wLM2qWsauzJRBPceeF
         do8Lz8KM9xT8XlI6lxG/30+lKdMVZ2CVey0hWBVGvOYKNeI/GYuS9W8nWW1/Is6aMBdf
         MQ0Zl1ImQ32Y/4ndoxQRMyjWbP5fZarxp0o60GxmWgCo9IrxcWi2Avis3uKtH51rJFyT
         FW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=YmLyXgmtxlMO+L5DYAu6LZZ3Lz1Tih5zRqjYLEDPQpE=;
        b=7j1YWhuLj/yCME4aOXmRZ1b5OkWt6hOojKcmbjIk8PRKyHkFM3sNGi9feysC7zX5wF
         c/YejG/inKwKXYzDpzA3R1rg/Tr295MRM9fpXfOER0B+kCANDZlFnGwGc04BMsTwh9mO
         927qPxFhVbzASFm05tqNQwuNjGvfcQhS1PVRtSu/Bm91U4Qj5jYkOw5Pq/3SNK1IYVfd
         Ty3/Xd6S42HNKii6xNtvC8QFfnfyurYnLgYqH+m9P1tmkUKIreTlX6vVP3S1T3OUWbjY
         KUOTdAwhjle5Ho3A22wVzNGRibwuWmHvv0r/wk38Fkl1J6mgW0qbuKDrnf34wRRCQLLU
         /c5Q==
X-Gm-Message-State: AOAM533ZhE7sp8lugVdhBB1F4K3ssijnvgJ6aE91ym8rdDLP65AiLktj
        T+2j3rbb+R+j+NVB8IsH8H+1Ug==
X-Google-Smtp-Source: ABdhPJwjYwFZypL6KKboRlPe127KlLQjOWE+b/dda4B6oFxcNi0mgQEwYRXwPkU/7XQIPgPzVRQqRw==
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr19525756otn.128.1638587809540;
        Fri, 03 Dec 2021 19:16:49 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id d3sm977300otc.0.2021.12.03.19.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 19:16:49 -0800 (PST)
Message-ID: <1c366d77-49aa-07f3-4801-9374ad7e6016@kali.org>
Date:   Fri, 3 Dec 2021 21:16:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
Content-Language: en-US
From:   Steev Klimaszewski <steev@kali.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
 <9f9ad753-a97c-b11c-4b8b-5ddad0508e0e@kali.org>
In-Reply-To: <9f9ad753-a97c-b11c-4b8b-5ddad0508e0e@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/21 6:39 PM, Steev Klimaszewski wrote:
>
> On 12/2/21 9:56 PM, Bjorn Andersson wrote:
>> As GDSCs are turned on and off some associated clocks are momentarily
>> enabled for house keeping purposes. Failure to enable these clocks seems
>> to have been silently ignored in the past, but starting in SM8350 this
>> failure will prevent the GDSC to turn on.
>>
>> At least on SM8350 this operation will enable the RCG per the
>> configuration in CFG_REG. This means that the current model where the
>> current configuration is written back to CF_REG immediately after
>> parking the RCG doesn't work.
>>
>> Instead, keep track of the currently requested rate of the clock and
>> upon enabling the clock reapply the configuration per the saved rate.
>>
>> Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source 
>> as needed")
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>   drivers/clk/qcom/clk-rcg.h  |  2 ++
>>   drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
>>   2 files changed, 19 insertions(+), 15 deletions(-)
>>
>> <snip patch>
>
> With this applied, I'm getting
> <snip>

Actually turns out, I had a testing patch in from Dmitry that I'd never 
taken back out when it was decided it wasn't good enough. Apologies for 
the useless message.  This does not actually cause the issue, just the 
combination of them does.

Tested on the Lenovo Yoga C630

Tested-By: Steev Klimaszewski <steev@kali.org>

