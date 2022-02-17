Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9567A4BA588
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbiBQQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:16:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242892AbiBQQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:16:45 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FF63EF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:16:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p15so131561oip.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytu0Gx4Ee/+5dkAxsCITxVC/7yyCoOiEqzDXQO8bwEE=;
        b=hW00c6ROWmn+snifswDQ5zvWgLKzzxTtorrsLYKzTPfbkWCSd8nyY5XFmOjZtuo6aT
         Kb0uJN4PiZPTx5bTQss59vSLEEKuDJNp0vp0AntkMIY+3uwLlIUrtLWF08DmkLa+pL0D
         PYt+YrKPtMIBECkSHxbiHGZCLRem4t6yfvaZlP30y8DUrl2+a4DZPydmZaG156nI43gq
         HHHmphpOUhIW41BwTVq6fSGOy9RX3CCGX2cGAhzE6dNSOFxz4RiDWTAyZ0a9ADCQCgjP
         FsIjuJjChETAP8qXmGZGN4GbfLSwe6lsutCPAs7zv3Qig/epukDh/XeewpqjoaUIxsSo
         OmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytu0Gx4Ee/+5dkAxsCITxVC/7yyCoOiEqzDXQO8bwEE=;
        b=blhn4OB6+at8DW0if6hdBFQqMaVSp8sPwxrUGgxjhUj+7bnP61xUtPV3MdX2ltKfbP
         vD0uJYdctOyElSW3fqrhny53hIUSqBVYfQ1XkH4bqBnQXBab7kTNLgmrTV8kvPSRWPX2
         dFJylVjohXtWU/d/uzmAnix+POdXenQiolnCYpQwMan1Qr0FgFS4Pnbr0voQTcTzNasu
         ucjmcITTgImdTb6nheDJy/+tIwAR36jOPCFP5DWaGdBDlkS6gfDZUluBpkO9c4Tn6OYz
         fyv2av2TmusDeQvw10qev/jYOVyhdEUKge9BPsTi3+5bLCE/uKxurqYZVUcRly3GNb1v
         2hMQ==
X-Gm-Message-State: AOAM532oyYysNZzz/7V5FUBaFt8T8xKvuN3OfxPISo+OMZtOJhNrIKrz
        2JJm3O6gTxD3h+/ToLgxrpsp9hiJKFRvccGHmQ4=
X-Google-Smtp-Source: ABdhPJx8wTyezWB9AK6JyxubX/zJkOWu5At1AfwaOAntEheYpYTl183pwdekUGsijpPNoomOiHIueXChIM2l1XK/Q7s=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr1147310oie.132.1645114585339; Thu, 17
 Feb 2022 08:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20220217153842.3252424-1-trix@redhat.com> <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
In-Reply-To: <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Feb 2022 11:16:14 -0500
Message-ID: <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Tom Rix <trix@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>, llvm@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Applied.  Thanks!

Alex

On Thu, Feb 17, 2022 at 10:57 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Thanks for catching this.
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
> On 2022-02-17 10:38, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > Clang build fails with
> > amdgpu_ras.c:2416:7: error: variable 'ras_obj' is used uninitialized
> >   whenever 'if' condition is true
> >   if (adev->in_suspend || amdgpu_in_reset(adev)) {
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > amdgpu_ras.c:2453:6: note: uninitialized use occurs here
> >  if (ras_obj->ras_cb)
> >      ^~~~~~~
> >
> > There is a logic error in the error handler's labels.
> > ex/ The sysfs: is the last goto label in the normal code but
> > is the middle of error handler.  Rework the error handler.
> >
> > cleanup: is the first error, so it's handler should be last.
> >
> > interrupt: is the second error, it's handler is next.  interrupt:
> > handles the failure of amdgpu_ras_interrupt_add_hander() by
> > calling amdgpu_ras_interrupt_remove_handler().  This is wrong,
> > remove() assumes the interrupt has been setup, not torn down by
> > add().  Change the goto label to cleanup.
> >
> > sysfs is the last error, it's handler should be first.  sysfs:
> > handles the failure of amdgpu_ras_sysfs_create() by calling
> > amdgpu_ras_sysfs_remove().  But when the create() fails there
> > is nothing added so there is nothing to remove.  This error
> > handler is not needed. Remove the error handler and change
> > goto label to interrupt.
> >
> > Fixes: b293e891b057 ("drm/amdgpu: add helper function to do common ras_late_init/fini (v3)")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index b5cd21cb6e58..c5c8a666110f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2432,12 +2432,12 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
> >       if (ras_obj->ras_cb) {
> >               r = amdgpu_ras_interrupt_add_handler(adev, ras_block);
> >               if (r)
> > -                     goto interrupt;
> > +                     goto cleanup;
> >       }
> >
> >       r = amdgpu_ras_sysfs_create(adev, ras_block);
> >       if (r)
> > -             goto sysfs;
> > +             goto interrupt;
> >
> >       /* Those are the cached values at init.
> >        */
> > @@ -2447,12 +2447,11 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
> >       }
> >
> >       return 0;
> > -cleanup:
> > -     amdgpu_ras_sysfs_remove(adev, ras_block);
> > -sysfs:
> > +
> > +interrupt:
> >       if (ras_obj->ras_cb)
> >               amdgpu_ras_interrupt_remove_handler(adev, ras_block);
> > -interrupt:
> > +cleanup:
> >       amdgpu_ras_feature_enable(adev, ras_block, 0);
> >       return r;
> >  }
>
