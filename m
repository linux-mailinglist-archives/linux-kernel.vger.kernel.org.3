Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D95523CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346369AbiEKSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346370AbiEKSgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:36:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854C02899C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:36:35 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e93bbb54f9so3819324fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c24hMS7WpiIOCU2zBlghi9w7iiPETthn8Oys+Y9A4/M=;
        b=RVrvvjyYi6+uwGJshrvP26QBJ/UhS/zOMuVWL2YjmVKpp2xtdtezDiLcExQZmwZHQV
         ZXtEc4GRUn6P5ti1v/sUPlehQqCSa1c7PaCBjcwcoot1lttaoYfHuQ0Mq3CqGhkymJ90
         SCyCD0WPdPWIELtR0H+QJL2DPJ7pymcVe76xHh9JC+qcXmNgHxJ9wMSWPk7bWXMwVuae
         59oQ5eHqpVgBQrUs8LofWYBlVup3QkNrZ2JddkjsgLaxOIoJnC2goUXoHxrj6PUQPQh+
         7x2fv+8m1lQmE263riUnFnXz30Fwot93EFqfuM1/C0UsRgygFchQMTFpY6UQ48D2emGE
         vRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c24hMS7WpiIOCU2zBlghi9w7iiPETthn8Oys+Y9A4/M=;
        b=bAOq/gjq0Pq8wr1wLchSfkn76TLwPuJo8ZZRHUkUV4mk/Qm7buHRg5AOVcFP+TmhIh
         Jd7pVwuu11yoswwLslcPPiSqsTez1mg6sdh6/3R9D6WZuyguTzWBbQhicgMaLlYUrf+u
         /Guhu0dfMPdaPDWKGA6UbsA46M2SWiTvKss0KCJY8Sbjjs3zWOv+0K8v1iLSabisuBKb
         PvpDUnqUWstvZ3GDp4UNdeuevuub8g4JrEHd+SXWj/V3hjv83/kQFwz6Sm1Gd/GwCOd9
         EKRWZOuA6IpDQBrbM6tXp8h/S4Dxgsr/PR0z2q23cvq5VqqxXcCA9luD5XcZbkrG8nlu
         tmAw==
X-Gm-Message-State: AOAM5321pK3j9dLnbUl+YBrj1wMLWCZ9NwsPF7l/t2lqLWeeqA3Yu39T
        ne6SOfYpmdqSTI1E2rNFjEa6wkuX/TnghPiFCHo=
X-Google-Smtp-Source: ABdhPJxYls/DZkm0AwI7Mcf85JV3K1161l411LCMOeOvx4/neBkQknKQa22bMjyYmKnal6BpYKfScOVBIl1HTjRCRaE=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr3285781oaa.200.1652294194845; Wed, 11
 May 2022 11:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220511181935.810735-1-lyude@redhat.com>
In-Reply-To: <20220511181935.810735-1-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 11 May 2022 14:36:23 -0400
Message-ID: <CADnq5_OWH-Bat3OyCmHz6hTE++7hPLXqqMgg2=Nk6HB_Qk61JA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add 'modeset' module parameter
To:     Lyude Paul <lyude@redhat.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, May 11, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Many DRM drivers feature a 'modeset' argument, which can be used to
> enable/disable the entire driver (as opposed to passing nomodeset to the
> kernel, which would disable modesetting globally and make it difficult to
> load amdgpu afterwards). Apparently amdgpu is actually missing this
> however, so let's add it!

You can already do that by passing modprobe.blacklist=amdgpu on the
kernel command line.  I don't think we need another option to do that.


>
> Keep in mind that this currently just lets one enable or disable amdgpu, I
> haven't bothered adding a headless mode like nouveau has - however I'm sure
> someone else can add this if needed.

You can do this as well by passing an IP block mask which disables the
display IP, or media IP, etc.

Alex

>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ebd37fb19cdb..24e6fb4517cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -872,6 +872,15 @@ MODULE_PARM_DESC(smu_pptable_id,
>         "specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
>  module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>
> +/**
> + * DOC: modeset (int)
> + * Used to enable/disable modesetting for amdgpu exclusively.
> + */
> +bool amdgpu_enable_modeset = true;
> +MODULE_PARM_DESC(modeset,
> +                "Enable or disable display driver (1 = on (default), 0 = off");
> +module_param_named(modeset, amdgpu_enable_modeset, bool, 0444);
> +
>  /* These devices are not supported by amdgpu.
>   * They are supported by the mach64, r128, radeon drivers
>   */
> @@ -2003,6 +2012,11 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         bool is_fw_fb;
>         resource_size_t base, size;
>
> +       if (!amdgpu_enable_modeset) {
> +               DRM_INFO("modeset=0 passed to amdgpu, driver will not be enabled\n");
> +               return -ENODEV;
> +       }
> +
>         /* skip devices which are owned by radeon */
>         for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
>                 if (amdgpu_unsupported_pciidlist[i] == pdev->device)
> --
> 2.35.1
>
