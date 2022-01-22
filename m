Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E68496A02
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiAVEW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiAVEW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:22:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD87C06173B;
        Fri, 21 Jan 2022 20:22:26 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f21so3029835ljc.2;
        Fri, 21 Jan 2022 20:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSl0n+WwVjP76UBPGcTgsvP7+rrxq9Ric0OqJhwHSkg=;
        b=Ifz1AWXrSg+wgkYOmdBm1iMMJyLipcIzsywwWvL28u7TFV6c2w+oQn70f5wHbm7bjy
         8pOqbS9n8ZsaagYrjRrYi6KrjdoRuuk5auolsU7jzm67aqVLfvUIklnVXV3pr2GanjfE
         UNBI7kxvS8znxD9CxpqcFgrSQJTjXqUAFeode9QFaEz9b2Vh/DJFs7jtQ4HOfB6nYL37
         6ol8AtPht+nBQKwMLVjp9p3dv6sl9kkT6Pzd8OXABDtkiCveZP6d7BJwdU7ECpvtojQF
         WPZBmNP/x6c6K9XEjUIOpJPlEV5SN3Shm3rksWd0q7Xmh7lS5WLH0/v42OWsikmV/fIs
         41NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSl0n+WwVjP76UBPGcTgsvP7+rrxq9Ric0OqJhwHSkg=;
        b=T+WF313fzc9W0s3pMTNn2JgBdIW2rjogXJ8dVVv6YJSJLW1hE4CkT6tOeCSSwzo8+7
         puZqgEWR8A4HJq8sd2PUhgkRJcoec+6AoLhQbYMGj+NnlZrpw9NsehgEK33ay2iLAuqp
         JF/lgG36bucyAuQ9q7QDv7Abv5vz1uhnftzsHnA3v1oHQd4mW2L6wCfBl6I46PBWC9aa
         axhvhByCZBunm02jBeILo8KQCcii7aE+tcltAbsoA0TiXVtBjtkQuoU36ypQqHsS+dR2
         rHNSkuRmSiBJZ0yVqFJeOw5Ehzx89V1ibrqM0trRb/1MOZkQpyfvE+6qInbODaFWefEX
         cwrg==
X-Gm-Message-State: AOAM530kydZ4Hsch2fYNIQ5+cPajINLGflVAFEQ85hOn4WW+rGbSailz
        KCOHf353T/FpiIfeYncdc4K+zNrEPr7Mq8YOm2c=
X-Google-Smtp-Source: ABdhPJwiGYOcyqqKUP3LR31Yz846qneduAyOw2NJAiB3r7G6Bp7VYLQAC+HwdkKvTYKdtTBJ1fNArj7SN5apWT13fvI=
X-Received: by 2002:a05:651c:1a06:: with SMTP id by6mr4909100ljb.244.1642825344529;
 Fri, 21 Jan 2022 20:22:24 -0800 (PST)
MIME-Version: 1.0
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn> <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
In-Reply-To: <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 22 Jan 2022 13:22:12 +0900
Message-ID: <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

On Sat, Jan 22, 2022 at 9:31 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > (added Nanyong Sun to CC)
> > Hi Dongliang,
> >
> > On Thu, Jan 20, 2022 at 11:07 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
> >
> >
> > Hi Dongliang,
> >
> > On 1/20/22 16:44, Dongliang Mu wrote:
> >
> > The preivous commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> > nilfs_sysfs_delete_device_group") only handles the memory leak in the
> > nilfs_sysfs_delete_device_group. However, the similar memory leak still
> > occurs in the nilfs_sysfs_create_device_group.
> >
> > Fix it by adding kobject_del when
> > kobject_init_and_add succeeds, but one of the following calls fails.
> >
> > Fixes: 8fd0c1b0647a ("nilfs2: fix memory leak in nilfs_sysfs_delete_device_group")
> >
> >
> > Why Fixes tag points to my commit? This issue was introduced before my patch
> >
> >
> > As Pavel pointed out, this patch is independent of his patch.
> > The following one ?
>
> Hi Pavel,
>
> This is an incorrect fixes tag. I need to dig more about `git log -p
> fs/nilfs2/sysfs.c`.
>
> I wonder if there are any automatic or semi-automatic ways to capture
> this fixes tag. Or how do you guys identify the fixes tag?

I guess `git blame fs/nilfs2/sysfs.c` may help you to confirm where the change
came from.   It shows information of commits for every line of the input file.
If you are using github, 'blame button' is available.

If an issue is reproducible, we use `git bisect` to identify the patch
that caused the
issue, however, even then, try to understand why and how it affected
by looking at
source code and the commit.

>
> >
> > 5f5dec07aca7 ("nilfs2: fix memory leak in nilfs_sysfs_create_device_group")
> >
> > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> > ---
> > fs/nilfs2/sysfs.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> >
> > Can you describe what memory leak issue does this patch actually fix ?
> >
> > It looks like kobject_put() can call __kobject_del() unless circular
> > references exist.
> >
> > kobject_put() -> kref_put() -> kobject_release() ->
> > kobject_cleanup() -> __kobject_del()
> >
> > As explained in Documentation/core-api/kobject.rst,
> >
> > kobject_del() can be used to drop the reference to the parent object, if
> > circular references are constructed.
> >
> > But, at least, the parent object is NULL in this case.
> > I really want to understand what the real problem is.
> >
> > Thanks,
> > Ryusuke Konishi
>
> I know where my problem is. From the disconnect function, I think the
> kobject_del and kobject_put are both necessary without checking the
> documentation of kobjects.
>
> Then I think the current error handling may miss kobject_del, and this
> patch is generated.
>
> As a result, I think we can ignore this patch. Sorry for my false alarm.

Okay, thank you for your reply.
If you notice anything we missed on this difference, please let us know.

Regards,
Ryusuke Konishi
