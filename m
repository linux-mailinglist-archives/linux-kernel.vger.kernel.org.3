Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5BB54F740
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382365AbiFQMJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiFQMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:09:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5754517598;
        Fri, 17 Jun 2022 05:09:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A982660179A;
        Fri, 17 Jun 2022 13:09:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655467775;
        bh=i83+JJRH3W4qGEUUYF7SQgp3g5O/kI5O54Jr6yQ71BE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XIolfYkv5wCh7FeJg7jAXVgOWno+AIsYz2EAAkTSiosvk+Zk6BZE97kOvD8Y3jxIc
         gJ6mIOFP6jopreRU78cYaOG1ksMT5d9sfuvpTdJqozYEKZazAHBPeBzJMQxMm2QFdb
         /eW6AT6ci5okv6oddXQcLPOAVV2b4YXjYui2rvZBtPeIhcMvEo1UGuAftRnuK1aaSh
         fgunC+t7IEtZyroUMbpsy315Y5f3fBwgdWFy6nyo8HK3y14/UkRcN+PVvJfHJxayLh
         lHGQKhTmNhRbLd4LJMBF/f0+6fw1V0HtcxbbzvzH8CvWDdhwTwFNXRo5cVNAnuEtJG
         InSQmD26Arhiw==
Message-ID: <223d33be-4c73-8605-e2bb-33e4a14682d2@collabora.com>
Date:   Fri, 17 Jun 2022 15:09:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 08/31] cpufreq: tegra20: Migrate to
 dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
 <793e49ea-aeb0-a47a-9fe8-742a6397bb35@collabora.com>
 <5c0e697e-abca-bcf0-cf68-d9c240d82527@collabora.com>
 <20220530075256.lpw6bhupejy2dnqi@vireshk-i7>
 <20220607084351.i4s5veww6irmaf3t@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220607084351.i4s5veww6irmaf3t@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 11:43, Viresh Kumar wrote:
> On 30-05-22, 13:22, Viresh Kumar wrote:
>> On 29-05-22, 19:59, Dmitry Osipenko wrote:
>>>> Please keep the PTR_ERR_OR_ZERO.
>>
>> Ahh, sorry about that. Fixed.
>>
>>>> tegra20-cpufreq tegra20-cpufreq: failed to set OPP config: -1042688000
>>>
>>> With that fixed, now there is another error:
>>>
>>> [    1.761945] cpu cpu0: _of_add_opp_table_v2: no supported OPPs
>>> [    1.761960] cpu cpu0: OPP table can't be empty
>>
>> So we failed to find any OPPs which work with the hardware version of
>> updated with dev_pm_opp_set_config(). I tried to follow the path and
>> see if there is something wrong here. Failed to find that :(
>>
>>> I see this on Tegra30, but not on Tegra20. Apparently OPP table
>>> refcounting is broken on Tegra30 by this patchset. To make it clear,
>>> there are no error without these OPP patches applied. I may take a
>>> closer look if will be needed, just ping me.
>>
>> Yes, it would be very helpful as I don't have the necessary hardware.
> 
> Hey, any updates on this ? I am looking to resend the series soon, would be nice
> to fix this before that.
> 

I'll take a look over this weekend. Sorry for the delay.

-- 
Best regards,
Dmitry
