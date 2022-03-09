Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1BE4D3181
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiCIPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiCIPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:11:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB8A647B;
        Wed,  9 Mar 2022 07:10:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E19B4B82200;
        Wed,  9 Mar 2022 15:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF819C340F4;
        Wed,  9 Mar 2022 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646838632;
        bh=HW6Lkz1+wwMQvCFCzrUzcgIzsEbj2Xvy0+6Wzf4FlwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LGhLLa6WQZwwbOvrvE8SdNp/PVxstQcAKsfzBHxZoCY2eRahiO4DqB45w3O02pmga
         LLAc2B7q31qxwDpCXzDZHymzbuaKd14QF/KvaajyHI5vpzeMeZsnyumQfEU0Jh9G/2
         velrEIq7E/uFEIVK6aZm+xNJbR0ZEl3Ik9yIsjiGPDscMfIhJKaedP3Bwh1npXTI0b
         hXdIiiVujtBXv0oq224S+MhJbcbWHVw1KtUMq68/CACe5wCB9GuCzd8oz6BFirqa+p
         ka+Dtz/j5MajKEN/zho5f1nKjOt33yJQwgMCSlomOguD3seQx5Om3v/7y/wr/yyajP
         9ptheUk809JDQ==
Received: by mail-yb1-f178.google.com with SMTP id h126so5031873ybc.1;
        Wed, 09 Mar 2022 07:10:32 -0800 (PST)
X-Gm-Message-State: AOAM533NHuZ49tziH3jrAJxmWg9g2bGjiVugzZ3DM8OpddjG0IAfBd9Z
        UpYT4HgGkS9DwrsFXjNm503elzrSw4TWKyUkq+c=
X-Google-Smtp-Source: ABdhPJzx5u3nDic/3NGork/wE0Eh6ZeiSg3n7IH/fjWdHYj5xLNZiTNQkVuz3X16fIODQIFlxy4WRQb2U5gnUC/dInA=
X-Received: by 2002:a25:df4e:0:b0:629:547b:d83a with SMTP id
 w75-20020a25df4e000000b00629547bd83amr98521ybg.432.1646838631682; Wed, 09 Mar
 2022 07:10:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
 <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk> <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
 <CA+G9fYvCvBBi+dZ+CnUy=ZK6GhCFhBw72_==Cav=Q8QP5T1r5w@mail.gmail.com>
 <CA+G9fYt73AYs=z-BeZh22RBp==sf73pKky6m4iPSH7a4FssK7w@mail.gmail.com>
 <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com> <YijCkHHhpleeADAO@shell.armlinux.org.uk>
In-Reply-To: <YijCkHHhpleeADAO@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Mar 2022 16:10:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHRb6JSmA9Jx8ude+14US1S1XvzZg9i2QSnhF_8FP7h6A@mail.gmail.com>
Message-ID: <CAMj1kXHRb6JSmA9Jx8ude+14US1S1XvzZg9i2QSnhF_8FP7h6A@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 16:07, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 09, 2022 at 03:57:32PM +0100, Ard Biesheuvel wrote:
> > On Wed, 9 Mar 2022 at 15:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Wed, 9 Mar 2022 at 19:37, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > On Wed, 9 Mar 2022 at 16:16, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 9 Mar 2022 at 11:37, Russell King (Oracle)
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Wed, Mar 09, 2022 at 03:18:12PM +0530, Naresh Kamboju wrote:
> > > > > > > While boting linux next-20220308 on BeagleBoard-X15 and qemu arm the following
> > > > > > > kernel crash reported which is CONFIG_KASAN enabled build [1] & [2].
> > > > > >
> > > > > > The unwinder is currently broken in linux-next. Please try reverting
> > > > > > 532319b9c418 ("ARM: unwind: disregard unwind info before stack frame is
> > > > > > set up")
> > >
> > > I have reverted the suggested commit and built and boot failed due to reported
> > > kernel crash [1].
> > >
> > > - Naresh
> > >
> >
> > Thanks Naresh,
> >
> > This looks like it might be related to the issue Russell just sent a fix for:
> > https://lore.kernel.org/linux-arm-kernel/CAMj1kXEqp2UmsyUe1eWErtpMk3dGEFZyyno3nqydC_ML0bwTLw@mail.gmail.com/T/#t
> >
> > Could you please try that?
>
> Well, we unwound until:
>
>  __irq_svc from migrate_disable+0x0/0x70
>
> and then crashed - and the key thing there is that we're at the start
> of migrate_disable() when we took an interrupt.
>
> For some reason, this triggers an access to address 0x10, which faults.
> We then try unwinding again, and successfully unwind all the way back
> to the same point (the line above) which then causes the unwinder to
> again access address 0x10, and the cycle repeats with the stack
> growing bigger and bigger.
>
> I'd suggest also testing without the revert but with my patch.
>

Indeed.

And as I suggested the other day, maybe it wouldn't be so bad to
harden the vsp dereference, like below:

--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include <linux/list.h>

 #include <asm/sections.h>
@@ -236,10 +237,11 @@ static int unwind_pop_register(struct
unwind_ctrl_block *ctrl,
                if (*vsp >= (unsigned long *)ctrl->sp_high)
                        return -URC_FAILURE;

-       /* Use READ_ONCE_NOCHECK here to avoid this memory access
-        * from being tracked by KASAN.
+       /* Use get_kernel_nofault() here to avoid this memory access
+        * from causing a fatal fault, and from being tracked by KASAN.
         */
-       ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
+       if (get_kernel_nofault(ctrl->vrs[reg], *vsp))
+               return -URC_FAILURE;
        if (reg == 14)
                ctrl->lr_addr = *vsp;
        (*vsp)++;
