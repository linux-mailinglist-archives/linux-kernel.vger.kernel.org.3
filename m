Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C665A4FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiH2Ovl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2Ova (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:51:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6452A27E;
        Mon, 29 Aug 2022 07:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0766CCE12A4;
        Mon, 29 Aug 2022 14:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF870C433B5;
        Mon, 29 Aug 2022 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661784685;
        bh=1D0W+JUuTCSdI7AzrUhn/hlZUpEEwVpbMnzddha3JUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQxSi2DeR2phw3xh3HceJX/KJGEAg8XqaNihdtr9RdIvSmSxvdhiVGbaCKcVJSTw3
         vQrazrLaQvkaShQZre7DNIMhsyfNWQT9IeVpDb4Z84L1ln3C3a8Ph2zilbCLrPI6/r
         hz58KOeq+9LbAAWUrVXbqECfqFBBaBz0jzwyYdgI=
Date:   Mon, 29 Aug 2022 16:51:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: Check sanity of endpoint in pegasus_open()
Message-ID: <YwzSasZjvYDRGi1O@kroah.com>
References: <20220829123959.21298-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123959.21298-1-soumya.negi97@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 05:39:59AM -0700, Soumya Negi wrote:
> Fix WARNING in pegasus_open/usb_submit_urb
> Syzbot bug: https://syzkaller.appspot.com/bug?id=bbc107584dcf3262253ce93183e51f3612aaeb13
> 
> Add sanity check of endpoint for Pegasus URB in pegasus_open() so that
> transfer requests for bogus URBs are not submitted. If the URB is bogus
> pegasus_open() will fail.
> 
> Reported-by: syzbot+04ee0cb4caccaed12d78@syzkaller.appspotmail.com
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/input/tablet/pegasus_notetaker.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index c608ac505d1b..5e47882ee4c0 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -225,6 +225,15 @@ static int pegasus_open(struct input_dev *dev)
>  
>  	mutex_lock(&pegasus->pm_mutex);
>  	pegasus->irq->dev = pegasus->usbdev;
> +
> +	/* Sanity check of endpoint in Pegasus URB */
> +	error = usb_urb_ep_type_check(pegasus->irq);

That is not checking for the type of the endpoint, so are you sure this
works?

And this should happen at probe time, not when the device is opened.

thanks,

greg k-h
