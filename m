Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2E56C906
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGIKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:30:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A22643C5;
        Sat,  9 Jul 2022 03:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71CA5B81910;
        Sat,  9 Jul 2022 10:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E90C3411C;
        Sat,  9 Jul 2022 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657362654;
        bh=+StW1gOLTZgdcvRatpGmh7s1OknwJrHLQ9GRWP9NdC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pq0+JUbS8bqFQopWY7oG/wgS3nVVemFHzsgErgrU8PhKix5W7hEKYR00OQoTTbLj6
         AyPtvlTxYKaQs2yAtMR4m6WqGOmM5cKLm+jHp4m3Nqdyt47+z7zMDR5IIZqbFNlz1f
         /URWkB56i7OyC8F/r/2ewjWYTVYROKlIwxo/uNLE=
Date:   Sat, 9 Jul 2022 12:30:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christos Kollintzas <c.kollintzas.92@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace udelay with usleep_range
Message-ID: <YslY25NnW6O5Tn+p@kroah.com>
References: <YslTQLhM7GSaGXki@mandalorian.koija>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YslTQLhM7GSaGXki@mandalorian.koija>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 01:06:56PM +0300, Christos Kollintzas wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: usleep_range is preferred over udelay
> 
> Signed-off-by: Christos Kollintzas <c.kollintzas.92@gmail.com>
> ---
>  drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
> index c680160d6380..eeafbab4ace1 100644
> --- a/drivers/staging/fbtft/fb_upd161704.c
> +++ b/drivers/staging/fbtft/fb_upd161704.c
> @@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
>  
>  	/* oscillator start */
>  	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
> -	udelay(100);
> +	usleep_range(100, 110);

When doing these types of changes, you really need access to the
hardware involved in order to be able to properly test it.

Especially for this type of function which is trying to do timing
changes which the hardware requires.

Did you test this on the real hardware and did it work properly?

thanks,

greg k-h
