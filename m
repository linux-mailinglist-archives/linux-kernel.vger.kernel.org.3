Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD850298E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353336AbiDOM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347180AbiDOM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:27:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F303C12EE;
        Fri, 15 Apr 2022 05:24:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 503111F47DFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025455;
        bh=+DG/SR1JZeY9TwBgdasuUGclUXboAsJu+KnxOPlJeQM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F56RCCZtK14fdbv8+VqhuyMC1l8IR5zkZ8hj1ud//5Ykt3U6LvU0Gk2cWyWXMZ462
         7UsUTfE4QDJpCjA9SHekhbdjbPX4Y64wTZzU2l1k3sEAAS6Ob+YW+wPSx9s5kH0zKt
         Gjsl3Q3iGwvlbOT1zuqxawrfW9MP0xvmNTxZ3k2h8SemrUJ8dRaUJ0RI2mr3j2KmZZ
         2huEg/J5dRhfH92O1HZyWctVXVvhDc73B0gS81+WzH1aI4lVpRXAw2yzvZ4rmSFwIR
         eI2fjWOMwoQsUQSy2+vKCxGbD3EdS3req9fSG1ZNdctU8uXmF7+Rw4Dul7bcqXsnmy
         RRGXS9hWnp7SQ==
Message-ID: <cfde61f1-5581-23b8-bd5b-f2a1875ec4ae@collabora.com>
Date:   Fri, 15 Apr 2022 14:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 10/15] cpufreq: mediatek: Add counter to prevent
 infinite loop when tracking voltage
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@google.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tim Chang <jia-wei.chang@mediatek.com>, roger.lu@mediatek.com,
        Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-11-rex-bc.chen@mediatek.com>
 <CACb=7PXykpUgZ+QG93Bd-vWstq2V-k6G0zTg+D1q2WchJHPbig@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CACb=7PXykpUgZ+QG93Bd-vWstq2V-k6G0zTg+D1q2WchJHPbig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 08:14, Hsin-Yi Wang ha scritto:
> On Fri, Apr 15, 2022 at 1:59 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>>
>> To prevent infinite loop when tracking voltage, we calculate the maximum
>> value for each platform data.
>> We assume min voltage is 0 and tracking target voltage using
>> min_volt_shift for each iteration.
>> The retry_max is 3 times of expeted iteration count.
>>
>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

I'm sorry Rex, but this commit has to be squashed with 09/15, as the logic is
that each commit has to be acceptable, and 09/15 is not, without this fix.

Besides, as Hsin-Yi suggested, calculating this every time may hit performance,
but at the same time I don't want to lose this explicit calculation...

>> ---
>>   drivers/cpufreq/mediatek-cpufreq.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
>> index cc44a7a9427a..d4c00237e862 100644
>> --- a/drivers/cpufreq/mediatek-cpufreq.c
>> +++ b/drivers/cpufreq/mediatek-cpufreq.c
>> @@ -86,6 +86,16 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>>          struct regulator *proc_reg = info->proc_reg;
>>          struct regulator *sram_reg = info->sram_reg;
>>          int pre_vproc, pre_vsram, new_vsram, vsram, vproc, ret;
>> +       int retry_max;
>> +
>> +       /*
>> +        * We assume min voltage is 0 and tracking target voltage using
>> +        * min_volt_shift for each iteration.
>> +        * The retry_max is 3 times of expeted iteration count.
>> +        */
>> +       retry_max = 3 * DIV_ROUND_UP(max(info->soc_data->sram_max_volt,
>> +                                        info->soc_data->proc_max_volt),
>> +                                    info->soc_data->min_volt_shift);
> 
> mtk_cpufreq_voltage_tracking() will be called very frequently.
> retry_max is the same every time mtk_cpufreq_voltage_tracking() is
> called. Is it better to calculate before and store in
> mtk_cpu_dvfs_info?
> 

...so I agree with this solution: perhaps you can add a "vtrack_max" variable to
mtk_cpu_dvfs_info as suggested, and fill in that one in function
mtk_cpu_dvfs_info_init(), where we effectively initialize all-the-things.

Cheers,
Angelo
