Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952AA48E719
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiANJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:07:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:29351 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbiANJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642151263; x=1673687263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P6a7MGar2Rg8ifSaUbEYyz7wwax7DUKswFAABctDBH4=;
  b=DGomPT6UEfrVQCgVgNEGn0KWdiZ3qbBeY3NpCaVTNUXtc5uLGbJIEhQd
   IOns877zfhRlt9vmBNwEHF5+JqQgfraelJpH+5aZSO545hIP6OMX1k1Nm
   7SBv8QSR68DzSCztDmRW8yXT+gp6vgd5HpH4455o37DXZnQwyY7cKEfQ8
   q4ZvBo7KJzeS8MVaOkqFXupcDJE9qyAnd8vuHqzYf93hG4B4ftwsdKQVm
   s2RvaDRrwOS0B+Paa1KFd1olAUzsIZnJOlJA9lLDENPSxP3BXG2TALsw8
   dV9ggJt6lxCLuYpBa3jgmeBqrDXjbI34JSnFIlzV/gGliCZmF0PnMzpAv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="330561939"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="330561939"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 01:07:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="475710448"
Received: from rjastrzx-mobl.ger.corp.intel.com (HELO [10.237.180.117]) ([10.237.180.117])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 01:01:45 -0800
Message-ID: <e815d582-bd7d-6ec0-05ca-97d633ef9e13@linux.intel.com>
Date:   Fri, 14 Jan 2022 10:01:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/6] ASoC: amd: acp: Add ACP init()/deinit() callback
 for Renoir.
Content-Language: en-US
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
 <20220113163348.434108-5-AjitKumar.Pandey@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220113163348.434108-5-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/2022 5:33 PM, Ajit Kumar Pandey wrote:
