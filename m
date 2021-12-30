Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC6481B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhL3K5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:57:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49426 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhL3K5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:57:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF35FB81B72
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16E4C36AEA;
        Thu, 30 Dec 2021 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640861871;
        bh=iFlZ4wt7LI1+4h2aPKyiKIRISOvhlTY1S2WNqNp8KRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i45hnyK2GkEE2R6V3UILQW6XUWgov9qcEv/aeFC0psN2ifwxrfc8GqOZFM4LsqNM6
         Wh1qEefpgxWfoaODe8xOMSdb+RjUxJqvwZEA4mPJVfpO5HeMxKa7PmlwIwrYmu5cmQ
         uiO4cfCcWKixYt4WuEBB17c5BvrHNS6lZf7r1Byo=
Date:   Thu, 30 Dec 2021 11:57:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add docs to packet_format and
 tx_start_condition enum
Message-ID: <Yc2QrMecuVQFRcBZ@kroah.com>
References: <20211229094713.GA28795@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229094713.GA28795@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 10:47:13PM +1300, Paulo Miguel Almeida wrote:
> While pi433 driver deals with the nuances of the different possible
> config combinations, it's hard (at first) to understand the rationale
> for some of the tx/rx-related source code unless you're fairly familiar
> with the rf69's inner workings.
> 
> This patch documents the expected behaviour and limits of both
> packet_format and tx_start_condition enum fields.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  drivers/staging/pi433/rf69_enum.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
> index fbf56fcf5fe8..c902916a063d 100644
> --- a/drivers/staging/pi433/rf69_enum.h
> +++ b/drivers/staging/pi433/rf69_enum.h
> @@ -109,13 +109,32 @@ enum fifo_fill_condition {
>  	always
>  };
>  
> +/*
> + * Defines the packet format used.

What "Defines"?  This is an odd sentence.

> + *
> + * In both modes the length of the payload is limited to 255 bytes if AES
> + * is not enabled or 64 bytes otherwise.

What does this have to do with the format type?

> + */
>  enum packet_format {
> +    /*
> +     * Used when the size of payload is fixed in advance. This mode of
> +     * operation may be of interest to minimize RF overhead by 1 byte as
> +     * no length byte field is required
> +     */
>  	packet_length_fix,
> +    /*
> +     * Used when the size of payload isn't known in advance. It requires the
> +     * transmitter to send the length byte in each packet so the receiver
> +     * would know how to operate properly
> +     */
>  	packet_length_var
>  };
>  
> +/* Defines the condition to start packet transmission */
>  enum tx_start_condition {
> +    /* the number of bytes in the FIFO exceeds FIFO_THRESHOLD */
>  	fifo_level,
> +    /* at least one byte in the FIFO */
>  	fifo_not_empty
>  };

Also, always run your patches through scripts/checkpatch.pl before
sending them out.  I couldn't take this patch for that reason alone :(

thanks,

greg k-h
