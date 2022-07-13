Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDF9573A38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiGMPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiGMPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0531204
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10B65B82053
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E8DC34114;
        Wed, 13 Jul 2022 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657726480;
        bh=nT2RN1aMruPfS4BFZROr+Hv9mNx9Yl/JwyTaPDsJYps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsDS1LrS0dEZB4vrgWYUcNkj2gGlNsknsEop5lbvU8Gzxarn4H510sYSSJfqliyNP
         VBekAgcQdo0/CGMc+Pyf++Bq3GrLyPf+HSWzStK489NWMOWz4aR7MBmBzdqSa6zW3J
         paYAX1iZ8/cyCehavPmht4F8T3UP4510ke0egkRg=
Date:   Wed, 13 Jul 2022 17:34:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     matt.hsiao@hpe.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, jerry.hoemann@hpe.com,
        scott.norton@hpe.com, geoffrey.ndu@hpe.com, gustavo.knuppe@hpe.com,
        camille.lu@hpe.com
Subject: Re: [PATCH] misc: hpilo: switch .{read,write} ops to
 .{read,write}_iter
Message-ID: <Ys7mDT4VXwel6Y9O@kroah.com>
References: <20220713150831.32453-1-matt.hsiao@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713150831.32453-1-matt.hsiao@hpe.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:08:31PM +0800, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
> 
> Commit 4d03e3cc59828c82ee89 ("fs: don't allow kernel reads and writes
> without iter ops") requested exclusive .{read,write}_iter ops for
> kernel_{read,write}. To support dependent drivers to access hpilo by
> kernel_{read,write}, switch .{read,write} ops to its iter variants.
> 
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> ---
>  hpilo.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/hpilo.c b/hpilo.c
> index 8d00df9..5d431a5 100644
> --- a/hpilo.c
> +++ b/hpilo.c
> @@ -23,6 +23,7 @@
>  #include <linux/wait.h>
>  #include <linux/poll.h>
>  #include <linux/slab.h>
> +#include <linux/uio.h>
>  #include "hpilo.h"
>  
>  static struct class *ilo_class;
> @@ -435,14 +436,14 @@ static void ilo_set_reset(struct ilo_hwinfo *hw)
>  	}
>  }
>  
> -static ssize_t ilo_read(struct file *fp, char __user *buf,
> -			size_t len, loff_t *off)
> +static ssize_t ilo_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> -	int err, found, cnt, pkt_id, pkt_len;
> -	struct ccb_data *data = fp->private_data;
> +	int err = 0, found, cnt, pkt_id, pkt_len;
> +	struct ccb_data *data = iocb->ki_filp->private_data;
>  	struct ccb *driver_ccb = &data->driver_ccb;
>  	struct ilo_hwinfo *hw = data->ilo_hw;
>  	void *pkt;
> +	size_t len = iov_iter_count(to), copied;
>  
>  	if (is_channel_reset(driver_ccb)) {
>  		/*
> @@ -477,7 +478,9 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
>  	if (pkt_len < len)
>  		len = pkt_len;
>  
> -	err = copy_to_user(buf, pkt, len);
> +	copied = copy_to_iter(pkt, len, to);
> +	if (unlikely(copied != len))
> +		err = -EFAULT;
>  
>  	/* return the received packet to the queue */
>  	ilo_pkt_enqueue(hw, driver_ccb, RECVQ, pkt_id, desc_mem_sz(1));
> @@ -485,14 +488,14 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
>  	return err ? -EFAULT : len;
>  }
>  
> -static ssize_t ilo_write(struct file *fp, const char __user *buf,
> -			 size_t len, loff_t *off)
> +static ssize_t ilo_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
> -	int err, pkt_id, pkt_len;
> -	struct ccb_data *data = fp->private_data;
> +	int err = 0, pkt_id, pkt_len;
> +	struct ccb_data *data = iocb->ki_filp->private_data;
>  	struct ccb *driver_ccb = &data->driver_ccb;
>  	struct ilo_hwinfo *hw = data->ilo_hw;
>  	void *pkt;
> +	size_t len = iov_iter_count(from), copied;
>  
>  	if (is_channel_reset(driver_ccb))
>  		return -ENODEV;
> @@ -506,9 +509,11 @@ static ssize_t ilo_write(struct file *fp, const char __user *buf,
>  		len = pkt_len;
>  
>  	/* on failure, set the len to 0 to return empty packet to the device */
> -	err = copy_from_user(pkt, buf, len);
> -	if (err)
> +	copied = copy_from_iter(pkt, len, from);
> +	if (unlikely(copied != len)) {
>  		len = 0;
> +		err = -EFAULT;
> +	}
>  
>  	/* send the packet */
>  	ilo_pkt_enqueue(hw, driver_ccb, SENDQ, pkt_id, len);
> @@ -639,8 +644,8 @@ out:
>  
>  static const struct file_operations ilo_fops = {
>  	.owner		= THIS_MODULE,
> -	.read		= ilo_read,
> -	.write		= ilo_write,
> +	.read_iter	= ilo_read_iter,
> +	.write_iter	= ilo_write_iter,
>  	.poll		= ilo_poll,
>  	.open 		= ilo_open,
>  	.release 	= ilo_close,
> -- 
> 2.16.6
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

- Your patch is malformed and can not be applied.

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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
