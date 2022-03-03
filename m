Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20EF4CB458
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiCCBfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiCCBfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:35:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57661AE654;
        Wed,  2 Mar 2022 17:34:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gb21so3354984pjb.5;
        Wed, 02 Mar 2022 17:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJe6o6kOYUsVDZGZdIQBgO3hTT0nURrPq8TyLaBL26k=;
        b=Ji3otGrQQO90v6nf+Pw0zJXjsReY+4IjW093S6IgLizJrTza5WMcsk0sMiXJdviB+j
         Gh/xZapihQUXk85y5My0tcVzcCuk8AkqgJDrnZXt66EMyzvwySzGDKm5qirXLkCDOLa9
         r0BKQJj1PHblhVXqTk5umT/zQ8zvNYJiHOtkv8tWAhAAhXVNf2Mi7GKDitx2OSSr13SG
         RAJanLoAAPSd6qzFEOEk7LuaUbXGfaPd7BwQT/vCAp2c8r/EFP4NZanbRvyVdZuXbLgT
         khSadLdadCKnYa5ZhmantnCSs50Jck+Mb67Gu4iDKgfgFndBgWiTGew/b/yokahgewlj
         YdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJe6o6kOYUsVDZGZdIQBgO3hTT0nURrPq8TyLaBL26k=;
        b=4qE97CHRdLiEguVp5uJto5xCdm95Pj3ZqLgYwoYTEwjc7O04f21XK8CiI6uZlPi7+e
         fGWEN5palfGCNw5BDhX+yalkOS60yCyRmAgFwv0M6Y7Qrd+rGJ8EZwX/2SMVljW/X1Qh
         9x+NsnkFM777QlhO5eo2TVMtsWixuVOBmm1vnMUQWK6GvrFJ+DQce6DwPXTqLn6x539Z
         1PqX92L8gbYtr5kmcRV14eiFEQr5yy6vqUtMrsJJ/pRWXn8etnBlU8t8FU1Cbtl2lqh9
         7NMGTTPi0Z0JkW+l/khL1GfdueOdLGMpKdckSUf83+Uclein7wRSNrcgqHVdLKZj4SW5
         mNUQ==
X-Gm-Message-State: AOAM532csGb2HqYD4HUIV80GBMrKNJufXwAAsf7oafZAaD9+myqnOFKF
        KSS104v3oubWHfUTe3wE7udiUhovJNOqH5wHSg==
X-Google-Smtp-Source: ABdhPJyKZkyhTgZtgkuDJ8TTOmVDM/RSZPhspXLa7591Zm5jXxcfkynti4aLwIUGC91ivpRbH5lsbpG1H9PVxg/0re0=
X-Received: by 2002:a17:902:8a91:b0:14f:969b:f6be with SMTP id
 p17-20020a1709028a9100b0014f969bf6bemr33826185plo.161.1646271291341; Wed, 02
 Mar 2022 17:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20220302143311.2109322-1-zheyuma97@gmail.com> <666d1565-0467-bb21-916b-073392129e1a@gmx.de>
In-Reply-To: <666d1565-0467-bb21-916b-073392129e1a@gmx.de>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Thu, 3 Mar 2022 09:34:40 +0800
Message-ID: <CAMhUBj=P82_f6LdhWqEbe06SRPrMU2jxquNzgWkrttGDy6C4Kg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: sm712fb: Fix crash in smtcfb_write()
To:     Helge Deller <deller@gmx.de>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 3, 2022 at 12:49 AM Helge Deller <deller@gmx.de> wrote:
>
> On 3/2/22 15:33, Zheyu Ma wrote:
> > When the sm712fb driver writes three bytes to the framebuffer, the
> > driver will crash:
> >
> >     BUG: unable to handle page fault for address: ffffc90001ffffff
> >     RIP: 0010:smtcfb_write+0x454/0x5b0
> >     Call Trace:
> >      vfs_write+0x291/0xd60
> >      ? do_sys_openat2+0x27d/0x350
> >      ? __fget_light+0x54/0x340
> >      ksys_write+0xce/0x190
> >      do_syscall_64+0x43/0x90
> >      entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Fix it by removing the open-coded endianness fixup-code.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>
> Thanks... it's already in the fbdev git tree and queued up for v5.18...
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?h=for-next&id=bd771cf5c4254511cc4abb88f3dab3bd58bdf8e8

This patch fixes the crash in smtcfb_read(), but there is a similar
bug in smtcfb_write(), and I mocked up your patch a wrote a new patch
for it.
So we should fix two bugs with two patches.

Regards,
Zheyu Ma
