Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE650B2C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444909AbiDVIYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444733AbiDVIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:23:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95E652B1D;
        Fri, 22 Apr 2022 01:21:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6F5FE1F46407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650615660;
        bh=4ryxE2grXNDQxyBkghcQhW6+HdJdRAPqXcGrba7PMns=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YJx8Jq44JrSHL3i6P6Sc23HtfEme3lFv9sVkoansgK7HUTAjydO1yjUObsBu/eqSc
         Zb/3Pa9V/oSPweeuM+lCNUvDE8oEmv+49umjd5t/eDjcf+0br31Ujm8HXJCGT9yn8c
         dMqkI8OwPGvLjNixqk9N0c7j+VnWU7epmstbkuRK0ut3qiSeszPdWiI6tG8Yu/i+2m
         HMf2NawmPN0dxjQVh5OCvg9/u7uNnL9dr3GoOV6dJLOJvlkr0COK6mach3iEAccfev
         XJaAF4eo19EFTPsp7ZHErsfUlVdu6nco9l7XWWnxKZsZ0CUHDb1DNdMO3cP1GjPWoD
         JV76lU14PH0kg==
Message-ID: <f0837023-64ce-7a3b-d3c7-e713f48b2c6e@collabora.com>
Date:   Fri, 22 Apr 2022 10:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 09/14] cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-10-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220422075239.16437-10-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 09:52, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Because the difference of sram and proc should in a range of min_volt_shift
> and max_volt_shift. We need to adjust the sram and proc step by step.
> 
> We replace VOLT_TOL (voltage tolerance) with the platform data and update the
> logic to determine the voltage boundary and invoking regulator_set_voltage.
> 
> - Use 'sram_min_volt' and 'sram_max_volt' to determine the voltage boundary
>    of sram regulator.
> - Use (sram_min_volt - min_volt_shift) and 'proc_max_volt' to determine the
>    voltage boundary of vproc regulator.
> 
> Moreover, to prevent infinite loop when tracking voltage, we calculate the
> maximum value for each platform data.
> We assume min voltage is 0 and tracking target voltage using
> min_volt_shift for each iteration.
> The retry_max is 3 times of expeted iteration count.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

