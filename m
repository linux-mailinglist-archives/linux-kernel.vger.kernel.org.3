Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA1584908
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiG2AWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2AWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:22:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED17B1DB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:22:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z22so4061780edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YbqiOPzZmbvFzZa130GwJGGGwEXthWuw9oeJXPqxLMw=;
        b=kRjkFi56KoI/XZGvwlf6yOjdbiP1tOmPWovRkV0lQ9r/9z+zKKFuNvzZ526mN8SbkY
         2TdEpBoXlMQ+lVoNCpoWhAPvoC8JWZChWscjFpUjaHrW9+uuQyrM093O5JJ2ch0W3yhw
         53t5JnC3EDdl/YBCZLn7vwtZGg7twxgkwE0VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YbqiOPzZmbvFzZa130GwJGGGwEXthWuw9oeJXPqxLMw=;
        b=p3CjOnbZoPmqHBOLtD0YsJ/QD2gTnFVZlBH/+fqKQpqsIVyCwbBib2gXZVncwFzWg6
         g7U//Rlcihq3SDkMQgXPkaxbv4apqG4xS5+YJ1ZFKvdBKW6UiKRMSRQmmMSvS5haN5ry
         jahrFNnnGXFz3Ws3XLdcqIb7+lyAhT+6lOgi2tcwlFoBML5134kjdiZDXuyozWLESuMh
         gmGccZk4Ji0aW2WAJJpEs7NIARQcpi/3dAJTFW+H/oXTvPh/KdfdFS+SgIRBO7RCcGeq
         /IJfiLqifgDWWupHCfAxT1/RgfiiASXQrIRm36NpXqGhnQoccnEkIXqA+I4hy8xYhGdp
         Q67A==
X-Gm-Message-State: AJIora/U41iTYZMh9uhCQOgg+xLwtXdTtTPhJZkvtcwuSU1KSM/1mNTh
        7uW4TAwavfcjsB7ajhhtdaGTkLLtsE1pe+Kz
X-Google-Smtp-Source: AGRyM1v9U0affx8c2UR6ktBOCNW1Fm+wDn+p+QQphTV1LNSgR9yomZr50Kfx4j6noExSVqfWT/Jb6g==
X-Received: by 2002:a05:6402:5191:b0:43b:d047:dcb5 with SMTP id q17-20020a056402519100b0043bd047dcb5mr1256841edd.390.1659054152849;
        Thu, 28 Jul 2022 17:22:32 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906560b00b0072b2eab813fsm964008ejq.75.2022.07.28.17.22.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 17:22:31 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id k8so1995701wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:22:31 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr744258wrr.617.1659054151464; Thu, 28
 Jul 2022 17:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 17:22:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_GStziLOCVLs_FC_2Vr=ykGfbb4ZtUp79iV8V=B0cEA@mail.gmail.com>
