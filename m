Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6346E495397
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiATRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiATRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:54:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47CC061574;
        Thu, 20 Jan 2022 09:54:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o12so24530040lfu.12;
        Thu, 20 Jan 2022 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbH6zkOi7dKvv5s46NOnhTsCXPGrtE83ptL2g2IOIGI=;
        b=kbpj99JhO2MgCD6lGdp2Pv4hZmrjw0Z+W9PYEVYv2RGTMOPUOuoHbe+9j+8OOZWRL2
         /srULlCME1O0jRBwACgDYcTc00Utp0V7tUzGYMquajQUpchIlY/+FOHgxQ+4Hby1yk6J
         toWL3RN7+AGdfnOr7Fem89VZdkM4LOk9h7jfYlrfA4ML5IRBJo+6yQcjw6a5kVZ8jhi9
         BJBe0g75AmvBnSoSZR7/InbTb/j7uvyBKDixSbyr3VmXTmpnMZSxYxe/FTKDO9HtSsV3
         ghDDCubGPKMDkhefuQ0dRVZpen6PQRNAOyk9eIMl8FKOXduXdruZ2UzDotmtYRKlYTBL
         xRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbH6zkOi7dKvv5s46NOnhTsCXPGrtE83ptL2g2IOIGI=;
        b=Qpa2F0CXKR2rBC/s/2TcNDXUNlmr1xXZ13Z6AiT7RfSMYre09kKxjuFUE/cO0bQSde
         6hkHXWaHzaDefa55AEpVVGnfF2Sp13vw5RSz1FAVNvjXtkP7zAdL7an7i8PQHHuUMJLn
         XAN0U9xT8Gq+LXKlPv2M4aOCdg+lVgMKAsVVnLOkCo6qWKpsUE6G2DjoSXjodPMBg1QA
         mLSnuSwOZ4sLgTBJRCPVfiKugkFXGY77Bh7MPNMhEaqEZ1yMtUJ5nQyEq8mmXLbxu0p7
         scaGwGm7+fclZOBUKYYvM8QnZGtHfMgGPJMlvNQueHd1nH38mabWvGJIfRq6ULchfV2H
         GGRQ==
X-Gm-Message-State: AOAM533D48sVAUHHdva4FaVNhaqBx9GDozfNy9rcPH6Uy5mejg0JS4/F
        C5lG5oyMiDXgFrsNa64wCObkcjTLq1HSpt374q0atSo0JUQ=
X-Google-Smtp-Source: ABdhPJxXftE89c8dVvocLbeuqhad3aLCt+4OzZDKPZLJGmHYmGyfHT9J058mwGhpJaiaDoGWIg8hfQjJn14NKzHzQdA=
X-Received: by 2002:a19:8c55:: with SMTP id i21mr140687lfj.627.1642701274033;
 Thu, 20 Jan 2022 09:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20220120134415.57147-1-dzm91@hust.edu.cn> <0bc923d8-6565-69a3-c234-3789707efeb9@gmail.com>
In-Reply-To: <0bc923d8-6565-69a3-c234-3789707efeb9@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 21 Jan 2022 02:54:21 +0900
Message-ID: <CAKFNMo=orkfaAmgPEHvWQmb83PG4nURgv+eaS0BX5_iDbG5pDw@mail.gmail.com>
Subject: Re: [PATCH] fs: nilfs2: fix memory leak in nilfs_sysfs_create_device_group
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added Nanyong Sun to CC)
Hi Dongliang,

On Thu, Jan 20, 2022 at 11:07 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Dongliang,
>
> On 1/20/22 16:44, Dongliang Mu wrote:
> > The preivous commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> > nilfs_sysfs_delete_device_group") only handles the memory leak in the
> > nilfs_sysfs_delete_device_group. However, the similar memory leak still
> > occurs in the nilfs_sysfs_create_device_group.
> >
> > Fix it by adding kobject_del when
> > kobject_init_and_add succeeds, but one of the following calls fails.
> >
> > Fixes: 8fd0c1b0647a ("nilfs2: fix memory leak in nilfs_sysfs_delete_device_group")
>
> Why Fixes tag points to my commit? This issue was introduced before my patch
>

As Pavel pointed out, this patch is independent of his patch.
The following one ?

 5f5dec07aca7 ("nilfs2: fix memory leak in nilfs_sysfs_create_device_group")

> > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> > ---
> >   fs/nilfs2/sysfs.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)

Can you describe what memory leak issue does this patch actually fix ?

It looks like kobject_put() can call __kobject_del() unless circular
references exist.

  kobject_put() -> kref_put() -> kobject_release() ->
kobject_cleanup() -> __kobject_del()

As explained in Documentation/core-api/kobject.rst,

  kobject_del() can be used to drop the reference to the parent object, if
  circular references are constructed.

But, at least, the parent object is NULL in this case.
I really want to understand what the real problem is.

Thanks,
Ryusuke Konishi

> >
> > diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> > index 379d22e28ed6..0b2db2b499d5 100644
> > --- a/fs/nilfs2/sysfs.c
> > +++ b/fs/nilfs2/sysfs.c
> > @@ -995,7 +995,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
> >
> >       err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
> >       if (err)
> > -             goto cleanup_dev_kobject;
> > +             goto delete_dev_kobject;
> >
> >       err = nilfs_sysfs_create_checkpoints_group(nilfs);
> >       if (err)
> > @@ -1027,6 +1027,9 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
> >   delete_mounted_snapshots_group:
> >       nilfs_sysfs_delete_mounted_snapshots_group(nilfs);
> >
> > +delete_dev_kobject:
> > +     kobject_del(&nilfs->ns_dev_kobj);
> > +
> >   cleanup_dev_kobject:
> >       kobject_put(&nilfs->ns_dev_kobj);
> >       kfree(nilfs->ns_dev_subgroups);
> With regards,
> Pavel Skripkin
