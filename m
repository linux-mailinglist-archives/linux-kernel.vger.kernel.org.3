Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC42550199B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244906AbiDNRHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244474AbiDNRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C450DE4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:47:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q14so6751225ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zX+0Rp8KeI1bu36+dWYbiIQtitTDuR4Sdzxg17DTCMM=;
        b=N693k4tshoimUMR7PJSOzCwUrqo6jmdbynTTZ5/gGXiI4BUH5YFaTyhChlD1qYPwIv
         Kh7ugHtuZ2uky5ruCQ6mniUIioKbVQxsbZ/Rnh06noLFOOH9Mi+acFsRtex2XGvkaG4R
         Q3VlTKcErFU8W0iVIIxODoppOuI9yIftPOgPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zX+0Rp8KeI1bu36+dWYbiIQtitTDuR4Sdzxg17DTCMM=;
        b=37S/0J0SvWONPX/zFv5LF1rVFyXwXVA0vnNGrP7defSyL/3qa3vkULry1T3+wWtacF
         A47F0iQQIk3Pz5XvCOUnaRuhzTLcWTgF94UaqlQ6gNxGCapqAixY+HZHqVqOiazdmWar
         B4NgDrwK7QAqXumCI0+9MhV4XNuGNoHrgYS0PYFsfDoQSsMXG3oIsWfoHoIUz6ek2MR/
         L0GuyaEOyRRYkD75gYwDfj8/KZU9pTYB6Xg95hhQx2tuYYHYY6sFX3g/Eto6Io47vXQx
         MKiEtbPg59OjptZl22p7mckiu2f7eKX35nsr1CO2RFcPkENEDkNZgsezzMnV8Tcjg2ui
         JLPw==
X-Gm-Message-State: AOAM5326e1FQPwmc/WmJywiw44+HsZHE4l8eoiPSfaatQZddKKizxHIC
        wCP+n5VwPQDKTPbc7TNvFzmkqJT/EAPCIHMz0So=
X-Google-Smtp-Source: ABdhPJw+KR23cz3eZ3C2oXT0pZVS/C0afqbq3o8wvRlt0GHY93W5UIskiLKQsfFGyoftLqjfSX2s3Q==
X-Received: by 2002:a2e:6814:0:b0:24a:f422:e953 with SMTP id c20-20020a2e6814000000b0024af422e953mr2042842lja.527.1649954872347;
        Thu, 14 Apr 2022 09:47:52 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i18-20020a056512225200b0044a29058506sm46388lfu.194.2022.04.14.09.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 09:47:52 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id u19so10130486lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:47:51 -0700 (PDT)
X-Received: by 2002:a5d:47cf:0:b0:207:ac31:c2ce with SMTP id
 o15-20020a5d47cf000000b00207ac31c2cemr2734623wrc.422.1649954428907; Thu, 14
 Apr 2022 09:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Apr 2022 09:40:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ui6BAsnTaJ2_TMh1Tnjtaw7FR92aWoUysS+UT=c0qB3Q@mail.gmail.com>
Message-ID: <CAD=FV=Ui6BAsnTaJ2_TMh1Tnjtaw7FR92aWoUysS+UT=c0qB3Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add support for the eDP panel over aux_bus
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 14, 2022 at 5:19 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> This series adds support for generic eDP panel over aux_bus.
>
> These changes are dependent on the following series:
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=613654&state=*

You're basically depending on the last two patches of that series.
What's the plan there? In patchwork they're marked as "Not
Applicable". If they're good to go, maybe we should land them? If not,
maybe you should include them (with Dmitry as the author, of course)
at the beginning of your series?


> Sankeerth Billakanti (4):
>   drm/msm/dp: Add eDP support via aux_bus
>   drm/msm/dp: Support only IRQ_HPD and REPLUG interrupts for eDP
>   drm/msm/dp: wait for hpd high before aux transaction
>   Support the eDP modes given by panel

One of these things is not like the others. One of these things just
doesn't belong. Can you spot which patch is missing the prefix by
looking at the subject line of all 4 patches? ;-)
