Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483756ACEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGGUp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiGGUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:45:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4101EC7A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:45:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd6so24600307edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8b0kNH+mf64WowheLy0t8fPMJjHTnvWvV3xGK03JawY=;
        b=NpiRS+xQXwP+V0/ZYaobHAzR01/Ps/WK3+RkGwFc/HRL44A9ok013W3tDmZr7pq8kf
         orn07Xp5Kevn554XJxdMNfKtg8RFZc0/Y68+jWe9zWVVp/H5VQEAI4BQx3GArdEkV1Ju
         H9uDGpcBsyY84DVz2rhkJJZCcQPAgt9cAS25+dqCr/FgjlLaIT3XGNmqWetYLev1Udjl
         FipfVpdXy9/SmfPq0zQ5Fe0o/rS5n/4VrgY8NW+rLas3pyLhYfOPZv4HkwV2mRnQKhEh
         hQKX4f3E1mlldrWPxM/hmLSyD+aRePnFcOhGx+8OYqgekHCW5zBqqjrmpQUTqx4cNxLh
         7J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b0kNH+mf64WowheLy0t8fPMJjHTnvWvV3xGK03JawY=;
        b=wQvmf2NPUTHNNvFvwtjbTl9JBU2l1CrJhNY9NLKVOcNvHL4zflXp7so5djQ/OATY1H
         NXWmaUkVAeHWnN6J09x5iOPX/fXXeOEzWdk660Nq7mCddigoHrYCNFtOQj3DdUTT6OGp
         1/UyVlgdHWRfgzREymXz9d4rmtCo8egjWyZB8Bpqoos8pv81h2XINqDt3Ot/dyEywcSE
         0HKJfhCHBeAX2i4fjYsXVj2K7yCGoPB3YCsbzPcb8vo/wHqq6gnCQEJCnV16aSETY0Tq
         hbKMxGeiI882eo4BDdsmXmEsK5Zd/CKGbtUyZ7eqkjKIOKRQZdFGjsoeMtr9WUm95AMm
         BKkQ==
X-Gm-Message-State: AJIora+W+4kJZdTsA2vnG90KEl1voiP+Q0M3D5k/0PoaofZB3IsyVsyj
        8m+QJ0sPpCFcgGCFGT7KFGOneI3awq+3zhOzw6w9+yWs
X-Google-Smtp-Source: AGRyM1vt/5gj6C7ggw3jfDDriN4sNUUIiQ/+rhA6PMFiH+IpKPILML7r8Ir3YtLSf2VP3OKaSdIMxHL90fGmf9q5Lo4=
X-Received: by 2002:a05:6402:28c3:b0:43a:6d78:1b64 with SMTP id
 ef3-20020a05640228c300b0043a6d781b64mr28680140edb.93.1657226718744; Thu, 07
 Jul 2022 13:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220706063951.54122-1-hbut_tan@163.com> <CADnq5_NpXcua54cSeSGaG2X_afcvoGswKgSb=Gysr5gpoT0AHw@mail.gmail.com>
 <51186366-a040-f99d-f43b-bb6ac771f20d@amd.com>
In-Reply-To: <51186366-a040-f99d-f43b-bb6ac771f20d@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Jul 2022 16:45:06 -0400
Message-ID: <CADnq5_OsRKiHvCr6PH9rdbaKwTqYEcBrBYwHJLo8dqCQ+3m0Zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsigned expression compared with zero
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Zhongjun Tan <hbut_tan@163.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
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

On Thu, Jul 7, 2022 at 4:38 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2022-07-07 14:22, Alex Deucher wrote:
> > On Wed, Jul 6, 2022 at 3:41 AM Zhongjun Tan <hbut_tan@163.com> wrote:
> >>
> >> From: Zhongjun Tan <tanzhongjun@coolpad.com>
> >>
> >> Fix unsigned expression compared with zero
> >>
> >> Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
> >> ---
> >>  .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> >> index 548cdef8a8ad..21e4af38b8c1 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> >> @@ -244,8 +244,8 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
> >>         bool req128_c = false;
> >>         bool surf_linear = (pipe_src_param->sw_mode == dm_sw_linear);
> >>         bool surf_vert = (pipe_src_param->source_scan == dm_vert);
> >> -       unsigned int log2_swath_height_l = 0;
> >> -       unsigned int log2_swath_height_c = 0;
> >> +       int log2_swath_height_l = 0;
> >> +       int log2_swath_height_c = 0;
> >
> > @Wentland, Harry Can you comment on the required range needed for
> > these integers?  Maybe it would be better to just drop the comparisons
> > with 0.
> >
>
> I'm not sure I see the problem we're trying to fix.
> An unsigned int can be 0, so a x != 0 or x > 0 check
> is still a valid check.

Hmm, you are right.  I swear I had seen a >= 0 check in that code, but
now I can't find it.  Sorry for the noise.

Alex

>
> Harry
>
> > Alex
> >
> >>         unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
> >>
> >>         full_swath_bytes_packed_l = rq_param->misc.rq_l.full_swath_bytes;
> >> --
> >> 2.29.0
> >>
>
