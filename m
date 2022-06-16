Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7054EDA9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379213AbiFPWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378857AbiFPWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:54:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC462233;
        Thu, 16 Jun 2022 15:54:29 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b138so2925591iof.13;
        Thu, 16 Jun 2022 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qs/jEqJkbgzcEUoEFkoJzijODSfrMvSC/4IDtEIJDn8=;
        b=WjRKkIJn6q5BG9lml+FODpDUwiGYbSeSCEGJjoiTU8puE6GioJLPlR3ur43+Zl8eVa
         JYSYI6wkpSEjFKvB0xQ1oMJtPyOS/+97eX+SvoE1QEC5fkV+k7rxPi1ca+X9o78l9s4s
         JnUdxEDtjSArSHSUJ245Yo2LYB37pK5OZ6MAhkod9cv2J+WncJelVdx04qkgVcMWkTB5
         SrtlapNOsUmD/2RET8qBFIoZMDE6uKhy+/JVh8k5H4lEA4v74mIauFejTvurZkmeEzDK
         wPcVZaP8OtYzB6rFKjb6JnDOY+3L28ylA9j14bIERuK27v1PX3qytxRwiTswckP3dU91
         jXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qs/jEqJkbgzcEUoEFkoJzijODSfrMvSC/4IDtEIJDn8=;
        b=ptp1ibB4rP2ytF1uvtNd37n3XJ9GufPKU+kxZaGpz53vl8LWlSdYG74UNHGRPTgs/M
         0bXE3Vi3Rfd7HRvHhIwMcXHAeBlQIDc4AlYD5+7JNM50hXEj5LcBZf+z2BWj44vgvwpb
         PYRy1ON2zEuh/K0sqYmhbTN+hn9A62I7CK2GIVXlztdcW2cw8ZDYZDbnrHNNPjAOueMV
         vqHPAtIlt8M9Ovfv0uX/hUSAYF0t2YgdD1pxEIpiDSe45KK6yApA68Q4EbhMbcnrFE+j
         VSKUxaAM4M4W1F1ZwOo+WFzardV4U8zPIIWrr8dyBTmuATdvkM7hzPjd6Quqp6z5gG1E
         442A==
X-Gm-Message-State: AJIora9ud+mqcV+e6IQwuKuhmrLdLDsEbiD4we/dc1hd56o2X8FdlGG9
        XngyogeqHceCWdF5SxA8LnxdBHlON4EKZzOsJww=
X-Google-Smtp-Source: AGRyM1uKdkKdJAzIlavmx5oXJrk63yzsq+ZrVSqDjHhWQ5Uv3WPJBAwZR+oPnlHYsM4MTJI2hXZ6Nx2NtgUAcgf1DBY=
X-Received: by 2002:a05:6602:26cb:b0:648:f391:c37d with SMTP id
 g11-20020a05660226cb00b00648f391c37dmr3617629ioo.198.1655420068983; Thu, 16
 Jun 2022 15:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz> <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
In-Reply-To: <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Jun 2022 00:53:53 +0200
Message-ID: <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
> >
> > Until the link-vmlinux.sh split (cf. the commit below), the linker was
> > run with jobserver set in MAKEFLAGS. After the split, the command in
> > Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> > is lost.
> >
> > Restore it as linkers working in parallel (esp. the LTO ones) make a use
> > of it.
> >
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>
> Nice catch.
> ( I have seen some slowdown in my build-time. Will test and report. )
>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
>

No measurable difference in build-time.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

-Sedat-

>
> > ---
> >  scripts/Makefile.vmlinux_o | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> > index 3c97a1564947..d032f625b576 100644
> > --- a/scripts/Makefile.vmlinux_o
> > +++ b/scripts/Makefile.vmlinux_o
> > @@ -65,7 +65,7 @@ define rule_ld_vmlinux.o
> >  endef
> >
> >  vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> > -       $(call if_changed_rule,ld_vmlinux.o)
> > +       +$(call if_changed_rule,ld_vmlinux.o)
> >
> >  targets += vmlinux.o
> >
> > --
> > 2.36.1
> >
