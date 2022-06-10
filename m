Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7272954688A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbiFJOk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiFJOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:40:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88876172C0B;
        Fri, 10 Jun 2022 07:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48144B835D7;
        Fri, 10 Jun 2022 14:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B9C34114;
        Fri, 10 Jun 2022 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654872050;
        bh=qON7PtySj0W506V7PJbMt0B5q9WsCbarSbGg63xlv1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMBfoXPbGM5hUbCGZFtP+BXn2o9XM9KXsn8VUhbCD4lBPmWbqeInfCbD6fyb+DMIu
         I7EBj/DTb8PX76XOdwlUZj1Jray2cgEhIUQg/PkLCgnVcdkb8oskaY0OlF7yfkPyDq
         3NIUzZVD8W7fPvfyxq2T73sXRxyY1KeF+IWEzvYs=
Date:   Fri, 10 Jun 2022 16:40:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: sysfs: convert sysfs snprintf to sysfs_emit
Message-ID: <YqNX7+xrJ2Z0+B1V@kroah.com>
References: <20220610140345.102331-1-zhangxuezhi1@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610140345.102331-1-zhangxuezhi1@coolpad.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:03:45PM +0800, Xuezhi Zhang wrote:
> Fix the following coccicheck warnings:
> drivers/usb/core/sysfs.c:921:8-16:
> WARNING: use scnprintf or sprintf
> drivers/usb/core/sysfs.c:730:8-16:
> WARNING: use scnprintf or sprintf
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
>  drivers/usb/core/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index fa2e49d432ff..6387c0dfe30e 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct usb_device *usb_dev = to_usb_device(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
> +	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
>  }
>  
>  /*
> @@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
>  	struct usb_hcd *hcd;
>  
>  	hcd = bus_to_hcd(usb_bus);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
> +	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
>  }
>  
>  static ssize_t authorized_default_store(struct device *dev,
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

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
