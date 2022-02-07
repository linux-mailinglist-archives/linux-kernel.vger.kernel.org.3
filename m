Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA44AC692
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbiBGQ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391434AbiBGQq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:46:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C0AC0401DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:46:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C71760AE7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F65BC004E1;
        Mon,  7 Feb 2022 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644252380;
        bh=XQGsi326UEPve0z/EdN0Sb8WFS/rHTPTPvFza9C3uAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZb+qvbEn0meMEbpwK8P+G3w6neBQZG6vSNVffopUfSGmsLmZDRGDLjyiQ/UFTGe7
         9b+EaH7RAU7yMhX+Oo9PwJGox9wozxu8NttKIR3EOMcfSDPqXygXuzulNd9Hui6oae
         r+FuXvVpQOhnBeOoa8LfP9k/ibtlvkv0PuyimiAk=
Date:   Mon, 7 Feb 2022 17:46:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leonardo Araujo <leonardo.aa88@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: wfx: CHECK: usleep_range is preferred over
 udelay
Message-ID: <YgFM1HHs7rSqp/0Q@kroah.com>
References: <20220207160051.27829-1-leonardo.aa88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207160051.27829-1-leonardo.aa88@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 01:00:51PM -0300, Leonardo Araujo wrote:
> Fixes the checks reported by checkpatch.pl for usleep_range.
> 
> Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> ---
>  drivers/staging/wfx/bh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
> index a0f9d1b53019..ebc7eaf93ef0 100644
> --- a/drivers/staging/wfx/bh.c
> +++ b/drivers/staging/wfx/bh.c
> @@ -312,7 +312,7 @@ void wfx_bh_poll_irq(struct wfx_dev *wdev)
>  			dev_err(wdev->dev, "time out while polling control register\n");
>  			return;
>  		}
> -		udelay(200);
> +		usleep_range(200, 200);

Do you have the hardware to verify that this is the correct fix for
this?

You can not just blindly make this type of change here, sorry, otherwise
we would have done so long ago with a simple search/replace :)

thanks,

greg k-h
