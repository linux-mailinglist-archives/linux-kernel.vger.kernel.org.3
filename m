Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A874949357F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351974AbiASHct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351693AbiASHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:32:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:32:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso564097wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oywy9ftbribAzFibwUS70C/yiewBFP7MYNcFHdRZvzs=;
        b=gK7OSiLCBQBsCd7ZtzUEVrI6AvYOUIoUSHJxJHJ5Vpu5qEEYM2yJxk16x7UzEfjd0d
         qry5ZcCNMFtrM9/pcckWhwoio0jrfeHN9tZcfivzrI1c8L0IkT5H3KhD86QFNmQ6Mjzo
         lJxOSwxn64pI+v0p8msVW72CAlAUC4WjZKVobXj1qL0ncpt1p6Srj3XhByiUeBbFS/7Q
         CG+cxuGAXqk4djvOKlj0S0hdJaRI3pjjM7WL9DT9yUZEdE+6ZEVCOonkkyq77ri+l0wa
         DPcOpCtMhD8ID6rPzoIXzESE++exmAigq5UImS59acsBPO3I9FuuvKVqqTITEnXaUrTq
         jwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oywy9ftbribAzFibwUS70C/yiewBFP7MYNcFHdRZvzs=;
        b=W7cc3D0O/qpJOepV35liTHczlz0DdWcCIrK4/0qmNVr/DCjMlmtuBKLseJV3fSCsH8
         75mglFdzNgyx/njdB3ulEkQeQcY37wFq6DYXUYPGfxES0Jm1AOidJRaGFB0E/MOc7ZkU
         4WsZsCRFm9oGq/UwRrqa0YW04lS9SIPJu3jy/bIVJbK2l3V/k/CREe0owiPkShW0MaQE
         TzsCw2ub1XXRzeLEbiCW77EdUOXOhRgAvVkpZiYGw1AjyOkMldvJmI8TvPEdffISM4L3
         qLMe2qgdXXy0yxYaBt3A92f86M6ZDCra9YzN1M3l4Igx7jTagUqe09IF1OxrgtFwVC5e
         5pzQ==
X-Gm-Message-State: AOAM532dfa/8ePXGy6jix19Ur9NO+6zAjvqAVgYnmFTaqLddUjg6rUCj
        rupBlKZeSgaIsIkHJl+jD2sN8N+/M5xcckryjj+z545A1bE=
X-Google-Smtp-Source: ABdhPJy9aT/mumRNRJ29sNyrscW+MelX5f6AlEHcaOaE3YGVHUnvxvngGVSJxRNTE29eInkHtkhC8Fyb2npmyBuy4k0=
X-Received: by 2002:adf:e312:: with SMTP id b18mr21998166wrj.321.1642577560786;
 Tue, 18 Jan 2022 23:32:40 -0800 (PST)
MIME-Version: 1.0
References: <a4e48364368cce3c91005a3bd4fdacee086ef00d.1642087405.git.jerome@forissier.org>
 <CAFA6WYM94k7n3mXA7UpGxL=J5TYJFXSa6KWhqjHPzS63SrNCpg@mail.gmail.com>
In-Reply-To: <CAFA6WYM94k7n3mXA7UpGxL=J5TYJFXSa6KWhqjHPzS63SrNCpg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 19 Jan 2022 08:32:30 +0100
Message-ID: <CAHUa44Hff45AQxpqPT5_pKF3hTNGmcxhuGphdND=NRJVUpj5og@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: do not check memref size on return from
 Secure World
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 1:05 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jerome,
>
> On Thu, 13 Jan 2022 at 20:57, Jerome Forissier <jerome@forissier.org> wrote:
> >
> > Commit c650b8dc7a79 ("tee: optee: do not check memref size on return
> > from Secure World") was mistakenly lost in commit 4602c5842f64 ("optee:
> > refactor driver with internal callbacks"). Remove the unwanted code
> > again.
> >
>
> Ah, that's unfortunate. The refactoring that OP-TEE driver has gone
> through to support multiple ABIs (SMC and FF-A) was huge and I missed
> it during review.
>
> > Fixes: 4602c5842f64 ("optee: refactor driver with internal callbacks")
> > Signed-off-by: Jerome Forissier <jerome@forissier.org>
> > ---
> >  drivers/tee/optee/smc_abi.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index cf2e3293567d..09e7ec673bb6 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -71,16 +71,6 @@ static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
> >         p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
> >         p->u.memref.shm = shm;
> >
> > -       /* Check that the memref is covered by the shm object */
> > -       if (p->u.memref.size) {
> > -               size_t o = p->u.memref.shm_offs +
> > -                          p->u.memref.size - 1;
> > -
> > -               rc = tee_shm_get_pa(shm, o, NULL);
> > -               if (rc)
> > -                       return rc;
> > -       }
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.32.0
> >
