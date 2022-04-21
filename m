Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82071509A51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386445AbiDUIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiDUIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 534721E3C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650528569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ir9vzIEtQayZQr8mh6LXrOfRUcASxVlzgbPMyAmrmXU=;
        b=hcLaKc3q9Yos56CZoRf38pdZmSi/EqCaf7ierTC9PW9oIncSib0qRo14qxyFO4XntCwqAe
        dkn13/m+zRA3zdA+5UqAdTxlW1V+E3h+adFpKF80L30ZUlPysXPtCTWV2zZFFI4IUzjYGR
        LJ1i8YWRgr8dLAxYU1R1z0JIdtBpH4M=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-Nt2YDStlNB2Isb1ilx8JQg-1; Thu, 21 Apr 2022 04:09:28 -0400
X-MC-Unique: Nt2YDStlNB2Isb1ilx8JQg-1
Received: by mail-pf1-f200.google.com with SMTP id d6-20020aa78686000000b0050adc2b200cso737576pfo.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ir9vzIEtQayZQr8mh6LXrOfRUcASxVlzgbPMyAmrmXU=;
        b=BrOKcXWEqWZTE0clC1QiZQK+9vIOiP9iyWac+buhy9xA4gwmmO5hcY2L7T5fhyvjyu
         Ajo/1q6qlnKK/CRhFdRdPq+lWUpalzBF3NGVVQViB7JZvKvM59H/Kw+B9z2Gxa3f+1Qn
         Vk81493T3sqm+VKuXk8AmEKinEh/cNW6x63+ml4+vwqUjkw/bHFy3fqM6NR1N14KEiqQ
         h8m/ssUGXaVVMa5wyuFEN3FiO3a1hyelcpok43JSJhFM4qI5ibX1LxHcRp18DJNjnwyr
         zCqmHMNlXKJVrhujXsTR8bfxqAbNh6IZeAlMomyKBhug4fEbkTfuFZgE2HCWpwRLaapt
         a46Q==
X-Gm-Message-State: AOAM533wV9qcGHAlFxIJtgZ00+cY39rXHv1wkNtrJYk4ZYgSeNHVuxah
        DEK+f0zdfKAsjVt199m4VNZjIDBvV/Rxy9npYV3FwAjROb4QvJ3jdbGTkHIKwNKGtWnxxK8D5BB
        NRSq8RO30iET9Per829qAikQylJZOh4DtuBYKFufJ
X-Received: by 2002:a17:90b:4c42:b0:1d2:8eeb:108 with SMTP id np2-20020a17090b4c4200b001d28eeb0108mr9091843pjb.113.1650528566874;
        Thu, 21 Apr 2022 01:09:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVeiyGsZ9UDWKWaDonn0u+GwCO9EO4r4aqhu9wcZx4AcxNxb+RMikAGi3hrYCklR9n2Sid7VGLUEPr01knqyk=
X-Received: by 2002:a17:90b:4c42:b0:1d2:8eeb:108 with SMTP id
 np2-20020a17090b4c4200b001d28eeb0108mr9091809pjb.113.1650528566487; Thu, 21
 Apr 2022 01:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <YmEAPZKDisM2HAsG@quokka> <99f54616-5464-be0d-9454-638352bc39eb@redhat.com>
