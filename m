Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B522755C91F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiF0NIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiF0NH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCBF636F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AE6CB8166D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13EBC3411D;
        Mon, 27 Jun 2022 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656335252;
        bh=nV79Q5azCfltiNcYxLCaCC7JoCoTXIWDuHA0bpXISFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y09OIJDQRhDYmaJubskhBcuje9FuR947hSDeIO5VuCBQCiBihs/BKjPIdkZRUZe93
         1SXRtpSH1u93YsZZ2Xq4jWLzzhN4Df5LvxFYlUdxvmx+W//st1eN++/yapG2NZ6RE6
         7YI+wBLy6MO24F+vaiv377xsyJCzJdYpkK1WcUyY=
Date:   Mon, 27 Jun 2022 15:07:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangxi Xiang <xyangxi5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH v2] vt: fix memory overlapping when deleting chars in the
 buffer
Message-ID: <YrmrkQ1cIZZALRh5@kroah.com>
References: <20220627125428.19885-1-xyangxi5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627125428.19885-1-xyangxi5@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 08:54:28PM +0800, Yangxi Xiang wrote:
> A memory overlapping copy occurs when deleting a long line. This memory
> overlapping copy can cause data corruption when scr_memcpyw is optimized
> to memcpy because memcpy does not ensure its behavior if the destination
> buffer overlaps with the source buffer. The line buffer is not always
> broken, because the memcpy utilizes the hardware acceleration, whose
> result is not deterministic.
> 
> Fix this problem by using replacing the scr_memcpyw with scr_memmovew, and
> preserving the memcpy optimization when the buffers are not overlapping.
> 
> Fixes: 81732c3b2fed ("Fix line garbage in virtual console").
> Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index f8c87c4d7399..d87bff9d8ed5 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -853,9 +853,13 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
>  static void delete_char(struct vc_data *vc, unsigned int nr)
>  {
>  	unsigned short *p = (unsigned short *) vc->vc_pos;
> +	unsigned short cp = (vc->vc_cols - vc->state.x - nr) * 2;
>  
>  	vc_uniscr_delete(vc, nr);
> -	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
> +	if (cp > nr)
> +		scr_memmovew(p, p + nr, cp);
> +	else
> +		scr_memcpyw(p, p + nr, cp);
>  	scr_memsetw(p + vc->vc_cols - vc->state.x - nr, vc->vc_video_erase_char,
>  			nr * 2);
>  	vc->vc_need_wrap = 0;
> -- 
> 2.17.1
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
