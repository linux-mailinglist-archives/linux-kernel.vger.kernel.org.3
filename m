Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9569750F395
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiDZIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiDZIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:25:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D5C3A183
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:22:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t13so15478355pgn.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYVekr4YvbLsHucHgm8G116TEThN3UMClXJfeXv+hU4=;
        b=Nb0f085ZebEJPCinOt6pZuFn0qnmDisNJu5Rk80wCa2s+nzszKjhhN4UYYPkQf6Acl
         4MNxkF4dJar7sBIPLss1tBOwkJIQPxjxDiJhtK+qBWVV3FueQ7Y3/3FNXr4iEj6LLWQ0
         XtKDYU3kDmdNcLu0lZTv3l1D1v8FEexelBTge/3sgZ1G2+x/gnzegDDxD7OWEEqauFPo
         Dyh4tqvAiTtlFtRibQNGYrzkR+45N/GSrL65LCMM6ZIYcS2gUX/5TrsQf/m7AWZIsDlz
         HCl0y0xFw62Tkv9V9sIeieoOmG678iXvg1SIo/di5OfVnOIVtnLujz92GTkOopXwSOqg
         Pa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYVekr4YvbLsHucHgm8G116TEThN3UMClXJfeXv+hU4=;
        b=eb8au87+HbSnDhVZH4eifnAbAeUKTYI5nsAIBnwK/gDmZOFmrbVE/obqlwBqn901xb
         6H9HC0K9DHtIt8ixGoHsQo1Thj69WNmOzYBdpX0R2peXloHvzY6jgOd18BRjgX0fE/24
         Y/TJAjwR+mFm26YOdt/wd/KWWB5bWawULhQBfyB8CTyO8OvglA3/B24Q0P7SjT2+uTHk
         ej4sLUBsuWcCwvexETnSP9ZdgOp3Y5EpoWYlEN/pbpb2jdvAugx6GH/gVABeUZImTPYu
         tR3JlLBg+yX9RZIHbJ2spbeYiIb7+XkpNJ/RzWV2oSpm8nqJXkq4Vg/VoaIMdxE4ntmi
         x+LQ==
X-Gm-Message-State: AOAM5338Zas5qD3Jq2uoJ8VmQEnloKl3B8ALz2MrITuF73FmS833pBE1
        vzelZW8hWT+c4tYNXCx98uM7hDOqOAvAKC3ambR2Hw==
X-Google-Smtp-Source: ABdhPJybbRW7pdqOBNu6OOPzoqNan/UX/T0v/4RUTxOJQn1Z3o8uYdUQoDVJmhHDZY+9YjyLjHQlZWEfPkhhw0B3A+Y=
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id
 h16-20020a056a00231000b004fa7eb1e855mr23543830pfh.14.1650961323839; Tue, 26
 Apr 2022 01:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220425141617.23925-1-afd@ti.com> <20220425141617.23925-2-afd@ti.com>
 <CAFA6WYN7GG6ZgxQ=AMinZ91f7QDh+aEPhL-Obx1s=zqReViAew@mail.gmail.com>
In-Reply-To: <CAFA6WYN7GG6ZgxQ=AMinZ91f7QDh+aEPhL-Obx1s=zqReViAew@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 26 Apr 2022 10:21:53 +0200
Message-ID: <CAHUa44H34Wh-Hpw9LzSS3KsKYethLMo_ih+9BafWCvW_TDU=3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Andrew Davis <afd@ti.com>, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 4:18 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 25 Apr 2022 at 19:46, Andrew Davis <afd@ti.com> wrote:
> >
> > These look to be leftover from an early edition of this driver. Userspace
> > does not need this information. Checking all users of this that I have
> > access to I have verified no one is using them.
> >
> > They leak internal use flags out to userspace. Even more they are not
> > correct anymore after a45ea4efa358. Lets drop these flags before
> > someone does try to use them for something and they become ABI.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >
> > Changes from v1:
> >  - Removed flags return from tee_ioctl_shm_alloc()
> >
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit
>
> >  drivers/tee/tee_core.c   | 2 --
> >  include/uapi/linux/tee.h | 4 ----
> >  2 files changed, 6 deletions(-)


Looks good to me, I'm picking up this.

Thanks,
Jens

> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 8aa1a4836b92f..af0f7c603fa46 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -302,7 +302,6 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
> >                 return PTR_ERR(shm);
> >
> >         data.id = shm->id;
> > -       data.flags = shm->flags;
> >         data.size = shm->size;
> >
> >         if (copy_to_user(udata, &data, sizeof(data)))
> > @@ -339,7 +338,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
> >                 return PTR_ERR(shm);
> >
> >         data.id = shm->id;
> > -       data.flags = shm->flags;
> >         data.length = shm->size;
> >
> >         if (copy_to_user(udata, &data, sizeof(data)))
> > diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> > index 25a6c534beb1b..23e57164693c4 100644
> > --- a/include/uapi/linux/tee.h
> > +++ b/include/uapi/linux/tee.h
> > @@ -42,10 +42,6 @@
> >  #define TEE_IOC_MAGIC  0xa4
> >  #define TEE_IOC_BASE   0
> >
> > -/* Flags relating to shared memory */
> > -#define TEE_IOCTL_SHM_MAPPED   0x1     /* memory mapped in normal world */
> > -#define TEE_IOCTL_SHM_DMA_BUF  0x2     /* dma-buf handle on shared memory */
> > -
> >  #define TEE_MAX_ARG_SIZE       1024
> >
> >  #define TEE_GEN_CAP_GP         (1 << 0)/* GlobalPlatform compliant TEE */
> > --
> > 2.17.1
> >
