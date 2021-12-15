Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE1475216
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbhLOFbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhLOFbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:31:00 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:30:59 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id a24so19375297qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wc+ZvGS9ImSHF7dldCq9sw9VHATWaXJnPCcJpDuiP2c=;
        b=Lu1GJ24wF1qJKagoWzUQFoKXmtSyBvGMDoVoxHu6bMWnb6yaF1UvIKuaxaet1f7d4h
         7oAZuLpWVIs99opsRLvbKwp/HEAxgttRgHukG4xMU0yunbnFKfjeZyANABaT+D0d+gZu
         lGB5GOM51wbL9wiqhGcgMSfe4svvQmDn8lxq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wc+ZvGS9ImSHF7dldCq9sw9VHATWaXJnPCcJpDuiP2c=;
        b=G/lkni1qPQCRV/yxrTyOUPh5Rns4HacHaTmaDT+vOKB0RgX7uTtJhizg2g8OyXLaY2
         P1jyCeyyvozEYrKYmAf5zbTTL1k1LYLPSl6F70dGnXs50WmQ5/vvJi1wRZYTy2OnrVN+
         feI9cll7SGE/WXRpWXXXwX5+h1vmSoKZWzjA6SoHYRv5abSS1/fMieFTEZGPsbPFGpJk
         zdMhH3JFsdu4xhDjFFvHYXF3ntJ/dEo5z6TPffr+W5Cb21o1+ZNDgwcWqU7LbGDYGrFB
         HIFKSC6goKsKyJegnYC9j21PVGN6JdiRPe2Tezef+qHC6t6+1GyLEOJRZjSWKMfWsFH8
         DNew==
X-Gm-Message-State: AOAM531s9M1KDU++n6qkaWYpbwuSbRQMOmnVRm7h0QLCxhRrcv6qvms1
        fB742+04qK5dFxa6d7v+inWqfWRoNjZYwmmlmntNtguo
X-Google-Smtp-Source: ABdhPJyz53BcoFzFrLPyNWTF4SxErjumicR5pAk3kQIISNQzv1ROUM6rP4MJc69abbCrIT5F+ZXYvWYf70ZSyx3JY+c=
X-Received: by 2002:ad4:5beb:: with SMTP id k11mr9946393qvc.107.1639546258940;
 Tue, 14 Dec 2021 21:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20211215005833.222841-1-amitay@ozlabs.org> <20211215005833.222841-2-amitay@ozlabs.org>
In-Reply-To: <20211215005833.222841-2-amitay@ozlabs.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 15 Dec 2021 05:30:46 +0000
Message-ID: <CACPK8Xcmy-UfhWKQRnGD_QuKXenCeho=gcumb2tuo-oa0iA=_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT ioctl
To:     Amitay Isaacs <amitay@ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsi@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 00:58, Amitay Isaacs <amitay@ozlabs.org> wrote:
>
> FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds) for
> the response to *the next* chip-op sent to sbe.  The timeout value is
> reset to default after the chip-op.  The timeout affects only the read()
> operation on sbefifo device fd.

Makes sense to me.

Lets see if Greg or Andrew will review the icotl interface for us.

Reviewed-by: Joel Stanley <joel@jms.id.au>

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
>         void                    *cmd_page;
>         void                    *pending_cmd;
>         size_t                  pending_len;
> +       uint32_t                read_timeout_ms;
>  };
>
>  static DEFINE_MUTEX(sbefifo_ffdc_mutex);
> @@ -796,6 +799,7 @@ static int sbefifo_user_open(struct inode *inode, struct file *file)
>                 return -ENOMEM;
>         }
>         mutex_init(&user->file_lock);
> +       user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
>
>         return 0;
>  }
> @@ -838,7 +842,11 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
>         rc = mutex_lock_interruptible(&sbefifo->lock);
>         if (rc)
>                 goto bail;
> +       sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
>         rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
> +       /* Reset the read timeout after a single chip-op */
> +       sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
> +       user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
>         mutex_unlock(&sbefifo->lock);
>         if (rc < 0)
>                 goto bail;
> @@ -847,6 +855,7 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
>         rc = len - iov_iter_count(&resp_iter);
>   bail:
>         sbefifo_release_command(user);
> +       user->read_timeout_ms = 0;
>         mutex_unlock(&user->file_lock);
>         return rc;
>  }
> @@ -928,12 +937,45 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
>         return 0;
>  }
>
> +static int sbefifo_read_timeout(struct sbefifo_user *user, void __user **argp)
> +{
> +       uint32_t timeout;
> +
> +       if (get_user(timeout, (__u32 __user *)argp))
> +               return -EFAULT;
> +       if (timeout < 10 || timeout > 120)
> +               return -EINVAL;
> +
> +       user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
> +       return 0;
> +}
> +
> +static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       struct sbefifo_user *user = file->private_data;
> +       void __user **argp = (void __user *)arg;
> +       int rc = -ENOTTY;
> +
> +       if (!user)
> +               return -EINVAL;
> +
> +       mutex_lock(&user->file_lock);
> +       switch (cmd) {
> +       case FSI_SBEFIFO_READ_TIMEOUT:
> +               rc = sbefifo_read_timeout(user, argp);
> +               break;
> +       }
> +       mutex_unlock(&user->file_lock);
> +       return rc;
> +}
> +
>  static const struct file_operations sbefifo_fops = {
>         .owner          = THIS_MODULE,
>         .open           = sbefifo_user_open,
>         .read           = sbefifo_user_read,
>         .write          = sbefifo_user_write,
>         .release        = sbefifo_user_release,
> +       .unlocked_ioctl = sbefifo_user_ioctl,
>  };
>
>  static void sbefifo_free(struct device *dev)
> diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
> index da577ecd90e7..3e00874ace22 100644
> --- a/include/uapi/linux/fsi.h
> +++ b/include/uapi/linux/fsi.h
> @@ -55,4 +55,10 @@ struct scom_access {
>  #define FSI_SCOM_WRITE _IOWR('s', 0x02, struct scom_access)
>  #define FSI_SCOM_RESET _IOW('s', 0x03, __u32)
>
> +/*
> + * /dev/sbefifo* ioctl interface
> + */
> +
> +#define FSI_SBEFIFO_READ_TIMEOUT       _IOW('s', 0x00, __u32)
> +
>  #endif /* _UAPI_LINUX_FSI_H */
> --
> 2.33.1
>
