Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE7A5A01B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiHXTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiHXTB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:01:57 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E92186C6;
        Wed, 24 Aug 2022 12:01:56 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so21992486fac.12;
        Wed, 24 Aug 2022 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BmUDAkEKs1QpgVs64aZzzQ45Z2VQd8OBs9xag8teZ5A=;
        b=hq301drIRDNXKLDjux5Dw7HOGWufL2ta4/DKG0n/S8UDdcDf8G6vX0gNBwWL4kfU4D
         l8aaI7AW8dcuYM77/3T9t/84xiLojrORAiIsE8vMyAe5brccsxj/rokbVEIROAMvx5Uc
         aaDqYj7esjRU9Yc6PA6fGDJ8V/qWKw/Umb9shFdTiap4MDV8s/BF3KqOJzKqR5sPRyh9
         /ZdCDk2yuadBFZqTh0lKHt6Q7K1IJ9I3NDH4MVLxIrSH9JPgTrCBqNr4nhIQqSbCGxrb
         BoRgPi11+3jOZPJU4Cmmg4ilmc19AAN/seMUEkemwVpvhg24ZxXAER5nPLrsDe6gtG49
         KF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BmUDAkEKs1QpgVs64aZzzQ45Z2VQd8OBs9xag8teZ5A=;
        b=xybV3UaOd8FU1FJadLt3lgToNdUq8BPZnQbRllIyyHY+c1+24cbdZw9buLVNH09JpL
         bEolyhfBdhr5rRxSfwT96HmGMxf3i5mXD1ac+pWwL/xqYaybrjePVJmw4VD8dqwfHYdt
         4dcfgdEk+3BeGdRLqybyHuMYg0Y70i1QJQubW3+CYsRE23NqfSHkiPuclkcw4r6OnjQW
         j9PzIW6kJ7uVlD/oBgBjyZm/HhhII2QsXAyMQWtHf9H5mxF4mtobz5ocpqBbkGvLUJMZ
         lk2QzFH8mEJaYrzMIxzbAuRkf2aQllcJgN5p2s10SEolSCT6o+LLCXUQV+ctWRfKGPQY
         tZVg==
X-Gm-Message-State: ACgBeo3NiFvKSwb4NXfNkMnn0DHSlLdzyc+/cmKJc16qqJ1FToVNs2k3
        iZInD0yfDDcZYFobo1IrW3WbYKZczEZD+vsRJfU=
X-Google-Smtp-Source: AA6agR6utCAbb8FEE7KJ6XCRZJyWK6tahQl9cT49ap8xyT6ONQ04pMG8osXSVOG0kx+xHxkNzrDvp9mZYPzrJKAplBg=
X-Received: by 2002:a05:6870:b692:b0:11d:482f:3642 with SMTP id
 cy18-20020a056870b69200b0011d482f3642mr264476oab.38.1661367714607; Wed, 24
 Aug 2022 12:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220821181917.1188021-1-robdclark@gmail.com> <20220821181917.1188021-6-robdclark@gmail.com>
 <93ff00db-b5d0-350c-b192-e58b781bb1cf@quicinc.com>
In-Reply-To: <93ff00db-b5d0-350c-b192-e58b781bb1cf@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 24 Aug 2022 12:02:28 -0700
Message-ID: <CAF6AEGtBw5pgdpaF6F5sBJvn6Kief2jHnSbKXFJGZ_GeGVjafQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/msm: Skip tlbinv on unmap from non-current pgtables
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 10:46 AM Akhil P Oommen
<quic_akhilpo@quicinc.com> wrote:
>
> On 8/21/2022 11:49 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > We can rely on the tlbinv done by CP_SMMU_TABLE_UPDATE in this case.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  6 ++++++
> >   drivers/gpu/drm/msm/msm_iommu.c       | 29 +++++++++++++++++++++++++++
> >   2 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index c8ad8aeca777..1ba0ed629549 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1180,6 +1180,12 @@ static int hw_init(struct msm_gpu *gpu)
> >       /* Always come up on rb 0 */
> >       a6xx_gpu->cur_ring = gpu->rb[0];
> >
> > +     /*
> > +      * Note, we cannot assume anything about the state of the SMMU when
> > +      * coming back from power collapse, so force a CP_SMMU_TABLE_UPDATE
> > +      * on the first submit.  Also, msm_iommu_pagetable_unmap() relies on
> > +      * this behavior.
> > +      */
> >       gpu->cur_ctx_seqno = 0;
> >
> >       /* Enable the SQE_to start the CP engine */
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> > index 94c8c09980d1..218074a58081 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -45,8 +45,37 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
> >               size -= 4096;
> >       }
> >
> > +     /*
> > +      * A CP_SMMU_TABLE_UPDATE is always sent for the first
> > +      * submit after resume, and that does a TLB invalidate.
> > +      * So we can skip that if the device is not currently
> > +      * powered.
> > +      */
> > +     if (!pm_runtime_get_if_in_use(pagetable->parent->dev))
> > +             goto out;
> > +
> > +     /*
> > +      * If we are not the current pgtables, we can rely on the
> > +      * TLB invalidate done by CP_SMMU_TABLE_UPDATE.
> > +      *
> > +      * We'll always be racing with the GPU updating ttbr0,
> > +      * but there are only two cases:
> > +      *
> > +      *  + either we are not the the current pgtables and there
> > +      *    will be a tlbinv done by the GPU before we are again
> > +      *
> > +      *  + or we are.. there might have already been a tblinv
> > +      *    if we raced with the GPU, but we have to assume the
> > +      *    worse and do the tlbinv
> > +      */
> > +     if (adreno_smmu->get_ttbr0(adreno_smmu->cookie) != pagetable->ttbr)
> > +             goto out_put;
> > +
> >       adreno_smmu->tlb_inv_by_id(adreno_smmu->cookie, pagetable->asid);
> >
> > +out_put:
> > +     pm_runtime_put(pagetable->parent->dev);
> > +out:
> >       return (unmapped == size) ? 0 : -EINVAL;
> >   }
> >
> Asking because it is a *security issue* if we get this wrong:
> 1. Is there any measure benefit with this patch? I believe tlb
> invalidation doesn't contribute much to the unmap latency.

It turned out to not make a huge difference.. although I expect the
part about skipping the inv when runtime suspended is still useful
from a power standpoint (but don't have a great setup to measure that)

BR,
-R

> 2. We at least should insert a full memory barrier before reading the
> ttbr0 register to ensure that everything we did prior to that is visible
> to smmu. But then I guess the cost of the full barrier would be similar
> to the tlb invalidation.
>
> Because it could lead to security issues or other very hard to debug
> issues, I would prefer this optimization only if there is a significant
> measurable gain.
>
> -Akhil.
>
