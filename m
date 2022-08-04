Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36843589F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiHDQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiHDQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:21:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D256611A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:21:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a89so298316edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvAqCBmhC1zB39spR1tg3XxszATJUMKEiGdcZPVBnEk=;
        b=UErQStKIF5hZVlCtEqf1Am7dqLpJ3Gf93i3FVYaQ4WnaZGrJrjTToT0UTJCKeJWi7F
         C+ASE7ShUEwtc8+vcatkrMMqsliKcY70qJzCb9Qlf9Pkfquo1CyCK8lv35BU0pIjOOWC
         vDkE68covrngok0XigFTlS5HlB4zBDCRKFjJJM48SyUrICpUP/bg/2FzpPwnEpgnfTQ2
         DELUKeugxTGXXTyQQHMmUQzzT2pMZVpi+PkYVvoCsuKElaZyanc/7Bb9OXKG4s9kxaXX
         HM7e45G9kdDwUwaMaNZT/WdQ289cMM5Ci4V4Bwk5qR5equtn3xIEJMy+oL1xCGN5WBTt
         ANFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvAqCBmhC1zB39spR1tg3XxszATJUMKEiGdcZPVBnEk=;
        b=uIyqFg+wOMALWcV3awcc0KQLGBgMMb64v33CrUSqcfHeMDwXhto5Me7ydbJTNpjNF2
         HdcYla8M8MHkI40KG3loOt6H2M4AhAIjv39jF2XpeQx+Hef07YzzwBfpLkezRejh+i6r
         Sn7fa2BLzYlPCyA5TE0Xd1aYYR/7vLab8Bjc/QnUO/Q2AaoCz2tt5PmVQDrlDD30vXJ4
         PHuHR8jbRdyaILZMeXEjCDt276m1a7UeCRZoFFg77jmU46ChNCExKZqVQeDi8i4xx6L9
         /Icv3cn58MamQmOfHgkKiTlHi9BP90V2Px55+NOZys+Y4Xv3k+lOxy3h/XsjvI7Vvc0Z
         yVFw==
X-Gm-Message-State: ACgBeo2zf6aZeE7U1B69FBXQdd1ob5FFICVNzmHkR37nc+d6WvgPevz1
        dXmgOSFWKQoE/wmIuoEddclnkbPCnyStgk1NCqonow==
X-Google-Smtp-Source: AA6agR4d07uIaAqAc9iaaznOWJ4GsUqNCVavrOx8TxPMdJe98XydwPgZ07U3x/6+7aPRKb0bACRT3oDA2mJN9dI52kg=
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id
 g9-20020a056402090900b004350a8b5232mr2845711edz.240.1659630077136; Thu, 04
 Aug 2022 09:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com> <CAD=FV=U_GStziLOCVLs_FC_2Vr=ykGfbb4ZtUp79iV8V=B0cEA@mail.gmail.com>
In-Reply-To: <CAD=FV=U_GStziLOCVLs_FC_2Vr=ykGfbb4ZtUp79iV8V=B0cEA@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 4 Aug 2022 18:21:05 +0200
Message-ID: <CAG3jFyv3up0o4S+UYMKaAjanKL6hxCNtEa5zQTQEeNREab-NRA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add PSR support for eDP
To:     Doug Anderson <dianders@chromium.org>
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 at 02:22, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 11, 2022 at 5:57 AM Vinod Polimera
> <quic_vpolimer@quicinc.com> wrote:
> >
> > Changes in v2:
> >   - Use dp bridge to set psr entry/exit instead of dpu_enocder.
> >   - Don't modify whitespaces.
> >   - Set self refresh aware from atomic_check.
> >   - Set self refresh aware only if psr is supported.
> >   - Provide a stub for msm_dp_display_set_psr.
> >   - Move dp functions to bridge code.
> >
> > Changes in v3:
> >   - Change callback names to reflect atomic interfaces.
> >   - Move bridge callback change to separate patch as suggested by Dmitry.
> >   - Remove psr function declaration from msm_drv.h.
> >   - Set self_refresh_aware flag only if psr is supported.
> >   - Modify the variable names to simpler form.
> >   - Define bit fields for PSR settings.
> >   - Add comments explaining the steps to enter/exit psr.
> >   - Change DRM_INFO to drm_dbg_db.
> >
> > Changes in v4:
> >   - Move the get crtc functions to drm_atomic.
> >   - Add atomic functions for DP bridge too.
> >   - Add ternary operator to choose eDP or DP ops.
> >   - Return true/false instead of 1/0.
> >   - mode_valid missing in the eDP bridge ops.
> >   - Move the functions to get crtc into drm_atomic.c.
> >   - Fix compilation issues.
> >   - Remove dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc.
> >   - Check for crtc state enable while reserving resources.
> >
> > Changes in v5:
> >   - Move the mode_valid changes into a different patch.
> >   - Complete psr_op_comp only when isr is set.
> >   - Move the DP atomic callback changes to a different patch.
> >   - Get crtc from drm connector state crtc.
> >   - Move to separate patch for check for crtc state enable while
> > reserving resources.
> >
> > Changes in v6:
> >   - Remove crtc from dpu_encoder_virt struct.
> >   - fix crtc check during vblank toggle crtc.
> >   - Misc changes.
> >
> > Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> > Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> > Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> >
> > Vinod Polimera (10):
> >   drm/msm/disp/dpu: clear dpu_assign_crtc and get crtc from connector
> >     state instead of dpu_enc
> >   drm: add helper functions to retrieve old and new crtc
> >   drm/msm/dp: use atomic callbacks for DP bridge ops
> >   drm/msm/dp: Add basic PSR support for eDP
> >   drm/msm/dp: use the eDP bridge ops to validate eDP modes
> >   drm/bridge: use atomic enable/disable callbacks for panel bridge
> >   drm/bridge: add psr support for panel bridge callbacks
> >   drm/msm/disp/dpu: use atomic enable/disable callbacks for encoder
> >     functions
> >   drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
> >   drm/msm/disp/dpu: check for crtc enable rather than crtc active to
> >     release shared resources
> >
> >  drivers/gpu/drm/bridge/panel.c              |  68 ++++++++--
> >  drivers/gpu/drm/drm_atomic.c                |  60 +++++++++
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  17 ++-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  56 +++++----
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   8 --
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   2 +-
> >  drivers/gpu/drm/msm/dp/dp_catalog.c         |  81 ++++++++++++
> >  drivers/gpu/drm/msm/dp/dp_catalog.h         |   4 +
> >  drivers/gpu/drm/msm/dp/dp_ctrl.c            |  73 +++++++++++
> >  drivers/gpu/drm/msm/dp/dp_ctrl.h            |   3 +
> >  drivers/gpu/drm/msm/dp/dp_display.c         |  31 +++--
> >  drivers/gpu/drm/msm/dp/dp_display.h         |   2 +
> >  drivers/gpu/drm/msm/dp/dp_drm.c             | 184 ++++++++++++++++++++++++++--
> >  drivers/gpu/drm/msm/dp/dp_drm.h             |   9 +-
> >  drivers/gpu/drm/msm/dp/dp_link.c            |  36 ++++++
> >  drivers/gpu/drm/msm/dp/dp_panel.c           |  22 ++++
> >  drivers/gpu/drm/msm/dp/dp_panel.h           |   6 +
> >  drivers/gpu/drm/msm/dp/dp_reg.h             |  27 ++++
> >  include/drm/drm_atomic.h                    |   7 ++
> >  19 files changed, 631 insertions(+), 65 deletions(-)
>

Which tree does this series apply to?
