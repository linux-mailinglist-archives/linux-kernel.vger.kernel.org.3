Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED151DCE2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443418AbiEFQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443446AbiEFQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:08:51 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7336E8ED
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:04:32 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ed9a75c453so7612982fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDk8CLpGRoVS/nwhqjQcSZZPJtApcIin/4k05h1/9dQ=;
        b=k9ASF4o+zPpG8um1hBui3JtPfn+7sZeylk1K8M1/Z0zTdpqY05/keSvxcQviqyqfX5
         uYcaR/jGP63IklF1ElrKpy76Amh/FA7ZV3lh7+wdoisgbEWVB2cFOldPvZ5tzxLfG5rA
         0H6KPWAMoElssOOKoHWDR+kjcp8/T/Ex9r8yxnzF0HOO22tPCSqtyJJs+9TmfHZZjBC/
         DO+zVKhW6F0PX/HFlh13IHyGnNnC0vqoNPNEgbh330DGD2nDCzHuqNniAsMLX/mHLVe6
         CUD5yAILef0nRPVuUGkI9EORUlV+DF52Hm8TfG906EBDKsOp17O6X0saCqVFcrC6RpiE
         wedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDk8CLpGRoVS/nwhqjQcSZZPJtApcIin/4k05h1/9dQ=;
        b=fKeA9HGsU7PDL7qc0NDOxdXhjYS0CFV0nSRngTkIXGYENKohgRlwOiVdORsMQ4u8Ft
         /BnKHTum2ScjsrtL84QJHSpVYmzRffFLiijnNpUPGChPhkqlgu+WDup7n6Yc3N/eWWCb
         IOniwKJMwZidUGqA/QVOhp7aykyfk7PfO3LcjfKZp4r9HlnqotCMzKwhcIyjvGy3zQuB
         SdUabRh8a7oUQx9wxrCHqa3hpSOPY8G+UTxbOQUGca1EDRrAeLCtLD6qQIYvu12kIMex
         Rc4Z7Gwx+Ibm4rfZiqXlognOwHQD+Hze4g2/W4gVWQUBVVgjhNraK6/0UqHvaNNtzgaG
         Dlhg==
X-Gm-Message-State: AOAM5337axmzsDhf/bYMQoIBVrA/lvio/Ggbn6xQPCrBzGp8d3EIiaAz
        DX0EQ8kl+B5Rg4Tjl2Mg7m6xyfuHxHJSQApHu4o=
X-Google-Smtp-Source: ABdhPJw+NxCjtZCwZoT1SPToIWlf3F2AZG01IK+k6OAXZP1VvMETGiq/IXGbU5zuneU6f/ritu5vQyqtnNCtn5PT4Xs=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr1644821oap.253.1651853071705; Fri, 06
 May 2022 09:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220505232312.129997-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220505232312.129997-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 6 May 2022 12:04:20 -0400
Message-ID: <CADnq5_NWmHJHFtnMJfHYdQsBPGOAXcS2XR1vC1XYWjMrHKRGQw@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] drm/amdkfd: Return true/false (not 1/0) from
 bool functions
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 5, 2022 at 7:28 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> functions. This fixes the following warnings from coccicheck:
>
> ./drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c:244:9-10: WARNING:
> return of 0/1 in function 'event_interrupt_isr_v11' with return type
> bool
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
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
> 2.20.1.7.g153144c
>
