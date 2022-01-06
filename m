Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3B48699B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbiAFSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiAFSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:18:12 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89BC061245;
        Thu,  6 Jan 2022 10:18:12 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id t13-20020a4a760d000000b002dab4d502dfso859216ooc.6;
        Thu, 06 Jan 2022 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PMSMkWEPDQ2oSh7sUWVHmcEarJbHBfWQuR5lIshW6tY=;
        b=LULwuzjshD+Oc+0TxcWyiwZsq2ionPHXdxJWDahOfAwxXIyKJPSee6jTvFb3gRuxVR
         zy4NwzR59VLArTvmgncoykA5FLgAlZPxo0Gmh68sLRgvVnVnRCc6Rcposk14fA3EAhvK
         RKpc1jRHxaq1qA/VsHb6HoJ9y/ej8dE7bFj/ZwVf9kD6kZvxSXVIKcKP4VpW6r/3PorV
         0hhbyMUPiREhYofuHJInGeC+Uq/IpR/3KEOKM5esjI/wlUHLwG+gWjDUkxVYj/LoA+lI
         tkITK4VDXZYUNIzXBRYOyMUieECuSoxWcjgyyW+hPb04QiGiUohqAxVh7MNsU7Z/Lzcn
         KjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PMSMkWEPDQ2oSh7sUWVHmcEarJbHBfWQuR5lIshW6tY=;
        b=NKBsnZOagqg3SRrS4dUG2OORqP3qfoQDEFK3jzcdSW9kFP5E61Bi9BEUJOcZ8fu8nL
         vvA9bFtMa5RemTajEzmrczShgmi7I+nQiib2/wMbnfggsl/KPO3TMhF5/UjhzaDKM0r2
         lgyHEDVKXigvz4mCuRDoDKAeXm3M1V6oCg+HWcQzDctJJiQfA5FKMtZfT8tJ6mRS8a1x
         Er6NlmtkyEfJ1lpBJe8tbC5ZKjSClJHhM6SpNJPeXf7VdVJ1H94seWh9cawGC3FlK3va
         IF6ndkzV4NyVp3nZUPd6pI0a7YvEzM2cH+I5CAYMduT+2cj456oA2lXm85LcJEr/hPYa
         /3Jw==
X-Gm-Message-State: AOAM533SYT3MbsY3AZ1O5EPHt8cvahbDQAV/SfTFZg1r4Jq0Km3HY0Sm
        fWfPaE24b6UtWGSQoB/yxsnAu9R4hYI=
X-Google-Smtp-Source: ABdhPJxrwEbRfRzEuI2N+1b1/yVXAfyZ8tcNx10ArFVMGdLkxi38IVa89OY2t48nJyK9Nfe4cu6w0w==
X-Received: by 2002:a4a:4516:: with SMTP id y22mr3891387ooa.70.1641493091896;
        Thu, 06 Jan 2022 10:18:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm489069oic.37.2022.01.06.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:18:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Jan 2022 10:18:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     linux-watchdog@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        ssg.sos.patches@amd.com, sudheesh.mavila@amd.com
Subject: Re: [PATCH v2 3/4] Watchdog: sp5100_tco: Add EFCH SMBus controller
 initialization using MMIO
Message-ID: <20220106181809.GA240027@roeck-us.net>
References: <20211103161521.43447-1-terry.bowman@amd.com>
 <20211103161521.43447-4-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103161521.43447-4-terry.bowman@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:15:20AM -0500, Terry Bowman wrote:
