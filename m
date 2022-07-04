Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EB25656D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiGDNRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiGDNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:17:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2567BF4A;
        Mon,  4 Jul 2022 06:17:35 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BB8166015BA;
        Mon,  4 Jul 2022 14:17:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656940654;
        bh=jM53Mho55XJNAJOjfJCae7IdDAjzaVZy7HpFUzPGAPo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cSZJanOk+FjZtVbkDhVcXylgobp5ueC046dvJyNpKa31imRMw/nPZU/X1605BkALH
         zEZwloLad0acLGq6g9C5rTWkEwOSdpVDQwOMz6paZV67j0ysaXykc9d2lD8LPIRwuq
         lknwMi9xyVFdLpLbdji+z07pAASwr0gGCm+psnS89ok4uHgzSNdTeOGKOtvgAat6mV
         A06czF/ZjTlL6eoKT9HFsJmIbuvfjAmUGbv1yIwjIW4e9E5sfTW5C+Cyx8yd2PWZH8
         92dQy8HDGGapvNje3wZJ62kgRx6TaoEzAkPgNT3QEE9hw0SnPXXkgnaeqGLFPktiZJ
         IkXWtnWoKqNiA==
Message-ID: <58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com>
Date:   Mon, 4 Jul 2022 16:17:30 +0300
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
References: <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
 <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
 <40e616eb-22f9-19c2-8d77-20cd3c7c518b@nvidia.com>
 <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
 <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
 <8367c38b-8cd3-cde1-5833-874769ef3350@collabora.com>
 <20220630095245.otvo53ezd4avoujw@vireshk-i7>
 <b899ff5f-b424-5f44-7c94-deb013ff6bbc@collabora.com>
 <20220630101540.5dafkegrmcattt2c@vireshk-i7>
 <20220704120915.s3ermueulcofg7nj@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220704120915.s3ermueulcofg7nj@vireshk-i7>
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

On 7/4/22 15:09, Viresh Kumar wrote:
> On 30-06-22, 15:45, Viresh Kumar wrote:
>> On 30-06-22, 12:57, Dmitry Osipenko wrote:
>>> The set_freq_table() gets available freqs using
>>> dev_pm_opp_find_freq_ceil() iteration.
>>>
>>> The first dev_pm_opp_find_freq_ceil(freq=0) succeeds and returns ceil
>>> freq=1.
>>
>> I don't see how this can possibly happen. One possibility is that freq
>> is set to 0 and one the next loop you do freq++, which can make it 1.
>>
>>> The second dev_pm_opp_find_freq_ceil(freq=1) fails with -ERANGE.
>>
>> Even if we send freq = 1, I don't see how we can get ERANGE if the OPP
>> table is properly initialized.
>>
>>> I haven't looked yet at why freq is set to 1.
Actually the freq was 0 and it was 1 on the next loop like you suggested.

>> Thanks, but I would need some help to get it debugged.
> 
> Hi Dmitry,
> 
> I am looking to send another version of this now and soon merge this
> in for 5.20-rc1. Can you please help figure out what's going on here ?

Previously, the _read_opp_key() was always reading the opp-hz. Now it
skips reading the rates in _read_rate() because opp_table->clk_count=0
for the tegra30-devfreq driver the uses devm_pm_opp_of_add_table_noclk().

-- 
Best regards,
Dmitry
