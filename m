Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04984F8480
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbiDGQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiDGQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:06:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6814114DE4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:04:33 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t21so6049779oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EL8pHj3hP/kpuDq+NWZZhljQXcG1ABgU+pQO9JXOdy4=;
        b=B0m9apwsBYjKnjhDmOFQbfKdnb3YotEIUSHlaXRYjqkz6oDPTyhdz5M0BuV/2rdOJ2
         ebqukW3nwpmA2pqXlnTI3K/18E3Yj9WrW4/xpDeLtHDZelUcO0T+mvOnqQbdkL2dANbd
         +jNxIYdq8+E4YKgqF64oyPX2r5qDj9DMPFxjbQz3xzA/+il0Qi8GciQ7YGq9i78w60mO
         m8Qy7fmISE2uhwv6vSYXAKAM9y5ABcgJFud+A8r8RGJ4Xc8PrGbAOwe78L8ok/JbXDdH
         OEh+S1Tc+TENe9AsVc5SkKkGlxfRkrCOHfSfC/Ap0jxaKjduKr7IJVWSh9f4TVJrUx0K
         U2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EL8pHj3hP/kpuDq+NWZZhljQXcG1ABgU+pQO9JXOdy4=;
        b=pGOkvhIab5bON7sM7gAE5jOnsmNmgXmV6AETn2NrOW3m1pqrV9BDCQOx0Wnxm39Hc1
         HBwlWGrhBpD3q/iHmPIAyx8bKRxkTUKFt1427w3xcWxLDiKa+keuptWnGAn7wbia9OcY
         lH5QiAlNesb2CY/+2F7S+GfGOTE/oToA+64KV2ido1TjuBZ+ZSiOaNZIuApXmUMiJKV4
         DLNbgfbZ+k+2mKhWhxnfNeWShA7tHCHTPkJaEbC5Kj9LMZ8wgF4Je5yFc8mpM0msbSPY
         PY+/2MJrcVtwHEkZcpsf7/And7XQdrkHwMijwVkwUSZY+WVwIByDaoo47jlOVub8ZFB6
         wbtg==
X-Gm-Message-State: AOAM530aHx3RaWB90bk18u+FHOPlGaJBwbBtCJoO9QqXHNDTaSmDWBx1
        3zdrvDniHhd0f+/b4TIhJR9SbJDfpugu5aXcfDI=
X-Google-Smtp-Source: ABdhPJzOmyyMsZaVgMTXGelPV4QHuZc7oJmlP4JPcbiVjyaFe7JQmNzF5BMHat66s7/QBNXb2jDAGWf//u7xdkdn67Y=
X-Received: by 2002:a05:6808:2390:b0:2f9:c718:80e0 with SMTP id
 bp16-20020a056808239000b002f9c71880e0mr216061oib.253.1649347473160; Thu, 07
 Apr 2022 09:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220407121230.132627-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220407121230.132627-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Apr 2022 12:04:22 -0400
Message-ID: <CADnq5_P7jM8-FCW1i3Lm7MBrWYd2RKsFvBdTJJp1rp6tPdn2tQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure HDA function is suspended before ASIC reset
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
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

Alex

On Thu, Apr 7, 2022 at 8:21 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> DP/HDMI audio on AMD PRO VII stops working after S3:
> [  149.450391] amdgpu 0000:63:00.0: amdgpu: MODE1 reset
> [  149.450395] amdgpu 0000:63:00.0: amdgpu: GPU mode1 reset
> [  149.450494] amdgpu 0000:63:00.0: amdgpu: GPU psp mode1 reset
> [  149.983693] snd_hda_intel 0000:63:00.1: refused to change power state from D0 to D3hot
> [  150.003439] amdgpu 0000:63:00.0: refused to change power state from D0 to D3hot
> ...
> [  155.432975] snd_hda_intel 0000:63:00.1: CORB reset timeout#2, CORBRP = 65535
>
> The offending commit is daf8de0874ab5b ("drm/amdgpu: always reset the asic in
> suspend (v2)"). Commit 34452ac3038a7 ("drm/amdgpu: don't use BACO for
> reset in S3 ") doesn't help, so the issue is something different.
>
> Assuming that to make HDA resume to D0 fully realized, it needs to be
> successfully put to D3 first. And this guesswork proves working, by
> moving amdgpu_asic_reset() to noirq callback, so it's called after HDA
> function is in D3.
>
> Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bb1c025d90019..31f7229e7ea89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2323,18 +2323,23 @@ static int amdgpu_pmops_suspend(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -       int r;
>
>         if (amdgpu_acpi_is_s0ix_active(adev))
>                 adev->in_s0ix = true;
>         else
>                 adev->in_s3 = true;
> -       r = amdgpu_device_suspend(drm_dev, true);
> -       if (r)
> -               return r;
> +       return amdgpu_device_suspend(drm_dev, true);
> +}
> +
> +static int amdgpu_pmops_suspend_noirq(struct device *dev)
> +{
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +
>         if (!adev->in_s0ix)
> -               r = amdgpu_asic_reset(adev);
> -       return r;
> +               return amdgpu_asic_reset(adev);
> +
> +       return 0;
>  }
>
>  static int amdgpu_pmops_resume(struct device *dev)
> @@ -2575,6 +2580,7 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
>         .prepare = amdgpu_pmops_prepare,
>         .complete = amdgpu_pmops_complete,
>         .suspend = amdgpu_pmops_suspend,
> +       .suspend_noirq = amdgpu_pmops_suspend_noirq,
>         .resume = amdgpu_pmops_resume,
>         .freeze = amdgpu_pmops_freeze,
>         .thaw = amdgpu_pmops_thaw,
> --
> 2.34.1
>
