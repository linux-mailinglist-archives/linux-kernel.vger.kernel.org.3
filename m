Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE446E662
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhLIKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:14:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47254 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhLIKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:14:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5936B82410;
        Thu,  9 Dec 2021 10:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA0AC004DD;
        Thu,  9 Dec 2021 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639044654;
        bh=GVvjYM00aJP8zDx6WCbRh2XIzr6kU99AH7W9x3Je8wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ui76EfrvGoYxkELNF/UznUbMuIYkyuE3v5yAhuKYBhm3mvdycXSd0h/9IgNvazBGD
         A8ph90F7Sqk3lbWfrD2oVvc1LmutStNhcvjOBzMj4Wq8si+bFW4ZIoica6PZL6LTOr
         0wFOppcjxWmGkjB8WyYXcu0SEjI8QP7mpqqTPeBI=
Date:   Thu, 9 Dec 2021 11:10:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Subject: Re: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <YbHWKx6AU4z/TJS1@kroah.com>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:58:09PM +0800, Tony Huang wrote:
> +	while (1) {
> +		if (p_iop_reg->iop_data7 == 0xaaaa)
> +			break;
> +	}

You can not create a loop that could never exit.  Please fix.

Also, what prevents the compiler from optimizing this away into nothing?
This code does not look correct at all.

> +
> +	writel(0xdd, &p_iop_reg->iop_data1);//8051 bin file call Ultra low function.
> +	mdelay(10);
> +}
> +
> +static int  sp_iop_get_normal_code(struct device *dev, struct sp_iop *iop)
> +{
> +	const struct firmware *fw;
> +	static const char file[] = "normal.bin";
> +	unsigned int err, i;
> +
> +	dev_info(dev, "normal code\n");

Please always delete your debugging code before submitting a patch.

Also, please run checkpatch.pl on your changes before submitting them.

thanks,

greg k-h
