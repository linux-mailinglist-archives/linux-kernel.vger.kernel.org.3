Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C91481B89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbhL3K4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhL3K4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:56:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:56:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A2661653
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEFEC36AEA;
        Thu, 30 Dec 2021 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640861796;
        bh=A2T/Y+Ql9k2bDuHwfMm6vLzaSZVqqfDo2M66dRFPWzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7ns7QvxczrnJAaIWB3vRy66toNLXSgpNTwLjtG2Ku8BIKW3wI+X4QAwwERQRAECJ
         Td6hiQUWaaKQHhyBxWT8yJ3NKkYBQntyUDX6PBzFAqnbTcpF01XY29XyL8aT99Qu0j
         oLQOtSbSv4/ZKi0yr938BwyOMtF7lj+F+wEZrgQU=
Date:   Thu, 30 Dec 2021 11:56:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: add comment to rx_lock mutex
 definition
Message-ID: <Yc2QYUcIAV2SY9JU@kroah.com>
References: <20211222215615.GA9361@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222215615.GA9361@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 10:56:15AM +1300, Paulo Miguel Almeida wrote:
> Checkpatch reports: CHECK: struct mutex definition without comment.
> Fix this by documenting what rx_mutex struct is used for in pi433 driver.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> v2: ellaborate on reasons why the mutex lock is used in the driver (Req: Greg k-h)
> v1: https://lore.kernel.org/lkml/20211222093626.GA13332@localhost.localdomain/
> ---
>  drivers/staging/pi433/pi433_if.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 29bd37669059..1cd3d5f2df2a 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -92,6 +92,17 @@ struct pi433_device {
>  	u32			rx_bytes_to_drop;
>  	u32			rx_bytes_dropped;
>  	unsigned int		rx_position;
> +	/*
> +	 * rx_lock is used to avoid race-conditions that can be triggered from userspace.
> +	 *
> +	 * For instance, if a program in userspace is reading the char device
> +	 * allocated in this module then another program won't be able to change RX
> +	 * configuration of the RF69 hardware module via ioctl and vice versa.
> +	 *
> +	 * utilization summary:
> +	 *  - pi433_read: blocks are read until rx read something (up to the buffer size)
> +	 *  - pi433_ioctl: during pending read request, change of config not allowed
> +	 */

This is nice, but way too specific, and will quickly get out-of-date.

How about something simple like:
	/* Protects all rx_* variable accesses */

thanks,

greg k-h
