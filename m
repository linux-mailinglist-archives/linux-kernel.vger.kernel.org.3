Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B584531C96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiEWQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiEWQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:44:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3625E2A70C;
        Mon, 23 May 2022 09:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84D1BB811BB;
        Mon, 23 May 2022 16:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A6C385AA;
        Mon, 23 May 2022 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653324257;
        bh=rtqYP0ZQa4NAFg8KqObgIGDYik0yDA77R/wJlGYZsok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDrQxldv43sog2KuOElrDQBgYStJ6EBvvJpRgrlnOFlQUl3RGubLR2dUF98ReoPhK
         rSToO2xSDAZukTIXI+MQidt/Ujlbl0l8jJCvydjjetUaaPb4l2BqtDf6K76ld8eD3R
         cKqr66enGOSciuv7NhSuqm0/ftqzeNNVhRUobJws=
Date:   Mon, 23 May 2022 18:44:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     paskripkin@gmail.com, steffen.klassert@secunet.com,
        syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "net: xfrm: fix shift-out-of-bounds in xfrm_get_default"
 has been added to the 5.10-stable tree
Message-ID: <You53ZPw0u/BfoNy@kroah.com>
References: <16533236846953@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16533236846953@kroah.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 06:34:44PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     net: xfrm: fix shift-out-of-bounds in xfrm_get_default
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      net-xfrm-fix-shift-out-of-bounds-in-xfrm_get_default.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 3c10ffddc61f8a1a59e29a110ba70b47e679206a Mon Sep 17 00:00:00 2001
> From: Pavel Skripkin <paskripkin@gmail.com>
> Date: Thu, 2 Sep 2021 22:04:00 +0300
> Subject: net: xfrm: fix shift-out-of-bounds in xfrm_get_default
> 
> From: Pavel Skripkin <paskripkin@gmail.com>
> 
> commit 3c10ffddc61f8a1a59e29a110ba70b47e679206a upstream.
> 
> Syzbot hit shift-out-of-bounds in xfrm_get_default. The problem was in
> missing validation check for user data.
> 
> up->dirmask comes from user-space, so we need to check if this value
> is less than XFRM_USERPOLICY_DIRMASK_MAX to avoid shift-out-of-bounds bugs.
> 
> Fixes: 2d151d39073a ("xfrm: Add possibility to set the default to block if we have no policy")
> Reported-and-tested-by: syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/xfrm/xfrm_user.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1989,6 +1989,11 @@ static int xfrm_get_default(struct sk_bu
>  		return -EMSGSIZE;
>  	}
>  
> +	if (up->dirmask >= XFRM_USERPOLICY_DIRMASK_MAX) {
> +		kfree_skb(r_skb);
> +		return -EINVAL;
> +	}
> +
>  	r_up = nlmsg_data(r_nlh);
>  	r_up->in = net->xfrm.policy_default[XFRM_POLICY_IN];
>  	r_up->fwd = net->xfrm.policy_default[XFRM_POLICY_FWD];
> 
> 
> Patches currently in stable-queue which might be from paskripkin@gmail.com are
> 
> queue-5.10/net-xfrm-fix-shift-out-of-bounce.patch
> queue-5.10/net-xfrm-fix-shift-out-of-bounds-in-xfrm_get_default.patch

Nevermind, this breaks the build, now dropping it.

greg k-h
