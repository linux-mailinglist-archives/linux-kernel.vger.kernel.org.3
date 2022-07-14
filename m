Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C35755A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbiGNTOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiGNTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:14:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09372CE2A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:14:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd6so3654103edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/LuQaklzlHjl5BZ/8eW+8DGSrCrY0hPsrbHgWp39LsY=;
        b=j5cmfIzSb0o8su2rrNFsM+DdfRM5O8YbXY5cqf45nBqgp/YUiLdqlUXJ1FloTqUVbN
         BQBKarHQsRsU7Idd35j5Jqyzwg+9TrbSFy0jT3WdTtf0PidMS9tTqScnu2muzhtIA1or
         hYFIlkeSK/hVy7cxNIkYRGSA8tBiJ4bzfXtRFyJ8J7zDa2CEt5xXkoGu1B+T6g21zr8s
         uswP36Ao7v3PF5wL0HJwtjuBdPuZ7RVg2R2qJkKl8/oaefh+qAar3o2Du1kJjeRFhehU
         047aB5wyIf/eECeg0D/asBMJk0/Vb1/uCy6biYnA+O4b5cV1SpbmYr7lBqnwT1+6JlVf
         Kt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/LuQaklzlHjl5BZ/8eW+8DGSrCrY0hPsrbHgWp39LsY=;
        b=DmAkqJ7bOnfTMY8xi00+RPf07ot3eUrZS1BmSyoNbx84J2yRzVGV3avwx8TZiwUro8
         xZk1QA5GbVrpQS6tBYqxIgiBq08EeZPoXqtUQISmL2uRcfe4Xo0asWTB0a8Ieugn8Fk+
         7onLHIVY5SmMNANhaN9lklIXHyNye9Up+9LHexHDB45HgNdaTyHJNhu4VYS+lXdTHf6v
         Iq23/BR831Lzu72JkdvEfGD16oJoVbvEFSjDqNoU/e7hcNge5KuAvH4mIYrWUpalbikk
         PwW50J4cnsJxU7fnBEF0dxD50HyVH4Bce/KMc1HRsm0fKW7hLO4Bm/pEYPlRnb9u7gXz
         hZow==
X-Gm-Message-State: AJIora9gob+/Wj0yPkOKadp0wlgxfXYaqP2TkRlPGAP6ESu2FNpGrylR
        5rLliIKxiKxKyuseNqx0N9j453vfenEj3sewpn8=
X-Google-Smtp-Source: AGRyM1uGYn42AA2Dmstp5qhjOfkmCIE3Gd1zm5LuMv8WTL6o5D5bfwSjt3MR+0MHK7z9l9ON7nXoiVWW+MU7Qf3SPlk=
X-Received: by 2002:a05:6402:28c3:b0:43a:6d78:1b64 with SMTP id
 ef3-20020a05640228c300b0043a6d781b64mr14061217edb.93.1657826090552; Thu, 14
 Jul 2022 12:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <92eebfd3-4234-b3fa-87cc-c48b3deec33f@igalia.com>
In-Reply-To: <92eebfd3-4234-b3fa-87cc-c48b3deec33f@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jul 2022 15:14:39 -0400
Message-ID: <CADnq5_OGGMTDhacr+x5jO=DttEmTvsMWPLZGxcQ=_GJS4B-r+Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: Write masked value to control register
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Magali Lemes <magalilemes00@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Melissa Wen <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
        Harry Wentland <harry.wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
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

On Thu, Jul 14, 2022 at 3:05 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Hi Ma=C3=ADra,
>
> Thank you for your patch,
>
> =C3=80s 13:44 de 14/07/22, Ma=C3=ADra Canal escreveu:
> > On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
> > should be written into the control register instead of 0.
> >
>
> Why? I do see that tmp was unused before your patch, but why should we
> write it into this register? Did you manage to test this somehow?

The patch is correct.  We should only be clearing the enable bit in
this case, not the entire register.  Clearing the other fields could
cause spurious hotplug events as it affects the short and long pulse
times for the HPD pin.

Alex

>
> > Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
> > Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
>
> Checking both commits, I can see that 0 is written at `mmDC_HPD1_CONTROL
> + N` register in _hpd_fini() in them, so if you are trying to fix the
> commit that inserted that behavior, I think aren't those ones. For instan=
ce:
>
> $ git show 2285b91c
>
> [...]
>
> @@ -479,28 +372,11 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device
> *adev)
>         list_for_each_entry(connector, &dev->mode_config.connector_list,
> head) {
>                 struct amdgpu_connector *amdgpu_connector =3D
> to_amdgpu_connector(connector);
>
> -               switch (amdgpu_connector->hpd.hpd) {
> -               case AMDGPU_HPD_1:
> -                       WREG32(mmDC_HPD1_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_2:
> -                       WREG32(mmDC_HPD2_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_3:
> -                       WREG32(mmDC_HPD3_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_4:
> -                       WREG32(mmDC_HPD4_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_5:
> -                       WREG32(mmDC_HPD5_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_6:
> -                       WREG32(mmDC_HPD6_CONTROL, 0);
> -                       break;
> -               default:
> -                       break;
> -               }
> +               if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> +                       continue;
> +
> +               WREG32(mmDC_HPD1_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd], 0);
> +
>
> 0 was the valued written here before this commit. The commit basically
> replaces the switch case with a sum in this snippet.
>
> thanks,
>         andr=C3=A9
