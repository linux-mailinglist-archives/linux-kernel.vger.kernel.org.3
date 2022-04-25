Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230D50EBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiDYW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbiDYV6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:58:54 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276AB3298E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:55:49 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id g30-20020a4a251e000000b0033a39d8340aso3046944ooa.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRxcdf2w/jvgBn/u4RdkEXeiNvH19TSLvJDSRvR1heQ=;
        b=JmheJvyryMJtpqVWc5yk3qs+kDpkw5/AYBwMAAJ9S/yHT7qWf0WgTM5yH157BCuqqz
         ABnLL4htcJOjrRMHGRMc0eEg5K2G2FmWdA78ERk4N6OdcIVCDKjVMmbdbSviBlS856Wh
         5BrKL7kdyoG2wunDb0si928fF0y/g784bnByLh1ogTWakYahSOIqlRa2nzX62hShABDS
         WMIasoWg1V+K+1wex8bvsNtfzwf0McLxCG8HFL6Zv8fgstAKPaJzHBGvZmqJrtcxi1Tx
         nX5msTlvEb6cEkHd+meuTJrm69i2LeU5v9S0wjVeJMlDfVsyKoSwzXy0yyI3onsZj/b3
         T1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRxcdf2w/jvgBn/u4RdkEXeiNvH19TSLvJDSRvR1heQ=;
        b=cXicOT+104CfrpHKVPTM02rckpLB2wTJXXZNPfjR0iHpC4bSEoso1IYxeC5H+zloCs
         67YFnJobvTjt8fHERckog45WI7QPg6GHSHQuEQesV8j2zqRtI/doa21AWz7oey9RJyFp
         WUjZ80vkO2dPkmoONwI7fHxlpEuvwd0XsyyyQdk9H90/v4RJzGppxyhLlE1yJYt+XfD3
         qm87cCzBpO4df35/AfGfd7cw7j54PIAO7rK4+I/u5pKrZW/Xh78AXIWgm47qPRz13Raw
         ZLgqQwpQSrPdhgvLBXksYSJPW14O3P0V2zZNp+rphprv41y5tR4YhUqFTdYfKzGf1VPN
         nUGg==
X-Gm-Message-State: AOAM533BdT1sn8ZPXw20B9snqcGZHQMQd7Evev8z/dAZV7ZVsUt7NVFW
        WN90jrGD1DcX2Cq4LHf3hiz3Een6Vv5txWv2FwA=
X-Google-Smtp-Source: ABdhPJypMLKCwtGwU1ckiXgvI+GUpxa1h4lksUtuDOxtEZKqiuuAe7eWGYfwxzWaugWHVmzsmFt4IKY8MNzzKv28hVU=
X-Received: by 2002:a4a:5257:0:b0:33a:48e1:8e75 with SMTP id
 d84-20020a4a5257000000b0033a48e18e75mr7125313oob.68.1650923748478; Mon, 25
 Apr 2022 14:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220424090640.1865-1-guozhengkui@vivo.com> <DM4PR12MB52143C2204F820E49D377A519EF99@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB52143C2204F820E49D377A519EF99@DM4PR12MB5214.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Apr 2022 17:55:35 -0400
Message-ID: <CADnq5_O5-PFqrvfL6y9q_KY2i9pLfjf2_ro-+iXr4HV3ki9Zqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix if == else warning
To:     "Liu, Zhan" <Zhan.Liu@amd.com>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Liu, Charlene" <Charlene.Liu@amd.com>,
        "Lei, Jun" <Jun.Lei@amd.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Alex

On Sun, Apr 24, 2022 at 4:15 PM Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Guo Zhengkui <guozhengkui@vivo.com>
> > Sent: 2022/April/24, Sunday 5:06 AM
> > To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Air=
lie
> > <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Liu, Charlene
> > <Charlene.Liu@amd.com>; Lei, Jun <Jun.Lei@amd.com>; Guo Zhengkui
> > <guozhengkui@vivo.com>; Liu, Zhan <Zhan.Liu@amd.com>; Jos=C3=A9 Exp=C3=
=B3sito
> > <jose.exposito89@gmail.com>; open list:AMD DISPLAY CORE <amd-
> > gfx@lists.freedesktop.org>; open list:DRM DRIVERS <dri-
> > devel@lists.freedesktop.org>; open list <linux-kernel@vger.kernel.org>
> > Cc: zhengkui_guo@outlook.com
> > Subject: [PATCH] drm/amd/display: fix if =3D=3D else warning
> >
> > Fix the following coccicheck warning:
> >
> > drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c:98:8-10:
> > WARNING: possible condition with no effect (if =3D=3D else)
> >
> > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>
> Thanks a lot for fixing this warning.
>
> Reviewed-by: Zhan Liu <zhan.liu@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> > b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> > index fe22530242d2..05b3fba9ccce 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> > @@ -95,8 +95,6 @@ static void gpu_addr_to_uma(struct dce_hwseq *hwseq,
> >       } else if (hwseq->fb_offset.quad_part <=3D addr->quad_part &&
> >                       addr->quad_part <=3D hwseq->uma_top.quad_part) {
> >               is_in_uma =3D true;
> > -     } else if (addr->quad_part =3D=3D 0) {
> > -             is_in_uma =3D false;
> >       } else {
> >               is_in_uma =3D false;
> >       }
> > --
> > 2.20.1
>
