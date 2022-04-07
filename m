Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35534F7EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiDGM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiDGM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:26:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBC5419A;
        Thu,  7 Apr 2022 05:24:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 237COENA099315;
        Thu, 7 Apr 2022 07:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649334254;
        bh=xu7j83V1wccmIKw0dlyr7Z20v0J2kE4QXcR1rpoy2g8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dYE2eflMsJSyhixrCBYbZeerGxznXN8h7jIAgXlPvSA8hImWxxcNHHfIce1ghgT7Q
         jxZQD2zqj9w2xTFgAdn9etsdCLrbgfWLg6EE4xd9JweB4d96bC8RinaWVbNJD9RazM
         +A4hIiR/VDrKC/cuu8G1PYfPsWsX1SPjlMBXjpFk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 237COE7w031767
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Apr 2022 07:24:14 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Apr 2022 07:24:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Apr 2022 07:24:13 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 237COADC005664;
        Thu, 7 Apr 2022 07:24:11 -0500
Message-ID: <4cc5cc8f-3249-4caf-0c09-995860bd379d@ti.com>
Date:   Thu, 7 Apr 2022 17:54:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC] mmc: sdhci_am654: Add support for PM suspend/resume
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>
References: <20220330075255.12127-1-a-govindraju@ti.com>
 <CAPDyKFoEZPaPG1bGq+nHtyO=FNzSfmwDPtVh5tobSJcctmQD4A@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <CAPDyKFoEZPaPG1bGq+nHtyO=FNzSfmwDPtVh5tobSJcctmQD4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 07/04/22 16:12, Ulf Hansson wrote:
> + Faiz
> 
> On Wed, 30 Mar 2022 at 09:53, Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> Add support for suspend/resume and pm_runtime resume/suspend.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/mmc/host/sdhci_am654.c | 204 ++++++++++++++++++++++++++++++---
>>  1 file changed, 191 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index e54fe24d47e7..e86df72dfd78 100644
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
>> @@ -808,30 +803,42 @@ static int sdhci_am654_probe(struct platform_device *pdev)
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
>> +       pm_runtime_set_active(dev);
>> +       pm_runtime_enable(dev);
>> +       clk_prepare_enable(pltfm_host->clk);
> 
> I think some error handling is missing, at least for clk_prepare_enable().
> 
>> +       ret = pm_runtime_resume_and_get(dev);
> 
> This can be replaced with a pm_runtime_get_noresume() - and I think it
> would improve the readability of the code, to put the call above
> pm_runtime_set_active().
> 

Shouldn't pm_runtime_get_* be only done after we execute
pm_runtime_enable and pm_runtime_set_active should be called before
pm_runtime_enable()

"In addition to that, the initial runtime PM status of all devices is
‘suspended’, but it need not reflect the actual physical state of the
device. Thus, if the device is initially active (i.e. it is able to
process I/O), its runtime PM status must be changed to ‘active’, with
the help of pm_runtime_set_active(), before pm_runtime_enable() is
called for the device." [1]


Yeah, and I agree that pm_runtime_get_noresume would be better to use
over here.

[1] - https://www.infradead.org/~mchehab/kernel_docs/power/runtime_pm.html


