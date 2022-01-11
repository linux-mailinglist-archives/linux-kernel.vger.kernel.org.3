Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6821548A9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiAKIm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:42:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45972 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiAKImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:42:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1125B81835;
        Tue, 11 Jan 2022 08:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B80C36AE3;
        Tue, 11 Jan 2022 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641890572;
        bh=LN0bM0PV85bgqHIPq9jkVFjh0nc2l/zowS1CsyWEfTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JENFMSprGHBcxINRGy/ZlIsKQOhgrliuUtBkNx7IJ6sIhEef9z0LC1opZes3Fm9O6
         tXWkQr5arS4hw+9xfOkUxrQnJwJSOM4HrZAImpUnvBHqz/O+Yu4OEkEPOQRcNO3NkG
         Fw+nVcg9ZyFHhWf78sfoK5vfoE95w8CDu/55pgqw=
Date:   Tue, 11 Jan 2022 09:42:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Starke <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: n_gsm: Fix SW flow control encoding/handling
Message-ID: <Yd1DCeajCpJ62zUs@kroah.com>
References: <20220111072317.2082-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111072317.2082-1-daniel.starke@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:23:17PM -0800, Daniel Starke wrote:
> According to 3GPP 27.010 chapter 5.2.7.3 DC1 and DC3 (SW flow control)

What is all of that?  Do you have a link to the document that this is
and where it says this?

> are to
> be treated according to ISO/IEC 646.

What is "ISO/IEC 646"?

> That means the MSB shall be ignored.

"MSB"?  Please spell it out, you have plenty of room here.

> This patch applies the needed changes to handle this correctly.

What changes are needed?  Please talk about what you are doing, as the
documentation asks you to so do.

> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 0b96b14bbfe1..9ee0643fc9e2 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -322,6 +322,7 @@ static int addr_cnt;
>  #define GSM1_ESCAPE_BITS	0x20
>  #define XON			0x11
>  #define XOFF			0x13
> +#define ASCII_MASK		0x7F

Where did "ASCII" come from?  You didn't say anything about that in the
changelog.

>  static const struct tty_port_operations gsm_port_ops;
>  
> @@ -521,7 +522,7 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
>   *	@output: output buffer
>   *	@len: length of input
>   *
> - *	Expand a buffer by bytestuffing it. The worst case size change
> + *	Expand a buffer by byte stuffing it. The worst case size change

This change is not described above, and is totally different and belongs
in a different change.


>   *	is doubling and the caller is responsible for handing out
>   *	suitable sized buffers.
>   */
> @@ -531,7 +532,8 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
>  	int olen = 0;
>  	while (len--) {
>  		if (*input == GSM1_SOF || *input == GSM1_ESCAPE
> -		    || *input == XON || *input == XOFF) {
> +		    || (*input & ASCII_MASK) == XON
> +		    || (*input & ASCII_MASK) == XOFF) {
>  			*output++ = GSM1_ESCAPE;
>  			*output++ = *input++ ^ GSM1_ESCAPE_BITS;
>  			olen++;
> -- 
> 2.25.1
> 

What commit does this fix?

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for a description of how
to do all of this better.

thanks,

greg k-h
