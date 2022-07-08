Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06356C0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbiGHQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiGHQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:15:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9073A76E93;
        Fri,  8 Jul 2022 09:15:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F188A66019F2;
        Fri,  8 Jul 2022 17:15:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657296913;
        bh=cGD7Qcg1KyeXM3eFu7vGytfwcnRw+Ni4gAxVLw/K5uw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JdJ2cmzgPNWEff1eeEeMOJK8q5x/fvBRgdyO8Pn0/GpKdljlmuCUtWGuRuJAJIyiS
         70VrdfsMqYts3bUsvhlybiotdexYCkhIQDYn4NA2uVF0G3ifWgiRIEYzLMjuwr6pat
         VhqNojOxiUcS9QRMUKkjaN0i9qmFd1eRwJD2Da+8+7+J/6MW0IiSkWoPd3E5w9j2Im
         IbUCi0kf/A5kHgQz1AzptkYvOTkfdmjs354a2/jYRPRV9WYVJJKaKjGeSCIlTKsMn6
         fNMKdXOhTlDL+ff7g7hyld+JUV1r2EqxkPanCMcz7kVpyOsPPNwccG6EUQFEUYnEZp
         dhiLDlM7pOkcg==
Message-ID: <a56a5acd-9b17-9d58-565c-2ac11efb17e9@collabora.com>
Date:   Fri, 8 Jul 2022 19:15:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <d557bbd0-2afb-12dc-1287-1aeb44ef55f5@collabora.com>
 <20220708071926.zehurtbcf35s5tv6@vireshk-i7>
 <8c52e1d2-6c6d-9a09-e426-e5292f68a3f0@collabora.com>
 <20220708081233.pncnill6dqe4ghko@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220708081233.pncnill6dqe4ghko@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22 11:12, Viresh Kumar wrote:
> On 08-07-22, 10:26, Dmitry Osipenko wrote:
>> On 7/8/22 10:19, Viresh Kumar wrote:
>>> On 07-07-22, 22:43, Dmitry Osipenko wrote:
>>>> This patch breaks Tegra again, please take a look:
>>>
>>> Damn, not again :(
>>>
>>>>    OPP: Remove dev{m}_pm_opp_of_add_table_noclk()
>>>
>>> Why did you mention this patch ? This just removed an unused API,
>>> Tegra should have broke because of something else, isn't it ?
>>
>> This patch is the cause.
> 
> I was tracking the crash too closely it seems. :(
> 
>> I see that previously dev_pm_opp_set_config() had "_add_opp_table(dev,
>> false)", now it's "_add_opp_table(dev, true)".
> 
> That's definitely a mistake, I still don't understand though how it
> can lead to the crash we got.

I'll investigate it.

> I have fixed this in my tree now, can you check again please.
> 

Yours tree works, thank you.

-- 
Best regards,
Dmitry