> ACP hardware has PGFSM control registers that can be configured to
> power On/Off the ACP IP block. Add acp init()/de_init() callbacks
> in renoir platform driver probe()/remove() respectively to power
> on and off ACP IP block on ACP3X device.
> 
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> ---
>   sound/soc/amd/acp/acp-renoir.c       | 170 +++++++++++++++++++++++++++
>   sound/soc/amd/acp/chip_offset_byte.h |   6 +
>   2 files changed, 176 insertions(+)
> 
> diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
> index 770a57a0677b..a29f910f25d1 100644
> --- a/sound/soc/amd/acp/acp-renoir.c
> +++ b/sound/soc/amd/acp/acp-renoir.c
> @@ -25,6 +25,19 @@
>   
>   #define DRV_NAME "acp_asoc_renoir"
>   
> +#define ACP_SOFT_RST_DONE_MASK	0x00010001
> +
> +#define ACP_PWR_ON_MASK		0x01
> +#define ACP_PWR_OFF_MASK	0x00
> +#define ACP_PGFSM_STAT_MASK	0x03
> +#define ACP_POWERED_ON		0x00
> +#define ACP_PWR_ON_IN_PROGRESS	0x01
> +#define ACP_POWERED_OFF		0x02
> +
> +
> +#define ACP_ERROR_MASK 0x20000000
> +#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
> +
>   static struct snd_soc_acpi_codecs amp_rt1019 = {
>   	.num_codecs = 1,
>   	.codecs = {"10EC1019"}
> @@ -112,11 +125,154 @@ static struct snd_soc_dai_driver acp_renoir_dai[] = {
>   },
>   };
>   
> +static int acp3x_power_on(void __iomem *base)
> +{
> +	u32 val;
> +	int timeout = 0;
> +
> +	val = readl(base + ACP_PGFSM_STATUS);
> +
> +	if (val == ACP_POWERED_ON)
> +		return 0;
> +
> +	if ((val & ACP_PGFSM_STAT_MASK) != ACP_PWR_ON_IN_PROGRESS)
> +		writel(ACP_PWR_ON_MASK, base + ACP_PGFSM_CONTROL);
> +
> +	while (++timeout < 500) {
> +		val = readl(base + ACP_PGFSM_STATUS);
> +		if (!val)
> +			return 0;
> +		udelay(1);
> +	}

Can this while loop perhaps be replaced with readl_poll_timeout?
Similarly for cases below?

> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int acp3x_power_off(void __iomem *base)
> +{
> +	u32 val;
> +	int timeout = 0;
> +
> +	writel(ACP_PWR_OFF_MASK, base + ACP_PGFSM_CONTROL);
> +
> +	while (++timeout < 500) {
> +		val = readl(base + ACP_PGFSM_STATUS);
> +		if ((val & ACP_PGFSM_STAT_MASK) == ACP_POWERED_OFF)
> +			return 0;
> +		udelay(1);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int acp3x_reset(void __iomem *base)
> +{
> +	u32 val;
> +	int timeout = 0;
> +
> +	writel(1, base + ACP_SOFT_RESET);
> +
> +	while (++timeout < 500) {
> +		val = readl(base + ACP_SOFT_RESET);
> +		if (val & ACP_SOFT_RST_DONE_MASK)
> +			break;
> +		cpu_relax();
> +	}
> +
> +	writel(0, base + ACP_SOFT_RESET);
> +
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = readl(base + ACP_SOFT_RESET);
> +		if (!val)
> +			return 0;
> +		cpu_relax();
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void acp3x_enable_interrupts(void __iomem *base)
> +{
> +	u32 ext_intr_ctrl;
> +
> +	writel(0x01, base + ACP_EXTERNAL_INTR_ENB);
> +	ext_intr_ctrl = readl(base + ACP_EXTERNAL_INTR_CNTL);
> +	ext_intr_ctrl |= ACP_ERROR_MASK;
> +	writel(ext_intr_ctrl, base + ACP_EXTERNAL_INTR_CNTL);
> +}
> +
> +static void acp3x_disable_interrupts(void __iomem *base)
> +{
> +	writel(ACP_EXT_INTR_STAT_CLEAR_MASK, base + ACP_EXTERNAL_INTR_STAT);
> +	writel(0x00, base + ACP_EXTERNAL_INTR_ENB);
> +}
> +
> +static int rn_acp_init(void __iomem *base)
> +{
> +	int ret;
> +
> +	/* power on */
> +	ret = acp3x_power_on(base);
> +	if (ret)
> +		return ret;
> +
> +	writel(0x01, base + ACP_CONTROL);
> +
> +	/* Reset */
> +	ret = acp3x_reset(base);
> +	if (ret)
> +		return ret;
> +
> +	acp3x_enable_interrupts(base);
> +
> +	return 0;
> +}
> +
> +static int rn_acp_deinit(void __iomem *base)
> +{
> +	int ret = 0;
> +
> +	acp3x_disable_interrupts(base);
> +
> +	/* Reset */
> +	ret = acp3x_reset(base);
> +	if (ret)
> +		return ret;
> +
> +	writel(0x00, base + ACP_CONTROL);
> +
> +	/* power off */
> +	ret = acp3x_power_off(base);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
>   static int renoir_audio_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	struct acp_chip_info *chip;
>   	struct acp_dev_data *adata;
>   	struct resource *res;
> +	int ret;
> +
> +	chip = dev_get_platdata(&pdev->dev);
> +	if (!chip || !chip->base) {
> +		dev_err(&pdev->dev, "ACP chip data is NULL\n");
> +		return -ENODEV;
> +	}
> +
> +	if (chip->acp_rev != ACP3X_DEV) {
> +		dev_err(&pdev->dev, "Un-supported ACP Revision %d\n", chip->acp_rev);
> +		return -ENODEV;
> +	}
> +
> +	ret = rn_acp_init(chip->base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "ACP Init failed\n");
> +		return -EINVAL;
> +	}
>   
>   	adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), GFP_KERNEL);
>   	if (!adata)
> @@ -155,6 +311,20 @@ static int renoir_audio_probe(struct platform_device *pdev)
>   static int renoir_audio_remove(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	struct acp_chip_info *chip;
> +	int ret;
> +
> +	chip = dev_get_platdata(&pdev->dev);
> +	if (!chip || !chip->base) {
> +		dev_err(&pdev->dev, "ACP chip data is NULL\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = rn_acp_deinit(chip->base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "ACP de-init Failed\n");
> +		return -EINVAL;
> +	}
>   
>   	acp_platform_unregister(dev);
>   	return 0;
> diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
> index e38589a142e9..88f6fa597cd6 100644
> --- a/sound/soc/amd/acp/chip_offset_byte.h
> +++ b/sound/soc/amd/acp/chip_offset_byte.h
> @@ -14,6 +14,12 @@
>   #define ACPAXI2AXI_ATU_CTRL                           0xC40
>   #define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_5                0xC20
>   #define ACPAXI2AXI_ATU_BASE_ADDR_GRP_5                0xC24
> +
> +#define ACP_PGFSM_CONTROL			0x141C
> +#define ACP_PGFSM_STATUS                        0x1420
> +#define ACP_SOFT_RESET                          0x1000
> +#define ACP_CONTROL                             0x1004
> +
>   #define ACP_EXTERNAL_INTR_ENB                         0x1800
>   #define ACP_EXTERNAL_INTR_CNTL                        0x1804
>   #define ACP_EXTERNAL_INTR_STAT                        0x1808

