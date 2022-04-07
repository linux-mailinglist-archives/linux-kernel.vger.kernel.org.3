Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398534F8596
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbiDGRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiDGRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:10:19 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1A82CE03
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:08:18 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z8so6294247oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqDkTinK10x3zeolGbydLx/yEZJP4ImSGKmYcvP6lVQ=;
        b=Cy0VXhmnAEqP0lRJ0KQuwUy715TtVttVKnb19XsHu+WELC6cFz4o3We4LkuxtsJYIR
         Di3N1+8prGyIRhYxREa/bbeMsylUltqSC4+WRA7TqQv1qm8UCzeUwGYDYmw8YKHJEf9Z
         04x1BYmO7f/FAI3j/O9jTgK0tyiQxdbUurLzX3Ymyxm03m1bvBllSiZgGdEfD0Ryrsyp
         MJHwx0eF5rHTH+brtzbUTyGdYEzq6lvEIZFtsiFGfXDAxewiOFiWrlfPMkot2B56Cw90
         VaHAdRR1AQW3Qw4Ny+MBKI+761GiyxeWIsLhSVsmJLnE+7ZA6n4Q1XYWaV6p6NxlA8jp
         e2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqDkTinK10x3zeolGbydLx/yEZJP4ImSGKmYcvP6lVQ=;
        b=bXfcXmAHz9oGEhBa1keApm9gofymwqsTg+QLEfq7lzdrPhHmdqcUkMvObRU5IfAX+x
         e+H7ZI+cnzSnmXVqZsuOpJaKKhF1XnsDO7kUHHAa0CeWUMCS2YFWZnHzr7oQKknmORma
         LRGcmm34HUWDbPKZwxWcbC8zkyOl1jn/cBDKoltu1Bh1+o1bL64uIxJwwzuE+bVU1cHQ
         6rHWdvrIoWyppZCIorjfY3SyMPgEXzdDYI0Rq+4J7C25vZ3VTgMsJ4mVs2tSdtkOioop
         +iKACDqFWtqUTKF0y7tZuinasqX1ESvAPAgRYun2ppNqOh+DTH8vNaL7uqnV4EYzWEKd
         1qlQ==
X-Gm-Message-State: AOAM533C47rnP/HZNiVbT2e5dyPGk24YQU9zu/h5cwA4F6CkaDHV4hOL
        67HZKHYRYyO4kxauOYSlqDDUoGH9abmN8USIYEZIsDM/FNw=
X-Google-Smtp-Source: ABdhPJxylZ9P0pQvwI6USl2YGwdfB/0/fgO3ea3ZdU5f2ipIyl5F1+aUvZ2K86YyCnVCnX962vuWjCpdcgbpRakh+Vw=
X-Received: by 2002:aca:6006:0:b0:2f9:c685:f4e2 with SMTP id
 u6-20020aca6006000000b002f9c685f4e2mr446739oib.200.1649351298327; Thu, 07 Apr
 2022 10:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220407121230.132627-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220407121230.132627-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Apr 2022 13:08:07 -0400
Message-ID: <CADnq5_Oq4nS1A8MxosTn=0EztBCDeURmGq9WBW9886E9y-sO7Q@mail.gmail.com>
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

As an aside, shouldn't device links order this properly already?  I
thought that was the whole point of them.  We have quirks in PCI
quirks.c to create device links for all GPU integrated peripherals
(audio, usb, ucsi).

Alex

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
