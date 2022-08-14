Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87859203E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiHNOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHNOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B9D13D0D;
        Sun, 14 Aug 2022 07:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA30D60BCA;
        Sun, 14 Aug 2022 14:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E6C433D7;
        Sun, 14 Aug 2022 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660488311;
        bh=iMBFg6BfWJyRlJEWO3cnG3IzMydQoIwzayCIiqd/lL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqeP+WC8M3JPUEoMmWj9BuYa9NwUVS63OcZXLi7LrnZLJ/ZMHBPJSBSTzBMMFyQ8Q
         AWGUg0MjUaViHFgDo2SClIfVd4OgYIBEuE2LKawXPrbmReif6bx3SpGya7it7fPc4Z
         TgjBMDMQ0uy3vNs6iL5XizwfeEcsNAZ0+atGvUUE=
Date:   Sun, 14 Aug 2022 16:45:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     sean@mess.org, mchehab@kernel.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] drivers/media/rc: Ensure usb_submit_urb() is not called
 if write is in progress
Message-ID: <YvkKdIL8UVhKrI0Q@kroah.com>
References: <20220814142543.24910-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814142543.24910-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 07:55:42PM +0530, Gautam Menghani wrote:
> The warning "URB submitted while active" is reported if the function
> send_packet() in imon.c is called if a write is already is in progress.
> Add a check to return -EBUSY in case a write is already is in progress.
> Also, mark tx.busy as false after transmission is completed.
> 
> Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
> Cc: hdanton@sina.com
> Suggested-by: hdanton@sina.com
> Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
> Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  drivers/media/rc/imon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> index 735b925da998..a5b997c2c7e2 100644
> --- a/drivers/media/rc/imon.c
> +++ b/drivers/media/rc/imon.c
> @@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
>  	int retval = 0;
>  	struct usb_ctrlrequest *control_req = NULL;
>  
> +	if (ictx->tx.busy)
> +		return -EBUSY;

What happens if we go busy right after this check?  Where is the locking
here to protect this?

thanks,

greg k-h
