Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40E646753A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbhLCKmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:42:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47140 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351489AbhLCKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:42:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8102D629D6;
        Fri,  3 Dec 2021 10:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9A2C53FC7;
        Fri,  3 Dec 2021 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638527933;
        bh=CLitVH5zb9MwqVoZhQ8/XRZZIgxCxnB9Ir/NHCBc8qY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z33pSsyTQ3SA0v9jiuZTnq8XKTcuZ2lQJ76h4DUlNTbY1zA37Iwy3TCUJ31SScAp9
         KGiJjmnGDzuhybGMyjAK6mOorEpPKZ4rAQGs8Q6xhvUEbeLJn3+gC4FH3lcethW2DG
         HMX1Svp7BZgfcaNnxbefiHmJYY5sdCfZfW1zlbOs=
Date:   Fri, 3 Dec 2021 11:38:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Yanzu7/J75n/OCUY@kroah.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:48:45AM +0800, Tony Huang wrote:
> +#define NORMAL_CODE_MAX_SIZE 0X1000
> +#define STANDBY_CODE_MAX_SIZE 0x4000
> +unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
> +unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];

Please make your local variables static so that yhou do not polute the
kernel's global symbol table.

> +/* ---------------------------------------------------------------------------------------------- */
> +resource_size_t SP_IOP_RESERVE_BASE;
> +resource_size_t SP_IOP_RESERVE_SIZE;
> +/* ---------------------------------------------------------------------------------------------- */

Again, static.

And why the odd comment lines?

And those are not good variable names.

> +struct sp_iop {
> +	struct miscdevice dev;			// iop device
> +	struct mutex write_lock;
> +	void __iomem *iop_regs;
> +	void __iomem *pmc_regs;
> +	void __iomem *moon0_regs;
> +	int irq;
> +};
> +/*****************************************************************
> + *						  G L O B A L	 D A T A
> + ******************************************************************/

Global where?  What about the ones above?  :)

> +static struct sp_iop *iop;

Why do you think you only have one device in the system?  Please do not
use a single variable like this.  It is easy to make your driver handle
an unlimited number of devices just as easy as to handle 1 device.
Please do that instead and hang your device-specific data off of the
correct data structures that the driver core gives you.

> +
> +void iop_normal_mode(void)

Did you run sparse on this code?  Please do so.

Also, no need for a .h file for a driver that only has one .c file.

thanks,

greg k-h
