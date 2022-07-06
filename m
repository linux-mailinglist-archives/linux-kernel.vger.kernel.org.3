Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD095694B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiGFVwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiGFVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:52:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B131A810
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:52:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z41so20928814ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sVKNj9SkoISChFSURoq2rBmW/pxSFV/VJJFMmSbwpGs=;
        b=Go6ki17JNkyXFJID7151VQQd1gPh6zHpB+PcndVXU8y0ABMMSTBToYa/eIYvSK0+nt
         xvVRXlhHDTD3/ZMHoWQuT9s8dvQ2nhyc9v9p+4zD+KO/gkOlU5ZPTtnff73hgNZgX5mS
         WExsn+cJai5DENSjsWBJ3RGP/mqkpMNI19J6/oHh5hTTzqOQ56NUmsbZJvW/Q8b4ECWy
         +Z4En8Lv+px8oAX8JJ26vUMDDxlPQkokxMHCt59JrX9lOHimc1UzUYU5hzn81E1TaPrE
         AO11+uiyE8vIAs0/M14C+ifm18MYO+hRBZGPbvL9v2QQT68n/33CaDc00uNr+093nIYD
         vduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sVKNj9SkoISChFSURoq2rBmW/pxSFV/VJJFMmSbwpGs=;
        b=Zy4htpDvTZ/p4JCxAdupU3esid1bRCmvJxXI3AAPEleXD6TCChofS3XKE0KLVOURKe
         cfbqCwVBoSRXyaNycbVCPj7i/9f+uVXl0lllC5fgQDuo1HIPYxkeI/PT2wMF0KoHIVr8
         p58CpHc7ot6eCwylZIZhF7muAkNDqM7p5y0MVwzkCh+S28VVhfUszPwwBIJ4cQCr9F8e
         ga1cgIBS4mNbsj3POvpl0K19/nUxwHCYbs61W6XL1SvgmU4ssax8yAsYvD8Wq1Ua4Yfo
         YNlTbqieg+mXAraKEnfLwvKMRZwLH6dYTa6visOxrdX70xyPV2YY5pR46odhaJtVZAOM
         D9PA==
X-Gm-Message-State: AJIora+G+OYAhvKRftYTjJVmAv5DY5+5XCorcsaTvXp6CEkRZV/TvAHQ
        LWBW1RjUWR5ZNZgyCWbWV0poA8ZAcNmWLJUfe0laESJe
X-Google-Smtp-Source: AGRyM1uTE+GtqSHSfiDE+D7/pQfZittO31nLWCwKLry3URJ/yUFOSww0ibrgZU0AWs4loA76jNinpLCiuO4GqUAR8tE=
X-Received: by 2002:aa7:de88:0:b0:435:9a54:168a with SMTP id
 j8-20020aa7de88000000b004359a54168amr55951504edv.73.1657144350408; Wed, 06
 Jul 2022 14:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220706200144.68851-1-mat.jonczyk@o2.pl>
In-Reply-To: <20220706200144.68851-1-mat.jonczyk@o2.pl>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Jul 2022 17:52:18 -0400
Message-ID: <CADnq5_OJzANwVTu81DUM7qgYbbY7w1OjZsToMKtFe8U9aC4fiA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: avoid bogus "vram limit (0) must be a power
 of 2" warning
To:     =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Gray <jsg@jsg.id.au>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied.  Thanks!

Alex

On Wed, Jul 6, 2022 at 5:40 PM Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl> wro=
te:
>
> I was getting the following message on boot on Linux 5.19-rc5:
>         radeon 0000:01:05.0: vram limit (0) must be a power of 2
> (I didn't use any radeon.vramlimit commandline parameter).
>
> This is caused by
> commit 8c2d34eb53b9 ("drm/radeon: use kernel is_power_of_2 rather than lo=
cal version")
> which removed radeon_check_pot_argument() and converted its users to
> is_power_of_2(). The two functions differ in its handling of 0, which is
> the default value of radeon_vram_limit: radeon_check_pot_argument()
> "incorrectly" considered it a power of 2, while is_power_of_2() does not.
>
> An appropriate conditional silences the warning message.
>
> It is not necessary to add a similar test to other callers of
> is_power_of_2() in radeon_device.c. The matching commit in amdgpu:
> commit 761175078466 ("drm/amdgpu: use kernel is_power_of_2 rather than lo=
cal version")
> is unaffected by this bug.
>
> Tested on Radeon HD 3200.
>
> Not ccing stable, this is not serious enough.
>
> Fixes: 8c2d34eb53b9 ("drm/radeon: use kernel is_power_of_2 rather than lo=
cal version")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jonathan Gray <jsg@jsg.id.au>
> Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/rad=
eon/radeon_device.c
> index 15692cb241fc..429644d5ddc6 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1113,7 +1113,7 @@ static int radeon_gart_size_auto(enum radeon_family=
 family)
>  static void radeon_check_arguments(struct radeon_device *rdev)
>  {
>         /* vramlimit must be a power of two */
> -       if (!is_power_of_2(radeon_vram_limit)) {
> +       if (radeon_vram_limit !=3D 0 && !is_power_of_2(radeon_vram_limit)=
) {
>                 dev_warn(rdev->dev, "vram limit (%d) must be a power of 2=
\n",
>                                 radeon_vram_limit);
>                 radeon_vram_limit =3D 0;
>
> base-commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
> --
> 2.25.1
>
