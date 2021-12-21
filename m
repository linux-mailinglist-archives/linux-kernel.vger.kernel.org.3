Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87CC47BBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhLUISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhLUISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:18:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE010C061574;
        Tue, 21 Dec 2021 00:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D45EB80E07;
        Tue, 21 Dec 2021 08:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1161C36AE7;
        Tue, 21 Dec 2021 08:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640074708;
        bh=vrx6RPSDmWAICZO/O856wjjtSS7R7umwCZ+joXnTXy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2fbqHayxI5zE8rz7XssFncNFlkheTrC0qEaUpbufP9D9nhnmrUkTSTw4Fd3KzNzw
         XvDaug56XhG1VsIE0IDzOOaRQiMo3IR70nij7cfM1Gse1OCuIQ72t7al9hpTAAoPXG
         EmRiiBLfpv7UZXc9K41Jl5l0+8LPNyGRwQhRcf6g=
Date:   Tue, 21 Dec 2021 09:18:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3] tty: rpmsg: Fix race condition releasing tty port
Message-ID: <YcGN0fDn2hqAdrP9@kroah.com>
References: <20211215153121.30010-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215153121.30010-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 04:31:21PM +0100, Arnaud Pouliquen wrote:
> The tty_port struct is part of the rpmsg_tty_port structure.
> The issue is that the rpmsg_tty_port structure is freed on
> rpmsg_tty_remove while it is still referenced in the tty_struct.
> Its release is not predictable due to workqueues.
> 
> For instance following ftrace shows that rpmsg_tty_close is called after
> rpmsg_tty_release_cport:
> 
>      nr_test.sh-389     [000] .....   212.093752: rpmsg_tty_remove <-rpmsg_dev_
> remove
>              cat-1191    [001] .....   212.095697: tty_release <-__fput
>       nr_test.sh-389     [000] .....   212.099166: rpmsg_tty_release_cport <-rpm
> sg_tty_remove
>              cat-1191    [001] .....   212.115352: rpmsg_tty_close <-tty_release
>              cat-1191    [001] .....   212.115371: release_tty <-tty_release_str
> 
> As consequence, the port must be free only when user has released the TTY
> interface.
> 
> This path :
> - Introduce the .destruct port ops function to release the allocated
>   rpmsg_tty_port structure.
> - Manages the tty port refcounting to trig the .destruct port ops,
> - Introduces the rpmsg_tty_cleanup function to ensure that the TTY is
>   removed before decreasing the port refcount.
> - Uses tty_vhangup and tty_port_hangup instead of tty_port_tty_hangup.

Shouldn't this hangup change be a separate change?

> 
> Fixes: 7c0408d80579 ("tty: add rpmsg driver")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> delta vs V2: taking into account Jiri Slaby's comments:
>  - Inline rpmsg_tty_release_cport in rpmsg_tty_destruct_port,
>  - call tty_port_put in case of error in rpmsg_tty_probe,
>  - use tty_port_get port return in rpmsg_tty_install to take into account
>    NULL port return case.
> 
> Applied and tested on fa55b7dcdc43 ("Linux 5.16-rc1", 2021-11-14)
> ---
>  drivers/tty/rpmsg_tty.c | 49 +++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> index dae2a4e44f38..cdc590c63f03 100644
> --- a/drivers/tty/rpmsg_tty.c
> +++ b/drivers/tty/rpmsg_tty.c
> @@ -50,10 +50,21 @@ static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len, void *p
>  static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>  {
>  	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> +	struct tty_port *port = tty->port;
>  
>  	tty->driver_data = cport;
>  
> -	return tty_port_install(&cport->port, driver, tty);
> +	port = tty_port_get(&cport->port);
> +	return tty_port_install(port, driver, tty);
> +}
> +
> +static void rpmsg_tty_cleanup(struct tty_struct *tty)
> +{
> +	struct tty_port *port = tty->port;
> +
> +	WARN_ON(!port);

How can this ever trigger?  Shouldn't you do something if it can?

thanks,

greg k-h
