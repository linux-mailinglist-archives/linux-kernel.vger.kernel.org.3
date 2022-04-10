Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE84FAB3E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiDJAyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiDJAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:52:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E149167C1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:50:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u18so3469905eda.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7HtVe2guHiIahNbZDnAKk5WaarwcdEBXzqi2lyPe5QI=;
        b=WebFnt8vxXxGF9+rn0eXifa+Pk7Pg897od0g0G9rMzYZiHzWGLOFv4tzOcSRkloPNk
         ZfCAmKoJQSs22cv7vAEF9bb/W20yEPZjHeMijK7yMzgq8VPA4sN9R69aGH+XTVaBFsxi
         EZyeSftXxzY82g2AkJDeYAD6JLrf9mmMCM/RZoI3FHNhyOBEP5rmdL47x2r4QDiUk2nv
         UWvDfyCz5WC1Mw5oPvGqisRYdouOAht1OJhGaCswEGhFI9vr9+SjpmGUN69q+qp8zCvz
         d2QdaJVmTk0VPbfQQZ6t/ug+/Y6ojBz+2Qn474YrDwlLhzn5jfp3TjNNa6RBrmy+KQ1I
         VjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7HtVe2guHiIahNbZDnAKk5WaarwcdEBXzqi2lyPe5QI=;
        b=mm2a9dyWzxcHMfvJZb5TX+dCPluaBtIGAzaEtqM1GuZPJqApr+3bQ44DI2u+dmE2H4
         MQFhS5wDGPrS+s0VNhKR89bk06W54By5w6tjqLuqhwYdTjV0X2Si19fjIrUTUsv6UC1w
         Tjv+vqE59uHjHKEruNPkk81q8+pQBmt4ner2kXVxW/+J11aw/+oBLbkZ64xKfXM1s2E3
         MQsswxLf0EQpSOJzpGTIax4ej6nwzOYej+Jo681B83VLT/M139Ougerj5g80X9CVGCaZ
         LkO/3a6//jnrUKOP9Emf3iKuQ3sfORK4Obe5OH75KlaCA8aOtD30P02TllLepjdesKe/
         9LNw==
X-Gm-Message-State: AOAM531vAFcyW4mPxjieoelWOUjNyy8lvKwB19jCQPoPWOcp296WRZRw
        UzEkGWL7AcydoQwyhAvTDEsHj7qjlR4xMd3bN98=
X-Google-Smtp-Source: ABdhPJxrqwFrLV44uG+X6bhKQxtFAe//AUKD4xulz+mQi3zOvMiBcpohNfsTapnOWH4OzRPGHvXTS8+L228j29ItyEw=
X-Received: by 2002:a05:6402:1907:b0:41d:29d9:e3d with SMTP id
 e7-20020a056402190700b0041d29d90e3dmr10131837edz.250.1649551826678; Sat, 09
 Apr 2022 17:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220405173632.2663-1-h0tc0d3@gmail.com> <614a4844-fa5d-8b8e-0628-894394f31608@amd.com>
 <874k3670ez.fsf@intel.com> <f742b6b8-4056-543c-17a5-ae373ca71b45@amd.com>
In-Reply-To: <f742b6b8-4056-543c-17a5-ae373ca71b45@amd.com>
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
Date:   Sun, 10 Apr 2022 03:50:25 +0300
Message-ID: <CAD5ugGBZeA1+7pS2eSyXkCt+DvHY8=6wObD7eJ98UAgY-FPVOw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Senseless code and unnecessary memset
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiawei Gu <Jiawei.Gu@amd.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian K=C3=B6nig in fact the compiler will very often replace {0} with
a memset call. I don't see a problem using {0} for local arrays with
primitive types.
There should also be no problem with memory alignment. Because the
compiler understands it. Using sizeof is also not a good idea.
More often everyone also makes mistakes with sizeof. It's best to
leave it as is, and there's no errors.
Indeed, when using structures and {0}, errors may occur, but I am not
aware of errors when using primitive types. I also looked at the
amdgpu code and  {0} is used in many places.
Also from experience malloc+memset is the most dangerous chain, can
silently damage memory, causing a bunch of subtle problems, and it is
better to replace them with more safe calloc.
Such a problem, for example, was recently found by me in fontconfig
and it crashed intel quartus. Therefore, where possible, I try to
avoid memset.

Regards, Grigory.

=D1=81=D1=80, 6 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 17:43, Christian K=
=C3=B6nig <christian.koenig@amd.com>:
>
> Am 06.04.22 um 16:26 schrieb Jani Nikula:
> > On Tue, 05 Apr 2022, Christian K=C3=B6nig <christian.koenig@amd.com> wr=
ote:
> >> Am 05.04.22 um 19:36 schrieb Grigory Vasilyev:
> >>> Using memset on local arrays before exiting the function is pointless=
.
> >>> Compilator will remove this code. Also for local arrays is preferable=
 to
> >>> use {0} instead of memset. Mistakes are often made when working with
> >>> memset.
> >> Well actually memset is preferred when working with structures which a=
re
> >> given to the hardware parser because {0} won't initialize paddings.
> > Not that I'd know anything that's going on here... but it sure seems
> > strange to me to be passing unpacked structures where the padding might
> > matter to a "hardware parser".
>
> Well to me it is an absolute miracle why the heck compilers don't
> initialize paddings.
>
> We had so many ups moments over the years and I really don't see why it
> should be more optimal to do this.
>
> Anyway, the memset() is used intentionally here and I don't really want
> to change it. What we could do is removing the second superfluous memset
> and use sizeof() instead of hard coding the size.
>
> Regards,
> Christian.
>
> >
> > *shrug*
> >
> >
> > BR,
> > Jani.
> >
> >
> >> So please don't use {0} in any of the atom bios code.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/atom.c | 8 +-------
> >>>    1 file changed, 1 insertion(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/=
amdgpu/atom.c
> >>> index be9d61bcb8ae..537e48fbbe6b 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> >>> @@ -1538,11 +1538,9 @@ struct atom_context *amdgpu_atom_parse(struct =
card_info *card, void *bios)
> >>>    int amdgpu_atom_asic_init(struct atom_context *ctx)
> >>>    {
> >>>     int hwi =3D CU16(ctx->data_table + ATOM_DATA_FWI_PTR);
> >>> -   uint32_t ps[16];
> >>> +   uint32_t ps[16] =3D {0};
> >>>     int ret;
> >>>
> >>> -   memset(ps, 0, 64);
> >>> -
> >>>     ps[0] =3D cpu_to_le32(CU32(hwi + ATOM_FWI_DEFSCLK_PTR));
> >>>     ps[1] =3D cpu_to_le32(CU32(hwi + ATOM_FWI_DEFMCLK_PTR));
> >>>     if (!ps[0] || !ps[1])
> >>> @@ -1551,10 +1549,6 @@ int amdgpu_atom_asic_init(struct atom_context =
*ctx)
> >>>     if (!CU16(ctx->cmd_table + 4 + 2 * ATOM_CMD_INIT))
> >>>             return 1;
> >>>     ret =3D amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, ps);
> >>> -   if (ret)
> >>> -           return ret;
> >>> -
> >>> -   memset(ps, 0, 64);
> >>>
> >>>     return ret;
> >>>    }
>
