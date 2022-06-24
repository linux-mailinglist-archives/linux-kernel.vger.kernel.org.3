Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A25598B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiFXLoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiFXLo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875727B34B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47DFEB82805
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723BBC34114;
        Fri, 24 Jun 2022 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071064;
        bh=5GaDbYkCmC3tdhhIV9ziig6CAMB349i0je6WtHNaCaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBQteETmNc7is2merTkludsBNbrUN2A2Va+dM8VpzZ5s5Bik327VEIG4mTKVD0itY
         LsJG7G1KKEMmOVqmyR6Q/pFuz19uFRfZcqUQ2mMdlTdaoEUU6xfsfK2Red6bvrlRnh
         p6viDTMtBmv47e/7cTAgdj5UkeAHpCeNp/Svgo0U=
Date:   Fri, 24 Jun 2022 08:42:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chang Yu <marcus.yu.56@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: core/rtw_recv.c: clean up nested if
 statements
Message-ID: <YrVczYDubrISrujc@kroah.com>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <20220624062705.436690-1-marcus.yu.56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624062705.436690-1-marcus.yu.56@gmail.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:27:05PM -0700, Chang Yu wrote:
> Combine two nested if statements into a single one to fix indentation
> issue and improve readability, as suggested by checkpatch.pl
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 6564e82ddd66..020bc212532f 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>  
>  	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
>  
> -	if (padapter) {
> -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> -				precvpriv->free_recvframe_cnt++;
> -	}
> +	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
> +		precvpriv->free_recvframe_cnt++;
>  
>  	spin_unlock_bh(&pfree_recv_queue->lock);
>  
> -- 
> 2.36.1
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
