Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0258B46E84B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhLIMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhLIMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:23:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95BC061746;
        Thu,  9 Dec 2021 04:19:53 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 8so5280101pfo.4;
        Thu, 09 Dec 2021 04:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=og+qCz5A3ha24/ANK8rg1/6Ba06Ku8qUmtp+0PbKslc=;
        b=pAIE3CG+3RqxsmtrkZHa5rZNPLxZbB8wRuGwbHixNL1A6xOkw6bfAvDiciD8xrWV6u
         rEgamR/nohyyqiABrA8RXuNak76NfsrUwbklsfR9zH22P8UfIspSoeVEPITXqxXfIWIJ
         4ZnYUO5n9LgFBjG3zBNUHArBuMDoKmwVt3lwl6rXbXtwn3ygI6kKQDB9/rpIxZcA1GCb
         ce4RYyuzw4b0sjCwQHNJRQAudHNgWlunvFYOqiRENJg+gc4G16OWOV+MRI2tqclQ+xLf
         2EFf2QRpgSIqgkaAm2gN0AGkPYU+lEihrIFMTjHcci9vTz+aPgsPrhqDfrTFPi8frQf/
         Z0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=og+qCz5A3ha24/ANK8rg1/6Ba06Ku8qUmtp+0PbKslc=;
        b=GjmydhOKBKLXjvHVge4o28H7t5WnuYp7/6N+XgY7m+eCTJUS+E/ffxbhNnNICbQ8Qa
         b80ZJD16fI1x5PyhD76fsB2oXi35ZZUQSTXwzb4E/q0VqKkCDqKdXY70q2AexAo1ILtS
         uGpLtggbtrHjTCWmdZRzLaxV3lk7bhijuMWt7sqg1cmLZ2wz7jjeqSkVwDtF6tA5RUFI
         /tdIXUAz32RE3B1iOUeEZO+L3sxrxZkCUHMZiocNfe5b+VuybPLaGnMPZxMaWTJgVfpH
         OQbhS3obKInSEH5rrODgRa6pAV6q9fSwqksnTpN+5lPY0KE560Z2xV3uRjenm5EY27rg
         GYAg==
X-Gm-Message-State: AOAM532QVBRZfbzYHT8bNVA+4fRm+nrmQoHu/Zq3PnfwcCtzdpEh1+Ja
        9gnfz1L0be6uDua9DIvBNac=
X-Google-Smtp-Source: ABdhPJwqPLhHIccBffFOCfv9vyulpCCuapxqxIZFVgwuT1qRRHjD+o3RdavrNuTqZuh7wPEjLzZ+cQ==
X-Received: by 2002:a63:565d:: with SMTP id g29mr34603949pgm.245.1639052392702;
        Thu, 09 Dec 2021 04:19:52 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id h186sm7084523pfg.59.2021.12.09.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:19:52 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     marcan@marcan.st
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, maz@kernel.org, sven@svenpeter.dev,
        ulf.hansson@linaro.org, benchuanggli@gmail.com
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: GL9755: Issue 8/16-bit MMIO reads as 32-bit reads.
Date:   Thu,  9 Dec 2021 20:19:49 +0800
Message-Id: <20211209121949.61135-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211207064019.61444-3-marcan@marcan.st>
References: <20211207064019.61444-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On Tue,  7 Dec 2021 15:40:19 +0900, Hector Martin <marcan@marcan.st> wrote:
>
> For some reason, <32-bit reads do not work on Apple ARM64 platforms with
> these chips (even though they do on other PCIe devices). Issue them as
> 32-bit reads instead. This is done unconditionally, as it shouldn't hurt
> even if not necessary.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ad742743a494..31547fed0952 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -906,7 +906,26 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  	return 0;
>  }
>  
> +#define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)
> +
> +static u16 sdhci_gli_readw(struct sdhci_host *host, int reg)
> +{
> +	u32 val = readl(host->ioaddr + (reg & ~3));
> +	u16 word;
> +	word = (val >> REG_OFFSET_IN_BITS(reg)) & 0xffff;

checkpatch says "
WARNING: Missing a blank line after declarations
#71: FILE: drivers/mmc/host/sdhci-pci-gli.c:915:
+	u16 word;
+	word = (val >> REG_OFFSET_IN_BITS(reg)) & 0xffff;
"

> +	return word;
> +}
> +
> +static u8 sdhci_gli_readb(struct sdhci_host *host, int reg)
> +{
> +	u32 val = readl(host->ioaddr + (reg & ~3));
> +	u8 byte = (val >> REG_OFFSET_IN_BITS(reg)) & 0xff;
> +	return byte;
> +}
> +
>  static const struct sdhci_ops sdhci_gl9755_ops = {
> +	.read_w			= sdhci_gli_readw,
> +	.read_b			= sdhci_gli_readb,

I think GL9750 also need this patch. 
Can you help to add these two functions to sdhci_gl9750_ops?

Best regards,
Ben

>  	.set_clock		= sdhci_gl9755_set_clock,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,
> -- 
> 2.33.0
