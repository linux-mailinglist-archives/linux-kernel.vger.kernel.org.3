Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE847EDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352261AbhLXJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:30:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51606 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbhLXJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:30:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5891962022;
        Fri, 24 Dec 2021 09:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DB2C36AE8;
        Fri, 24 Dec 2021 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640338236;
        bh=pVnKU5E7H2niKq40NMElt1hFDNoOWaIizPhhyMx0ccU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dc3RnuebViZH1Jham/m5d7N0WhjVOJAUk5GCDqmltgDAK2Ot/ih34qtBOAm8hBhIq
         nIBlWHPaYVKecnf0YtuufHtHIBzG0ha2Cmm6k4Gt8vzEIQc+iY72BL2BxkrZc4JZPp
         REDXsofzBeN856XzjgsMZpmTctIgt02feDvSfTdU=
Date:   Fri, 24 Dec 2021 10:30:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, tony.huang@sunplus.com,
        wells.lu@sunplus.com
Subject: Re: [PATCH v5 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <YcWTME5BAkH9Z9cZ@kroah.com>
References: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
 <75e44cae76b74b16c1e178d2d6bb18a332179bc9.1640332430.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e44cae76b74b16c1e178d2d6bb18a332179bc9.1640332430.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 04:35:56PM +0800, Tony Huang wrote:
> IOP (IO Processor) embedded inside SP7021 which is used as
> Processor for I/O control, RTC wake-up and cooperation with
> CPU & PMC in power management purpose.
> The IOP core is DQ8051, so also named IOP8051,
> it supports dedicated JTAG debug pins which share with SP7021.
> In standby mode operation, the power spec reach 400uA.
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v5:
>  - Modify sysfs read/write function.
>  - Added gpio pin for 8051 wake up linux kernel. 
> 
>  Documentation/ABI/testing/sysfs-platform-soc@B |  18 +
>  MAINTAINERS                                    |   2 +
>  drivers/misc/Kconfig                           |  12 +
>  drivers/misc/Makefile                          |   1 +
>  drivers/misc/sunplus_iop.c                     | 481 +++++++++++++++++++++++++
>  5 files changed, 514 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-soc@B
>  create mode 100644 drivers/misc/sunplus_iop.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-soc@B b/Documentation/ABI/testing/sysfs-platform-soc@B
> new file mode 100644
> index 0000000..b0c54b5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-soc@B
> @@ -0,0 +1,18 @@
> +What:		/sys/devices/platform/soc@B/9c000400.iop/sp_iop_mailbox
> +Date:		December 2021
> +KernelVersion:	5.15

5.15 was alread released, this can not be added to older kernels.

> +Contact:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +Description:
> +		Show 8051 mailbox data.
> +
> +What:		/sys/devices/platform/soc@B/9c000400.iop/sp_iop_mode
> +Date:		December 2021
> +KernelVersion:	5.15
> +Contact:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +Description:
> +		Operation mode of IOP is switched to standby mode by writing
> +		"1" to sysfs.
> +		Operation mode of IOP is switched to normal mode by writing
> +		"0" to sysfs.

You are not documenting what reading these sysfs files show.  Remember,
sysfs is "one value per file" and it looks like you are printing out
many values in the same file:

> +static ssize_t sp_iop_mailbox_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sp_iop *iop = dev_get_drvdata(dev);
> +	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
> +	unsigned int MB0, MB1, MB2;
> +
> +	MB0 = readl(&p_iop_reg->iop_data0);
> +	MB1 = readl(&p_iop_reg->iop_data1);
> +	MB2 = readl(&p_iop_reg->iop_data2);
> +	return sprintf(buf, "MB0:0x%x MB1:0x%x MB2:0x%x\n", MB0, MB1, MB2);

That is a very odd "single value".

Also please use sysfs_emit().

> +static ssize_t sp_iop_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sp_iop *iop = dev_get_drvdata(dev);
> +
> +	if (iop->mode == 0)
> +		return sprintf(buf, "normal code\n");
> +	else
> +		return sprintf(buf, "standby code\n");

2 words?


