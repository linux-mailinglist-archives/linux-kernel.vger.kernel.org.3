Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B555DB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbiF1KIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245666AbiF1KIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:08:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A22F393;
        Tue, 28 Jun 2022 03:08:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C21966015BF;
        Tue, 28 Jun 2022 11:08:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656410921;
        bh=4SmhwJ59cYNwGa9/uAOmjkCzl5Kwd4RkrU6slG6AY6c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gBcsZ9sToRUM8cKdvaAO72/zDI2G3Kl2iaVhdyvOxLtKDzWiVt3MBPV9oeKUhssOi
         62COElRol0rewHQCq5aLavu4HrwWozFJA0T6/XTjCyKEGJI+BZDli/VzJ/hui00gjE
         i/FI7Yx7Y+jHenRhurJ+RtU/QFwGVq7wnYmgmjSHrqM5yN1k4fsTdwktEDjORqgoab
         +Ss7jDoo002EMMU0Nt/ZG8an7mVtncv4k0kIoBCjzpIcOpEqKrpMUPJTi8Ro6t7fV0
         TCU3XOjLd6zZ66MOZUsfG9URyZSk/aebQQvUblK2QjoPpJH5CojSW3mctDn264kGhp
         uiYWKUDHGukNw==
Message-ID: <a0155aeb-b209-07e1-747a-594a755f54fc@collabora.com>
Date:   Tue, 28 Jun 2022 13:08:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
 <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
 <ecc72279-0892-d5ab-689d-87b8fba5147e@gmail.com>
 <20220627072104.ir7kujhezxhzl6a7@vireshk-i7>
 <20220628070943.5tfyad63rh6niq6x@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220628070943.5tfyad63rh6niq6x@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 10:09, Viresh Kumar wrote:
> On 27-06-22, 12:51, Viresh Kumar wrote:
>> On 27-06-22, 10:14, Dmitry Osipenko wrote:
>>> 27.06.2022 09:45, Viresh Kumar пишет:
>>>>> Looks okay. If you'll solve the cpufreq problem where OPP config is set
>>>>> by two drivers for the same cpu device
>>>> This is supported, there is some early freeing of resources on the
>>>> removal path though, the reasoning for which I already gave in another
>>>> email. Though, I am open to sorting that out as well, but nothing
>>>> breaks the code for now AFAICT.
>>>>
>>>
>>> In case of Tegra, we use tegra-cpufreq driver that sets supported_hw and
>>> registers cpufreq-dt. If cpufreq-dt driver defers the probe, then the
>>> supported_hw will be lost on the re-probe. I haven't checked yet, but I
>>> suppose that cpufreq-dt driver defers on Tegra30 because of the CPU
>>> regulator and that's why we get the "OPP table is missing" error.
>>
>> Aha, I get it now. I see, this is a real problem. Will fix it. Give me
>> some time to think. Thanks.
> 
> Okay, I fixed this in opp/linux-next, can you or Jon please give it a
> go on tegra30 to see if the issue is fixed ?
> 
> FWIW, I have fixed this with the IDR API and the OPP core will only
> free the resources in clear-config, that the corresponding set-config
> has configured. I have tested it with the clk API only though.
> 
> Once you confirm, I will resend all the patches and hope no issues are
> left here.
> 
> Thanks for helping out guys. Really appreciate it.
> 

The opp/linux-next works fine, thank you.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

BTW, the idr_alloc() is obsoleted by xa_alloc().

-- 
Best regards,
Dmitry
