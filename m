Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970AC4FF668
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiDMMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiDMMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:09:45 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF55C872;
        Wed, 13 Apr 2022 05:07:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23DC7LuW076187;
        Wed, 13 Apr 2022 07:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649851641;
        bh=kv0WOGZGyIs6AmNxmdTQseU7k8P+XWMLBQfQO9Tv/S4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qyERnKAnMbWumkfY9lkYsNAj/grZOuz0BE65O0vg3ZQIw3BEHibtMiN1QYRfsds+l
         7lHW4aoo9IK7KCU0Pb0s+3002Yn/EJVH0ni2bqVodl1eVBZMLPyZOYgT8aw+oaaXFb
         XN3STqgjoB7vKXOSbqCcw5a3hFxl1A1EYrAAZNDM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23DC7LMP018497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 07:07:21 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 07:07:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 07:07:21 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23DC7Iqq065645;
        Wed, 13 Apr 2022 07:07:19 -0500
Message-ID: <862dc646-4b80-4c6f-1e0f-99a498068f84@ti.com>
Date:   Wed, 13 Apr 2022 17:37:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2] mmc: sdhci_am654: Add support for PM
 suspend/resume
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220408124338.27090-1-a-govindraju@ti.com>
 <CAPDyKFqy6sEtU57-QkZeCfMtJgcoHG8siRBieOUjkBZMfPge9Q@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <CAPDyKFqy6sEtU57-QkZeCfMtJgcoHG8siRBieOUjkBZMfPge9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 12/04/22 20:08, Ulf Hansson wrote:
> On Fri, 8 Apr 2022 at 14:43, Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> Add support for suspend/resume and pm_runtime resume/suspend.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>
>> Changes since v1:
>> - Removed System pm calls and used force_runtime_pm calls instead
>> - Added error handling at required places
>> - Added pm_runtime_sync call in the sdhci_am654_remove function
>> - Replaced pm_runtime_*_sync calls in probe with noidle and noresume
>>   calls
>> - Used MACRO SET_RUNTIME_PM_OPS to avoid build errors when CONFIG_PM
>>   is disabled
>>
>>  drivers/mmc/host/sdhci_am654.c | 146 +++++++++++++++++++++++++++++----
>>  1 file changed, 132 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index e54fe24d47e7..131b2b9ae0e7 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -84,6 +84,7 @@
>>  #define DRIVER_STRENGTH_40_OHM 0x4
>>
>>  #define CLOCK_TOO_SLOW_HZ      50000000
>> +#define SDHCI_AM654_AUTOSUSPEND_DELAY  100
>>
>>  /* Command Queue Host Controller Interface Base address */
>>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
>> @@ -791,16 +792,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>
>>         pltfm_host->clk = clk_xin;
>>
>> -       /* Clocks are enabled using pm_runtime */
>> -       pm_runtime_enable(dev);
>> -       ret = pm_runtime_resume_and_get(dev);
>> -       if (ret)
>> -               goto pm_runtime_disable;
>> -
>>         base = devm_platform_ioremap_resource(pdev, 1);
>>         if (IS_ERR(base)) {
>>                 ret = PTR_ERR(base);
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>         }
>>
>>         sdhci_am654->base = devm_regmap_init_mmio(dev, base,
>> @@ -808,31 +803,47 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>         if (IS_ERR(sdhci_am654->base)) {
>>                 dev_err(dev, "Failed to initialize regmap\n");
>>                 ret = PTR_ERR(sdhci_am654->base);
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>         }
>>
>>         ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
>>         if (ret)
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>
>>         ret = mmc_of_parse(host->mmc);
>>         if (ret) {
>>                 dev_err(dev, "parsing dt failed (%d)\n", ret);
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>         }
>>
>>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>>
>> +       pm_runtime_get_noresume(dev);
>> +       ret = pm_runtime_set_active(dev);
>> +       if (ret)
>> +               goto pm_put;
>> +       pm_runtime_enable(dev);
>> +       ret = clk_prepare_enable(pltfm_host->clk);
>> +       if (ret)
>> +               goto pm_disable;
>> +
>>         ret = sdhci_am654_init(host);
>>         if (ret)
>> -               goto pm_runtime_put;
>> +               goto clk_disable;
>>
>> +       /* Setting up autosuspend */
>> +       pm_runtime_set_autosuspend_delay(dev, SDHCI_AM654_AUTOSUSPEND_DELAY);
>> +       pm_runtime_use_autosuspend(dev);
>> +       pm_runtime_mark_last_busy(dev);
>> +       pm_runtime_put_autosuspend(dev);
>>         return 0;
>>
>> -pm_runtime_put:
>> -       pm_runtime_put_sync(dev);
>> -pm_runtime_disable:
>> +clk_disable:
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +pm_disable:
>>         pm_runtime_disable(dev);
>> +pm_put:
>> +       pm_runtime_put_noidle(dev);
>>  err_pltfm_free:
>>         sdhci_pltfm_free(pdev);
>>         return ret;
>> @@ -841,23 +852,130 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>  static int sdhci_am654_remove(struct platform_device *pdev)
>>  {
>>         struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>         int ret;
>>
>> +       ret = pm_runtime_get_sync(&pdev->dev);
> 
> pm_runtime_resume_and_get() is better suited here, as it helps us to
> restore the usage count in the error path.
> >> +       if (ret < 0)
>> +               return ret;
>> +
>>         sdhci_remove_host(host, true);
>>         ret = pm_runtime_put_sync(&pdev->dev);
> 
> We need to drop the above call to pm_runtime_put_sync(). Otherwise you
> may potentially end up gating the clock, in which case the below call
> to clk_disable_unprepare() becomes wrong.
> >>         if (ret < 0)
>>                 return ret;
>>
>> +       clk_disable_unprepare(pltfm_host->clk);
>>         pm_runtime_disable(&pdev->dev);
> 
> You need a call to pm_runtime_put_noidle() here to restore the RPM
> usage count to zero.
> 
>>         sdhci_pltfm_free(pdev);
>> +       return 0;
>> +}
> 
> [...]
> 
> Other than the rather minor things above, this looks good to me!
> 

Thank you for the review.

Regards,
Aswath

> Kind regards
> Uffe
