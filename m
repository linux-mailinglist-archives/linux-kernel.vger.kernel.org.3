Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64FA4E54AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiCWO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiCWO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:58:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C049982317
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648047428; x=1679583428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jzJJB4ceuOD3wfw/nSCP0X8/PdP6WW3A58taq3XnVuE=;
  b=cRti0z5pR8sqgJ4mRvRsA+QMZeqZeWavOrgo6HnahdCMJVfKVnELl6h+
   JSmih9n13Syv9zS0ifznUuoO8Yg9oUaXnFdvxbqUMgX+MbuwVP4li+gYc
   T8nzoSGW/kkrH+YurRuxTBZtIBuNdKtbz7IcGHGJ6LDaWnncGYCL56UwS
   hF1wBSrFCanUEVqW2h/cLQpYOzpjfhoY28BwATfg6s+6mZFLuzs0OJ66t
   AfU6dB8GVW/942K39XJvYUdOyZ68SbLzT3RXPF3cbr3p8SFGS7ZacGiki
   1DA+JA/gUtjaCsgk/6QyOmV1xVoOy0hm1K/ACEjeCefii90j4pIIzsglr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="256950537"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="256950537"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:57:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="519386771"
Received: from thientha-mobl1.amr.corp.intel.com (HELO [10.251.10.76]) ([10.251.10.76])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:57:07 -0700
Message-ID: <9f44016c-4774-64b3-4485-630401710568@linux.intel.com>
Date:   Wed, 23 Mar 2022 09:57:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH -next] ASoC: SOF: Intel: Fix build error without
 SND_SOC_SOF_PCI_DEV
Content-Language: en-US
To:     Zheng Bin <zhengbin13@huawei.com>, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     limingming.li@huawei.com, tangyizhou@huawei.com
References: <20220323092501.145879-1-zhengbin13@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220323092501.145879-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/22 04:25, Zheng Bin wrote:
> If SND_SOC_SOF_PCI_DEV is n, bulding fails:
> 
> sound/soc/sof/intel/pci-tng.o:(.data+0x1c0): undefined reference to `sof_pci_probe'
> sound/soc/sof/intel/pci-tng.o:(.data+0x1c8): undefined reference to `sof_pci_remove'
> sound/soc/sof/intel/pci-tng.o:(.data+0x1e0): undefined reference to `sof_pci_shutdown'
> sound/soc/sof/intel/pci-tng.o:(.data+0x290): undefined reference to `sof_pci_pm'
> 
> Make SND_SOC_SOF_MERRIFIELD select SND_SOC_SOF_PCI_DEV to fix this.
> 
> Fixes: 8d4ba1be3d22 ("ASoC: SOF: pci: split PCI into different drivers")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Indeed that's a miss, thanks for the patch. We select 
SND_SOC_SOF_PCI_DEV for all HDaudio-based PCI devices but forgot 
Merrifield which is PCI-based but not HDaudio-based.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/sof/intel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index b53f216d4ecc..172419392b33 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -84,6 +84,7 @@ if SND_SOC_SOF_PCI
>   config SND_SOC_SOF_MERRIFIELD
>   	tristate "SOF support for Tangier/Merrifield"
>   	default SND_SOC_SOF_PCI
> +	select SND_SOC_SOF_PCI_DEV
>   	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
>   	help
>   	  This adds support for Sound Open Firmware for Intel(R) platforms
> --
> 2.31.1
> 
