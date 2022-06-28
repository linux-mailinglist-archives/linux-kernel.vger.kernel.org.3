Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8055D8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbiF1KRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344788AbiF1KQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7672FE76;
        Tue, 28 Jun 2022 03:16:54 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0743E66015C6;
        Tue, 28 Jun 2022 11:16:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656411412;
        bh=1tqlWAxPmJlNCdOk5uOFfVSOEf7qfVbTP0IA7EU/8zw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TkpMzbKCu0LchDuRwPJ+t8ON7otup+mIijJ2VrV9eByciW5GXXr0zIaDw4YlzyPj/
         deUCZv+VKquqT9EFxdT1p0qPnDAv4Lei3peIFI9JGyDAC7lvDY+9t1aWs7emcYMIDy
         ck2pJgoFq/Sx3ZmbPjJBCkuwVivsZO4rqdLmb2NhvZPzsd48inkYAKTutX+wQQos+7
         CUM21fxNr6L11CEOcWx0kf70LOzrIYDy5oyxeYq4c30mtMt7nFLOIYWA+TURyRh8L9
         MbqD6b4ODAkfashBMrB4DxnH5i4Pb+QAqvWqKLJFHHPSOx1AVxhS27LUyVGVmA1cGs
         7746SqpG3zIog==
Message-ID: <49ffbe2d-73ac-ee2e-e3d1-c31a88e40dd4@collabora.com>
Date:   Tue, 28 Jun 2022 13:16:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
 <a0155aeb-b209-07e1-747a-594a755f54fc@collabora.com>
 <20220628101139.jdpsplkqbbh6qpse@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220628101139.jdpsplkqbbh6qpse@vireshk-i7>
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

On 6/28/22 13:11, Viresh Kumar wrote:
> On 28-06-22, 13:08, Dmitry Osipenko wrote:
>> The opp/linux-next works fine, thank you.
>>
>> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Thanks. I should add this to all the core + tegra -patches in that
> branch, right ?

Yes, please.

>> BTW, the idr_alloc() is obsoleted by xa_alloc().
> 
> The earlier interface isn't deprecated, right ? I really don't want to
> go change it again :)
> 

It has been in a process of deprecation for a couple years now. All IDR
instances are slowly converting to XA. You won't need to take mutex with
xa_alloc().

-- 
Best regards,
Dmitry
