Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5A50BCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357212AbiDVQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350961AbiDVQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:13:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553155B3DF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:10:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y20so17303756eju.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TO6k5Eg+5Nqe4CCIAN4ROGKgZysMxXNX64mWMEm2504=;
        b=oY3R9eMENeA4yFgfxxAh0CIL63NfU/4cQZy0VBfnWqdkaQCrjP1OSsrzairEuqTc8h
         dCnx5NBV16wwOh8IExGkxkRthS5yV1+uEB61rOzpqQGfyzUlUPRRrILpKog4hvbptgGe
         HyH8ZzQX9V8+aRsclZdqqy2LK9aUqTNtjPWfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TO6k5Eg+5Nqe4CCIAN4ROGKgZysMxXNX64mWMEm2504=;
        b=XJ0g2bX/Ex1GL/jtzWRk1EFljS90WXpWV+LEjfo5RsN05ZzkA4MACZ4YXs9lb43+2G
         nifV1rtwdYIPcBO9kLovP0Qdx8b9J2BvRCrKVEWmHUnnPN6QPo6ptCCY3QSNjtXK81gv
         ki0PY3NJuPNLFR8njBVsTXd3g9vZqFtdqISe1DhyDKv1YscMADhhAMH9ULiUGQ1q1FsC
         shStDWZjNF5Dg2diUWnAzceG4scJHWP8fRMxprXQZhU5gUtMbV91yIRZTA3gKCxW8SMf
         7tGTRI0k/0nG/q18kHAhEek7w2al1yLxRGB7NRBt34MZ5b++XJHR0VPJ5xXq4v+CmriP
         /fiA==
X-Gm-Message-State: AOAM532faR8XUsyZtqlPpNPnbYft7ZoLivXZ2hHe7V+SMLbXyp82cJIU
        rZHgouY2kwSAel2mDwqhpSwoIG5beJHvyx9QtfA=
X-Google-Smtp-Source: ABdhPJzlwvF7aNI5cOOlf58VIf+zLAbFKjSypiM1uqQ8P/LjsvCeXZmU/iDmwkqyRejtgP2czHgrDQ==
X-Received: by 2002:a17:907:c11:b0:6f0:1b1a:65bd with SMTP id ga17-20020a1709070c1100b006f01b1a65bdmr4791609ejc.268.1650643851908;
        Fri, 22 Apr 2022 09:10:51 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm874236ejc.25.2022.04.22.09.10.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:10:51 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id k22so11758120wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:10:51 -0700 (PDT)
X-Received: by 2002:adf:a29c:0:b0:20a:a246:a826 with SMTP id
 s28-20020adfa29c000000b0020aa246a826mr4418755wra.422.1650643850709; Fri, 22
 Apr 2022 09:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <1650618666-15342-1-git-send-email-quic_sbillaka@quicinc.com>
 <1650618666-15342-3-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=WWa8n0MJB8ks7bgrSj1Qop1Z5hvfEAOWtFcmsz38eR_w@mail.gmail.com> <83129bad-44a9-bec7-f931-8067ef1b9d4d@quicinc.com>
In-Reply-To: <83129bad-44a9-bec7-f931-8067ef1b9d4d@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Apr 2022 09:10:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vu_0vxb_D+8n3qhNZ66nRXBp5vxshChmOM-ToPJxk=aA@mail.gmail.com>
Message-ID: <CAD=FV=Vu_0vxb_D+8n3qhNZ66nRXBp5vxshChmOM-ToPJxk=aA@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] drm/msm/dp: Support only IRQ_HPD and REPLUG
 interrupts for eDP
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>, Sean Paul <seanpaul@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 22, 2022 at 9:05 AM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Doug
>
> For the lockdep error, the splat looks similar to what kuogee fixed
> recently.
>
> Can you please check if below patch is present in your tree?
>
> https://patchwork.freedesktop.org/patch/481396/

Indeed I did have that in my tree already, but the lockdep splat is
still there. I think the problem is that we're now calling
dp_hpd_plug_handle() directly in dp_bridge_enable()

-Doug
