Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD5F4C88ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiCAKGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiCAKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:06:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7978D6AA;
        Tue,  1 Mar 2022 02:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646129120; x=1677665120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OqRnVMfE9sumNiyhj1Qk7+SncksPrSyR31RaHEHrlOY=;
  b=EupCCXi7Kx1VcAyY1BWANLcZfkh2IRY6XU0AWcrcfdIbfFZIenjVynvZ
   9h+yvDLkb/cIe9zXgrc9yTyWayqJoIxA2bRck7zYiNd0k/t+v8kuVc3qH
   fdZx5/5RoEtqnnt8OLerB3PltOOLi6SrDsvhEV3jlkRJn+yJ202HAZEK6
   pDdnr8TNp720gMFTVCfB6Y1IuznOVl+QSq3H3IWdffUDGPcS3aTrYpcrS
   o4Z8PD2D1TC84A/29PewXXnI1Ixn7ERgfBU+L3deDssYr8ohLTXDQF/ZP
   aOa36dkt7cp/VcK0VZ9VFLgbi2pwdZONuuC1g+0gsAGok2tn9r8R5kcxR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233073225"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="233073225"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 02:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="685669736"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2022 02:05:18 -0800
Message-ID: <4b35e465-626a-7218-ed9a-4e5cf28c1ccc@intel.com>
Date:   Tue, 1 Mar 2022 12:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
References: <20220225125553.1185108-1-benchuanggli@gmail.com>
 <20220225125553.1185108-2-benchuanggli@gmail.com>
 <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 19:03, Ulf Hansson wrote:
> On Fri, 25 Feb 2022 at 13:56, Ben Chuang <benchuanggli@gmail.com> wrote:
>>
>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>
>> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
>> gated of upstream port can be enabled.
>>
>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index 97035d77c18c..cf99b6af792d 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>>  }
>>
>> +#ifdef CONFIG_PM
>> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>> +{
>> +       struct sdhci_pci_slot *slot = chip->slots[0];
>> +       struct sdhci_host *host = slot->host;
>> +       u16 clock;
>> +
>> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
>> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
>> +
>> +       return 0;
>> +}
>> +
>> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>> +{
>> +       struct sdhci_pci_slot *slot = chip->slots[0];
>> +       struct sdhci_host *host = slot->host;
>> +       ktime_t timeout;
>> +       u16 clock;
>> +
>> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +
>> +       clock |= SDHCI_CLOCK_PLL_EN;
>> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
>> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
>> +
>> +       timeout = ktime_add_ms(ktime_get(), 150);
>> +       while (1) {
>> +               bool timedout = ktime_after(ktime_get(), timeout);
>> +
>> +               clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +               if (clock & SDHCI_CLOCK_INT_STABLE)
>> +                       break;
>> +               if (timedout) {
>> +                       pr_err("%s: PLL clock never stabilised.\n",
>> +                              mmc_hostname(host->mmc));
>> +                       sdhci_dumpregs(host);
>> +                       break;
>> +               }
>> +               udelay(10);
>> +       }

Could use something like read_poll_timeout() here e.g.

	if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
			      1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
		pr_err("%s: PLL clock never stabilised.\n",
		       mmc_hostname(host->mmc));
		sdhci_dumpregs(host);
	}


>> +       clock |= SDHCI_CLOCK_CARD_EN;
>> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
>> +
>> +       return 0;
>> +}
> 
> Both functions above look very similar to what sdhci_set_clock() does.
> Can you use that, rather than open coding the above?
> 
> Other than that, I would appreciate it if Adrian could have a look at
> this too. For example, I wonder if perhaps
> sdhci_runtime_suspend|resume_host() should be called in these paths
> too.

Assuming the host controller does not lose state information, it should be fine.

> 
>> +#endif
>> +
>>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>>  {
>>         struct pci_dev *pdev = slot->chip->pdev;
>> @@ -982,6 +1031,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>>  #ifdef CONFIG_PM_SLEEP
>>         .resume         = sdhci_cqhci_gli_resume,
>>         .suspend        = sdhci_cqhci_gli_suspend,
>> +#endif
>> +#ifdef CONFIG_PM
>> +       .runtime_suspend = gl9763e_runtime_suspend,
>> +       .runtime_resume  = gl9763e_runtime_resume,
>> +       .allow_runtime_pm = true,
>>  #endif
>>         .add_host       = gl9763e_add_host,
>>  };
>> --
>> 2.35.1
>>
> 
> Kind regards
> Uffe

