Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402AE4958A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 04:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiAUDr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 22:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiAUDry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 22:47:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D06CC061574;
        Thu, 20 Jan 2022 19:47:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f21so37404554eds.11;
        Thu, 20 Jan 2022 19:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9pfbFTwNFOqXDTrn460UZ4SRTCU9wK5Pp87Cp8WcchQ=;
        b=dnJghX5S5motNuQxvgJPOMnDkZD+vOuJ5IFIkIJpj0yUDXXoSJaohYJOzU9AH8ThJR
         3bm4L7ANXW2Z0gQDvx9O67UUJ3jFoAqJ4zr5OaTnyZfXVIzSlmHMoIuxGzLUvunIC6sG
         AHqZYkHhFKfVURa4oemNwl5tVB/TXnYG6avUOwJGjJJTW9lVPE2FccpUqBu2rmp46HSs
         PApICazBeoq40F/Twm5SRogT+s9FCqtIQS9txE1Z8JI6OweiGwZnCNw/fWd0TpfX6Q2w
         h1j/8oOkYYi5RBPcW/tUoaMjQ/OnUUW809hIkbADdbx+8Jjc5BURA8E6GecrcirwvAA6
         W6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9pfbFTwNFOqXDTrn460UZ4SRTCU9wK5Pp87Cp8WcchQ=;
        b=eVZRaehoyvm8y0hzrlsrMkRwD7oMedQgII6poa0TuYolK854KsR/J0gcArhNuCVNlH
         x05zU7PEKpdI7FeoWluZ6bPXYl5m6ZGE2ErmgxwwqqFd1SAt0CV8+gdnC2g8Zpzfl5L4
         XG75DW1a27FIDYYFHG3wVmaGR1vvl3vxzOroEnYPTCbM1hymhE+jIWr9fHM19jMBegcv
         p9Obh+UVwiUwr8Y9K8pslgSDf/VI1LGl2ZZaI6QZwVIsmY1YfaKsQUz30Hi54kfO01vR
         Curfzu0ZLVWrzlQda3S5tGI8LswDfho/RbpxmUuPnY3tr/p9LwCF/XHJ+qGMLHtF8szN
         Sf5w==
X-Gm-Message-State: AOAM5320ivCx/d6bOelErZpsfiVm17Wi/wCzM/jZBqstVToNoJASTdjq
        FbHVZQ+bk0ME9lypfFnZw4Y+rxFlc6GZUU6JQEGfZmZSVCpjW+JK
X-Google-Smtp-Source: ABdhPJxs1jeE6xBPx02aLtH98nrhh8sNx2SvbLSU6s3kKovJY5MJrBOd60EIqjaW5bSsUNVo1RFjk9uSMgfvQiF1HfY=
X-Received: by 2002:aa7:c243:: with SMTP id y3mr2429640edo.364.1642736873091;
 Thu, 20 Jan 2022 19:47:53 -0800 (PST)
MIME-Version: 1.0
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
In-Reply-To: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 21 Jan 2022 11:47:26 +0800
Message-ID: <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>
Cc:     =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> From=EF=BC=9A Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Date=EF=BC=9A 01/21/2022 01:54
> To=EF=BC=9A Dongliang Mu <dzm91@hust.edu.cn>
> Cc=EF=BC=9A Pavel Skripkin <paskripkin@gmail.com> =E3=80=81 Andrew Morton=
 <akpm@linux-foundation.org> =E3=80=81 linux-nilfs <linux-nilfs@vger.kernel=
.org> =E3=80=81 LKML <linux-kernel@vger.kernel.org> =E3=80=81 Nanyong Sun <=
sunnanyong@huawei.com>
> Subject=EF=BC=9A Re: [PATCH] fs: nilfs2: fix memory leak in nilfs_sysfs_c=
reate_device_group
> (added Nanyong Sun to CC)
> Hi Dongliang,
>
> On Thu, Jan 20, 2022 at 11:07 PM Pavel Skripkin <paskripkin@gmail.com> wr=
ote:
>
>
> Hi Dongliang,
>
> On 1/20/22 16:44, Dongliang Mu wrote:
>
> The preivous commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> nilfs_sysfs_delete_device_group") only handles the memory leak in the
> nilfs_sysfs_delete_device_group. However, the similar memory leak still
> occurs in the nilfs_sysfs_create_device_group.
>
> Fix it by adding kobject_del when
> kobject_init_and_add succeeds, but one of the following calls fails.
>
> Fixes: 8fd0c1b0647a ("nilfs2: fix memory leak in nilfs_sysfs_delete_devic=
e_group")
>
>
> Why Fixes tag points to my commit? This issue was introduced before my pa=
tch
>
>
> As Pavel pointed out, this patch is independent of his patch.
> The following one ?

Hi Pavel,

This is an incorrect fixes tag. I need to dig more about `git log -p
fs/nilfs2/sysfs.c`.

I wonder if there are any automatic or semi-automatic ways to capture
this fixes tag. Or how do you guys identify the fixes tag?

>
> 5f5dec07aca7 ("nilfs2: fix memory leak in nilfs_sysfs_create_device_group=
")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> fs/nilfs2/sysfs.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>
> Can you describe what memory leak issue does this patch actually fix ?
>
> It looks like kobject_put() can call __kobject_del() unless circular
> references exist.
>
> kobject_put() -> kref_put() -> kobject_release() ->
> kobject_cleanup() -> __kobject_del()
>
> As explained in Documentation/core-api/kobject.rst,
>
> kobject_del() can be used to drop the reference to the parent object, if
> circular references are constructed.
>
> But, at least, the parent object is NULL in this case.
> I really want to understand what the real problem is.
>
> Thanks,
> Ryusuke Konishi

I know where my problem is. From the disconnect function, I think the
kobject_del and kobject_put are both necessary without checking the
documentation of kobjects.

Then I think the current error handling may miss kobject_del, and this
patch is generated.

As a result, I think we can ignore this patch. Sorry for my false alarm.

>
>
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index 379d22e28ed6..0b2db2b499d5 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -995,7 +995,7 @@ int nilfs_sysfs_create_device_group(struct super_bloc=
k *sb)
>
> err =3D nilfs_sysfs_create_mounted_snapshots_group(nilfs);
> if (err)
> -             goto cleanup_dev_kobject;
> +             goto delete_dev_kobject;
>
> err =3D nilfs_sysfs_create_checkpoints_group(nilfs);
> if (err)
> @@ -1027,6 +1027,9 @@ int nilfs_sysfs_create_device_group(struct super_bl=
ock *sb)
> delete_mounted_snapshots_group:
> nilfs_sysfs_delete_mounted_snapshots_group(nilfs);
>
> +delete_dev_kobject:
> +     kobject_del(&nilfs->ns_dev_kobj);
> +
> cleanup_dev_kobject:
> kobject_put(&nilfs->ns_dev_kobj);
> kfree(nilfs->ns_dev_subgroups);
>
> With regards,
> Pavel Skripkin
