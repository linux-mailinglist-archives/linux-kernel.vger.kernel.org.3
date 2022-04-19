Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B3506852
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350471AbiDSKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiDSKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBE25298;
        Tue, 19 Apr 2022 03:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7808660DF6;
        Tue, 19 Apr 2022 10:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A840C385A7;
        Tue, 19 Apr 2022 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650362798;
        bh=A3Sh5pbusm5H9OKZcigTxWomGh4V96UysK52vKy8n4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbIjRW6ErLzAOJljXT4LXzZOdElpUjhsCr4puNiMqoiafx9PJqKbEOw2Bff4qE79j
         JIBtzdO+STW7qtaa1Y4SAmtcRdZCVXJHneKAb9yIdcNMju922lkVgHnmS64VHmvYYu
         MRJtEER6RcCOVFheCP8aqmQ1TXzCJuqpqzvLrckY=
Date:   Tue, 19 Apr 2022 12:06:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/20] tty: n_gsm: clean up implicit CR bit encoding
 in address field
Message-ID: <Yl6JpwMtL87mZZb+@kroah.com>
References: <YlkRvMhDfwgNZptV@kroah.com>
 <20220419081930.5886-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419081930.5886-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:19:30AM -0700, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.2.1.2 describes the encoding of the
> address field within the frame header. It is made up of the DLCI address,
> command/response (CR) bit and EA bit.
> Use the predefined CR value instead of a plain 2 in alignment to the
> remaining code and to make the encoding obvious.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 9bf5aa508f0e..1beb4b28cd18 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -751,7 +751,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
>  
>  	*--dp = msg->ctrl;
>  	if (gsm->initiator)
> -		*--dp = (msg->addr << 2) | 2 | EA;
> +		*--dp = (msg->addr << 2) | CR | EA;
>  	else
>  		*--dp = (msg->addr << 2) | EA;
>  	*fcs = gsm_fcs_add_block(INIT_FCS, dp , msg->data - dp);
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
