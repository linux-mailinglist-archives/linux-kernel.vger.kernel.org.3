Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9149D158
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbiAZSCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:02:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57404 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiAZSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:02:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56C5DB81EA3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7589EC340E7;
        Wed, 26 Jan 2022 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643220149;
        bh=AiX+hvOYWgbA+Mt9TrYxXVNB/AScaEEn/BB/TGNZJxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPtsvkuV4I8ipT4ElE71TA+29vkdME9gmXphrDb2U7PNTtBciaMSZ9s+53FLm4fQZ
         DZ4aohz5dI20tAVXgPWfLEISUVmR590umadFM/ymmeqmDLthdwI9QTKY6UCfNl7ZL1
         7tJrmb4ZduQV7iGXM1UMAenJr9FPhpFY6rk5pj64=
Date:   Wed, 26 Jan 2022 19:02:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alfasys <alfred@alfasys.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>
Subject: Re: [PATCH 001/001] UIO: allow binding uio_dmem_genirq to devices
 using command line options
Message-ID: <YfGMsujnTxIxlXp4@kroah.com>
References: <qFul607Amxy21SnrHljzWlk1zF1aanKgSpEIH0--hvj9t9wRzQR5xx80eFgl_2I6pppi8NNFp0TTHwkQw0uQD0Xl-8vth8-KOsbfwrLIHNg=@alfasys.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qFul607Amxy21SnrHljzWlk1zF1aanKgSpEIH0--hvj9t9wRzQR5xx80eFgl_2I6pppi8NNFp0TTHwkQw0uQD0Xl-8vth8-KOsbfwrLIHNg=@alfasys.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 04:42:02PM +0000, Alfasys wrote:
> Add an option to bind the uio_dmem_genirq driver to a given device
> using command line options.
> Make uio_dmem_genirq match uio_pdrv_genirq functionality added in
> commit 05c3e0bb5629 ("UIO: allow binding uio_pdrv_genirq.c to devices 
> 
> using command line option")
> 
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> Signed-off-by: Alfred Patriksson <alfred@alfasys.se>
> 
> ---
> 
> git diff c9e6606c7fe92 #(tag: v5.16-rc8)
> diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
> index 6b5cfa5b0673..7f6c9b594dd4 100644
> --- a/drivers/uio/uio_dmem_genirq.c
> +++ b/drivers/uio/uio_dmem_genirq.c
> @@ -317,10 +317,13 @@ static const struct dev_pm_ops uio_dmem_genirq_dev_pm_ops = {
>  };
>  
> 
>  #ifdef CONFIG_OF
> -static const struct of_device_id uio_of_genirq_match[] = {
> -       { /* empty for now */ },
> +static struct of_device_id uio_of_genirq_match[] = {
> +       { /* This is filled with module_parm */ },
> +       { /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
> +module_param_string(of_id, uio_of_genirq_match[0].compatible, 128, 0);
> +MODULE_PARM_DESC(of_id, "Openfirmware id of the device to be handled by uio");

I do not want to add new module parameters, this is not the 1990's
anymore.

thanks,

greg k-h
