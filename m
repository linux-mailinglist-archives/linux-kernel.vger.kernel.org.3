Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C955D1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbiF1KEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344679AbiF1KEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:04:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AED2B1B8;
        Tue, 28 Jun 2022 03:04:06 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABBF566018AF;
        Tue, 28 Jun 2022 11:04:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656410645;
        bh=uRRR4e7RSIOXYCVcdSS5IPUDASv9iE0gIMNRnAP/73M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ecZ1sTtwXEpq9nOapEj65/Kxs7CcDEsYhrqGa8qJDOzyTiTWx9fo6OPDJjoMa1kDU
         N2SW0qA53cTEtUO7lafakDBRzYVtcys7L3hljzcuNr4bkHKxrZEasct8pdf4qk+1pH
         avLu4TtCZhx+WN6tcS04s+rrioVQIveAR6jUiNllrwPt33fWL1qhSetofwCiPCb1hw
         suRXkJVP2JceQjjUSUz+fGLwjAskfFabP64MXd2XAptmic/f+sCp65mh/NR1aggLMT
         64xx0/kNeia5eXFWDrodjIrAGiqaqR7BJfwuNeYS9o6duf09fp+fkJzk8lAZ2jDL4w
         jhN19++GIUy6A==
Message-ID: <d2a8c329-4469-f68a-5b4b-789a93725ea4@collabora.com>
Date:   Tue, 28 Jun 2022 13:04:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] OPP: Remove custom OPP helper support
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
 <2e6ee73dbc8a231377547a8e9497561cadb38166.1653991004.git.viresh.kumar@linaro.org>
 <565ff879-11e4-1ae4-08d8-1237a875ef12@gmail.com>
 <20220627060636.rfpok75zydgcwwo6@vireshk-i7>
 <4a8114f7-4ee6-a9ad-f5be-ceaf64be8a0e@gmail.com>
 <20220627064155.jo7iqz5h33l7a4vn@vireshk-i7>
 <d18a1f18-d78c-2db8-9b19-196dc88978c2@gmail.com>
 <20220627071937.uneeudaqzo2aa2me@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220627071937.uneeudaqzo2aa2me@vireshk-i7>
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

On 6/27/22 10:19, Viresh Kumar wrote:
> On 27-06-22, 10:09, Dmitry Osipenko wrote:
>> Yes, I missed that multi-clock OPP patch, thanks.
>>
>> Seems _opp_compare_key() won't work properly for the multi-clocks since
>> Tegra doesn't have bandwidth nor level for the 3d OPPs. Why does it need
>> to check opp_table->clk_count == 1? Shouldn't it be opp_table->clk_count
>>> 0?
> 
> The problem is that when we have multiple clocks, we can't assume any
> of them as primary. Its the combination of the clock frequencies that
> make them unique. Otherwise, what will happen if we have same
> frequency of the first clock in two OPPs, but different frequency of
> the second clock.
> 
> Because of this, we won't also support multiple clocks in all freq
> finder APIs, like dev_pm_opp_find_freq_exact(). We can't do that from
> just one frequency.
> 
> Ideally, the drivers should now be calling dev_pm_opp_set_opp() to set
> the OPP now.
> 
> For your case, I think you can just add levels (like index) in the OPP
> table. So we can uniquely identify each OPP.
> 

What about to bump the "by-level" sorting priority, making it above the
"by-rate" sorting and then always use the first clock for the "by-rate"
sorting? Then the multi-clock will work for Tegra without breaking dtbs
and those for whom this sorting option won't be appropriate will have to
add levels to the DT.

-- 
Best regards,
Dmitry
