Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8851DCE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiEFQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443431AbiEFQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:09:49 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF04A1A2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:06:05 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e2fa360f6dso7649235fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFYD1jtv4MA5LyJp0wwZQbqa5q7DVbRBltnx1dOLS0M=;
        b=Q6GMzu3yDKdD2l/P8Rj2/FCcd55ZuvN3ETDxp95fGf5PnnibB7rU7MdAqR3pJEsY34
         Stq5PX6X1kOx7lFSw9rlnYzyckX8AwFbICA/qsXLSs4Syq+pSKgozjQ6sIUyRRRvYBCa
         Iydt5yoDndp07Zaq1Ssi7Qqp0rEgAbcLQBBV7U+vQzPov2FT7WtfyRRshbYLwQAUdSo8
         bntFfRgRXuhSdRouyAvEc1OvC0tZuveq3ymvxMrclsCkCweBUNeFFsnaMe5w58rgk48a
         AW5DxTTTG4RLz4NtblJ1swjwJakzDOId13RF3nDL2c1We7HqeRLOlMVx5RePupkAtTAz
         AkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFYD1jtv4MA5LyJp0wwZQbqa5q7DVbRBltnx1dOLS0M=;
        b=VbLV1uRHq6tERlOAiUnXnPbx18Sv2qutWrfbPTkm2egtF0Kl2FXRhx0T6rhCS6v9vR
         wfvMskxYvpjEweq9RL/isMFCK+EPcCcbne8PmG6PTQAoGU1d2Lb21zs8MAmw+BzeuLPc
         w+oso9o9JaGtsAOu/i7RHgWwvarXmnk7cNPgJ4oJ+r4fmp5Z+JIfI4w7Qjfe5cl2AtCe
         lhVPogF3RzpMGLZo7JiiplTYqVyWfUP2VRZWHUcvumgfKYTsYMnFFJtGU5TTsFdshR4Y
         G4L6gPXMFFH7WPZpeRGv5y+mANQIC9Lo8kN8Z9ktc7YSdGlrcUh898mwqDIk5eRqy0k2
         zg3w==
X-Gm-Message-State: AOAM5300yfPHjJMC0JIprc2YWkRQ6QJ+nZGm9WjzUoPCpl2nLrZnx7Qo
        2rLQ8kiWC2xLOeC0lorNQqmwx1dIER0SLgLgE5g=
X-Google-Smtp-Source: ABdhPJwo87Hs508g6ZdsuRY/hsmhIFexXOZO7iBLAGkYXXKy1oIC2sqTKW25TuRzhMTaJudebfNM+2FiDQNN8muD9b4=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr1649641oap.253.1651853165161; Fri, 06
 May 2022 09:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <1651802677-10154-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1651802677-10154-1-git-send-email-baihaowen@meizu.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 6 May 2022 12:05:54 -0400
Message-ID: <CADnq5_M0-makbeLxNhgSaW01MMG_v5zMMRuqHi2u1G0wuiyxpg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Return true/false (not 1/0) from bool functions
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, May 5, 2022 at 10:05 PM Haowen Bai <baihaowen@meizu.com> wrote:
>
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> functions.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Thanks, I just applied the same fix from someone else.

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index c3919aaa76e6..1431f0961769 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -241,14 +241,14 @@ static bool event_interrupt_isr_v11(struct kfd_dev *dev,
>         if (/*!KFD_IRQ_IS_FENCE(client_id, source_id) &&*/
>             (vmid < dev->vm_info.first_vmid_kfd ||
>             vmid > dev->vm_info.last_vmid_kfd))
> -               return 0;
> +               return false;
>
>         pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>         context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
>
>         if ((source_id == SOC15_INTSRC_CP_END_OF_PIPE) &&
>             (context_id0 & AMDGPU_FENCE_MES_QUEUE_FLAG))
> -               return 0;
> +               return false;
>
>         pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
>                  client_id, source_id, vmid, pasid);
> @@ -258,7 +258,7 @@ static bool event_interrupt_isr_v11(struct kfd_dev *dev,
>
>         /* If there is no valid PASID, it's likely a bug */
>         if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
> -               return 0;
> +               return false;
>
>         /* Interrupt types we care about: various signals and faults.
>          * They will be forwarded to a work queue (see below).
> --
> 2.7.4
>
