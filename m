Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E05573C80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiGMS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiGMS23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B92ED6E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C0C61B10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B7DC34114;
        Wed, 13 Jul 2022 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657736907;
        bh=024PDpb4vG1SYLNLpOleR7LwxDGQZrTQ/VrYxAkAb0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3npnU8cqSfirbehcrUP6HCEGPXzejeR2SCQcPzvl8EotN/2EOD+zWIixJd349A4v
         lmpeoYDy+bJJ/hLhemdkuUZaVenRqR8xZ/TUxEvOnTZP4HXQODAxx6M2ePAxW8Z1or
         lZySa4PCfm7OL8ICm+RUOqPHLlLO8F11Fe6LfpPI=
Date:   Wed, 13 Jul 2022 20:28:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     matt.hsiao@hpe.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, jerry.hoemann@hpe.com,
        scott.norton@hpe.com, camille.lu@hpe.com, geoffrey.ndu@hpe.com,
        gustavo.knuppe@hpe.com
Subject: Re: [PATCH v2 1/1] misc: hpilo: switch .{read,write} ops to
 .{read,write}_iter
Message-ID: <Ys8OyLA35o/wr1jB@kroah.com>
References: <20220713175452.4221-1-matt.hsiao@hpe.com>
 <20220713175452.4221-2-matt.hsiao@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713175452.4221-2-matt.hsiao@hpe.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:54:52AM +0800, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
> 
> Commit 4d03e3cc59828c82ee89 ("fs: don't allow kernel reads and writes
> without iter ops") requested exclusive .{read,write}_iter ops for
> kernel_{read,write}. To support dependent drivers to access hpilo by
> kernel_{read,write}, switch .{read,write} ops to their iter variants.
> 
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>

So this fixes a bug?  What commit does this fix?

Should it go to stable branches?  If so, which ones?

But my main question is I have no idea what the changelog means here.
What is a "dependent driver"?  What does "exclusive" mean here?  What is
a iter variant?



> ---
>  drivers/misc/hpilo.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> index 8d00df9243c4..5d431a56b7eb 100644
> --- a/drivers/misc/hpilo.c
> +++ b/drivers/misc/hpilo.c
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

Why unlikely?  If you can prove it is needed in benchmarks, great,
otherwise never add likely/unlikely as they are almost always wrong and
the compiler and cpu can do it better.


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

Same here.

thanks,

greg k-h
