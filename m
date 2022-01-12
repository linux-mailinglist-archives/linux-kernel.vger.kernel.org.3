Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9D48CD95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiALVTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiALVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:19:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0197C06173F;
        Wed, 12 Jan 2022 13:19:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r28so6577768wrc.3;
        Wed, 12 Jan 2022 13:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TxiOntNhsCrtTXgbXmjcIfphc43hOl3QDBs0NNaLFY=;
        b=KFiMw3MPBADupNQlBvuHMx9S77BKhdF50zxz77/j9FbgxZiOW10JkOCDEu4tDtTIUZ
         AF2ne5pOpFtLLh0J/9OVlZ3Xk8elbrON8BeE8eBJFFtdl+rcmCx6FlCLn1TGlLjOGU1U
         MbEepFp7jfyJPApV+rIYxxpUAJzQ5eydRVetMrqCpxYELcUkPYCWoTUG1/frTgYsvUGJ
         ZiTlzH1EJEC+Ki3ORSUcCKfj0/d1Le+p8V28PtIAlySvlQOqa+hdOESzqWF4D3jzjQSP
         3LTRiZFk53hsfrs+MASoRHQUwhCVAtsh7bisLyz3COXkFx2eHCyN6mzF2beFQqpPV5MI
         6hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TxiOntNhsCrtTXgbXmjcIfphc43hOl3QDBs0NNaLFY=;
        b=AhCHq7KkOBj8cb3yqwx2hxb4C5O1Y47uNXu8Q4DJ8YcKxNTl8ScG4l1lfR++qJaOXg
         jlBI6b5Xz3oVQ4puaQTTJfogXA1Y6WVCWh7jwnds5GgRNPBZtYs1mGa7Q9sMppW5/Ch9
         rDsOa/HPI+s4hahrPtCBjEh+s1bifAPKk6CxihkodLWGv+INl3GMtCNPlPTMKUgD49pk
         NvqJLGc42b0EKnuTPNvBGga+CTGK74I9QQnXzejjvd5D4prVRWYCIgvPvPeZfhOl4EgE
         yw4uKQwojRebBitb/ozp8DlpL4xAL58fpDbztS6Vm7H94zlBDsvAAJZnjXFYryAYB22A
         sVmw==
X-Gm-Message-State: AOAM533w+L5sRr9qrUpYclC6VRjs/yZv0JrAVVCcaK1iDk8HoZTjay6+
        TXdqGR6DyyW1jU5zBgP+UpOgj4osSFVAhPNZieE=
X-Google-Smtp-Source: ABdhPJzFEuWp7Wsk8JdHQYZwsj1tBXEicac30GClml/cPixPa0nmwZPRG1lrU1uj5FLFPmz34phbSV+YiJmWRQFzecY=
X-Received: by 2002:a5d:6488:: with SMTP id o8mr1369457wri.93.1642022349685;
 Wed, 12 Jan 2022 13:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20220112030115.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
 <20220112030115.3.I86c32730e08cba9e5c83f02ec17885124d45fa56@changeid>
In-Reply-To: <20220112030115.3.I86c32730e08cba9e5c83f02ec17885124d45fa56@changeid>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 12 Jan 2022 13:19:07 -0800
Message-ID: <CAF6AEGuJxdrYM5XXt6sUGmjossqZTRzwQ6Y8qYsnfCYDvGQurw@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/msm/adreno: Expose speedbin to userspace
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 1:31 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> Expose speedbin through MSM_PARAM_CHIP_ID parameter to help userspace
> identify the sku.
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index f33cfa4..e970e6a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -242,10 +242,11 @@ int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
>                 *value = !adreno_is_a650_family(adreno_gpu) ? 0x100000 : 0;
>                 return 0;
>         case MSM_PARAM_CHIP_ID:
> -               *value = adreno_gpu->rev.patchid |
> -                               (adreno_gpu->rev.minor << 8) |
> -                               (adreno_gpu->rev.major << 16) |
> -                               (adreno_gpu->rev.core << 24);
> +               *value = (uint64_t) adreno_gpu->rev.patchid |
> +                               (uint64_t) (adreno_gpu->rev.minor << 8) |
> +                               (uint64_t) (adreno_gpu->rev.major << 16) |
> +                               (uint64_t) (adreno_gpu->rev.core << 24) |
> +                               (((uint64_t) adreno_gpu->rev.sku) << 32);

How about this instead, so we are only changing the behavior for
new/unreleased devices:

*value = adreno_gpu->rev.patchid |
(adreno_gpu->rev.minor << 8) |
(adreno_gpu->rev.major << 16) |
(adreno_gpu->rev.core << 24);
if (!adreno_gpu->info->revn)
*value |= (((uint64_t) adreno_gpu->rev.sku) << 32);

(sorry about the butchered indentation.. somehow gmail has become
antagonistic about pasting code)

BR,
-R

>                 return 0;
>         case MSM_PARAM_MAX_FREQ:
>                 *value = adreno_gpu->base.fast_rate;
> --
> 2.7.4
>
