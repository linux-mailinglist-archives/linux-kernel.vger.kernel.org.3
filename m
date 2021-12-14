Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07A6474292
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhLNMbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhLNMbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639485111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01k8VryRrq+hfX184AWjTCDc3yypJM/0jG7B4R15oqg=;
        b=LmtdSjyuprhsEf7yvmYPpYzTpuqaxopv7O4q5r3Q9bklHNHiPf44l8jLTsN2d6rJ5XTNfj
        I48cfTTgleRpYeA9DtBK4WIFxy0lkXhGbAh8TW0YgF4tkU9C2YzAguR5gKaK2z5iHRsTfB
        eNgCALhIIZ7Ksbq4qe5tZIS2D77LVWI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-hjg1fDG0MYCiefA1mee8sQ-1; Tue, 14 Dec 2021 07:31:50 -0500
X-MC-Unique: hjg1fDG0MYCiefA1mee8sQ-1
Received: by mail-pj1-f69.google.com with SMTP id x18-20020a17090a789200b001a7317f995cso15098098pjk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 04:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=01k8VryRrq+hfX184AWjTCDc3yypJM/0jG7B4R15oqg=;
        b=wlTw8JMds+HJ8tBhu4C3FQGPt9yHQm8cl5Dyi4dTGdV7ZxYz9h9N7IRLxRm89dOJ3u
         EqF8u6dRX/XAMA40/tP78XOaxI7YMaPFm6OyF39A3/MGT7Uc4aDXrWX73HUrU2fUwN0k
         V3adekqZ8p0Kr9UF4lQpRWaY5Zz2T2wvKEl8WaTtZTZxVG6OQ6vRucvn5uiiW/DkBeXu
         xxeznIZc2yvWQQtbrxA2BD2OIT9Id6eWanYnhj37pedcEdtV4+33UlH2moi1ZNTwpVyP
         +XkjpVxXkUL6G8RSvZBp5rrPTsKd9Ze9d7wnob5qvV1+MjjgBlDi24ogUWyrnOiuo40l
         6ZOw==
X-Gm-Message-State: AOAM5329PrvbziHqNkEokl0FzO9laR3Ed1+BZ8YqUbiBWcISupmD3FPw
        Mw5LiZ+FtODClEi6PefsgtTCFDp3z0hqCDhKVLrD/nztEvEOlWLWemSSQ6u5CGl7a8mBNM7tETu
        Ur3ODjIc1PjvXwnVAQ9kd3PNa6RjxhnLz8mc5k+OX
X-Received: by 2002:a63:ea51:: with SMTP id l17mr3517629pgk.363.1639485109683;
        Tue, 14 Dec 2021 04:31:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpmFK2OLAd9iYozTh1YSvtM7rav3/I4yGUM7fQ6tIbRePjMcHAUqKdTvKmdmK4jB+0NYPwU087yICjhqF53n4=
X-Received: by 2002:a63:ea51:: with SMTP id l17mr3517606pgk.363.1639485109341;
 Tue, 14 Dec 2021 04:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20211130132957.8480-1-andrealmeid@collabora.com> <20211130132957.8480-2-andrealmeid@collabora.com>
In-Reply-To: <20211130132957.8480-2-andrealmeid@collabora.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Dec 2021 13:31:38 +0100
Message-ID: <CAO-hwJLKbomKLfvbNMON0E_uHO3AK1d1ZuPAHKqb2M31PBw5tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: hidraw: Replace hidraw device table mutex with a rwsem
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 2:36 PM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> Currently, the table that stores information about the connected hidraw
> devices has a mutex to prevent concurrent hidraw users to manipulate the
> hidraw table (e.g. delete an entry) while someone is trying to use
> the table (e.g. issuing an ioctl to the device), preventing the kernel
> to referencing a NULL pointer. However, since that every user that wants
> to access the table for both manipulating it and reading it content,
> this prevents concurrent access to the table for read-only operations
> for different or the same device (e.g. two hidraw ioctls can't happen at
> the same time, even if they are completely unrelated).
>
> This proves to be a bottleneck and gives performance issues when using
> multiple HID devices at same time, like VR kits where one can have two
> controllers, the headset and some tracking sensors.
>
> To improve the performance, replace the table mutex with a read-write
> semaphore, enabling multiple threads to issue parallel syscalls to
> multiple devices at the same time while protecting the table for
> concurrent modifications.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> ---

Patch looks good to me.

Applied to for-5.17/hidraw.

Thanks!

Cheers,
Benjamin

