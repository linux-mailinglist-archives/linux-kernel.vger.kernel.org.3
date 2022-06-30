Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F085616F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiF3J50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiF3J5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:57:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B4543ACD;
        Thu, 30 Jun 2022 02:57:18 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E21336601948;
        Thu, 30 Jun 2022 10:57:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656583037;
        bh=q8/O3O9cAhPR9Cw2/yL31YTcTztXCqBC3JyU3IRJV6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CjzdPE+le26ptVF7yKxrthrH553wOh4ZGUcJWjlPN741GxPd/+Cp/8DP2Pu++2X3v
         0UTM43e18ilosLAMvbE+hHdx2ZACU9wFpVjrpHvBNw//+jn2Ej/XWx0SzE+uGEDNKF
         HeElZTbqMEZ4Az8g2BNH/vqBjqg5YRh6dOB4myXdfOQzR6rF8jCOrLlg+//CDlI86n
         u0OyRLor47xOcUnTeaB0eV9lVz4Gnwc7Rhe8PzgqD38uzrvKXMcQ598GI87ooyzoEA
         rGOT+q0PLgfPIM+faQHKk5JQwxGK1kjr7LRPdBoDS4IqTU5goUAtLDBZtPtgycc8l4
         12uyZp4FYJLrw==
Message-ID: <b899ff5f-b424-5f44-7c94-deb013ff6bbc@collabora.com>
Date:   Thu, 30 Jun 2022 12:57:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
 <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
 <40e616eb-22f9-19c2-8d77-20cd3c7c518b@nvidia.com>
 <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
 <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
 <8367c38b-8cd3-cde1-5833-874769ef3350@collabora.com>
 <20220630095245.otvo53ezd4avoujw@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220630095245.otvo53ezd4avoujw@vireshk-i7>
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

On 6/30/22 12:52, Viresh Kumar wrote:
> On 30-06-22, 12:13, Dmitry Osipenko wrote:
>> On 6/30/22 03:50, Viresh Kumar wrote:
>>> On 29-06-22, 21:33, Dmitry Osipenko wrote:
>>>> Today I noticed that tegra30-devfreq driver now fails to probe because
>>>> dev_pm_opp_find_freq_ceil() fails with -ERANGE. This patch is guilty for
>>>> that. Could you please take a look?
>  
>> We added memory interconnect support to Tegra and since that time only
>> the memory controller can drive the clock rate. All other drivers,
>> including the devfreq, now issue memory bandwidth requests using ICC.
>>
>> In case of the devfreq driver, it's the OPP core that makes the bw
>> request using ICC.
>>
>> But it's the set_freq_table() that fails [2], I see
>> dev_pm_opp_get_opp_count() returns 17, which is correct, and then
>> dev_pm_opp_find_freq_ceil(freq=0) returns freq=1, which shall be
>> freq=12750000.
> 
> I am confused, you said earlier that it is failing with -ERANGE, but
> now it is a bad freq value ?
> 
> Which one of these it is ?
> 
> The problem I see is here though, because of which I was asking you
> the question earlier:
> 
> - tegra30-devfreq driver calls devm_pm_opp_of_add_table_noclk(), i.e.
>   clk_count == 0.
> 
> - _read_rate() (in drivers/opp/of.c) skips reading any opp-hz
>   properties if clk_count is 0.
> 
> - And so you can get -ERANGE or some other error.
> 
> Can you please see where we are failing. Also I don't see how freq can
> get set to 1 currently.
> 

The set_freq_table() gets available freqs using
dev_pm_opp_find_freq_ceil() iteration.

The first dev_pm_opp_find_freq_ceil(freq=0) succeeds and returns ceil
freq=1.

The second dev_pm_opp_find_freq_ceil(freq=1) fails with -ERANGE.

I haven't looked yet at why freq is set to 1.

-- 
Best regards,
Dmitry
