Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC78B56B388
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiGHH05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiGHH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:26:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF97D1CC;
        Fri,  8 Jul 2022 00:26:46 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD66166019C5;
        Fri,  8 Jul 2022 08:26:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657265205;
        bh=3UW1BZZx+0gVRM3Zkg56i+K3sZq4zS9Tzxasaob0LAE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ASA7nMIDiWDv/ejeK0zgmd16Zf+Q1IOtCFu4xdTH4MLLIgpZSSo/wjADlaiDbrrE2
         uHeh9xR3yGKahayPkylS9JJ15+X4wDVPR1x/TBbIHVIStRyfrmrjsLD9hQPwWqDdoX
         aQVgCM2QQ8hVVLNHF0fWZf6G+rH0TCwfkjuX/Ze3a9Db/u5VmaObbLhBpA/EqycblU
         4QzeMQqxt0wgwrgfslarMXYV9kkh0if9R2x74hsG84itLTGP9NdFFA32aPddiNmT7q
         YKlFgHMYNbqfXYJvr+ZAxiqKJeWELRwWR2wWKAFcXycCU0OsED+HwaGf+FiRz2yDQ2
         fVKndaxgkPdgA==
Message-ID: <8c52e1d2-6c6d-9a09-e426-e5292f68a3f0@collabora.com>
Date:   Fri, 8 Jul 2022 10:26:40 +0300
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
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220708071926.zehurtbcf35s5tv6@vireshk-i7>
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

On 7/8/22 10:19, Viresh Kumar wrote:
> On 07-07-22, 22:43, Dmitry Osipenko wrote:
>> This patch breaks Tegra again, please take a look:
> 
> Damn, not again :(
> 
>>    OPP: Remove dev{m}_pm_opp_of_add_table_noclk()
> 
> Why did you mention this patch ? This just removed an unused API,
> Tegra should have broke because of something else, isn't it ?

This patch is the cause.

>>  8<--- cut here ---
>>  Unable to handle kernel paging request at virtual address ffffffff
>>  [ffffffff] *pgd=9effd861, *pte=00000000, *ppte=00000000
>>  Internal error: Oops: 37 [#1] PREEMPT SMP ARM
>>  Modules linked in:
>>  CPU: 3 PID: 8 Comm: kworker/u8:0 Not tainted
>> 5.19.0-rc1-00040-g30b62d123f4f #82
>>  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>  Workqueue: events_unbound deferred_probe_work_func
>>  PC is at _opp_compare_key+0x40/0xc4
>>  LR is at 0xfffffffb
> 
> How is LR set to such an address ?
> 
>>  pc : [<c0b91b54>]    lr : [<fffffffb>]    psr: 20000113
>>  sp : df831b08  ip : c33cd4d0  fp : df831b24
>>  r10: c2586078  r9 : c258606c  r8 : 00000000
>>  r7 : 00000000  r6 : 00000001  r5 : c33cd480  r4 : c2586000
>>  r3 : 00000000  r2 : c33cd480  r1 : c258606c  r0 : c2586000
>>  Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>  Control: 10c5387d  Table: 8000404a  DAC: 00000051
>> ...
>>  Backtrace:
>>   _opp_compare_key from _set_opp+0x80/0x408
> 
> Whatever happened, happened from _opp_compare_key() and I tried to
> look at it many times, couldn't figure out what's wrong there.
> 
> For the device in question, pmc I think, we don't have any "opp-hz"
> property in the DT, but still the OPP core will fetch its clock and
> set clk_count to 1. But this was working earlier too, we were
> comparing the rate anyways. I think one of _opp_compare_rate() or
> _opp_compare_bw() is broken here, but I just couldn't figure out. The
> rate one should run one loop and bw one should just return. I don't
> see why a crash should come out eventually.
> 
> Can you help debug this a bit ? Also see what are the values of
> opp_table->path_count and opp_table->clk_count, should be 0 and 1
> AFAICT.

I see that previously dev_pm_opp_set_config() had "_add_opp_table(dev,
false)", now it's "_add_opp_table(dev, true)".

Will take a closer look later on.

> Sorry about this Dmitry, I think we are all settled and again went
> into crap.

No problems :)

-- 
Best regards,
Dmitry
