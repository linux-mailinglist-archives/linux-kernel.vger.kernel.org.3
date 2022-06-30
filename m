Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF465615BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiF3JNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiF3JNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:13:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691ABD6;
        Thu, 30 Jun 2022 02:13:15 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 93AC9660194B;
        Thu, 30 Jun 2022 10:13:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656580393;
        bh=XKL8+xkZSiICKivdUfCYqxq8X2Aebnt8te/3pqzmNSs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aQYgufgmhl54KmqTSf7Igvnj4S7OwTsTkYrevuyUc4JFoUDbN1e6a7l46MXBwiJmI
         9ukIbdJavpxrldGtnN6KH5f28ccdo6hSkj29mcMPnvk9u23qxPILiSdvkA9xSGKbaD
         e6mV00CflqARHJc8VPTA3mO5vIRPZOuvPFYC7ZZN7YPEckUr6jt/h05fnKNcfOh6wu
         egrUkecxcoDF5GjbZ79/URCT4KE6eyAG/thG2llF+UAnHWJ+6MlkhOXH7ri2dBNI+J
         477YhnswZ+O9IAXco6mzYJMqDnCPdsFL+dH8BCBC7xQ1PBQJqwgQRqpXpNokPqudYL
         3+gODHVo1+hHQ==
Message-ID: <8367c38b-8cd3-cde1-5833-874769ef3350@collabora.com>
Date:   Thu, 30 Jun 2022 12:13:09 +0300
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
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
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

On 6/30/22 03:50, Viresh Kumar wrote:
> On 29-06-22, 21:33, Dmitry Osipenko wrote:
>> Today I noticed that tegra30-devfreq driver now fails to probe because
>> dev_pm_opp_find_freq_ceil() fails with -ERANGE. This patch is guilty for
>> that. Could you please take a look?
> 
> I remember this corner case now [1] and it was easy to miss this. So
> you want the OPP core to still parse the DT to read opp-hz, but don't
> want dev_pm_opp_set_opp() to update the clock rate for it.
> 
> What was the reason for this again ?
> 
> I have a couple of solutions in mind, but one may be other than second
> and so want to know the real issue at hand first.
> 

We added memory interconnect support to Tegra and since that time only
the memory controller can drive the clock rate. All other drivers,
including the devfreq, now issue memory bandwidth requests using ICC.

In case of the devfreq driver, it's the OPP core that makes the bw
request using ICC.

But it's the set_freq_table() that fails [2], I see
dev_pm_opp_get_opp_count() returns 17, which is correct, and then
dev_pm_opp_find_freq_ceil(freq=0) returns freq=1, which shall be
freq=12750000.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/?id=16e8b2a7cb886bcc3dd89ad28948d374a2319bbc

[2]
https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/devfreq/devfreq.c#L179

-- 
Best regards,
Dmitry
