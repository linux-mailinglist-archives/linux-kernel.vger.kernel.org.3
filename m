Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147FD52DA05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbiESQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiESQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:17:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F03D0289;
        Thu, 19 May 2022 09:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F899B8266C;
        Thu, 19 May 2022 16:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B3C385AA;
        Thu, 19 May 2022 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652977049;
        bh=U5yzL+CNoWVKrDgGlCP/DCVT+PIEOgDIgx3wiuOFGFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmkJc7DkBLA8Qi9GHuf+MM9b5EhJ2jIlhirBdaKWAyiWrfYywDdkgNDbMbJdlH4cb
         6g0LYLYPPm9WepowDFrdWTv3R/CdQXr4z3T+08Bj0z5rRSbYuqqSAOoHx1bhUwC6r9
         mirodZrKFOp3SITLWSeMwy1i3bYddIHct0nJo2Qw=
Date:   Thu, 19 May 2022 18:17:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] tty: n_gsm: fix user open not possible at
 responder until initiator open
Message-ID: <YoZtlq3RkNU56xFx@kroah.com>
References: <20220519070757.2096-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519070757.2096-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:07:49AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> After setting up the control channel on both sides the responder side may
> want to open a virtual tty to listen on until the initiator starts an
> application on a user channel. The current implementation allows the
> open() but no other operation, like termios. These fail with EINVAL.
> The responder sided application has no means to detect an open by the
> initiator sided application this way. And the initiator sided applications
> usually expect the responder sided application to listen on the user
> channel upon open.
> Set the user channel into half-open state on responder side once a user
> application opens the virtual tty to allow IO operations on it.
> Furthermore, keep the user channel constipated until the initiator side
> opens it to give the responder sided application the chance to detect the
> new connection and to avoid data loss if the responder sided application
> starts sending before the user channel is open.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> This commit was not changed as there have been no comments on it in v1.
> 
> Link: https://lore.kernel.org/all/20220506144725.1946-1-daniel.starke@siemens.com/
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index fd8b86dde525..08fea3e7674d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1493,6 +1493,8 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
>  	if (debug & 8)
>  		pr_debug("DLCI %d goes closed.\n", dlci->addr);
>  	dlci->state = DLCI_CLOSED;
> +	/* Prevent us from sending data before the link is up again */
> +	dlci->constipated = true;
>  	if (dlci->addr != 0) {
>  		tty_port_tty_hangup(&dlci->port, false);
>  		spin_lock_irqsave(&dlci->lock, flags);
> @@ -1522,6 +1524,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
>  	del_timer(&dlci->t1);
>  	/* This will let a tty open continue */
>  	dlci->state = DLCI_OPEN;
> +	dlci->constipated = false;
>  	if (debug & 8)
>  		pr_debug("DLCI %d goes open.\n", dlci->addr);
>  	/* Send current modem state */
> @@ -1602,6 +1605,25 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
>  	mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
>  }
>  
> +/**
> + *	gsm_dlci_wait_open	-	wait for channel open procedure
> + *	@dlci: DLCI to open
> + *
> + *	Wait for a DLCI opening from the other side. Asynchronously wait until
> + *	we get a SABM and set off timers and the responses.
> + */
> +static void gsm_dlci_wait_open(struct gsm_dlci *dlci)
> +{
> +	switch (dlci->state) {
> +	case DLCI_CLOSED:
> +	case DLCI_CLOSING:
> +		dlci->state = DLCI_OPENING;
> +		break;
> +	default:
> +		break;
> +	}
> +}

The documentation for this function is odd, you are not waiting for
anything.  You are just changing the state.  This makes no sense as-is,
sorry.

greg k-h
