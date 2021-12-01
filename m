Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E944656D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbhLAUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbhLAUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:07:04 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B14C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:03:42 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id u74so50904677oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CnRqfpgLADDNTZxnQeaARyw+MQVCOBB9/QLoFKFTaY=;
        b=k8Tpb/goSn4OxnTRzZPdleRpfdsgEkWSn37q6iTGm5UHHRM3JadzgamYa9jcntWMNF
         U85NVBPFdEn8Tg4YD3IPsS1sz0+vguYM96laTil7SLw//CaHG0iy0XqJx+1iuXEnZitW
         0V+qwMTHj7p7aVL9RQJKBw0lVdwvU3OI583jsrwOIASQTLGxiaFPwWVJZ1heXflzvidj
         DitIoVnI43kS0L1FmWU8LDpQn1PiOWYGe8ANsZP4oBYiC6yLVPKuX0/j29wLv4lMFEVw
         PsU6tGIhtpCU7qC1SlI/nyQCDVZLV0qnsq9uybzf8nUY5LMPLQGcJNgfxQhqFvK91qhe
         xiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CnRqfpgLADDNTZxnQeaARyw+MQVCOBB9/QLoFKFTaY=;
        b=sK/QidUIUJHhmaJ/7pyVgJyk3921rsky7hh9VHTQV9lOwEYhhWzwVD7esNYWxra+Qz
         2AWlRQZiYr1oszCc4csOxNJbnGq1YeouSg7tUznSUI1Db7CZk33GOimFRtOJABetPB5e
         bu5eRxa32fNWALCVl/Jtg/iHmOnoVumqH1OavL3imp8+o+05xX4HwBGBYrO0cWRWkHB/
         3qOhDfq55Lj2+GYbDunvjq13Avqzkw/vbh8oHejVX3y+L46KYu9O9Sy6itXbJ2U7qM4/
         AQeWNsKc3DVHZafUYFGh4i7e8S1I0IASQ06NYpaQpOpMTywG1iGI6+Ec+K8duy5QelPt
         E5jA==
X-Gm-Message-State: AOAM530AN3aru8J/Bmb7l1iVWhruM+UajUfyr4R/ENqQVbCLLtGA3mne
        ojZtfNLji3gwBh/kueqoEGlRcLk0BzG2F15tPDQ=
X-Google-Smtp-Source: ABdhPJy6k0qxdww8PmNgmuAWz7XREQWa9kFFYwHBgKQzTv8HOIt56/td3z4oxlejLCTGzNVhqOWT869k8DCUt6suX10=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr357371oig.5.1638389022328;
 Wed, 01 Dec 2021 12:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20211130111832.113821-1-zhou1615@umn.edu>
In-Reply-To: <20211130111832.113821-1-zhou1615@umn.edu>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Dec 2021 15:03:31 -0500
Message-ID: <CADnq5_P8amQK60zD-2tkVWBneZCoLENe5KY_S6eqoAAyOieatg@mail.gmail.com>
Subject: Re: [PATCH] fix a NULL pointer dereference in amdgpu_connector_lcd_native_mode()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     Jammy Zhou <Jammy.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Kangjie Lu <kjlu@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        hongao <hongao@uniontech.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 6:24 AM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In amdgpu_connector_lcd_native_mode(), the return value of
> drm_mode_duplicate() is assigned to mode, and there is a dereference
> of it in amdgpu_connector_lcd_native_mode(), which will lead to a NULL
> pointer dereference on failure of drm_mode_duplicate().
>
> Fix this bug add a check of mode.
>
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
> Builds with CONFIG_DRM_AMDGPU=m show no new warnings, and
> our static analyzer no longer warns about this code.
>
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index 0de66f59adb8..0170aa84c5e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -387,6 +387,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
>             native_mode->vdisplay != 0 &&
>             native_mode->clock != 0) {
>                 mode = drm_mode_duplicate(dev, native_mode);
> +               if (!mode)
> +                       return NULL;
> +

The else if clause needs a similar check.  Care to fix that up as well?

Alex

>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 drm_mode_set_name(mode);
>
> --
> 2.25.1
>
