Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB09D4E4A93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiCWBk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiCWBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:40:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29887220EC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:39:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so338177pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieZ1YNZMdPMDle0nXlJhObnK0W4J43jf9cWsuNGkhUY=;
        b=iDjGY+J/5JvZcOb7jtGwUMPA86RmY+2Kd08u46Z4q1s0ZgozamxL6GZnVxGe4jiQ9B
         Ror0YmrKSXvrr2/xyj9TCPLtJkG0912nL9Ie7pcefbtt+N+D9r41oMa33PsswaGOxZp8
         rux8O2+CS76kYQHT92Uh9EP/edacCSVf3VpbIHSVcftb00FUq5DbEnC+k2vyEc3Qh3+9
         IDdiy0OzGMngKa9GfKlpTf23aNO5KBf3MVs56/ELlfGOCUc960xE47idnHnTTZRUd2dE
         lYRybJS3nHsAG/4MoztI28+HVklC3EkNVZh0JVVGKx31vedl5klbnmrcqcxntEchTSCa
         LfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieZ1YNZMdPMDle0nXlJhObnK0W4J43jf9cWsuNGkhUY=;
        b=czyOHaCJsjfqTtEJ0Qs/99cijMgcFKMtI5haroKHLxMBfcPD78vX36tfpxtC1y5rQj
         Wq6GA3xoXem3MseGI73j+GfPPKWRJDrXZKa6/Y3BiiR7eyApvu0GRKc+vYBCwuqzdu58
         S7vZqISEdVNcza7FlzJUxTFkQrTAAKdDRQnZLTFVsPvuruEQEpO7kkngpdusuXqs5JA3
         Y+tW0rwzFh3BCBPNvuUvseHFtia/Z2LozhNEISkEEtCbJxsS7y2ybDXRwYoPoLJKnSjE
         tdO40mCDbE0Z2nHgugCBOuBTU/nb35uIxXB+0/AUImbvlM4p/vxq+y4CwO4E9R52Xk3T
         FNdA==
X-Gm-Message-State: AOAM530tUje+gckjqtvSxZ5Wys/usKg5p5mVvK9RfJvd4ITvI+XP6UM4
        SFkyAq8wkRJdm8j7wqGXSElW7PLjjgRGCyo2xg==
X-Google-Smtp-Source: ABdhPJykxCUGEMdCG/iVtspeqcFCatcsR4M7mlCCgk2FUckmO7eqpB1Pl7YNEqGaJ18raP5HtezEbI/KGXBVxP4V/j8=
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id
 lw3-20020a17090b180300b001c724c4ab52mr8404054pjb.240.1647999565452; Tue, 22
 Mar 2022 18:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <1646983382-30036-1-git-send-email-zheyuma97@gmail.com>
 <YjMSMIrbsVZjEw8W@phenom.ffwll.local> <CAMhUBjkohp=-4YZ7x6Yyf4tQr_2zCoR+RVmEZPGLoXTEhNoPFA@mail.gmail.com>
 <Yjnc1A2heVopcyXh@phenom.ffwll.local>
In-Reply-To: <Yjnc1A2heVopcyXh@phenom.ffwll.local>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 23 Mar 2022 09:39:14 +0800
Message-ID: <CAMhUBjnRP+Jb8MY9T02hVH=rQ-hdKxb9UDYpN4twHUywiBoVDQ@mail.gmail.com>
Subject: Re: [PATCH] drm: drm_bufs: Error out if 'dev->agp' is a null pointer
To:     Zheyu Ma <zheyuma97@gmail.com>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
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

On Tue, Mar 22, 2022 at 10:27 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Mar 21, 2022 at 09:02:47PM +0800, Zheyu Ma wrote:
> > On Thu, Mar 17, 2022 at 6:49 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Fri, Mar 11, 2022 at 07:23:02AM +0000, Zheyu Ma wrote:
> > > > The user program can control the 'drm_buf_desc::flags' via ioctl system
> > > > call and enter the function drm_legacy_addbufs_agp(). If the driver
> > > > doesn't initialize the agp resources, the driver will cause a null
> > > > pointer dereference.
> > > >
> > > > The following log reveals it:
> > > >     general protection fault, probably for non-canonical address
> > > >     0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN PTI
> > > >     KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
> > > >     Call Trace:
> > > >      <TASK>
> > > >      drm_ioctl_kernel+0x342/0x450 drivers/gpu/drm/drm_ioctl.c:785
> > > >      drm_ioctl+0x592/0x940 drivers/gpu/drm/drm_ioctl.c:885
> > > >      vfs_ioctl fs/ioctl.c:51 [inline]
> > > >      __do_sys_ioctl fs/ioctl.c:874 [inline]
> > > >      __se_sys_ioctl+0xaa/0xf0 fs/ioctl.c:860
> > > >      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >      do_syscall_64+0x43/0x90 arch/x86/entry/common.c:80
> > > >      entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > >
> > > > Fix this bug by adding a check.
> > > >
> > > > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > >
> > > You can only hit this if you enabled a DRIVER_LEGACY drm driver, which
> > > opens you up to tons of other CVEs and issues. What's your .config?
> >
> > Yes, I enable the DRM_LEGACY option in the config.
> > I think you mean this is not a normal configuration file? Do you have
> > a recommended configuration option for when I want to test the GPU
> > driver?
>
> Yeah DRM_LEGACY gives you all kinds of horrible and known-broken
> interfaces. Don't enable that :-)
>
> You have a bunch of other drivers enable which require DRM_LEGACY, so
> those will disable too. Anything else I think would be an upstream bug and
> we'd need to adjust Kconfig (or fix the code).

Thanks for your explanation! I will pay attention next time.

Regards,
Zheyu Ma