>> +       if (ret)
>> +               goto clk_disable;
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
>> +clk_disable:
>> +       clk_disable_unprepare(pltfm_host->clk);
>>         pm_runtime_put_sync(dev);
>> -pm_runtime_disable:
>>         pm_runtime_disable(dev);
>>  err_pltfm_free:
>>         sdhci_pltfm_free(pdev);
>> @@ -841,6 +848,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>  static int sdhci_am654_remove(struct platform_device *pdev)
>>  {
>>         struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>         int ret;
>>
>>         sdhci_remove_host(host, true);
>> @@ -848,16 +856,186 @@ static int sdhci_am654_remove(struct platform_device *pdev)
>>         if (ret < 0)
>>                 return ret;
>>
>> +       clk_disable_unprepare(pltfm_host->clk);
> 
> To gate the clock, you need to make sure it has been ungated first. As
> you anyway need to add a call pm_runtime_get_sync() prior to calling
> sdhci_remove_host() a few lines above, this would fix it.
> 

This call was the counter part for the clk_enable_prepare called in
probe(). Yes, and I should have done a pm_runtime_get_sync before
calling sdhci_remove_host() in sdhci_am654_remove()

> Moreover, the existing call to pm_runtime_put_sync() a few lines above
> in sdhci_am654_remove(), should be replaced with a call to
> pm_runtime_put_noidle() - and that call should be made below the call
> pm_runtime_disable() to become correct.

Again shouldn't we disable pm_runtime after putting the device?

> 
>>         pm_runtime_disable(&pdev->dev);
>>         sdhci_pltfm_free(pdev);
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int sdhci_am654_restore(struct sdhci_host *host)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +       u32 ctl_cfg_2 = 0;
>> +       u32 val;
>> +       int ret;
>> +
>> +       if (sdhci_am654->flags & DLL_CALIB) {
>> +               regmap_read(sdhci_am654->base, PHY_STAT1, &val);
>> +               if (~val & CALDONE_MASK) {
>> +                       /* Calibrate IO lines */
>> +                       regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>> +                                          PDB_MASK, PDB_MASK);
>> +                       ret = regmap_read_poll_timeout(sdhci_am654->base,
>> +                                                      PHY_STAT1, val,
>> +                                                      val & CALDONE_MASK,
>> +                                                      1, 20);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +
>> +       /* Enable pins by setting IO mux to 0 */
>> +       if (sdhci_am654->flags & IOMUX_PRESENT)
>> +               regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>> +                                  IOMUX_ENABLE_MASK, 0);
>> +
>> +       /* Set slot type based on SD or eMMC */
>> +       if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>> +               ctl_cfg_2 = SLOTTYPE_EMBEDDED;
>> +
>> +       regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
>> +                          ctl_cfg_2);
>> +
>> +       regmap_read(sdhci_am654->base, CTL_CFG_3, &val);
>> +       if (~val & TUNINGFORSDR50_MASK)
>> +               /* Enable tuning for SDR50 */
>> +               regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
>> +                                  TUNINGFORSDR50_MASK);
>>
>>         return 0;
>>  }
>>
>> +static int sdhci_am654_runtime_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       int ret;
>> +
>> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>> +               mmc_retune_needed(host->mmc);
>> +
>> +       ret = cqhci_suspend(host->mmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = sdhci_runtime_suspend_host(host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* disable the clock */
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +       return 0;
>> +}
>> +
>> +static int sdhci_am654_runtime_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       int ret;
>> +
>> +       /* Enable the clock */
>> +       clk_prepare_enable(pltfm_host->clk);
>> +       ret = sdhci_am654_restore(host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = sdhci_runtime_resume_host(host, 0);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = cqhci_resume(host->mmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int sdhci_am654_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       int ret;
>> +
>> +       if (!host)
>> +               return 0;
>> +
>> +       ret = pm_runtime_get_sync(dev);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>> +               mmc_retune_needed(host->mmc);
>> +
>> +       ret = cqhci_suspend(host->mmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = sdhci_suspend_host(host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pm_runtime_put_sync(dev);
>> +
>> +       /* disable the clock */
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sdhci_am654_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       int ret;
>> +
>> +       if (!host)
>> +               return 0;
>> +
>> +       /* Enable the clock */
>> +       clk_prepare_enable(pltfm_host->clk);
>> +       ret = pm_runtime_get_sync(dev);
>> +       if (ret < 0)
>> +               goto clk_unprepare;
>> +
>> +       ret = sdhci_am654_restore(host);
>> +       if (ret)
>> +               goto put;
>> +
>> +       ret = sdhci_resume_host(host);
>> +       if (ret)
>> +               goto put;
>> +
>> +       ret = cqhci_resume(host->mmc);
>> +       if (ret)
>> +               goto put;
>> +
>> +       pm_runtime_mark_last_busy(dev);
>> +       pm_runtime_put_autosuspend(dev);
>> +       return 0;
>> +
>> +put:
>> +       pm_runtime_put_sync(dev);
>> +clk_unprepare:
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +       return ret;
>> +}
> 
> By looking at the code in sdhci_am654_suspend|resume(), I wonder if
> those is better replaced with assigning system PM callbacks to
> pm_runtime_force_suspend|resume() instead. Other sdhci variants do
> this already, you may have a look at those to better get the idea.
> 

The reason why I used different functions was because of the
sdhci_runtime_suspend/resume vs sdhci_suspend/resume but I think from
the controller perspective there is no difference. So, yeah I think it
is better to go with pm_runtime_force_suspend/resume().


>> +#endif
>> +
>> +static const struct dev_pm_ops sdhci_am654_dev_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_am654_suspend, sdhci_am654_resume)
>> +       .runtime_suspend = sdhci_am654_runtime_suspend,
>> +       .runtime_resume = sdhci_am654_runtime_resume,
> 
> For runtime PM callbacks, you can use SET_RUNTIME_PM_OPS(). Otherwise
> I think this will cause a build error when built with CONFIG_PM unset.
> 

Sure, will replace this in the respin.

>> +};
>> +
>>  static struct platform_driver sdhci_am654_driver = {
>>         .driver = {
>>                 .name = "sdhci-am654",
>>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +               .pm = &sdhci_am654_dev_pm_ops,
>>                 .of_match_table = sdhci_am654_of_match,
>>         },
>>         .probe = sdhci_am654_probe,
> 
> Kind regards
> Uffe


-- 
Thanks,
Aswath
