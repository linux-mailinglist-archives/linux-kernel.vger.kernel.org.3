Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A61475257
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbhLOF7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239951AbhLOF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:59:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED933C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:59:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5BC2B81D4C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DAEC34604;
        Wed, 15 Dec 2021 05:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639547968;
        bh=Ih5yr3MrQ08MPI3id+9m97pirrbFe9+TuLKCSumBb04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvAhuzoS4fy+lyassbbAcLzDu9bcoMQbW7q3X4iIedR++hMAxWgUcyOAcHpgJicKw
         e6sdXinF7pRw6vw3HZD1LEU0tjl7yb0LSYZzLPQlSBqn8kidQmG5X/8WehisPA4vHH
         KdPkMFogusmTZU15qISQCAHIkPrNJrTKN3fGJGi0=
Date:   Wed, 15 Dec 2021 06:59:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Subject: Re: [PATCH 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT
 ioctl
Message-ID: <YbmEOVWJoNJ5Tf4m@kroah.com>
References: <20211215005833.222841-1-amitay@ozlabs.org>
 <20211215005833.222841-2-amitay@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215005833.222841-2-amitay@ozlabs.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:58:33AM +1100, Amitay Isaacs wrote:
> FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds) for
> the response to *the next* chip-op sent to sbe.  The timeout value is
> reset to default after the chip-op.  The timeout affects only the read()
> operation on sbefifo device fd.
> 
> Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
> ---
>  drivers/fsi/fsi-sbefifo.c | 42 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fsi.h  |  6 ++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 9188161f440c..b2654b143b85 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -32,6 +32,8 @@
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
>  
> +#include <uapi/linux/fsi.h>
> +
>  /*
>   * The SBEFIFO is a pipe-like FSI device for communicating with
>   * the self boot engine on POWER processors.
> @@ -134,6 +136,7 @@ struct sbefifo_user {
>  	void			*cmd_page;
>  	void			*pending_cmd;
>  	size_t			pending_len;
> +	uint32_t		read_timeout_ms;

u32 please.  uint32_t is a userspace thing.

>  };
>  
>  static DEFINE_MUTEX(sbefifo_ffdc_mutex);
> @@ -796,6 +799,7 @@ static int sbefifo_user_open(struct inode *inode, struct file *file)
>  		return -ENOMEM;
>  	}
>  	mutex_init(&user->file_lock);
> +	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
>  
>  	return 0;
>  }
> @@ -838,7 +842,11 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
>  	rc = mutex_lock_interruptible(&sbefifo->lock);
>  	if (rc)
>  		goto bail;
> +	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
>  	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
> +	/* Reset the read timeout after a single chip-op */
> +	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
> +	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
>  	mutex_unlock(&sbefifo->lock);
>  	if (rc < 0)
>  		goto bail;
> @@ -847,6 +855,7 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
>  	rc = len - iov_iter_count(&resp_iter);
>   bail:
>  	sbefifo_release_command(user);
> +	user->read_timeout_ms = 0;
>  	mutex_unlock(&user->file_lock);
>  	return rc;
>  }
> @@ -928,12 +937,45 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static int sbefifo_read_timeout(struct sbefifo_user *user, void __user **argp)
> +{
> +	uint32_t timeout;

u32

> +
> +	if (get_user(timeout, (__u32 __user *)argp))
> +		return -EFAULT;
> +	if (timeout < 10 || timeout > 120)
> +		return -EINVAL;
> +
> +	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
> +	return 0;
> +}
> +
> +static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct sbefifo_user *user = file->private_data;
> +	void __user **argp = (void __user *)arg;
> +	int rc = -ENOTTY;
> +
> +	if (!user)
> +		return -EINVAL;
> +
> +	mutex_lock(&user->file_lock);
> +	switch (cmd) {
> +	case FSI_SBEFIFO_READ_TIMEOUT:
> +		rc = sbefifo_read_timeout(user, argp);
> +		break;
> +	}
> +	mutex_unlock(&user->file_lock);
> +	return rc;
> +}

Why do you have to have an ioctl for a single thing like this?

> +
>  static const struct file_operations sbefifo_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= sbefifo_user_open,
>  	.read		= sbefifo_user_read,
>  	.write		= sbefifo_user_write,
>  	.release	= sbefifo_user_release,
> +	.unlocked_ioctl = sbefifo_user_ioctl,
>  };
>  
>  static void sbefifo_free(struct device *dev)
> diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
> index da577ecd90e7..3e00874ace22 100644
> --- a/include/uapi/linux/fsi.h
> +++ b/include/uapi/linux/fsi.h
> @@ -55,4 +55,10 @@ struct scom_access {
>  #define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
>  #define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
>  
> +/*
> + * /dev/sbefifo* ioctl interface
> + */
> +
> +#define FSI_SBEFIFO_READ_TIMEOUT	_IOW('s', 0x00, __u32)

Where have you documented this new user/kernel api?

And why not just use a sysfs file for something like this?  

thanks,

greg k-h
