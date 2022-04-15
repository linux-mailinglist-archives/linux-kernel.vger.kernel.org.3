Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008FC502597
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbiDOGcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiDOGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:32:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A83FD88;
        Thu, 14 Apr 2022 23:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEC64B82BF0;
        Fri, 15 Apr 2022 06:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065EAC385A6;
        Fri, 15 Apr 2022 06:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650004199;
        bh=psflDfKqWvAP0ydCreaP3PvJtpFOl3v8AIMyqapUG2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtaTYBIq2FZeUlOqOuoVkkrpzAe7DAZ+feUTWibqx7lujuGLlhs+U36JpzhuVccoJ
         gN1jWTB+fPbV9VEJsStX6FLuYf+UrBdOT/n6qkUfc5oR1prJGNDCinedGOLWlvzp5y
         js7f9zzM8NCw1YhJHUnZhNB6w84tIDlf+vsMGvmA=
Date:   Fri, 15 Apr 2022 08:29:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/20] tty: n_gsm: fix missing update of modem controls
 after DLCI open
Message-ID: <YlkQ5Jh8HIm+AJHe@kroah.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
 <20220414094225.4527-15-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414094225.4527-15-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:42:20AM -0700, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Currently the peer is not informed about the initial state of the modem
> control lines after a new DLCI has been opened.
> Fix this by sending the initial modem control line states after DLCI open.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index f3fb66be8513..e9a7d9483c1f 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -369,7 +369,11 @@ static const u8 gsm_fcs8[256] = {
>  #define INIT_FCS	0xFF
>  #define GOOD_FCS	0xCF
>  
> +/*
> + * Prototypes
> + */

We know they are prototypes, no need to say it :)

>  static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
> +static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk);
>  
>  /**
>   *	gsm_fcs_add	-	update FCS
> @@ -1479,6 +1483,8 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
>  		pr_debug("DLCI %d goes open.\n", dlci->addr);
>  	/* Register gsmtty driver,report gsmtty dev add uevent for user */
>  	tty_register_device(gsm_tty_driver, dlci->addr, NULL);
> +	if (dlci->addr) /* Send current modem state */
> +		gsmtty_modem_update(dlci, 0);

Please do not put comments at the end of a line like this.

thanks,

greg k-h
