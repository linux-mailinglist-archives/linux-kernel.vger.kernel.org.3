Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4260565D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiGDSFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGDSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:05:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F178CF5A5;
        Mon,  4 Jul 2022 11:04:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0509F660199B;
        Mon,  4 Jul 2022 19:04:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656957896;
        bh=B1/s5PkMwtc2g1jiRy99Ol+azvWW3nmVEuKG3yZ3kbg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IwwfP1HxfJBCHXy9SE/unDpGuRpCbr0f4yYg7msWtbnzG21us3GsR+9nt1yD4P4zn
         jiO0NYr7Or5x29QpOl8zB4RSWL1Ch7NaUdMtoPC5AQWZUFfMNBnCoGCyn3jO3ga3NY
         JnCrB8l9TjGIZpks9evf9I6p6u2qTI16vRZOMPluFW8t6qsJCEdgFSFuQxiHnftH01
         PK7TiVigQgqKbzckUnSab/99oh17H+X3mVur+3WvrwZmbRbQQSbvO47tiIBRsNxumk
         HUtoORNh3dBbI7Lg+5DGhEF3wvSwMZLgpOG1ITwfCRO7tBU1tTFhWk+MtegarKEFAc
         I4htdyNTw913A==
Message-ID: <7c661c98-0cd2-1732-d60c-3202643926a5@collabora.com>
Date:   Mon, 4 Jul 2022 21:04:53 +0300
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
References: <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
 <40e616eb-22f9-19c2-8d77-20cd3c7c518b@nvidia.com>
 <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
 <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
 <8367c38b-8cd3-cde1-5833-874769ef3350@collabora.com>
 <20220630095245.otvo53ezd4avoujw@vireshk-i7>
 <b899ff5f-b424-5f44-7c94-deb013ff6bbc@collabora.com>
 <20220630101540.5dafkegrmcattt2c@vireshk-i7>
 <20220704120915.s3ermueulcofg7nj@vireshk-i7>
 <58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com>
 <20220704155225.n4kmgwnvsuksbo2p@vireshk-i7>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220704155225.n4kmgwnvsuksbo2p@vireshk-i7>
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

On 7/4/22 18:52, Viresh Kumar wrote:
> On 04-07-22, 16:17, Dmitry Osipenko wrote:
>> Actually the freq was 0 and it was 1 on the next loop like you suggested.
>>
>> Previously, the _read_opp_key() was always reading the opp-hz. Now it
>> skips reading the rates in _read_rate() because opp_table->clk_count=0
>> for the tegra30-devfreq driver the uses devm_pm_opp_of_add_table_noclk().
> 
> This is exactly what I wrote in an earlier email :)
> 
> Anyway, I have pushed two patches on top of my opp/linux-next branch
> and they should fix it in a good way now I suppose. Can you please
> give that a try.
> 
> This is how the diff looks like:
> 
> PM / devfreq: tegra30: Register config_clks helper
> 
> There is a corner case with Tegra30, where we want to skip clk
> configuration via dev_pm_opp_set_opp(), but still want the OPP core to
> read the "opp-hz" property so we can find the right OPP via freq finding
> helpers.
> 
> The OPP core provides support for the platforms to provide config_clks
> helpers now, lets use them instead of devm_pm_opp_of_add_table_noclk()
> to achieve the same result, as the OPP core won't parse the DT's
> "opp-hz" property if the clock isn't provided.

Works, thanks you!

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
