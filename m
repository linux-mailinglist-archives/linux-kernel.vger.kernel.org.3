Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC194F7702
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiDGHPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiDGHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:15:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6D3BF9A;
        Thu,  7 Apr 2022 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649315615; x=1680851615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BkzCxsE5hBRJs6P4NUF4QW7/C/WzYFq9gmdY1yy7Lls=;
  b=XXiMgoxPMT5meEsfgeHmVGQbKAU3EzKFZ01QMxfa2/Ef3Oodxiom1ixm
   ACdwWfX0m6lZLbAstKAjxOEN/EDCF6q9DpXc0y9Ql70lnLzXQn/KNib/Z
   D4UeHowKuA7yqtPrbe4MSS2rlmbQmR7JeYrkkwgqne5hHW1H1OGWCtViJ
   wOiEzpIJznT7FLOftCurmPSHej/t5Wne/UaKbbkNGUPVSFGGOVM+o2oJi
   mL0fGVRbXZDihLd7nNYUc89VN10615PvPXgwDdKLW+DJCPcTL4n1yqk7b
   H3jaFd0i5TfioeBbCRoq/ctvklqIqYeZ+tgPiQEcyKTt9HIPV6rfmZ9rW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261241901"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="261241901"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 00:13:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="549897306"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.40.48])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 00:13:26 -0700
Message-ID: <3c8e94e1-fb8e-0d8f-4e79-b8313a1da5cb@intel.com>
Date:   Thu, 7 Apr 2022 10:13:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 09/11] mmc: sdhci-cadence: Add Pensando Elba SoC support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>, dac2@pensando.io,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-10-brad@pensando.io>
 <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 9.45, Arnd Bergmann wrote:
> On Thu, Apr 7, 2022 at 1:36 AM Brad Larson <brad@pensando.io> wrote:
>> @@ -350,7 +461,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>>  static int sdhci_cdns_probe(struct platform_device *pdev)
>>  {
>>         struct sdhci_host *host;
>> -       const struct sdhci_pltfm_data *data;
>> +       const struct sdhci_cdns_drv_data *data;
>>         struct sdhci_pltfm_host *pltfm_host;
>>         struct sdhci_cdns_priv *priv;
>>         struct clk *clk;
>> @@ -369,10 +480,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>
>>         data = of_device_get_match_data(dev);
>>         if (!data)
>> -               data = &sdhci_cdns_pltfm_data;
>> +               data = &sdhci_cdns_drv_data;
>>
>>         nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
>> -       host = sdhci_pltfm_init(pdev, data,
>> +       host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>>                                 struct_size(priv, phy_params, nr_phy_params));
>>         if (IS_ERR(host)) {
>>                 ret = PTR_ERR(host);
>> @@ -389,6 +500,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>         host->ioaddr += SDHCI_CDNS_SRS_BASE;
>>         host->mmc_host_ops.hs400_enhanced_strobe =
>>                                 sdhci_cdns_hs400_enhanced_strobe;
>> +       if (data->init) {
>> +               ret = data->init(pdev);
>> +               if (ret)
>> +                       goto free;
>> +       }
>>         sdhci_enable_v4_mode(host);
>>         __sdhci_read_caps(host, &version, NULL, NULL);
> 
> I'm not sure about the abstraction here. The approach of having a single
> driver with some platform specific quirks like you do here works fine if the
> differences between hardware implementations are fairly minor, but if there
> are a larger number of variants, or the differences become too big, the
> better approach is to have separate top-level driver instances that call
> into a more generic driver, continuing the call chain
> 
> elba_drv_init()
>  -> sdhci_cdns_probe()
>      -> sdhci_pltfm_init()
>          -> sdhci_add_host()
>              -> mmc_add_host()
> 
> with each one being a more specific version of the one below it.
> At the moment, it doesn't quite require having a custom driver,
> but I fear that it it would get hard to rework if it continues to grow
> other front-ends. It may be better to do the abstraction right away,
> even if the elba driver becomes rather trivial.
> 
> Ulf, any preferences?
> 

What is the relationship between cadence and pensando elba?
