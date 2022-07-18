Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7025789CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiGRSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:52:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D725C4D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:52:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id oy13so22941468ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UXmtdUhrJat96q6rc3xCOJzu4OogdeIRqntsuTRjLRQ=;
        b=XLxe7i6ykG4WCMIYi9HZMI3sAy3BYK0lxLOgbdHHPNt31x99iY8v6kjKu/iNMP2DoN
         y1SCu1/2aLdhrfPU3erTOAcoosGqtpOeV4PpzLdw1qZEyj2phMBaoW1c2X6X/JQ1ltHu
         9hXr/uPoUsTMTxyHiEIzuEBEQlnezltMsh0xvy0IJy002TtPWUBrHa0d/aHOiwcrIjw/
         Mx4dOEMetIVD6LDDNEH5fsxXpL/ycyk7D8jHCubKX/06iYpDYnuYPOj8CrHug90v3aTc
         vqnmAN1aPZhV24t4QfYyMgmG1nGirVSeuMcPAr5rXqv57BDfRij2hwlyhHyIeG46s9eg
         dNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UXmtdUhrJat96q6rc3xCOJzu4OogdeIRqntsuTRjLRQ=;
        b=6jHVE3bozf7IWtpbIWYLnr5OeahrdkQKwGZVdMrh6tkVkdwuzl2mv1VjauKwwZBjve
         Xpk50SA6mcMV9AT1qOeJXuYGJWkcVUgW5pc7bkScm8qTYqv95RsWDCh7xijE7dNFoT+D
         Tz9+JrBKb6MH0RP8psUzhypsXcugCTOHFGEaEK1zRdpfh6PRBVApv1t2knlDozwLGIeM
         ydHS+9wVOBxiabrPwCgpsfc3Ird3r7lGHySbc1IlLx7KtvorulqO1stkSp5TH1t7/q7R
         feZ5uRbqFhD7GEKGkf1HoDNsvtaMERW53TVU3APFYqpNF2t9ZG5wQwYaqkJ7vlAxDVLy
         Pp9A==
X-Gm-Message-State: AJIora+O06HRg7z60UiFDaQSwOSllBs3dZfXG8fgO4eJ/QOJY33DUiwZ
        tbFui/xZSS97TpI3aVAts3L0jtfsQ2PfkTFpHTw=
X-Google-Smtp-Source: AGRyM1spfpipEO03MLUtPx4xNAYzVBWFgnXy1amuY1fxS7wlSg6Kh4maX/RyytZkZmeRURFyr433xVx45qXcMgI20jc=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr10874082ejy.451.1658170366855; Mon, 18
 Jul 2022 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-2-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-2-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 14:52:34 -0400
Message-ID: <CADnq5_NU_m=M3QZiKAD3NsCQZExi7ffecpc0TrYz3qSFCky=dw@mail.gmail.com>
Subject: Re: [PATCH 02/12] drm/amd/display: Change get_pipe_idx function scope
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Melissa Wen <mwen@igalia.com>,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
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

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Turn previously global function into a static function as it is not used
> outside the file.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index 39f93072b5e0..c5a0a3649e9a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -251,7 +251,7 @@ unsigned int get_total_surface_size_in_mall_bytes(
>         return size;
>  }
>
> -unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned in=
t plane_idx)
> +static unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsi=
gned int plane_idx)
>  {
>         int pipe_idx =3D -1;
>         int i;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 47b149d4bfcf..6e61b5382361 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -165,7 +165,6 @@ unsigned int get_total_surface_size_in_mall_bytes(
>                 struct display_mode_lib *mode_lib,
>                 const display_e2e_pipe_params_st *pipes,
>                 unsigned int num_pipes);
> -unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned in=
t plane_idx);
>
>  bool get_is_phantom_pipe(struct display_mode_lib *mode_lib,
>                 const display_e2e_pipe_params_st *pipes,
> --
> 2.36.1
>
