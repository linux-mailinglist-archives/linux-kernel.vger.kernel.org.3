Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21807481E73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbhL3RMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbhL3RMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:12:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81681C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21CE661706
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 17:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EA9C36AE9;
        Thu, 30 Dec 2021 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640884356;
        bh=Qoyvwny4RIcNEyTTjTptbnDKv3Vi7ycyTXmv8nLl+xU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4vJK4Q2vdqC50QEUrgws0u2ruzCkbtWSovMAisTN9uDkbDiaPWCIbCqPOND/V6iJ
         RCoh6Yy4bEW1dTW+MC0HiT4baouV1M1NdoTiqHWiS3Gaki2Cx5SaYuYNbp1MyGNdBa
         BcJ51o5vZUR+ijFpTZPi8nu3btYkkNaLJXIuRwbY=
Date:   Thu, 30 Dec 2021 18:12:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: add docs to packet_format and
 tx_start_condition enum
Message-ID: <Yc3ogfD+Cs8zteiB@kroah.com>
References: <20211230170129.GA10296@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230170129.GA10296@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 06:01:29AM +1300, Paulo Miguel Almeida wrote:
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
> v2: removed comments pointed out during v1 review (Req Greg k-h)
> v1: https://lore.kernel.org/lkml/20211229094713.GA28795@localhost.localdomain/
> ---
>  drivers/staging/pi433/rf69_enum.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
> index fbf56fcf5fe8..0f0fa741d089 100644
> --- a/drivers/staging/pi433/rf69_enum.h
> +++ b/drivers/staging/pi433/rf69_enum.h
> @@ -110,12 +110,24 @@ enum fifo_fill_condition {
>  };
>  
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
>  enum tx_start_condition {
> +    /* the number of bytes in the FIFO exceeds FIFO_THRESHOLD */
>  	fifo_level,
> +    /* at least one byte in the FIFO */
>  	fifo_not_empty
>  };
>  
> -- 
> 2.25.4
> 
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
