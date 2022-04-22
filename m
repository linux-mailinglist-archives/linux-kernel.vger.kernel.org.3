Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE750BA20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448689AbiDVOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378396AbiDVOdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:33:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383533897;
        Fri, 22 Apr 2022 07:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A519CB82ED8;
        Fri, 22 Apr 2022 14:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DFFC385A4;
        Fri, 22 Apr 2022 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650637818;
        bh=yahbdoWlqHWHArEz9FYsLhjfCwUS5AlwO6ecbof4pGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQ9j6JoSQvx155lNlUs0nMAeUFOVIYq6XBgVzRouD4jQjZA3TeODJbPyzuDZpsvgk
         2lQn8cw89dVEtwNdDduKc7DFxBQ8iq5blKn59UB2fvltrwRvoiuaqz0woKWDD1J64c
         Ux2q0bga4dOuCCqlHEo1Lkm6sINFWyo8ERVqzrjk=
Date:   Fri, 22 Apr 2022 16:30:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 2/5] tty: Simplify receive flow control char logic
Message-ID: <YmK796AkXmoSb5fZ@kroah.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
 <20220411094859.10894-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411094859.10894-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:48:56PM +0300, Ilpo Järvinen wrote:
> Add a helper to check if the character is a flow control one.
> Reorder return places, add else for the case where START_CHAR
> and STOP_CHAR are the same, w/o else both would match.
> 
> This seems cleanest approach once skipping due to lookahead
> is added by the next patch. Its downside is the duplicated
> START_CHAR and STOP_CHAR checks.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/n_tty.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index c7edfc001fd0..90b3e06cbeb1 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1220,20 +1220,25 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
>  		process_echoes(tty);
>  }
>  
> +static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> +{
> +	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
> +}
> +
>  /* Returns true if c is consumed as flow-control character */
>  static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
>  {
> +	if (!n_tty_is_char_flow_ctrl(tty, c))
> +		return false;
> +
>  	if (c == START_CHAR(tty)) {
>  		start_tty(tty);
>  		process_echoes(tty);
> -		return true;
> -	}
> -	if (c == STOP_CHAR(tty)) {
> +	} else if (c == STOP_CHAR(tty)) {

The else is always true here now so why check it again?

Just return in the above if statement and then call stop_tty().

thanks,

greg k-h
