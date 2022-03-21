Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08AA4E2093
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbiCUGVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245278AbiCUGVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:21:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA061B1A91
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 887E6B8110D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA6EC340E8;
        Mon, 21 Mar 2022 06:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647843617;
        bh=y2t+aPgtRfPaRo5y42R2mcdKf/j7bJjGo0jm0Tj0SLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IX6IcjQzXXTm4U9PFUX85UvTKb1C+x4RMf2q5crSj/tHQzy8my8y0LOnSXC/r4fjq
         mjmUi6Ax4hvZH84LdiWwiDukNCuq7D1BKSsIzTOK1qs1S1cv+PYclx9/UriWsJByvx
         9jiUrztVu4CE7VBJEh/2ChpoG3yKD/IdYTAoktYg=
Date:   Mon, 21 Mar 2022 07:20:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     arnd@arndb.de, jirislaby@kernel.org, dsterba@suse.com,
        elder@linaro.org, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: synclink_cs: Use bitwise instead of arithmetic
 operator for flags
Message-ID: <YjgZHkYlICLQi47t@kroah.com>
References: <1647843227-32098-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647843227-32098-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:13:47PM +0800, Haowen Bai wrote:
> This silences the following coccinelle warning:
> drivers/s390/char/tape_34xx.c:360:38-39: WARNING: sum of probable bitmasks, consider |
> 
> we will try to make code cleaner
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index 78baba5..e6f2186 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -922,7 +922,7 @@ static void rx_ready_async(MGSLPC_INFO *info, int tcd)
>  		// BIT7:parity error
>  		// BIT6:framing error
>  
> -		if (status & (BIT7 + BIT6)) {
> +		if (status & (BIT7 | BIT6)) {
>  			if (status & BIT7)
>  				icount->parity++;
>  			else
> -- 
> 2.7.4
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
