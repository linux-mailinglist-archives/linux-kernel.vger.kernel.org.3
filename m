Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40249F6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243320AbiA1KMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiA1KMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:12:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A382C061714;
        Fri, 28 Jan 2022 02:12:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28FC261E35;
        Fri, 28 Jan 2022 10:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6C8C340E0;
        Fri, 28 Jan 2022 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643364722;
        bh=6rQJDoEfOTyNhnq1L4xauHiwGg7CtJuOe5wXI7Bu8mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVh5tmzNHmEgqhEx2EJvWW1anevruUpbGT5vx7qQHVweuxdOCK5RPdpDpXlQgy8eJ
         ZJOY0xPDe0o1/LQKEYZqgGNYikmnroEVnsnwtzZNXi0Sa9iuTrNbs62dp688F1iNyL
         qErpfsIqfduXy/igLYR2pPjulHvA00AfUOpcfTNg=
Date:   Fri, 28 Jan 2022 11:11:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
Message-ID: <YfPBb4gHDkr76xPT@kroah.com>
References: <20220124164525.53068-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124164525.53068-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:45:25AM +0800, Zhou Qingyang wrote:
> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
> there is a dereference of it right after that, which could introduce a
> NULL pointer dereference bug.
> 
> Fix this by adding a NULL check of ap->ops.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---

As stated in the past, please do not make contributions to the Linux
kernel until umn.edu has properly resolved its development issues.

> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/ata/pata_platform.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index 028329428b75..021ef9cbcbc1 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
> @@ -128,6 +128,8 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>  	ap = host->ports[0];
>  
>  	ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
> +	if (ap->ops)
> +		return -ENOMEM;

This change seems to leak memory.  Damien, please revert it.

thanks,

greg k-h
