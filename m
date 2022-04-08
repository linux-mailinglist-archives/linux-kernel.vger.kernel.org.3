Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940854F96FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiDHNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiDHNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE9208249;
        Fri,  8 Apr 2022 06:37:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CF8971F47188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425022;
        bh=foN9Js8TKOpOz/If2h614GmeHSY3KSVwFZkOVYq728w=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Frs6uv4NmlFx2oJgHAGEtD/w4BHwRUoQ1hUb8mh+D0PHWnigVTLjRU7ZRkIazzBWO
         S/mW9lD53+qqYeB0P46Zcm0jOGXtgNUjtjagMW+09TQ5Od5gRk1D/8t7POyJxOSBfD
         ssNDcw4VqdvCN04dbNApsPWwE2m8Uw7NWDvqEbdkSQHDXtdbQ3aN8jsYhUkjhHk3Uk
         CSjnudVQTL37lGOLy5M/0EWIujdDwe3ytMqfxLPAQh+wRkzaMdMhzmJljORM1uacfK
         blua8Le4+QhzIlGapn2bePATWnFnKnK8j/qB6KI6MFP5KDNs4YXcIGSquYxG4jClw2
         L1tzt7VsZbBBg==
Message-ID: <3dade32c-4b46-351a-b3f9-d1fec16b603c@collabora.com>
Date:   Fri, 8 Apr 2022 15:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 08/15] cpufreq: mediatek: Move voltage limits to
 platform data
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-9-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-9-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Voltages and shifts are defined as macros originally.
> There are different requirements of these values for each MediaTek SoCs.
> Therefore, we add the platform data and move these values into it.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 90 ++++++++++++++++++++----------
>   1 file changed, 61 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 1369da62780a..0be5609ee82e 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c

..snip..

> @@ -625,20 +649,27 @@ static struct platform_driver mtk_cpufreq_platdrv = {
>   	.probe		= mtk_cpufreq_probe,
>   };
>   
> +static const struct mtk_cpufreq_platform_data mtk_platform_data = {

I would prefer if you name this after the oldest SoC that is supported in this
driver, or after the IP version.

Example: if the oldest one is mt7622, then this should be mt7622_platform_data;
          if newer SoCs have got a different cpu frequency control IP, then we
          should have here something like
          mtk_v1_platform_data, mtk_v1_3_platform_data.

Please note that I didn't check release dates, so my reference to mt7622 is
purely casual.

Regards,
Angelo
