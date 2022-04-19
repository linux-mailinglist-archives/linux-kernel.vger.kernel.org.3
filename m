Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698BA5070C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbiDSOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiDSOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:41:43 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F021273
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:39:01 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e5ca5c580fso7377708fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1s42UKgWJ4Pw4SvGNmkzwP7DSmoxOCXsEkE3mMBdmkk=;
        b=bryyFja6G/AfZjaCCp3S0G0ceVcHhyW1VQrZVSljNUEwwov2BVcqUpiqzWWuUzKqiW
         9rJzlHdS162QkPuOqWZq7UQ2VwiHR0xor0h0WIoSFyLZhJlv2+zectxrETiTHrAjY79E
         zvaLn+f9Sm9B8dmjE0Or93kQWpSpKq8AoM3n7JxTsgPapjJO/8m3TQ/iaLFyz1DG2xIq
         RiP7Bb6DpCXBOYWqJ6Jt2a/BXMLG9VaCGTBE7IW3ABkGUkYwH5Uo8gsuMe03xupp43CJ
         d8Hsw0jY3vd60CmLcfC6WgcMi3fzGpjUKBX5/aT2leGku3O/VYO4boI+1k75w43bNywb
         4uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s42UKgWJ4Pw4SvGNmkzwP7DSmoxOCXsEkE3mMBdmkk=;
        b=G0rAqGpbWCWoEVWrVrNtt28cWwuJDnGi3iJaMAoAVkOgEMW+Us71LXKnU9B2o4kDRF
         NH8PxeXCp+KAWYBgTm8JU5mBy1iOLuvN7ZW7l0TDT/Kl6C/acUX7RV8N6HoDvC93d9BR
         fkfixqOe1WY5kSdknXcQttvRHe/eCO4ibW/+7HhbAaWKP+q07UX1v6MQTa5QsXeS6tPq
         MrhkrUhmQyoMPHMvyYSN3CkxTGYOYD0LNiw1i5wTPB6nFzDVEuKBwj5Wzqj85to8++s4
         LgxWBOvm9Tc2UakcIOI17MG9DWmIzzSI9IXZk1unIQNnptHLhjH4j2KsPRQb7N4gy+dv
         iMNA==
X-Gm-Message-State: AOAM533JXB4aZmvkYKVZg3ATzhdYFYscCzQddq/rT6InAFNr2fK+h+SM
        br3Pzrz8i6su7EtS+8FpKhMs8JbemgKUw4ThQrk=
X-Google-Smtp-Source: ABdhPJxYRk2m9Utt9pJajmRXaqGutiUzLUudX5XJtfTMosQAR+UFtPG9su2APCdSuDKfZxLYGcxAh0AbE+xOcVMMHxQ=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr6741761oap.253.1650379140409; Tue, 19
 Apr 2022 07:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220419103721.4080045-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
In-Reply-To: <20220419103721.4080045-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Apr 2022 10:38:49 -0400
Message-ID: <CADnq5_MfjrZvegj-4r4DhRR5FDe6casvfcy54G0tM8PZqbsHeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix double free in si_parse_power_table()
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     Lijo Lazar <lijo.lazar@amd.com>, David Airlie <airlied@linux.ie>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

Applied.  Thanks!

On Tue, Apr 19, 2022 at 8:49 AM Keita Suzuki
<keitasuzuki.park@sslab.ics.keio.ac.jp> wrote:
>
> In function si_parse_power_table(), array adev->pm.dpm.ps and its member
> is allocated. If the allocation of each member fails, the array itself
> is freed and returned with an error code. However, the array is later
> freed again in si_dpm_fini() function which is called when the function
> returns an error.
>
> This leads to potential double free of the array adev->pm.dpm.ps, as
> well as leak of its array members, since the members are not freed in
> the allocation function and the array is not nulled when freed.
> In addition adev->pm.dpm.num_ps, which keeps track of the allocated
> array member, is not updated until the member allocation is
> successfully finished, this could also lead to either use after free,
> or uninitialized variable access in si_dpm_fini().
>
> Fix this by postponing the free of the array until si_dpm_fini() and
> increment adev->pm.dpm.num_ps everytime the array member is allocated.
>
> Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index caae54487f9c..079888229485 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7331,17 +7331,15 @@ static int si_parse_power_table(struct amdgpu_device *adev)
>         if (!adev->pm.dpm.ps)
>                 return -ENOMEM;
>         power_state_offset = (u8 *)state_array->states;
> -       for (i = 0; i < state_array->ucNumEntries; i++) {
> +       for (adev->pm.dpm.num_ps = 0, i = 0; i < state_array->ucNumEntries; i++) {
>                 u8 *idx;
>                 power_state = (union pplib_power_state *)power_state_offset;
>                 non_clock_array_index = power_state->v2.nonClockInfoIndex;
>                 non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
>                         &non_clock_info_array->nonClockInfo[non_clock_array_index];
>                 ps = kzalloc(sizeof(struct  si_ps), GFP_KERNEL);
> -               if (ps == NULL) {
> -                       kfree(adev->pm.dpm.ps);
> +               if (ps == NULL)
>                         return -ENOMEM;
> -               }
>                 adev->pm.dpm.ps[i].ps_priv = ps;
>                 si_parse_pplib_non_clock_info(adev, &adev->pm.dpm.ps[i],
>                                               non_clock_info,
> @@ -7363,8 +7361,8 @@ static int si_parse_power_table(struct amdgpu_device *adev)
>                         k++;
>                 }
>                 power_state_offset += 2 + power_state->v2.ucNumDPMLevels;
> +               adev->pm.dpm.num_ps++;
>         }
> -       adev->pm.dpm.num_ps = state_array->ucNumEntries;
>
>         /* fill in the vce power states */
>         for (i = 0; i < adev->pm.dpm.num_of_vce_states; i++) {
> --
> 2.25.1
>
