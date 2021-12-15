Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7763B47527E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhLOGGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhLOGGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:06:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:06:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDPrR0vP4z4xhm;
        Wed, 15 Dec 2021 17:06:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1639548375;
        bh=00J2hdcMS9OcXK4sz3ybXFpsvlbnBL4bh6oFTJwon0M=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=UHSxEILsQTMkVv9c+LoKT4J8sgKxmWHcn3NjC1aCAk2xvypgYBeV+SIKcX8oIz18E
         7FnKusRvQcP38sj15e7/NwFjBd3peQs4D7xf2xa9HaTuoiymRLuKXZY07RV1Z8qSY6
         yH6jFbO6h/jI7Ho+oUpsZK20+WjpGfRAubgSqhe59hJkKRCpxSX63sqLAoq2RAauxl
         L9i4cIgqgw3CRnN5RgF4Ww9u9rLafqwp5vhjHiuAMAXbbU5GAkJbihS0mCweg6c3VK
         YSs6PkBr9m1ibQKhwhj9oESJtNxdUOIGMsq9+tIkf/zYo0VJ5OdjyakjBOJ2Ez0Yjt
         PGby1L9AS/NKg==
Message-ID: <2501afe78a6e5027a0d5f270d6ef8a897564e5dc.camel@ozlabs.org>
Subject: Re: [PATCH 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT
 ioctl
From:   Amitay Isaacs <amitay@ozlabs.org>
To:     Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Date:   Wed, 15 Dec 2021 17:06:13 +1100
In-Reply-To: <6db73ea9-96e8-42cd-97a5-0667de8d0097@www.fastmail.com>
References: <20211215005833.222841-1-amitay@ozlabs.org>
         <20211215005833.222841-2-amitay@ozlabs.org>
         <6db73ea9-96e8-42cd-97a5-0667de8d0097@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 2021-12-15 at 16:13 +1030, Andrew Jeffery wrote:
> Hi Amitay,
> 
> On Wed, 15 Dec 2021, at 11:28, Amitay Isaacs wrote:
> > FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds)
> > for
> > the response to *the next* chip-op sent to sbe.  The timeout value
> > is
> > reset to default after the chip-op.
> 
> For the user? Why reset it automatically? To avoid unexpected
> surprises in existing code?

Ideally I would prefer the timeout as an argument for the read() call,
so it's specific to that read call and nothing else.  Of course, this
simplifies the user-space code that needs to issue only a single ioctl
before the "long" chip-ops.

I am fine with using the ioctl to just set the timeout value also.

> 
> >  The timeout affects only the read()
> > operation on sbefifo device fd.
> > 
> > Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
> > ---
> >  drivers/fsi/fsi-sbefifo.c | 42
> > +++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fsi.h  |  6 ++++++
> >  2 files changed, 48 insertions(+)
> > 
> > diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> > index 9188161f440c..b2654b143b85 100644
> > --- a/drivers/fsi/fsi-sbefifo.c
> > +++ b/drivers/fsi/fsi-sbefifo.c
> > @@ -32,6 +32,8 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/mm.h>
> > 
> > +#include <uapi/linux/fsi.h>
> > +
> >  /*
> >   * The SBEFIFO is a pipe-like FSI device for communicating with
> >   * the self boot engine on POWER processors.
> > @@ -134,6 +136,7 @@ struct sbefifo_user {
> >         void                    *cmd_page;
> >         void                    *pending_cmd;
> >         size_t                  pending_len;
> > +       uint32_t                read_timeout_ms;
> >  };
> > 
> >  static DEFINE_MUTEX(sbefifo_ffdc_mutex);
> > @@ -796,6 +799,7 @@ static int sbefifo_user_open(struct inode
> > *inode, 
> > struct file *file)
> >                 return -ENOMEM;
> >         }
> >         mutex_init(&user->file_lock);
> > +       user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
> > 
> >         return 0;
> >  }
> > @@ -838,7 +842,11 @@ static ssize_t sbefifo_user_read(struct file 
> > *file, char __user *buf,
> >         rc = mutex_lock_interruptible(&sbefifo->lock);
> >         if (rc)
> >                 goto bail;
> > +       sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
> >         rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, 
> > &resp_iter);
> > +       /* Reset the read timeout after a single chip-op */
> > +       sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
> > +       user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
> 
> I guess I was querying this one
> 
> >         mutex_unlock(&sbefifo->lock);
> >         if (rc < 0)
> >                 goto bail;
> > @@ -847,6 +855,7 @@ static ssize_t sbefifo_user_read(struct file
> > *file, 
> > char __user *buf,
> >         rc = len - iov_iter_count(&resp_iter);
> >   bail:
> >         sbefifo_release_command(user);
> > +       user->read_timeout_ms = 0;
> >         mutex_unlock(&user->file_lock);
> >         return rc;
> >  }
> > @@ -928,12 +937,45 @@ static int sbefifo_user_release(struct inode 
> > *inode, struct file *file)
> >         return 0;
> >  }
> > 
> > +static int sbefifo_read_timeout(struct sbefifo_user *user, void
> > __user 
> > **argp)
> > +{
> > +       uint32_t timeout;
> > +
> > +       if (get_user(timeout, (__u32 __user *)argp))
> 
> Hmm
> 
> > +               return -EFAULT;
> > +       if (timeout < 10 || timeout > 120)
> > +               return -EINVAL;
> > +
> > +       user->read_timeout_ms = timeout * 1000; /* user timeout is
> > in sec */
> > +       return 0;
> > +}
> > +
> > +static long sbefifo_user_ioctl(struct file *file, unsigned int
> > cmd, 
> > unsigned long arg)
> > +{
> > +       struct sbefifo_user *user = file->private_data;
> > +       void __user **argp = (void __user *)arg;
> 
> Why are we doing strange things with the pointer types?

That's what the ioctl implementation for fsi does.  (Monkey see, monkey
copy!) :-)

> 
> Andrew
> 
> > +       int rc = -ENOTTY;
> > +
> > +       if (!user)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&user->file_lock);
> > +       switch (cmd) {
> > +       case FSI_SBEFIFO_READ_TIMEOUT:
> > +               rc = sbefifo_read_timeout(user, argp);
> > +               break;
> > +       }
> > +       mutex_unlock(&user->file_lock);
> > +       return rc;
> > +}
> > +
> >  static const struct file_operations sbefifo_fops = {
> >         .owner          = THIS_MODULE,
> >         .open           = sbefifo_user_open,
> >         .read           = sbefifo_user_read,
> >         .write          = sbefifo_user_write,
> >         .release        = sbefifo_user_release,
> > +       .unlocked_ioctl = sbefifo_user_ioctl,
> >  };
> > 
> >  static void sbefifo_free(struct device *dev)
> > diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
> > index da577ecd90e7..3e00874ace22 100644
> > --- a/include/uapi/linux/fsi.h
> > +++ b/include/uapi/linux/fsi.h
> > @@ -55,4 +55,10 @@ struct scom_access {
> >  #define FSI_SCOM_WRITE _IOWR('s', 0x02, struct scom_access)
> >  #define FSI_SCOM_RESET _IOW('s', 0x03, __u32)
> > 
> > +/*
> > + * /dev/sbefifo* ioctl interface
> > + */
> > +
> > +#define FSI_SBEFIFO_READ_TIMEOUT       _IOW('s', 0x00, __u32)
> > +
> >  #endif /* _UAPI_LINUX_FSI_H */
> > -- 
> > 2.33.1

Amitay.
-- 

There will always be rocks in the road ahead of you.
They will be stumbling blocks or stepping stones;
It all depends on how you use them