> cd6h/cd7h port I/O can be disabled on recent AMD hardware. Read accesses to
> disabled cd6h/cd7h port I/O will return F's and written data is dropped.
> 
> The recommended workaround to handle disabled cd6h/cd7h port I/O is
> replacing port I/O with MMIO accesses. The MMIO access method has been
> available since at least SMBus controllers using PCI revision 0x59.
> 
> The EFCH MMIO path is enabled in later patch.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> To: linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Robert Richter <rrichter@amd.com>
> ---
>  drivers/watchdog/sp5100_tco.c | 104 +++++++++++++++++++++++++++++++++-
>  drivers/watchdog/sp5100_tco.h |   6 ++
>  2 files changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 80ae42ae7aaa..4777e672a8ad 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -48,12 +48,14 @@
>  /* internal variables */
>  
>  enum tco_reg_layout {
> -	sp5100, sb800, efch
> +	sp5100, sb800, efch, efch_mmio
>  };
>  
>  struct sp5100_tco {
>  	struct watchdog_device wdd;
>  	void __iomem *tcobase;
> +	void __iomem *addr;
> +	struct resource *res;

I must admit that I really don't like this code. Both res and
addr are only used during initialization, yet their presence suggests
runtime usage. Any chance to reqork this to not require those variables ?

Guenter

>  	enum tco_reg_layout tco_reg_layout;
>  };
>  
> @@ -161,6 +163,59 @@ static void sp5100_tco_update_pm_reg8(u8 index, u8 reset, u8 set)
>  	outb(val, SP5100_IO_PM_DATA_REG);
>  }
>  
> +static int sp5100_request_region_mmio(struct device *dev,
> +				      struct watchdog_device *wdd)
> +{
> +	struct sp5100_tco *tco = watchdog_get_drvdata(wdd);
> +	struct resource *res;
> +	void __iomem *addr;
> +
> +	res = request_mem_region(EFCH_PM_ACPI_MMIO_PM_ADDR,
> +				 EFCH_PM_ACPI_MMIO_PM_SIZE,
> +				 "sp5100_tco");
> +
> +	if (!res) {
> +		dev_err(dev,
> +			"SMB base address memory region 0x%x already in use.\n",
> +			EFCH_PM_ACPI_MMIO_PM_ADDR);
> +		return -EBUSY;
> +	}
> +
> +	addr = ioremap(EFCH_PM_ACPI_MMIO_PM_ADDR,
> +		       EFCH_PM_ACPI_MMIO_PM_SIZE);
> +	if (!addr) {
> +		release_resource(res);
> +		dev_err(dev, "SMB base address mapping failed.\n");
> +		return -ENOMEM;
> +	}
> +
> +	tco->res = res;
> +	tco->addr = addr;
> +	return 0;
> +}
> +
> +static void sp5100_release_region_mmio(struct sp5100_tco *tco)
> +{
> +	iounmap(tco->addr);
> +	release_resource(tco->res);
> +}
> +
> +static u8 efch_read_pm_reg8(struct sp5100_tco *tco, u8 index)
> +{
> +	return readb(tco->addr + index);
> +}
> +
> +static void efch_update_pm_reg8(struct sp5100_tco *tco,
> +				u8 index, u8 reset, u8 set)
> +{
> +	u8 val;
> +
> +	val = readb(tco->addr + index);
> +	val &= reset;
> +	val |= set;
> +	writeb(val, tco->addr + index);
> +}
> +
>  static void tco_timer_enable(struct sp5100_tco *tco)
>  {
>  	u32 val;
> @@ -201,6 +256,12 @@ static void tco_timer_enable(struct sp5100_tco *tco)
>  					  ~EFCH_PM_WATCHDOG_DISABLE,
>  					  EFCH_PM_DECODEEN_SECOND_RES);
>  		break;
> +	case efch_mmio:
> +		/* Set the Watchdog timer resolution to 1 sec and enable */
> +		efch_update_pm_reg8(tco, EFCH_PM_DECODEEN3,
> +				    ~EFCH_PM_WATCHDOG_DISABLE,
> +				    EFCH_PM_DECODEEN_SECOND_RES);
> +		break;
>  	}
>  }
>  
> @@ -313,6 +374,44 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
>  	return 0;
>  }
>  
> +static int sp5100_tco_setupdevice_mmio(struct device *dev,
> +				       struct watchdog_device *wdd)
> +{
> +	struct sp5100_tco *tco = watchdog_get_drvdata(wdd);
> +	const char *dev_name = SB800_DEVNAME;
> +	u32 mmio_addr = 0, alt_mmio_addr = 0;
> +	int ret;
> +
> +	ret = sp5100_request_region_mmio(dev, wdd);
> +	if (ret)
> +		return ret;
> +
> +	/* Determine MMIO base address */
> +	if (!(efch_read_pm_reg8(tco, EFCH_PM_DECODEEN) &
> +	      EFCH_PM_DECODEEN_WDT_TMREN)) {
> +		efch_update_pm_reg8(tco, EFCH_PM_DECODEEN,
> +				    0xff,
> +				    EFCH_PM_DECODEEN_WDT_TMREN);
> +	}
> +
> +	if (efch_read_pm_reg8(tco, EFCH_PM_DECODEEN) &
> +	    EFCH_PM_DECODEEN_WDT_TMREN)
> +		mmio_addr = EFCH_PM_WDT_ADDR;
> +
> +	/* Determine alternate MMIO base address */
> +	if (efch_read_pm_reg8(tco, EFCH_PM_ISACONTROL) &
> +	    EFCH_PM_ISACONTROL_MMIOEN)
> +		alt_mmio_addr = EFCH_PM_ACPI_MMIO_ADDR +
> +			EFCH_PM_ACPI_MMIO_WDT_OFFSET;
> +
> +	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name);
> +	if (!ret)
> +		ret = sp5100_tco_timer_init(tco);
> +
> +	sp5100_release_region_mmio(tco);
> +	return ret;
> +}
> +
>  static int sp5100_tco_setupdevice(struct device *dev,
>  				  struct watchdog_device *wdd)
>  {
> @@ -322,6 +421,9 @@ static int sp5100_tco_setupdevice(struct device *dev,
>  	u32 alt_mmio_addr = 0;
>  	int ret;
>  
> +	if (tco->tco_reg_layout == efch_mmio)
> +		return sp5100_tco_setupdevice_mmio(dev, wdd);
> +
>  	/* Request the IO ports used by this driver */
>  	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
>  				  SP5100_PM_IOPORTS_SIZE, "sp5100_tco")) {
> diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
> index adf015aa4126..73f179a1d6e5 100644
> --- a/drivers/watchdog/sp5100_tco.h
> +++ b/drivers/watchdog/sp5100_tco.h
> @@ -83,3 +83,9 @@
>  
>  #define EFCH_PM_ACPI_MMIO_ADDR		0xfed80000
>  #define EFCH_PM_ACPI_MMIO_WDT_OFFSET	0x00000b00
> +#define EFCH_PM_ACPI_MMIO_PM_OFFSET	0x00000300
> +
> +#define EFCH_PM_ACPI_MMIO_PM_ADDR	(EFCH_PM_ACPI_MMIO_ADDR +	\
> +					 EFCH_PM_ACPI_MMIO_PM_OFFSET)
> +#define EFCH_PM_ACPI_MMIO_PM_SIZE       8
> +