>  drivers/hid/hidraw.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 79faac87a06f..681614a8302a 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -34,7 +34,7 @@ static int hidraw_major;
>  static struct cdev hidraw_cdev;
>  static struct class *hidraw_class;
>  static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
> -static DEFINE_MUTEX(minors_lock);
> +static DECLARE_RWSEM(minors_rwsem);
>
>  static ssize_t hidraw_read(struct file *file, char __user *buffer, size_=
t count, loff_t *ppos)
>  {
> @@ -107,7 +107,7 @@ static ssize_t hidraw_send_report(struct file *file, =
const char __user *buffer,
>         __u8 *buf;
>         int ret =3D 0;
>
> -       lockdep_assert_held(&minors_lock);
> +       lockdep_assert_held(&minors_rwsem);
>
>         if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
>                 ret =3D -ENODEV;
> @@ -160,9 +160,9 @@ static ssize_t hidraw_send_report(struct file *file, =
const char __user *buffer,
>  static ssize_t hidraw_write(struct file *file, const char __user *buffer=
, size_t count, loff_t *ppos)
>  {
>         ssize_t ret;
> -       mutex_lock(&minors_lock);
> +       down_read(&minors_rwsem);
>         ret =3D hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT=
);
> -       mutex_unlock(&minors_lock);
> +       up_read(&minors_rwsem);
>         return ret;
>  }
>
> @@ -182,7 +182,7 @@ static ssize_t hidraw_get_report(struct file *file, c=
har __user *buffer, size_t
>         int ret =3D 0, len;
>         unsigned char report_number;
>
> -       lockdep_assert_held(&minors_lock);
> +       lockdep_assert_held(&minors_rwsem);
>
>         if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
>                 ret =3D -ENODEV;
> @@ -272,7 +272,7 @@ static int hidraw_open(struct inode *inode, struct fi=
le *file)
>                 goto out;
>         }
>
> -       mutex_lock(&minors_lock);
> +       down_read(&minors_rwsem);
>         if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
>                 err =3D -ENODEV;
>                 goto out_unlock;
> @@ -301,7 +301,7 @@ static int hidraw_open(struct inode *inode, struct fi=
le *file)
>         spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
>         file->private_data =3D list;
>  out_unlock:
> -       mutex_unlock(&minors_lock);
> +       up_read(&minors_rwsem);
>  out:
>         if (err < 0)
>                 kfree(list);
> @@ -347,7 +347,7 @@ static int hidraw_release(struct inode * inode, struc=
t file * file)
>         struct hidraw_list *list =3D file->private_data;
>         unsigned long flags;
>
> -       mutex_lock(&minors_lock);
> +       down_write(&minors_rwsem);
>
>         spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
>         list_del(&list->node);
> @@ -356,7 +356,7 @@ static int hidraw_release(struct inode * inode, struc=
t file * file)
>
>         drop_ref(hidraw_table[minor], 0);
>
> -       mutex_unlock(&minors_lock);
> +       up_write(&minors_rwsem);
>         return 0;
>  }
>
> @@ -369,7 +369,7 @@ static long hidraw_ioctl(struct file *file, unsigned =
int cmd,
>         struct hidraw *dev;
>         void __user *user_arg =3D (void __user*) arg;
>
> -       mutex_lock(&minors_lock);
> +       down_read(&minors_rwsem);
>         dev =3D hidraw_table[minor];
>         if (!dev || !dev->exist) {
>                 ret =3D -ENODEV;
> @@ -487,7 +487,7 @@ static long hidraw_ioctl(struct file *file, unsigned =
int cmd,
>                 ret =3D -ENOTTY;
>         }
>  out:
> -       mutex_unlock(&minors_lock);
> +       up_read(&minors_rwsem);
>         return ret;
>  }
>
> @@ -546,7 +546,7 @@ int hidraw_connect(struct hid_device *hid)
>
>         result =3D -EINVAL;
>
> -       mutex_lock(&minors_lock);
> +       down_write(&minors_rwsem);
>
>         for (minor =3D 0; minor < HIDRAW_MAX_DEVICES; minor++) {
>                 if (hidraw_table[minor])
> @@ -557,7 +557,7 @@ int hidraw_connect(struct hid_device *hid)
>         }
>
>         if (result) {
> -               mutex_unlock(&minors_lock);
> +               up_write(&minors_rwsem);
>                 kfree(dev);
>                 goto out;
>         }
> @@ -567,7 +567,7 @@ int hidraw_connect(struct hid_device *hid)
>
>         if (IS_ERR(dev->dev)) {
>                 hidraw_table[minor] =3D NULL;
> -               mutex_unlock(&minors_lock);
> +               up_write(&minors_rwsem);
>                 result =3D PTR_ERR(dev->dev);
>                 kfree(dev);
>                 goto out;
> @@ -583,7 +583,7 @@ int hidraw_connect(struct hid_device *hid)
>         dev->exist =3D 1;
>         hid->hidraw =3D dev;
>
> -       mutex_unlock(&minors_lock);
> +       up_write(&minors_rwsem);
>  out:
>         return result;
>
> @@ -594,11 +594,11 @@ void hidraw_disconnect(struct hid_device *hid)
>  {
>         struct hidraw *hidraw =3D hid->hidraw;
>
> -       mutex_lock(&minors_lock);
> +       down_write(&minors_rwsem);
>
>         drop_ref(hidraw, 1);
>
> -       mutex_unlock(&minors_lock);
> +       up_write(&minors_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(hidraw_disconnect);
>
> --
> 2.34.1
>

