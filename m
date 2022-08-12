Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA459121A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiHLOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiHLOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:19:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E688DEE
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660313998; x=1691849998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7SfuAmb8mmGQTiSG1CTMf6FTKfJ/9PLlg+perjfDTnI=;
  b=ZtBkjyj3P0CwuFRYud76TZQVyrhIlUX8MgerPWP5+VAjUw0s6NvztI4W
   OnFOgrI7HFK8X/kyn4v0t9B/ubmsFHpV1irMihJFrt05NFdwK8aFWBpZH
   pu+pAvp9ObCUg94IZP1Wf4VNtGP8z3zn3baC2dHBh5iW4uJSTODD2xse9
   urZ/UvWR9kA1J9gdUim164M8dcO9jBSxlGRGMJ6lzqtBkQdGOPN0NcqWZ
   bywuYeseRn389KcuRQhskn380BJkbqN+N3JG5SZ4kFBmJVmo4ydEs6LdC
   VSGShEhsgHObb7XNluLAoyvZb5FzX8rGS/lgf7VeCvF1UGjCDDIEqU6hz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291601632"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="291601632"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:19:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634655774"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.73]) ([10.99.241.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:19:51 -0700
Message-ID: <08ef0e7e-bc7a-9db5-23a4-4fd4fb70dd9a@linux.intel.com>
Date:   Fri, 12 Aug 2022 16:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/13] ASoC: amd: add acp6.2 init/de-init functions
Content-Language: en-US
To:     Syed Saba kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-4-Syed.SabaKareem@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220812120731.788052-4-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
> Add Pink Sardine platform ACP6.2 PCI driver init/deinit functions.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/ps/acp62.h  |  12 +++++
>   sound/soc/amd/ps/pci-ps.c | 109 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 121 insertions(+)
> 
> diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
> index e91762240c93..8e734f190b11 100644
> --- a/sound/soc/amd/ps/acp62.h
> +++ b/sound/soc/amd/ps/acp62.h
> @@ -10,6 +10,18 @@
>   #define ACP_DEVICE_ID 0x15E2
>   #define ACP62_PHY_BASE_ADDRESS 0x1240000
>   
> +#define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
> +#define ACP_PGFSM_CNTL_POWER_ON_MASK	1
> +#define ACP_PGFSM_CNTL_POWER_OFF_MASK	0
> +#define ACP_PGFSM_STATUS_MASK		3
> +#define ACP_POWERED_ON			0
> +#define ACP_POWER_ON_IN_PROGRESS	1
> +#define ACP_POWERED_OFF			2
> +#define ACP_POWER_OFF_IN_PROGRESS	3
> +
> +#define ACP_ERROR_MASK 0x20000000
> +#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
> +
>   static inline u32 acp62_readl(void __iomem *base_addr)
>   {
>   	return readl(base_addr - ACP62_PHY_BASE_ADDRESS);
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 25169797275c..2014f415af15 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -8,6 +8,7 @@
>   #include <linux/pci.h>
>   #include <linux/module.h>
>   #include <linux/io.h>
> +#include <linux/delay.h>
>   
>   #include "acp62.h"
>   
> @@ -15,6 +16,103 @@ struct acp62_dev_data {
>   	void __iomem *acp62_base;
>   };
>   
> +static int acp62_power_on(void __iomem *acp_base)
> +{
> +	u32 val;
> +	int timeout;
> +
> +	val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
> +
> +	if (!val)
> +		return val;
> +
> +	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
> +		acp62_writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
> +		if (!val)
> +			return 0;
> +		udelay(1);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int acp62_reset(void __iomem *acp_base)
> +{
> +	u32 val;
> +	int timeout;
> +
> +	acp62_writel(1, acp_base + ACP_SOFT_RESET);
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = acp62_readl(acp_base + ACP_SOFT_RESET);
> +		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
> +			break;
> +		cpu_relax();
> +	}
> +	acp62_writel(0, acp_base + ACP_SOFT_RESET);
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = acp62_readl(acp_base + ACP_SOFT_RESET);
> +		if (!val)
> +			return 0;
> +		cpu_relax();
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static void acp62_enable_interrupts(void __iomem *acp_base)
> +{
> +	acp62_writel(0x01, acp_base + ACP_EXTERNAL_INTR_ENB);

In function before you just write decimal 1 and 0, and here and later in 
patch you use hex values? Should probably be consistent.

> +}
> +
> +static void acp62_disable_interrupts(void __iomem *acp_base)
> +{
> +	acp62_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base +
> +		     ACP_EXTERNAL_INTR_STAT);
> +	acp62_writel(0x00, acp_base + ACP_EXTERNAL_INTR_CNTL);
> +	acp62_writel(0x00, acp_base + ACP_EXTERNAL_INTR_ENB);
> +}
> +
> +static int acp62_init(void __iomem *acp_base)
> +{
> +	int ret;
> +
> +	/* power on */
Unnecessary comment? Called function name is already self explanatory, 
no need to repeat it.
> +	ret = acp62_power_on(acp_base);
> +	if (ret) {
> +		pr_err("ACP power on failed\n");
> +		return ret;
> +	}
> +	acp62_writel(0x01, acp_base + ACP_CONTROL);
> +	/* Reset */
Same here?
> +	ret = acp62_reset(acp_base);
> +	if (ret) {
> +		pr_err("ACP reset failed\n");
> +		return ret;
> +	}
> +	acp62_writel(0x03, acp_base + ACP_CLKMUX_SEL);
> +	acp62_enable_interrupts(acp_base);
> +	return 0;
> +}
> +
> +static int acp62_deinit(void __iomem *acp_base)
> +{
> +	int ret;
> +
> +	acp62_disable_interrupts(acp_base);
> +	/* Reset */
Again
> +	ret = acp62_reset(acp_base);
> +	if (ret) {
> +		pr_err("ACP reset failed\n");
> +		return ret;
> +	}
> +	acp62_writel(0x00, acp_base + ACP_CLKMUX_SEL);
> +	acp62_writel(0x00, acp_base + ACP_CONTROL);
> +	return 0;
> +}
> +
>   static int snd_acp62_probe(struct pci_dev *pci,
>   			   const struct pci_device_id *pci_id)
>   {
> @@ -56,6 +154,10 @@ static int snd_acp62_probe(struct pci_dev *pci,
>   	}
>   	pci_set_master(pci);
>   	pci_set_drvdata(pci, adata);
> +	ret = acp62_init(adata->acp62_base);
> +	if (ret)
> +		goto release_regions;
> +
>   	return 0;
>   release_regions:
>   	pci_release_regions(pci);
> @@ -67,6 +169,13 @@ static int snd_acp62_probe(struct pci_dev *pci,
>   
>   static void snd_acp62_remove(struct pci_dev *pci)
>   {
> +	struct acp62_dev_data *adata;
> +	int ret;
> +
> +	adata = pci_get_drvdata(pci);
> +	ret = acp62_deinit(adata->acp62_base);
> +	if (ret)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
>   	pci_release_regions(pci);
>   	pci_disable_device(pci);
>   }

