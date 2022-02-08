Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7244ADFCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384336AbiBHRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384258AbiBHRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:37:28 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8930DC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:37:28 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q8so21328910oiw.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sdaXua3wKx89UC59F2Pt2PCQFc34eeBx4BY52D/5hak=;
        b=fklw61IBZcZyGHPDd2ELRKGQZOfkqMfaBii8mj+N2LVwMBOIoYhMsPap+wC38Q0ABX
         zbqL7H4XlY3ijwC+na7h9oK/uTgHO5tXUIlVmaej+OGZWHRSePmCMcrhkIuk7IBMZ3La
         Qw4cMTmwZPL4R9MhscuS5+vN5vQN6225VVVjgmV6M2JP9f/6n+lVWYbFWqglo7Djituv
         gI7vgcIu6hMcuiJb9LkUR+cYFzySkqjcfAtJxcg3h4zIkdaf8gynEszu4Bp/jUZpu+5j
         LhVrMYNVxikXwlYnLMLOHAFnmWwVT1FWizHjT+jegyAuMbHPHHJp/DvT0lAg24Otmcee
         fduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sdaXua3wKx89UC59F2Pt2PCQFc34eeBx4BY52D/5hak=;
        b=U5pa7TtLpD2IJYvKjrWLvmShoMYawX1Sf/bSKmVaMgEU/Z/QZVURNaoXBQIN9xFzk8
         0V6NYU60Mn2WBpDdlS0NxeAOJuR4/Djb6onGuw0gowuiPSMbg9IYZ3v0wMaMRKKVEBy8
         8GHtzLcjYxIqAByHSpHI26hVwaMFIujX5x4/MxfW25YItb/QbOB6LEUDmX7gsJC16oPD
         +XU0QcoA/+HBAJurjTOgqXws2m5OmmKTB9lRdL5ia/F7wH/LMADnmnyEPrDPQ+t+wFT/
         JxaGsKZR/nCmCIejie4UCXk7IOHb9uygDkyjXegc4qR/y24Q63PJyZkIsLCKjp2D5Xkc
         4kuw==
X-Gm-Message-State: AOAM531HvlWy1kF8EuSAeONf36xpMtOUDJm1vY8hqdSN2yhWs2XernTl
        99/DEt+HTAECruRBCqoznWYOcfTogIe8eQDA09w=
X-Google-Smtp-Source: ABdhPJxYwuVKLDoLcWXrr1pQZmbPOD2kj1DL9NOJA2yhIEEUymwXU+ANmM4nu/kRwLpwlL2q5FH9K/JSUBV+hEIgzbo=
X-Received: by 2002:a05:6808:2011:: with SMTP id q17mr1092702oiw.199.1644341847944;
 Tue, 08 Feb 2022 09:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20220208081443.28210-1-zhanglianjie@uniontech.com>
 <108cc1b0-8630-7f41-5ef9-73df69d250e9@amd.com> <400b7279-b738-5614-dff7-0e2f6f395a0e@uniontech.com>
 <00c5b899-ed35-44a0-6b22-bc3e882e49d4@amd.com>
In-Reply-To: <00c5b899-ed35-44a0-6b22-bc3e882e49d4@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 8 Feb 2022 12:37:17 -0500
Message-ID: <CADnq5_OukNR9N+iqd63ZT7Jrk0C7k6n6mCVR93WdG=96vqSS-g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     zhanglianjie <zhanglianjie@uniontech.com>,
        David Airlie <airlied@linux.ie>,
        PanXinhui <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Tue, Feb 8, 2022 at 3:33 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> I think so, Alex will probably pick that up.
>
> Thanks,
> Christian.
>
> Am 08.02.22 um 09:28 schrieb zhanglianjie:
> > I am very sorry that I submitted many times due to the character
> > coding problem. Can PATCH V4 be used?
> >
> >> I'm scratching my head what you are doing here?
> >>
> >> That's the fives time you send out the same patch, so something is
> >> going wrong here :)
> >>
> >> Please double check why that lands in your outbox over and over again.
> >>
> >> Regards,
> >> Christian.
> >>
> >> Am 08.02.22 um 09:14 schrieb zhanglianjie:
> >>> after the buffer object is successfully mapped, call
> >>> radeon_bo_kunmap before the function returns.
> >>>
> >>> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> >>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>
> >>> diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c
> >>> b/drivers/gpu/drm/radeon/radeon_uvd.c
> >>> index 377f9cdb5b53..0558d928d98d 100644
> >>> --- a/drivers/gpu/drm/radeon/radeon_uvd.c
> >>> +++ b/drivers/gpu/drm/radeon/radeon_uvd.c
> >>> @@ -497,6 +497,7 @@ static int radeon_uvd_cs_msg(struct
> >>> radeon_cs_parser *p, struct radeon_bo *bo,
> >>>       handle =3D msg[2];
> >>>
> >>>       if (handle =3D=3D 0) {
> >>> +        radeon_bo_kunmap(bo);
> >>>           DRM_ERROR("Invalid UVD handle!\n");
> >>>           return -EINVAL;
> >>>       }
> >>> @@ -559,12 +560,10 @@ static int radeon_uvd_cs_msg(struct
> >>> radeon_cs_parser *p, struct radeon_bo *bo,
> >>>           return 0;
> >>>
> >>>       default:
> >>> -
> >>>           DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
> >>> -        return -EINVAL;
> >>>       }
> >>>
> >>> -    BUG();
> >>> +    radeon_bo_kunmap(bo);
> >>>       return -EINVAL;
> >>>   }
> >>>
> >>> --
> >>> 2.20.1
> >>>
> >>>
> >>>
> >>
> >>
> >
> >
> >
>
