Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE24474174
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhLNL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:27:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:41245 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbhLNL1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639481231; x=1671017231;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mHMIttm44k0SALwbBPZ8GQA5pWb2uLFnFCHHneRnJqU=;
  b=C6VT/+wwo6hHSvDNKUNsgqbQM/Mi5vu6aAzETwttGUZ8Rpz8tsWabSBe
   4FnUXBfyhIrW/wfvIZIrOn6PrxcQdUwWzjaT+VOUyzg9NyDT5nchj9nuq
   l6Zw7N4fglbPzzo3r2hyuRfubBMslWAOyu2nAmbuhdxIz8JtgKtlTBTp2
   L8XHgHJjXidxFXeo1wuhshNfr7ZAesu+ci80dn5+wDoD9fQvXcSGwWzJh
   R+i/l6oeoVo7tWwo2rJTLgWPDlSvxlmOjsYbnpgMGG3BjTVe0/v9Q32lh
   Fyh9KsJPyXrd53jXgy9++6hXf85kHcOYvsIlP9SAggFO/Xxnp/8YSARy9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302337375"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="302337375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 03:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465046009"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 03:27:08 -0800
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pci-gli: GL9755: Support for CD/WP
 inversion on OF platforms
To:     Hector Martin <marcan@marcan.st>,
        Ben Chuang <benchuanggli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211212070210.141664-1-marcan@marcan.st>
 <20211212070210.141664-2-marcan@marcan.st>
 <72e29a9d-7e2a-5c2e-c44b-42172aae4f2d@intel.com>
 <82faec71-31f7-f64e-e8e7-cf698b29fa16@marcan.st>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <96b75b6a-d57f-a36a-1463-a36144fe763c@intel.com>
Date:   Tue, 14 Dec 2021 13:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <82faec71-31f7-f64e-e8e7-cf698b29fa16@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 13:17, Hector Martin wrote:
> On 14/12/2021 19.41, Adrian Hunter wrote:
>>>   #define PCI_GLI_9755_PECONF   0x44
>>> -#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
>>> -#define   PCI_GLI_9755_DMACLK   BIT(29)
>>> +#define   PCI_GLI_9755_LFCLK          GENMASK(14, 12)
>>> +#define   PCI_GLI_9755_DMACLK         BIT(29)
>>
>> Please don't mix in white space changes.
> 
> This is aligning the existing code with the additions; is it preferable to have the new ifdefs below misaligned?

White space changes should be a separate patch

> 
>>> +#define   PCI_GLI_9755_INVERT_CD      BIT(30)
>>> +#define   PCI_GLI_9755_INVERT_WP      BIT(31)
>>>     #define PCI_GLI_9755_CFG2          0x48
>>>   #define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
>>> @@ -570,6 +573,18 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>>>       gl9755_wt_on(pdev);
>>>         pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
>>> +#ifdef CONFIG_OF
>>> +    if (pdev->dev.of_node) {
>>
>> As Robin wrote, please remove #ifdef and if (pdev->dev.of_node)
>> because they are not needed.
> 
> Ack, will send out a v3 soon with the requested changes and hopefully it should be good to go :)
> 

