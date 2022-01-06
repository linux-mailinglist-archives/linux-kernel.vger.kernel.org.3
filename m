Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6CE486960
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiAFSHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbiAFSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:07:03 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8D2C061245;
        Thu,  6 Jan 2022 10:07:03 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so4004356otg.2;
        Thu, 06 Jan 2022 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kIN2rJ0QveAJsz4ovJWUBi8fFD9lV5F+WhARVVzNc4s=;
        b=SjUkBtQP7PinEH0y4uRuE2E/A70KeOuHWX+NqToUwMOrAaNiIAs4rr1Xjjp04OwuXG
         LO61GvSB2TWniKkm/OXDp+NSSxfpsY7RkxiH/qaZDn8tUFMv++GTjZ4NXZe8CFFMX73D
         i86EDccL2P+Ob7jyuQ09Hbii4zsccH+iSvHHw8gvTTbUGxGMRxKvgMKAz2TEPLeX5ekI
         BreQivNrdtJsLyA/XtHg8Oc6cy/fTv3x6KBc257yQUPvZF6FOQ+p9uo5Hs86K9yoHRl1
         iktKbNSPGhLEM7OwvjBb2EdAVvX0cl6SABWFWAbZ7LNuGWtdurNUIg+QPGDy7fCu/Mw9
         3KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kIN2rJ0QveAJsz4ovJWUBi8fFD9lV5F+WhARVVzNc4s=;
        b=5s/ZmjbG+vIjMIrPo2QSRVxH0BL4SAZj4Mb+dSAc34YVKvs4E4yhnH1YV2O/G8Ssi5
         12Zvzfj2adIy9QQ5TWrzdMGZzH0d4IydTYIjgqbF+r2jrqxvuENX51ZiDPvy7kKwlRSP
         An/T9fQwcMm22qypQgUIm5CntHv03yhPeG9Ctav11axbRgr8S+2TjTAeQZhMadSbLqrW
         f308ntK0tqC8AE06OwT3QuRlSPtSbh4KOJLEXQ3f3zh2HxFJ+0cioPv6yMAZ2JSapwbv
         TD3YMSWcyVeRChUjq5KLUsLN+sOag98O6lfs49GbDXRHyvak6meS3ocmWTem8qtr+QqY
         eQTw==
X-Gm-Message-State: AOAM533RW7wTOT4G+3MNac4jaPXBvZ/aCe+ULtEEcQPCRdUbKHJCWZCz
        rhDlftlrQRK94fng6ZoQXR1Bv8GKOgo=
X-Google-Smtp-Source: ABdhPJyfbrXOSFfWk7eeVbsUO3bPcLYPJdDJB0V/fROvvg3TBgITIeefRqHjYkEMB0Z1+RKHQy0cCg==
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr44075687otu.254.1641492422373;
        Thu, 06 Jan 2022 10:07:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13sm503933oil.42.2022.01.06.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:07:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Jan 2022 10:07:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     linux-watchdog@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        ssg.sos.patches@amd.com, sudheesh.mavila@amd.com
Subject: Re: [PATCH v2 3/4] Watchdog: sp5100_tco: Add EFCH SMBus controller
 initialization using MMIO
Message-ID: <20220106180700.GA4187021@roeck-us.net>
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

git complains about an empty line at the end of file when
applying this patch.

Guenter
