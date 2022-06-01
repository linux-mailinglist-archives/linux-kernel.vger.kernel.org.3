Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C053AE27
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiFAUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiFAUpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:24 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9271CA5EB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:32:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c8so2076662qtj.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqzzjZ/+YoAfsOt70hJSK1v4NOwUp//67c0gdA4z8gE=;
        b=o+8DoKQbuB6vo34q94PbCmoOZ1E42JHaRrsMzhV2F/ynt8Q+VdQtnDeWLT592DvZ7t
         AeMy3LYefWHmvgfCUohLgLa0KCbaal0aw7qMTAwwLRq6xfqCUug5WfT+u86M35AjoI91
         Emy6jxRdlsMSGIG6vRz8kwjnFKa3jFTpW1+pvaVa/+/LwfGm1MYRZQ/+BK+yeUtO5WUL
         mEQMcYZVBuDTpS2uWVEdGM6Xk19p34D75EanhUz/tcJ6SHYj4qcW5her+JqRSnS93jQC
         Baxr0ZA84v+AOXMoYiwB2Zcw7cV3bhjrdqtXX+iJaz0V12UJ4K8O75k0rjJOOUi9AFs7
         x/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqzzjZ/+YoAfsOt70hJSK1v4NOwUp//67c0gdA4z8gE=;
        b=0Kvh2via8Bvlgv2lzLd8KSzLoz9Xcc9M7EBePkxQ75po/2Ya98M8IoXiVvMb20IGLk
         tWekzZoAu1I2D81pmvBnGVydnA4bXHGibazIe/QGNySU97DZcLCSwJwtq+O8NfmXk3OR
         EwRB85yE+aE4/21aNWdL9Ov+XtEpjc81QOorP3pgTrQ6RD8RItxaq1HTumK1vaQ/iRhf
         OrtpaRF7UoSzFyHS5h6c57ykncCR0vIasc1dBLjNuW3KP1nl7Lznmf/VopRJQU5arbSr
         IUeazQ+a/XJaPGF20xmjacegUPPcLPexvgIhXzbKu8tVfcQMeIXHBxKcAgANOjgfP1Bq
         PsWg==
X-Gm-Message-State: AOAM531L8+Y26Pqmj5m3sZmaC2wjfHT0d0insjhm5kv3SeuVSg9qM7EZ
        K4OD34gAFQF7KqRlXEOpqCDo+fp2HKKe95I+MqwqcvInlz8=
X-Google-Smtp-Source: ABdhPJx4nAJPu/OXd+0EBsy6h9EWGrczLq7bqqCKi8jtBPrQeHOAUACKV0KVNp25KQQV9tdKC24tm1njoXJQNx7sc1A=
X-Received: by 2002:a37:582:0:b0:6a3:2ce4:3c72 with SMTP id
 124-20020a370582000000b006a32ce43c72mr913331qkf.203.1654113500549; Wed, 01
 Jun 2022 12:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220531160059.v2.1.Ie7f6d4bf8cce28131da31a43354727e417cae98d@changeid>
 <CAA8EJpqp64eDmXPN1qMTZ78My8BKPUcu7zKunZV1SJpzjSRDuQ@mail.gmail.com> <f8d5e4a7-bba8-ca51-41f7-885ce14a55fe@quicinc.com>
In-Reply-To: <f8d5e4a7-bba8-ca51-41f7-885ce14a55fe@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Jun 2022 22:58:09 +0300
Message-ID: <CAA8EJpp5v3qR2M-6Jms=3GgrzUeMOiMzQtgvQc_LPVE78aE=aw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: Move min BW request and full BW disable
 back to mdss
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 at 20:18, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> On 6/1/2022 3:04 AM, Dmitry Baryshkov wrote:
> > On Wed, 1 Jun 2022 at 02:01, Douglas Anderson <dianders@chromium.org> wrote:
> >>
> >> In commit a670ff578f1f ("drm/msm/dpu: always use mdp device to scale
> >> bandwidth") we fully moved interconnect stuff to the DPU driver. This
> >> had no change for sc7180 but _did_ have an impact for other SoCs. It
> >> made them match the sc7180 scheme.
> >
> > [skipped the description]
> >
> >>
> >> Changes in v2:
> >> - Don't set bandwidth in init.
> >>
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  8 ----
> >>   drivers/gpu/drm/msm/msm_mdss.c          | 57 +++++++++++++++++++++++++
> >>   2 files changed, 57 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> >> index 2b9d931474e0..3025184053e0 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> >> @@ -49,8 +49,6 @@
> >>   #define DPU_DEBUGFS_DIR "msm_dpu"
> >>   #define DPU_DEBUGFS_HWMASKNAME "hw_log_mask"
> >>
> >> -#define MIN_IB_BW      400000000ULL /* Min ib vote 400MB */
> >> -
> >>   static int dpu_kms_hw_init(struct msm_kms *kms);
> >>   static void _dpu_kms_mmu_destroy(struct dpu_kms *dpu_kms);
> >>
> >
> > [skipped]
> >
> >> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> >> index 0454a571adf7..e13c5c12b775 100644
> >> --- a/drivers/gpu/drm/msm/msm_mdss.c
> >> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> >> @@ -5,6 +5,7 @@
> >>
> >>   #include <linux/clk.h>
> >>   #include <linux/delay.h>
> >> +#include <linux/interconnect.h>
> >>   #include <linux/irq.h>
> >>   #include <linux/irqchip.h>
> >>   #include <linux/irqdesc.h>
> >> @@ -25,6 +26,8 @@
> >>   #define UBWC_CTRL_2                    0x150
> >>   #define UBWC_PREDICTION_MODE           0x154
> >>
> >> +#define MIN_IB_BW      400000000UL /* Min ib vote 400MB */
> >
> > As msm_mdss is now used for both DPU and MDP5 devices, could you
> > please confirm that this value is valid for older devices too? E.g.
> > db410c or 8974
> >
> I need to check with Kalyan on this value (400MB) as I am unable to find
> documentation on this. Will update this thread when I do.
>
> So prior to this change 627dc55c273da ("drm/msm/disp/dpu1: icc path
> needs to be set before dpu runtime resume"), this value was coming from
> the hw catalog
>
> @@ -1191,10 +1193,10 @@ static int __maybe_unused
> dpu_runtime_resume(struct device *dev)
>
>          ddev = dpu_kms->dev;
>
> +       WARN_ON(!(dpu_kms->num_paths));
>          /* Min vote of BW is required before turning on AXI clk */
>          for (i = 0; i < dpu_kms->num_paths; i++)
> -               icc_set_bw(dpu_kms->path[i], 0,
> -                       dpu_kms->catalog->perf.min_dram_ib);
> +               icc_set_bw(dpu_kms->path[i], 0, Bps_to_icc(MIN_IB_BW));
>
> After this, we moved to a hard-coded value, I am not sure why.
>
> So nothing wrong with this change as such, the only question is whether
> this value is correct for older chips.
>
> But the question here is, are older chips even using icc.
>
> It seems like only sc7180, RB3/RB5 are unless i am mistaken.

We are not using it for msm8916 (but we should most probably). And for
the msm8996 the icc patches were by Yassine.

> So is there really any impact to the older chips with this change.
>
> If not, we should probably let this one go ahead and move back to
> catalog based approach while extending ICC for older chips.

Let's get this sorted out. I'm fine with 400 MBps, if that works for
all chipsets.

-- 
With best wishes
Dmitry