In-Reply-To: <99f54616-5464-be0d-9454-638352bc39eb@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 21 Apr 2022 10:09:15 +0200
Message-ID: <CAO-hwJLLuJxQqTgaB7Q+0x4yiU43ARqqZ_mrUEGAQwFFn6ZNvA@mail.gmail.com>
Subject: Re: [PATCH] HID: hidraw - add HIDIOCREVOKE ioctl
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:41 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
>
>
> On Thu, Apr 21, 2022 at 8:57 AM Peter Hutterer <peter.hutterer@who-t.net> wrote:
> >
> > There is a need for userspace applications to open HID devices directly.
> > Use-cases include configuration of gaming mice or direct access to
> > joystick devices. The latter is currently handled by the uaccess tag in
> > systemd, other devices include more custom/local configurations or just
> > sudo.
> >
> > A better approach is what we already have for evdev devices: give the
> > application a file descriptor and revoke it when it may no longer access
> > that device.
> >
> > This patch is the hidraw equivalent to the EVIOCREVOKE ioctl, see
> > commit c7dc65737c9a607d3e6f8478659876074ad129b8 for full details.
> >
> > A draft MR for systemd-logind has been filed here:
> > https://github.com/systemd/systemd/pull/23140
> >
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > ---
> > Maybe noteworthy: even with logind support this is only the first step of
> > many. logind only hands the fd to whoever controls the session and the fd will
> > then have to be passed forward through portals to the application.
> >
> >  drivers/hid/hidraw.c        | 34 ++++++++++++++++++++++++++++++----
> >  include/linux/hidraw.h      |  1 +
> >  include/uapi/linux/hidraw.h |  1 +
> >  3 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> > index 681614a8302a..3449fe856090 100644
> > --- a/drivers/hid/hidraw.c
> > +++ b/drivers/hid/hidraw.c
> > @@ -42,6 +42,9 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
> >         int ret = 0, len;
> >         DECLARE_WAITQUEUE(wait, current);
> >
> > +       if (list->revoked)
> > +               return -ENODEV;
> > +
> >         mutex_lock(&list->read_mutex);
> >
> >         while (ret == 0) {
> > @@ -159,9 +162,13 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
> >
> >  static ssize_t hidraw_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
> >  {
> > +       struct hidraw_list *list = file->private_data;
> >         ssize_t ret;
> >         down_read(&minors_rwsem);
> > -       ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
> > +       if (list->revoked)
> > +               ret = -ENODEV;
> > +       else
> > +               ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
> >         up_read(&minors_rwsem);
> >         return ret;
> >  }
> > @@ -254,7 +261,7 @@ static __poll_t hidraw_poll(struct file *file, poll_table *wait)
> >         poll_wait(file, &list->hidraw->wait, wait);
> >         if (list->head != list->tail)
> >                 mask |= EPOLLIN | EPOLLRDNORM;
> > -       if (!list->hidraw->exist)
> > +       if (!list->hidraw->exist || list->revoked)
> >                 mask |= EPOLLERR | EPOLLHUP;
> >         return mask;
> >  }
> > @@ -313,6 +320,9 @@ static int hidraw_fasync(int fd, struct file *file, int on)
> >  {
> >         struct hidraw_list *list = file->private_data;
> >
> > +       if (list->revoked)
> > +               return -ENODEV;
> > +
> >         return fasync_helper(fd, file, on, &list->fasync);
> >  }
> >
> > @@ -360,6 +370,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
> >         return 0;
> >  }
> >
> > +static int hidraw_revoke(struct hidraw_list *list, struct file *file)
>
> There is no use of *file here, we can drop the argument.
>
> > +{
> > +       list->revoked = true;
> > +
> > +       return 0;
> > +}
> > +
> >  static long hidraw_ioctl(struct file *file, unsigned int cmd,
> >                                                         unsigned long arg)
> >  {
> > @@ -367,11 +384,12 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
> >         unsigned int minor = iminor(inode);
> >         long ret = 0;
> >         struct hidraw *dev;
> > +       struct hidraw_list *list = file->private_data;
> >         void __user *user_arg = (void __user*) arg;
> >
> >         down_read(&minors_rwsem);
> >         dev = hidraw_table[minor];
> > -       if (!dev || !dev->exist) {
> > +       if (!dev || !dev->exist || list->revoked) {
> >                 ret = -ENODEV;
> >                 goto out;
> >         }
> > @@ -409,6 +427,14 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
> >                                         ret = -EFAULT;
> >                                 break;
> >                         }
> > +               case HIDIOCREVOKE:
> > +                       {
> > +                               if (user_arg)
> > +                                       ret = -EINVAL;
> > +                               else
> > +                                       ret = hidraw_revoke(list, file);
> > +                               break;
> > +                       }
> >                 default:
> >                         {
> >                                 struct hid_device *hid = dev->hid;
> > @@ -515,7 +541,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
> >         list_for_each_entry(list, &dev->list, node) {
> >                 int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
> >
> > -               if (new_head == list->tail)
> > +               if (list->revoked || new_head == list->tail)
>
> We had quite some discussions offline about that, and I wonder if you
> should not squash the following patch into this one:
>
> ---
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 3449fe856090..ee5e6fe33a4d 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -36,13 +36,19 @@ static struct class *hidraw_class;
>   static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
>   static DECLARE_RWSEM(minors_rwsem);
>
> +__weak noinline bool hidraw_is_revoked(struct hidraw_list *list)
> +{
> +       return list->revoked;
> +}
> +ALLOW_ERROR_INJECTION(hidraw_is_revoked, TRUE);
> +
>   static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
>   {
>         struct hidraw_list *list = file->private_data;
>         int ret = 0, len;
>         DECLARE_WAITQUEUE(wait, current);
>
> -       if (list->revoked)
> +       if (hidraw_is_revoked(list))
>                 return -ENODEV;
>
>         mutex_lock(&list->read_mutex);
> @@ -165,7 +171,7 @@ static ssize_t hidraw_write(struct file *file, const char __user *buffer, size_t
>         struct hidraw_list *list = file->private_data;
>         ssize_t ret;
>         down_read(&minors_rwsem);
> -       if (list->revoked)
> +       if (hidraw_is_revoked(list))
>                 ret = -ENODEV;
>         else
>                 ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
> @@ -261,7 +267,7 @@ static __poll_t hidraw_poll(struct file *file, poll_table *wait)
>         poll_wait(file, &list->hidraw->wait, wait);
>         if (list->head != list->tail)
>                 mask |= EPOLLIN | EPOLLRDNORM;
> -       if (!list->hidraw->exist || list->revoked)
> +       if (!list->hidraw->exist || hidraw_is_revoked(list))
>                 mask |= EPOLLERR | EPOLLHUP;
>         return mask;
>   }
> @@ -320,7 +326,7 @@ static int hidraw_fasync(int fd, struct file *file, int on)
>   {
>         struct hidraw_list *list = file->private_data;
>
> -       if (list->revoked)
> +       if (hidraw_is_revoked(list))
>                 return -ENODEV;
>
>         return fasync_helper(fd, file, on, &list->fasync);
> @@ -389,7 +395,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
>
>         down_read(&minors_rwsem);
>         dev = hidraw_table[minor];
> -       if (!dev || !dev->exist || list->revoked) {
> +       if (!dev || !dev->exist || hidraw_is_revoked(list)) {
>                 ret = -ENODEV;
>                 goto out;
>         }
> @@ -541,7 +547,8 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>         list_for_each_entry(list, &dev->list, node) {
>                 int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
>
> -               if (list->revoked || new_head == list->tail)
> +               if (hidraw_is_revoked(list) ||
> +                   new_head == list->tail)
>                         continue;
>
>                 if (!(list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC))) {
> ---
>
> The reasons are:
> - we get one common helper for revoked
> - we can then emulate with BPF the ioctl even if logind is not the owner
> of the fd. This way, we can have the functionality without having to
> change a single line in the client applications.
>
> For an example such BPF program, see https://gitlab.freedesktop.org/bentiss/logind-hidraw

Another quick thought: maybe we want stable to be added to this patch.
This code hasn't changed in a while and could easily be backported in
older kernel releases. Not sure if it matches stable criterias though
(but it seems we are more relaxed with those criterias).

Cheers,
Benjamin

>
> Cheers,
> Benjamin
>
> >                         continue;
> >
> >                 if (!(list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC))) {
> > diff --git a/include/linux/hidraw.h b/include/linux/hidraw.h
> > index cd67f4ca5599..18fd30a288de 100644
> > --- a/include/linux/hidraw.h
> > +++ b/include/linux/hidraw.h
> > @@ -32,6 +32,7 @@ struct hidraw_list {
> >         struct hidraw *hidraw;
> >         struct list_head node;
> >         struct mutex read_mutex;
> > +       bool revoked;
> >  };
> >
> >  #ifdef CONFIG_HIDRAW
> > diff --git a/include/uapi/linux/hidraw.h b/include/uapi/linux/hidraw.h
> > index 33ebad81720a..d0563f251da5 100644
> > --- a/include/uapi/linux/hidraw.h
> > +++ b/include/uapi/linux/hidraw.h
> > @@ -46,6 +46,7 @@ struct hidraw_devinfo {
> >  /* The first byte of SOUTPUT and GOUTPUT is the report number */
> >  #define HIDIOCSOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0B, len)
> >  #define HIDIOCGOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0C, len)
> > +#define HIDIOCREVOKE   _IOW('H', 0x0D, int) /* Revoke device access */
> >
> >  #define HIDRAW_FIRST_MINOR 0
> >  #define HIDRAW_MAX_DEVICES 64
> > --
> > 2.36.0
> >

