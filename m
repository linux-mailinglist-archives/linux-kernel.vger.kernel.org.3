Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E094850D9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiDYGsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbiDYGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:48:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711C39828;
        Sun, 24 Apr 2022 23:44:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23P6iLUM127426;
        Mon, 25 Apr 2022 01:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650869061;
        bh=4EJh5D6LdGjk7iMaA1TW14jBbGPHosvUf2mdjD2XwvE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ddnDZy9d7LiemyjmU0s/0I+cXgHEFZIVOy0vu+GV+Y6awCLU160SIaoJ6CyZMGUk8
         fBymruE75vWXCmF0lDUwgVAcIhGcy2k0d3ywjDe4J4N9DCyw1RmH3Dks3AyUSQ7Ib3
         FXUQFBF2qBSxHpzYf2jA7uGAgPojPU5/ZucDwObk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23P6iLR5008358
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 01:44:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 01:44:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 01:44:21 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23P6iGjR095438;
        Mon, 25 Apr 2022 01:44:17 -0500
Message-ID: <7c1cfb06-e759-dcf7-7022-5e15b159b508@ti.com>
Date:   Mon, 25 Apr 2022 12:14:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] drivers: mmc: sdhci_am654: Add the quirk to set
 TESTCD bit
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220418102040.4993-1-a-govindraju@ti.com>
 <20220418102040.4993-3-a-govindraju@ti.com>
 <CAPDyKFreftOExcZ9hgxpDGtdHhniB847vGAGpoO-McTy5_ao1w@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <CAPDyKFreftOExcZ9hgxpDGtdHhniB847vGAGpoO-McTy5_ao1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 21/04/22 17:41, Ulf Hansson wrote:
> On Mon, 18 Apr 2022 at 12:21, Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> The ARASAN MMC controller on Keystone 3 class of devices need the SDCD
>> line to be connected for proper functioning. Similar to the issue pointed
>> out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
>> sdhci-of-arasan: Set controller to test mode when no CD bit").
>>
>> In cases where this can't be connected, add a quirk to force the
>> controller into test mode and set the TESTCD bit. Use the flag
>> "ti,fails-without-test-cd", to implement this above quirk when required.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/mmc/host/sdhci_am654.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index e54fe24d47e7..c36b969ed1b6 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -147,6 +147,9 @@ struct sdhci_am654_data {
>>         int drv_strength;
>>         int strb_sel;
>>         u32 flags;
>> +       u32 quirks;
>> +
>> +#define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>>  };
>>
>>  struct sdhci_am654_driver_data {
>> @@ -369,6 +372,21 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>>         }
>>  }
>>
>> +void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
> 
> This should be a static function.
> 

Fixed this in the respin.

>> +{
>> +       u8 ctrl;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       sdhci_reset(host, mask);
>> +
>> +       if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
>> +               ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> +               ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
>> +               sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +       }
>> +}
>> +
>>  static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>  {
>>         struct sdhci_host *host = mmc_priv(mmc);
>> @@ -500,7 +518,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
>>         .set_clock = sdhci_j721e_4bit_set_clock,
>>         .write_b = sdhci_am654_write_b,
>>         .irq = sdhci_am654_cqhci_irq,
>> -       .reset = sdhci_reset,
>> +       .reset = sdhci_am654_reset,
>>  };
>>
>>  static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
>> @@ -719,6 +737,9 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>         device_property_read_u32(dev, "ti,clkbuf-sel",
>>                                  &sdhci_am654->clkbuf_sel);
>>
>> +       if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>> +               sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>> +
>>         sdhci_get_of_property(pdev);
>>
>>         return 0;
>> --
>> 2.17.1
>>
> 
> Other than the minor thing above, this looks good to me.
> 

Thank you for the review.

Link to the v2 of this patch series,

https://patchwork.kernel.org/project/linux-mmc/list/?series=635179

-- 
Thanks,
Aswath

> Kind regards
> Uffe