Message-ID: <CAD=FV=U_GStziLOCVLs_FC_2Vr=ykGfbb4ZtUp79iV8V=B0cEA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add PSR support for eDP
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 5:57 AM Vinod Polimera
<quic_vpolimer@quicinc.com> wrote:
>
> Changes in v2:
>   - Use dp bridge to set psr entry/exit instead of dpu_enocder.
>   - Don't modify whitespaces.
>   - Set self refresh aware from atomic_check.
>   - Set self refresh aware only if psr is supported.
>   - Provide a stub for msm_dp_display_set_psr.
>   - Move dp functions to bridge code.
>
> Changes in v3:
>   - Change callback names to reflect atomic interfaces.
>   - Move bridge callback change to separate patch as suggested by Dmitry.
>   - Remove psr function declaration from msm_drv.h.
>   - Set self_refresh_aware flag only if psr is supported.
>   - Modify the variable names to simpler form.
>   - Define bit fields for PSR settings.
>   - Add comments explaining the steps to enter/exit psr.
>   - Change DRM_INFO to drm_dbg_db.
>
> Changes in v4:
>   - Move the get crtc functions to drm_atomic.
>   - Add atomic functions for DP bridge too.
>   - Add ternary operator to choose eDP or DP ops.
>   - Return true/false instead of 1/0.
>   - mode_valid missing in the eDP bridge ops.
>   - Move the functions to get crtc into drm_atomic.c.
>   - Fix compilation issues.
>   - Remove dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc.
>   - Check for crtc state enable while reserving resources.
>
> Changes in v5:
>   - Move the mode_valid changes into a different patch.
>   - Complete psr_op_comp only when isr is set.
>   - Move the DP atomic callback changes to a different patch.
>   - Get crtc from drm connector state crtc.
>   - Move to separate patch for check for crtc state enable while
> reserving resources.
>
> Changes in v6:
>   - Remove crtc from dpu_encoder_virt struct.
>   - fix crtc check during vblank toggle crtc.
>   - Misc changes.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
>
> Vinod Polimera (10):
>   drm/msm/disp/dpu: clear dpu_assign_crtc and get crtc from connector
>     state instead of dpu_enc
>   drm: add helper functions to retrieve old and new crtc
>   drm/msm/dp: use atomic callbacks for DP bridge ops
>   drm/msm/dp: Add basic PSR support for eDP
>   drm/msm/dp: use the eDP bridge ops to validate eDP modes
>   drm/bridge: use atomic enable/disable callbacks for panel bridge
>   drm/bridge: add psr support for panel bridge callbacks
>   drm/msm/disp/dpu: use atomic enable/disable callbacks for encoder
>     functions
>   drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
>   drm/msm/disp/dpu: check for crtc enable rather than crtc active to
>     release shared resources
>
>  drivers/gpu/drm/bridge/panel.c              |  68 ++++++++--
>  drivers/gpu/drm/drm_atomic.c                |  60 +++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  17 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  56 +++++----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   8 --
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   2 +-
>  drivers/gpu/drm/msm/dp/dp_catalog.c         |  81 ++++++++++++
>  drivers/gpu/drm/msm/dp/dp_catalog.h         |   4 +
>  drivers/gpu/drm/msm/dp/dp_ctrl.c            |  73 +++++++++++
>  drivers/gpu/drm/msm/dp/dp_ctrl.h            |   3 +
>  drivers/gpu/drm/msm/dp/dp_display.c         |  31 +++--
>  drivers/gpu/drm/msm/dp/dp_display.h         |   2 +
>  drivers/gpu/drm/msm/dp/dp_drm.c             | 184 ++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_drm.h             |   9 +-
>  drivers/gpu/drm/msm/dp/dp_link.c            |  36 ++++++
>  drivers/gpu/drm/msm/dp/dp_panel.c           |  22 ++++
>  drivers/gpu/drm/msm/dp/dp_panel.h           |   6 +
>  drivers/gpu/drm/msm/dp/dp_reg.h             |  27 ++++
>  include/drm/drm_atomic.h                    |   7 ++
>  19 files changed, 631 insertions(+), 65 deletions(-)

I spent some time looking at the first few patches. I can try to look
at more later this week, though (as you've noticed) many of my reviews
are more nit-picks because I don't really have experience with PSR and
my overall knowledge of the Qualcomm DP driver is pretty weak.

I tried to at least pick to give a Tested-by, but when I did that it
didn't work flawlessly. I picked this series to the chromeos-5.15
tree, which is pretty close to mainline right now. I left it sitting
at a screen with a blinking cursor which pretty much means it's always
transitioning into and out of PSR. I've seen several glitches on the
screen with the series applied. :( No idea what's wrong--that's just
me black-box testing. I did try to add debug printouts to see if we
were hitting "PSR_UPDATE_ERROR_INT | PSR_WAKE_ERROR_INT" but I didn't
see my printouts...

FWIW: I'm running with KASAN enabled which could affect timings...
Glitches happen every few minutes or so for me and so far I haven't
see any glitches without KASAN, but that could just be chance...

-Doug
