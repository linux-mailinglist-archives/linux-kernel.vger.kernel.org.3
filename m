Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DF4FC22C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiDKQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiDKQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:25:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758A30555
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649694219; x=1681230219;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ltUQurSEf7syUrN+loaIb4/tJxXmlbA0TKblHJomdWg=;
  b=ahi4SHTqSKN+zFW1wGR5yRQoIz4yi5z+WFFITKrcewGIr49tzqZr21JX
   juDlPzHuCEflPetmSQV/ZKX6keSpLiSSNib0UBeSF3pVuAPZv4B2NaGUq
   ufpcgD2lckxl9rj5pu1pWccK7UX7hSeMZOnQK6vVGmFn9HotZniKZn0IS
   Cz2yiUjukw8TRc/iCPq3s2QNG1F7BETsdlUMBdalKER/sapXPUHhT0qV6
   N3+GZIJLdzb9KhZive3E5zGBdjGky8HD2Wktlp453PvWxCl21CvWFxC+G
   fTs4R6DVe7ZNzm5qQpx9oi1rtsVf8te0Z6y2pl7ThH0RLUbWjgz6h3By/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244039394"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="244039394"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:23:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572279148"
Received: from prposam-mobl.amr.corp.intel.com (HELO [10.212.162.151]) ([10.212.162.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:23:26 -0700
Message-ID: <18cb711a-de2a-69e3-d753-7012a67bf2a7@linux.intel.com>
Date:   Mon, 11 Apr 2022 10:28:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: SOF: Intel: Check the bar size before remapping
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        peter.ujfalusi@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
References: <20220409143950.2570186-1-zheyuma97@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220409143950.2570186-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/22 09:39, Zheyu Ma wrote:
> The driver should use the pci_resource_len() to get the actual length of
> pci bar, and compare it with the expect value. If the bar size is too
> small (such as a broken device), the driver should return an error.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  sound/soc/sof/intel/pci-tng.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
> index 6efef225973f..7d502cc3ca80 100644
> --- a/sound/soc/sof/intel/pci-tng.c
> +++ b/sound/soc/sof/intel/pci-tng.c
> @@ -75,7 +75,11 @@ static int tangier_pci_probe(struct snd_sof_dev *sdev)
>  
>  	/* LPE base */
>  	base = pci_resource_start(pci, desc->resindex_lpe_base) - IRAM_OFFSET;
> -	size = PCI_BAR_SIZE;
> +	size = pci_resource_len(pci, desc->resindex_lpe_base);
> +	if (size < PCI_BAR_SIZE) {
> +		dev_err(sdev->dev, "error: I/O region is too small.\n");
> +		return -ENODEV;
> +	}

May I ask how you found this issue?

I am not clear on why there's a patch dedicated for a single device, but the same pattern in hda.c and in the HDaudio legacy driver exists.

>  
>  	dev_dbg(sdev->dev, "LPE PHY base at 0x%x size 0x%x", base, size);
>  	sdev->bar[DSP_BAR] = devm_ioremap(sdev->dev, base, size);
