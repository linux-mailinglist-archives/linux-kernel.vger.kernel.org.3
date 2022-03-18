Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6D4DDA23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiCRNIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiCRNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:08:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F22241CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96F8FB82339
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8FAC340E8;
        Fri, 18 Mar 2022 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647608821;
        bh=1+FGMiZIMnO/PtgJ9+9szNYYRdwNfhYrmezJRHVz2qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVYp2/aFhrtwZgyUXZJYFU/8agGpwQVujuvMKIIiQf/CBRRoTTzIqBUb3xGanVHvR
         GjNCPsTnKTwTH6qz8qnddSmxpEaS4T3T/2dJrmdGHyvr++P1TvbYV7tG+EVjjnf+xD
         186i4jPBzVlDayjuA5UzNcKatWCmWL8l4XPehLRA=
Date:   Fri, 18 Mar 2022 14:06:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Vogel <vogelchr@vogel.cx>
Cc:     linux-kernel@vger.kernel.org, zbr@ioremap.net
Subject: Re: [PATCH 2/2] w1/ds2490: remove dump from ds_recv_status & less
 verbose
Message-ID: <YjSD8us/T3eHDwB2@kroah.com>
References: <20220311192833.1792-1-vogelchr@vogel.cx>
 <20220311192833.1792-3-vogelchr@vogel.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311192833.1792-3-vogelchr@vogel.cx>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 08:28:33PM +0100, Christian Vogel wrote:
> The ds_recv_status function has a "dump" parameter that is used only
> once, and mixes in extremely verbose debugging to the kernel log with
> fetching the status registers.
> 
> Removing the logging from ds_recv_status(), making logging explitic at
> the one place where it was used. Also decoding of the status register
> is turned off by default, and a module parameter added to re-enable.
> 
> Signed-off-by: Christian Vogel <vogelchr@vogel.cx>
> ---
>  Documentation/w1/masters/ds2490.rst |  7 +++++++
>  drivers/w1/masters/ds2490.c         | 28 +++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/w1/masters/ds2490.rst b/Documentation/w1/masters/ds2490.rst
> index 7e5b50f9c0f5..8aa455627aad 100644
> --- a/Documentation/w1/masters/ds2490.rst
> +++ b/Documentation/w1/masters/ds2490.rst
> @@ -70,3 +70,10 @@ Notes and limitations.
>    or the host OS and more likely the host OS.
>  
>  03-06-2008 David Fries <David@Fries.net>
> +
> +Kernel Parameter
> +----------------
> +
> +A kernel parameter verbose_dump=1 can be added to make the module
> +decode the status register on errors in a very verbose way. By default
> +this verbose decode is turned off.
> diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
> index f6664fc9596a..354a35726967 100644
> --- a/drivers/w1/masters/ds2490.c
> +++ b/drivers/w1/masters/ds2490.c
> @@ -120,6 +120,10 @@
>  #define EP_DATA_OUT			2
>  #define EP_DATA_IN			3
>  
> +static int verbose_dump;
> +module_param(verbose_dump, int, 0644);
> +MODULE_PARM_DESC(verbose_dump, "Generate a very verbose dump of the status registers on errors.");
> +
>  struct ds_device {
>  	struct list_head	ds_entry;
>  
> @@ -222,6 +226,9 @@ static void ds_dump_status(struct ds_device *dev, unsigned char *buf, int count)
>  	dev_info(&dev->udev->dev, "ep_status=0x%x, count=%d, status=%*phC",
>  		dev->ep[EP_STATUS], count, count, buf);
>  
> +	if (!verbose_dump)
> +		return;
> +

Please just turn all of these dev_info() lines into dev_dbg() and then
the kernel-wide dynamic debugging logic will be used instead of a custom
module parameter.

thanks,

greg k-h
