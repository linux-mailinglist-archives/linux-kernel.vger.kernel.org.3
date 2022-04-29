Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB65514F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378261AbiD2PV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377845AbiD2PV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:21:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1EF60A95
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:18:07 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-d39f741ba0so8415041fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVKH9E+l7o2XudEOKH10/8Spo2yzScp0hzyP8QBi7BE=;
        b=JY7Q/ILOzg3ysXd9geh9fS9vWGHMd+NT6LqqxD1FH1YKig/AUTIyAJgQzgJTWp2YYt
         RUnLugHV/CY4y/L8n2vZx8Wlr0brkPm8eFpaH3bG4UENdLUFJ7emmoVdsKqn3NwxUhGi
         Gvee27j8FwozjSEXGPfuojiDp9cqm+gX1ieMrhvVgFok7Ci9b1V8whVmpEVV/nTdpWvA
         zh6gXX8ofsP64q3KH1uBLTpSzNxdY0DR/Sm+sTuDgATwZ3XSUuudDzgJjNECS+fA6IZi
         D+vVqyD6ZrNG5qbjdarPLWJ1KEJdtZssTLD8860ohjmFmM1joSCSMRx5mecsxpw2dnXs
         3f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVKH9E+l7o2XudEOKH10/8Spo2yzScp0hzyP8QBi7BE=;
        b=B0jb9a0GPMGGiftKvEbPu5iC4AmNUk4K8whH2wYrJAYOQWnsB4VFs0y/Uqf15El+zs
         LvgCrGpsVFJ9OZA7lM+F3QnF8+WuvxPCm4SS7MNgaT/nVfT56pIWigHjM4kSgyFd21ZE
         lGoBRju/VrDxwQZtH9OL3C3mgIZGng08zuvZnMc297eJ8ld0pqkBQ16juv2s0TyJPacw
         n1hNcjXdpUn2pFsOwEWe0owKf70m6z9NWHiokTW77vvhtasU3E0LdPBdXMirW/BDR9Se
         hnyu75EsaN68qJ8VOzzAlXOhf1xD/vgKJG72zjzGUehPCm5FJSMOHUH6TaEkEK/sgfOL
         uFcg==
X-Gm-Message-State: AOAM532SRKOs1muK1INEqLNbw65pweEgcjenuvP/O5WZfhuS7eCdD70D
        a3W9Fu40irQ36df3ROhTJrqJ4ht5JIyKlD2IAmI=
X-Google-Smtp-Source: ABdhPJxwBcfHMKT9AQjsJUPy7CWDdzvL4iBKjdwzdC6eu1LFYOZLa5zoFvTyB5EGbAMeY7Dy1Dd01LOpWKrIn+rUYFk=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1483544oaa.200.1651245487284; Fri, 29
 Apr 2022 08:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220429055037.3852147-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220429055037.3852147-1-chi.minghao@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 29 Apr 2022 11:17:56 -0400
Message-ID: <CADnq5_OJ7dvj8kh6AjQ6cSBMEqAbfDo5Gj7rFV+fpf+=RoXkzA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify the return expression of navi10_ih_hw_init()
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>, Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Minghao Chi <chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Apr 29, 2022 at 1:50 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Simplify the return expression.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 97201ab0965e..4b5396d3e60f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -593,14 +593,9 @@ static int navi10_ih_sw_fini(void *handle)
>
>  static int navi10_ih_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = navi10_ih_irq_init(adev);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return navi10_ih_irq_init(adev);
>  }
>
>  static int navi10_ih_hw_fini(void *handle)
> --
> 2.25.1
>
>
