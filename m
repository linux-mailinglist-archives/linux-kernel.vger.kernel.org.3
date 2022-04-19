Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B850685A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350502AbiDSKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiDSKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:10:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6EB252AF;
        Tue, 19 Apr 2022 03:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF3DEB81627;
        Tue, 19 Apr 2022 10:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D01C385A7;
        Tue, 19 Apr 2022 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650362881;
        bh=FjxRCysP6yTIk1x7vANf2A1RzUXNvS9mtcdGzeeB6nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QU247mMeSQ23g3HQacDRvoeJkCJgi5V4D1BeJQIPFddG3qc0hupibdpuvDR3cx1du
         nrS/ZsH5ylFQfhwJRYzMTVSG9/MGkrlSWEPCUN37wXhK0LGfILcllEnF+fN+7iZRFG
         yxyqEKbLdeoVDYMRbTQkjdKKaOxsJsILq2DxxKTA=
Date:   Tue, 19 Apr 2022 12:07:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/20] tty: n_gsm: fix missing update of modem
 controls after DLCI open
Message-ID: <Yl6J/vUZrIUEZoMg@kroah.com>
References: <YlkQ5Jh8HIm+AJHe@kroah.com>
 <20220419080724.5726-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419080724.5726-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:07:24AM -0700, D. Starke wrote:
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
>  drivers/tty/n_gsm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index f3fb66be8513..07d03447cdfd 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -370,6 +370,7 @@ static const u8 gsm_fcs8[256] = {
>  #define GOOD_FCS	0xCF
>  
>  static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
> +static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk);
>  
>  /**
>   *	gsm_fcs_add	-	update FCS
> @@ -1479,6 +1480,9 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
>  		pr_debug("DLCI %d goes open.\n", dlci->addr);
>  	/* Register gsmtty driver,report gsmtty dev add uevent for user */
>  	tty_register_device(gsm_tty_driver, dlci->addr, NULL);
> +	/* Send current modem state */
> +	if (dlci->addr)
> +		gsmtty_modem_update(dlci, 0);
>  	wake_up(&dlci->gsm->event);
>  }
>  
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
