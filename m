Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7CC47EDF3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352314AbhLXJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:42:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55654 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbhLXJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:42:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E4826202D;
        Fri, 24 Dec 2021 09:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C056FC36AEC;
        Fri, 24 Dec 2021 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640338963;
        bh=Rdn9oXTeHcImgFihzpqZ1fI0UPcOuss6aruBMOmC2/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Laaln0yGIAIH+L6HGuF+pEObSII1GuNdLEi5TeJsNWdLMRNTZCrinVlmhbuXbXh9O
         VwSQRC4r28nlV1XnJ4EjF46CQmKFXM7uXnpcbJskuM6haToGgul40ePhSMZDh3Odun
         9z9nasLvEEeq8KvPGu9NfBTy6YCxsbsYJpc+6HWpvgXQnnSJDei7J80hqplkKJGfpp
         3Js/VfTf9XSonM1vNdMd+godShZ/m/b1rSb0sHasa89+JPLet8Ka8xMsnLQVvWz+YI
         db7i2Ow/3WhXXwQg62PVZV79hd4KyEKB2BJ3tlu0hE3uj9p9uxrK+uA7zNJny8LJ4a
         D6mzoKHafKYiQ==
Received: by mail-vk1-f170.google.com with SMTP id u198so4651628vkb.13;
        Fri, 24 Dec 2021 01:42:43 -0800 (PST)
X-Gm-Message-State: AOAM530a40FqFiRWQxztDh5nhgf47pxEUUedoMIvItO/dqqNO7j5o6zR
        CC1KKjV6W7vZ3vOGWmmeW57NuCiKw2r//gqL5DA=
X-Google-Smtp-Source: ABdhPJxcJSJu2En8JVFZ+Ldq0fMZSqfS1yBXDZhXIwO3+MFkNQtCgMAjeZ2QrdzfLYykbg9IrlsFHRLb9DfFS2fW7l0=
X-Received: by 2002:a1f:ae91:: with SMTP id x139mr2017891vke.2.1640338962651;
 Fri, 24 Dec 2021 01:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-6-guoren@kernel.org>
 <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com>
 <CAJF2gTR2fAU=+0fvW_VCqaZfDkSTAxQ=cKE9iAYOoGORb3m+4g@mail.gmail.com>
 <CAK8P3a17A3MU_atWNEretDcr5sLRc7540tM4vfc=H4M8qVCDEg@mail.gmail.com> <CAK8P3a2b0zun=b84d=LhrjrwLDiKh5_KgyZbBAjTz+40NZri=A@mail.gmail.com>
In-Reply-To: <CAK8P3a2b0zun=b84d=LhrjrwLDiKh5_KgyZbBAjTz+40NZri=A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 24 Dec 2021 17:42:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRG4wRTEb_YHuZo3Xg6gcShduD2WnbEM1M4wg1rVz4qng@mail.gmail.com>
Message-ID: <CAJF2gTRG4wRTEb_YHuZo3Xg6gcShduD2WnbEM1M4wg1rVz4qng@mail.gmail.com>
Subject: Re: [PATCH 05/13] riscv: compat: syscall: Add compat_sys_call_table implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 22, 2021 at 2:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Dec 22, 2021 at 1:43 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > Right, I think the patch would be a nice cleanup, but it appears that
> > riscv is among the few architectures that have defined their own
> > nonstandard mmap2() syscall after all, despite using the standard
> > name for the entry point. Not sure how this slipped past my original
> > review, but it certainly can't be changed now.
>
> No, I misread, the calling conventions are fine after all, it's
> just written in a rather odd way.
>
> > Maybe leave it there and change the #ifdef to build mmap2 for both
> > native rv32 and compat mode.
>
> This bit still applies though, I don't think you need to add another
> helper, just use the one that is already there.
Yes, I will:

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 12f8a7fce78b..9c0194f176fc 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -33,7 +33,9 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 {
        return riscv_sys_mmap(addr, len, prot, flags, fd, offset, 0);
 }
-#else
+#endif
+
+#if defined(CONFIG_32BIT) || defined(CONFIG_COMPAT)
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
        unsigned long, prot, unsigned long, flags,
        unsigned long, fd, off_t, offset)
@@ -44,7 +46,7 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned
long, len,
         */
        return riscv_sys_mmap(addr, len, prot, flags, fd, offset, 12);
 }
-#endif /* !CONFIG_64BIT */
+#endif

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
