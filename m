Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B515E56AA67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiGGSWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiGGSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:22:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9F57271
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:22:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dn9so28572016ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6ncolguiQ+DPHRmzlhAw1z57F0HnokCJKSQgzd3UQs=;
        b=ohjqe3h1JnbCwaBEIZ2d69QR8cz52UUygEFiOvnMYGlCpXpnR1Qmj4YvAuvK0EJiWY
         4FGWd1fhgqJ8Hh/fZ0Up/Iu7IjXoofz/xMywSFCvKE8NSlPntfPXJZXlicN6Xw2E9/6l
         uFb+mi5Dacf9U9diBw77SQKNmaPSR3msiqmJY1fQA6skgYg/D7VFo/r7b52ybuRrtb1I
         fEii4Ih35R9wz1QXi0i6uzhivzSvYEXvDYNQmTAK/sOTg+IckYEmgXnTc9rTEml/aFgo
         y6NemwFJTWIUgYrRhYMmXfajWOACfbStbqrgZEYPmoeAnLoWh1oCHM4dWsKrmRJJnhxm
         9FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6ncolguiQ+DPHRmzlhAw1z57F0HnokCJKSQgzd3UQs=;
        b=IyNFIi+CoBywsG81TniDI+dpDLxAkGsBUXXcZZ7V1WbOJwPbOdmgud3Q5TnHFKFdXq
         BvQby06cjUU3WsXKGjr4Bigx4gMClpo6dGTLQJxHHiuCXJ2zoggsxr9bMs9FNZAFWNoJ
         e5BM6O+2pXuplvEveyenFSsyrNc88+WbI/jfIL+TlTx1AyIeiBj+mp77WSqrraZE7A9f
         h/wvrnvWw83ymMbbj7UoKcOQHKzEUFlYcaoDPeoj2R2/ym7fzCMpZl0btnOPlqbzAbvn
         bpatFXbJZ/MK6nQu8ht4f3TB3ut77ErX2XcW4fMHSanqo9D/yCI1BEwlNEH0Qsbi54O3
         uncw==
X-Gm-Message-State: AJIora9B6HW4t3oYm5+ahCgCGNNs+4Y0gBhShWoYgzOa5eB9rhMQuWwa
        j94l65W+8F/L0Eh01sxCYomJcslYd0XQtFhuKgrHR0hK
X-Google-Smtp-Source: AGRyM1vFFoUfixEhOUfl68/WDDiWcPlIS3gYGV84R38m2q33oIwZHt0dcJvwcUsnsfbSVJdNmTunjpQ6rR123O2EcU0=
X-Received: by 2002:a17:907:a40f:b0:726:a8f5:1031 with SMTP id
 sg15-20020a170907a40f00b00726a8f51031mr46947213ejc.185.1657218152576; Thu, 07
 Jul 2022 11:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220706063951.54122-1-hbut_tan@163.com>
In-Reply-To: <20220706063951.54122-1-hbut_tan@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Jul 2022 14:22:20 -0400
Message-ID: <CADnq5_NpXcua54cSeSGaG2X_afcvoGswKgSb=Gysr5gpoT0AHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsigned expression compared with zero
To:     Zhongjun Tan <hbut_tan@163.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
Cc:     "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        cai.huoqing@linux.dev, Zhongjun Tan <tanzhongjun@coolpad.com>,
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

On Wed, Jul 6, 2022 at 3:41 AM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Zhongjun Tan <tanzhongjun@coolpad.com>
>
> Fix unsigned expression compared with zero
>
> Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> index 548cdef8a8ad..21e4af38b8c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> @@ -244,8 +244,8 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
>         bool req128_c = false;
>         bool surf_linear = (pipe_src_param->sw_mode == dm_sw_linear);
>         bool surf_vert = (pipe_src_param->source_scan == dm_vert);
> -       unsigned int log2_swath_height_l = 0;
> -       unsigned int log2_swath_height_c = 0;
> +       int log2_swath_height_l = 0;
> +       int log2_swath_height_c = 0;

@Wentland, Harry Can you comment on the required range needed for
these integers?  Maybe it would be better to just drop the comparisons
with 0.

Alex

>         unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
>
>         full_swath_bytes_packed_l = rq_param->misc.rq_l.full_swath_bytes;
> --
> 2.29.0
>
