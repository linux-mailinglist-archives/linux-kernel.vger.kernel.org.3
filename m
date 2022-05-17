Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA7529B32
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiEQHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiEQHk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:40:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AAA4925B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:40:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f16so7010389ybk.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnwZrSLlP2BB5xIkW+a8cA8SwelHHc3AlZnDOhLB7fY=;
        b=fmYeJnWkAS9nTE9fMUFP6i5hntmsq7npf8EY7yzHx0UaacDLv3G/C8ZLxxRu965UYi
         6WrnZTUk4/ynjTBW5YIrg2CxkWG6wa601XaSoEUQ3QrjM8GbS5W52fncTYtYKO6FRFTV
         LU87alzVG0Eu+TfHcscqJZQPNGgGysP+BBugf2+pSvJBiYFlyOsxBSeLIA4t8s+c1sbR
         u/ERxPsYukBrWuD1IpGXhlM1RckHbkJ6X4i/tfkYEYv7lwNH+608AN65H83eGJ7QCbX7
         nFHY/rSz8iOCMxEUsGK3/JTjwrnW53FdPpzi4LkdJNK8VljZF2tMNuG0LvHO7XLO1oiy
         zROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnwZrSLlP2BB5xIkW+a8cA8SwelHHc3AlZnDOhLB7fY=;
        b=HLgS/9TIwPoNbVkMyoNSmcYMTOzXqeZyor3imGztgcZDdieQ/cJwwsHM3pQSXkdjPD
         h3CJAvdON/mJL+plcYb1iqzeTkYK/6VrcHXY3MD+s+Xo4CNSA6C+HSZK/h7wlTMPGQov
         LvJoZo3o9eod+FYv4utW2X5rqRAfQAU1O6xpWfmafUc40LjfeMoiGQIVSe0tuUzwPUgk
         mnQHShxzlWUsYDeeUehpMjNul/3mYmFiWQvDj5R/M52sTuUgMjEbzllTdnjH+oarffvi
         wBKEHA2DUi64MtVaoWnkgFYQaRViskYM/MINMvGWSL6f/7rtvmfft3bjNU/o8z7qIGm6
         uGrw==
X-Gm-Message-State: AOAM532TFMEDObRJn3ulx0ElaqQoXtxF9yWR4ag2gr3cMXVM8qXvfQl2
        0ADH+6j67GOZNBuaXKk41Zak0eoOvyTnoVtfa7s=
X-Google-Smtp-Source: ABdhPJx6n+IzK+xux+nTxf60oQGAo2eVyxguIm/g2TAQBS2ToTsNjN5emNpM63cZNsRUuItSxDuU11GYvan9T93ndzo=
X-Received: by 2002:a25:600b:0:b0:648:ef9b:172d with SMTP id
 u11-20020a25600b000000b00648ef9b172dmr21706811ybb.585.1652773227297; Tue, 17
 May 2022 00:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com> <a78343c8-2a6d-b223-4219-6b6b0a4fcb1f@arm.com>
In-Reply-To: <a78343c8-2a6d-b223-4219-6b6b0a4fcb1f@arm.com>
From:   Erico Nunes <nunes.erico@gmail.com>
Date:   Tue, 17 May 2022 09:40:16 +0200
Message-ID: <CAK4VdL2hCEoshWZbCh5mkHuS6wYMiPFR3v4MWTnrEKM9zyv6Mw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
To:     Steven Price <steven.price@arm.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Wed, Apr 13, 2022 at 12:05 PM Steven Price <steven.price@arm.com> wrote:
>
> On 11/04/2022 23:15, Dmitry Osipenko wrote:
> > Interrupt context can't sleep. Drivers like Panfrost and MSM are taking
> > mutex when job is released, and thus, that code can sleep. This results
> > into "BUG: scheduling while atomic" if locks are contented while job is
> > freed. There is no good reason for releasing scheduler's jobs in IRQ
> > context, hence use normal context to fix the trouble.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 542cff7893a3 ("drm/sched: Avoid lockdep spalt on killing a processes")
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>
> Reviewed-by: Steven Price <steven.price@arm.com>

Is there something blocking this patch?
Mesa CI is still hitting the issue and I have been waiting for it to
be applied/backported to update CI with it.
Thanks

Erico
