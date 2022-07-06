Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707415680C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiGFIJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGFIJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:09:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7971F18381;
        Wed,  6 Jul 2022 01:09:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6E51596;
        Wed,  6 Jul 2022 01:09:55 -0700 (PDT)
Received: from [10.57.42.44] (unknown [10.57.42.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F28C3F792;
        Wed,  6 Jul 2022 01:09:51 -0700 (PDT)
Message-ID: <ca5b2602-358c-ce37-c698-8aaf4f579945@arm.com>
Date:   Wed, 6 Jul 2022 09:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 02/20] OPP: Make dev_pm_opp_set_regulators() accept
 NULL terminated list
Content-Language: en-GB
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
References: <cover.1656935522.git.viresh.kumar@linaro.org>
 <9730e011004b7526e79c6f409f5147fb235b414a.1656935522.git.viresh.kumar@linaro.org>
 <48d865e8-6c0d-99c0-a43b-89793d5c3f85@arm.com>
 <20220705043439.xlrxusxrhwjupiyt@vireshk-i7>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220705043439.xlrxusxrhwjupiyt@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 05:34, Viresh Kumar wrote:
> On 04-07-22, 15:35, Steven Price wrote:
>> I have to say the 'new improved' list ending with NULL approach doesn't
>> work out so well for Panfrost. We already have to have a separate
>> 'num_supplies' variable for devm_regulator_bulk_get() /
>> regulator_bulk_{en,dis}able(), so the keeping everything in sync
>> argument is lost here.
>>
>> I would suggest added the NULL on the end of the lists in panfrost_drv.c
>> but then it would break the use of ARRAY_SIZE() to automagically keep
>> the length correct...
> 
> Actually we can still make it work.
> 
>> For now the approach isn't too bad because Panfrost doesn't yet support
>> enabling devfreq with more than one supply. But that array isn't going
>> to work so nicely when that restriction is removed.
>>
>> The only sane way I can see of handling this in Panfrost would be
>> replicating the loop to count the supplies in the Panfrost code which
>> would allow dropping num_supplies from struct panfrost_compatible and
>> then supply_names in the same struct could be NULL terminated ready for
>> devm_pm_opp_set_regulators().
> 
> Or doing this, which will simplify both the cases.

Yes the below works, it's just a bit ugly having the "- 1", and
potentially easy to forgot when adding another. However I don't suppose
it would get far in that case so I think it would be spotted quickly
when adding a new compatible.

It's probably the best solution at the moment.

Thanks,

Steve

> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 7fcbc2a5b6cd..b3b55565b8ef 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -625,24 +625,29 @@ static int panfrost_remove(struct platform_device *pdev)
>         return 0;
>  }
>  
> -static const char * const default_supplies[] = { "mali" };
> +/*
> + * The OPP core wants the supply names to be NULL terminated, but we need the
> + * correct num_supplies value for regulator core. Hence, we NULL terminate here
> + * and then initialize num_supplies with ARRAY_SIZE - 1.
> + */
> +static const char * const default_supplies[] = { "mali", NULL };
>  static const struct panfrost_compatible default_data = {
> -       .num_supplies = ARRAY_SIZE(default_supplies),
> +       .num_supplies = ARRAY_SIZE(default_supplies) - 1,
>         .supply_names = default_supplies,
>         .num_pm_domains = 1, /* optional */
>         .pm_domain_names = NULL,
>  };
>  
>  static const struct panfrost_compatible amlogic_data = {
> -       .num_supplies = ARRAY_SIZE(default_supplies),
> +       .num_supplies = ARRAY_SIZE(default_supplies) - 1,
>         .supply_names = default_supplies,
>         .vendor_quirk = panfrost_gpu_amlogic_quirk,
>  };
>  
> -static const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
> +static const char * const mediatek_mt8183_supplies[] = { "mali", "sram", NULL };
>  static const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
>  static const struct panfrost_compatible mediatek_mt8183_data = {
> -       .num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
> +       .num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies) - 1,
>         .supply_names = mediatek_mt8183_supplies,
>         .num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
>         .pm_domain_names = mediatek_mt8183_pm_domains,
> 

