Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA4480313
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 18:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhL0R5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 12:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhL0R5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:57:31 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A8C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 09:57:31 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id j3-20020a056830014300b0058f4f1ef3c2so17534829otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 09:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BW30tn1YOaWNFa+8QoO7oT2uLa84tu10Ml26KctqUJY=;
        b=dlOulSeH6GQ72XuLeRkFw0Hg0y6ijmrlqdTd/N9roWJG0OQ5AuatlGyvK2e5vXDZni
         Glp2asIPa/x0PK0RaN0LE6/Udp4EOhGNRutGILHL1SWH60R/yNH7IcSkC5yrM1UBuGor
         I9fgEc74e6couTMUZw2AhRtM0qonSepEJtsp9LQY+icOEKtYAPaPiWAhsqzJylHQ3Ue/
         lAPK73mRtkjYC/w9GcMfgpPv5vCZAMeOL0Dgwz7ZGIBhKiApYMb69XXqQ9OAd58QF37K
         4HbTTs+/o66xkTtGoKMzAGZjXuW7fUiLSJKq1I9fa3lNxdTKioGHpln5uqRmieUXQJwu
         u/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BW30tn1YOaWNFa+8QoO7oT2uLa84tu10Ml26KctqUJY=;
        b=r9liRv3ApuhWAgKOPlZ6LYoe1MFak1D57BDZCFuWA6DyrEznXgWolXRLQeDupJiFZ8
         2lwpkyx44ipwzegHx21lfNxZsChhpv++M9v/b46eDhDDIsmQeHcL47Lb1IDyuGxhlthO
         NKP/c6z3/hsucLS6Il1HA0q+npN8PP7zw8XmScqUo8Irn7qYA1XsBodNGYdL/VS09GRW
         kfrwo4ZtkGf2BTPN+cQ4Fx4sdlVOBWp50uSSnkt+uczdxbAYR5sI5amLj1qYRaIeZUCy
         pAbX9sGaxCb3Z2SX8HxymgPNV/jtsT2p/CpKAfFCZyhbMFlLNoidTl4o+5wQwagl6KEc
         OkeQ==
X-Gm-Message-State: AOAM531Wd5LUN3lOvRibD4/26S87h+HroJzEb0t4P5Koh1pKGTxNjM5y
        Jh0pN+hj6bFiRePVYLwJByrnhZGvPicGaBe+dl+htfHq
X-Google-Smtp-Source: ABdhPJwrnPXyP+/e7seaUaSuYFcBL04y9tZVeVuQyzYHFBrDwhGXblrapVe3azHehekSvIVKE+Ob82oiYHknrLLEclw=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr13539799otk.200.1640627850700;
 Mon, 27 Dec 2021 09:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20211226111614.30181-1-jose.exposito89@gmail.com>
In-Reply-To: <20211226111614.30181-1-jose.exposito89@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Dec 2021 12:57:19 -0500
Message-ID: <CADnq5_N9b_Wm2GrLfL9Ug4rXN4Wqqv6kM+KxGf+kguoj6Wfytw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix dereference before NULL check
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Dec 26, 2021 at 6:16 AM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gm=
ail.com> wrote:
>
> The "plane_state" pointer was access before checking if it was NULL.
>
> Avoid a possible NULL pointer dereference by accessing the plane
> address after the check.
>
> Addresses-Coverity-ID: 1493892 ("Dereference before null check")
> Fixes: 3f68c01be9a22 ("drm/amd/display: add cyan_skillfish display suppor=
t")
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> ---
>
> v2:
>
>  - Fix coverity report ID
>
>  - Add Reviewed-by tag (thanks to Harry Wentland)
> ---
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drive=
rs/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> index cfd09b3f705e..fe22530242d2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> @@ -134,11 +134,12 @@ void dcn201_update_plane_addr(const struct dc *dc, =
struct pipe_ctx *pipe_ctx)
>         PHYSICAL_ADDRESS_LOC addr;
>         struct dc_plane_state *plane_state =3D pipe_ctx->plane_state;
>         struct dce_hwseq *hws =3D dc->hwseq;
> -       struct dc_plane_address uma =3D plane_state->address;
> +       struct dc_plane_address uma;
>
>         if (plane_state =3D=3D NULL)
>                 return;
>
> +       uma =3D plane_state->address;
>         addr_patched =3D patch_address_for_sbs_tb_stereo(pipe_ctx, &addr)=
;
>
>         plane_address_in_gpu_space_to_uma(hws, &uma);
> --
> 2.25.1
>
