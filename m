Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150F34740A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhLNKmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:42:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:12164 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhLNKml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639478561; x=1671014561;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=k6ZD6Mq3KcmcQkn7Bmfs9r1wBk3xW7vepalZr36D/9U=;
  b=lD4jPRq7zK0DxL3lmPWGgiY20Qfn/5FOOTIqPgkRClHMjzUUeWWLqPZX
   5276F8+NYFzf1prT2X4Lk1xgVerlJI3sR43hrn1O/d4p5DxSBS5cxIapq
   KPwJ+ZORytiUEbswm+ib75l2A/pILZdjncImxe7uSib0b6E5BetQKvWE0
   /Xh/2MTotUjjWWB8vZuUk3rfk83962VrZzTcz4wd2n4z5G7hn5Qo7vGQ4
   Xpe6eZgLxUdM365Ub2NNWslT7yXd8zM02BlPBh42usmC27gDs/H0V6etr
   hK7ch2h4emtqKshVnLcD5/YfR2jssfB7zNxyPwgH+d8NYBnJrpcRdIQXS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="239174582"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="239174582"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 02:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465030400"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 02:42:21 -0800
Subject: Re: [PATCH v2 2/2] mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO
 reads as 32-bit reads.
To:     Hector Martin <marcan@marcan.st>,
        Ben Chuang <benchuanggli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211212070210.141664-1-marcan@marcan.st>
 <20211212070210.141664-3-marcan@marcan.st>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bd1387bf-f549-61f0-4498-7c79552af024@intel.com>
Date:   Tue, 14 Dec 2021 12:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211212070210.141664-3-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 09:02, Hector Martin wrote:
> For some reason, <32-bit reads do not work on Apple ARM64 platforms with
> these chips (even though they do on other PCIe devices). Issue them as
> 32-bit reads instead. This is done unconditionally, as it shouldn't hurt
> even if not necessary.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ad742743a494..c6828e84db31 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -906,7 +906,28 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  	return 0;
>  }
>  
> +#define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)
> +
> +static u16 sdhci_gli_readw(struct sdhci_host *host, int reg)
> +{
> +	u32 val = readl(host->ioaddr + (reg & ~3));
> +	u16 word;
> +
> +	word = (val >> REG_OFFSET_IN_BITS(reg)) & 0xffff;
> +	return word;
> +}
> +
> +static u8 sdhci_gli_readb(struct sdhci_host *host, int reg)
> +{
> +	u32 val = readl(host->ioaddr + (reg & ~3));
> +	u8 byte = (val >> REG_OFFSET_IN_BITS(reg)) & 0xff;
> +
> +	return byte;
> +}
> +
>  static const struct sdhci_ops sdhci_gl9755_ops = {
> +	.read_w			= sdhci_gli_readw,
> +	.read_b			= sdhci_gli_readb,
>  	.set_clock		= sdhci_gl9755_set_clock,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -926,6 +947,8 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
>  };
>  
>  static const struct sdhci_ops sdhci_gl9750_ops = {
> +	.read_w			= sdhci_gli_readw,
> +	.read_b			= sdhci_gli_readb,
>  	.read_l                 = sdhci_gl9750_readl,
>  	.set_clock		= sdhci_gl9750_set_clock,
>  	.enable_dma		= sdhci_pci_enable_dma,
> 

