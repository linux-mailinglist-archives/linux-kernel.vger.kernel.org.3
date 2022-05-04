Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BDD51B3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350016AbiEDXsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381861AbiEDXlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:41:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B8D614F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:38:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so5687663ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXeq/XPiJwEkXU3dI75Tl8dYba/oZ3LQ1VjEhaH9Vwg=;
        b=F8ZAHz6WSgNmgenOXICnR5VtLZmMglppgmbrbMqwX6PNKEjGhmfLbTITzRwZBewfUH
         /b5EfJyVCZr6ehKbYwB5lu3juAduuJ9CSsx6et/o9QODUmwNkM5rS8cqpMUwF6jSf0r6
         C//ckdHWg9VL4W9ByKAQIt66nwfQW6b5QZvls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXeq/XPiJwEkXU3dI75Tl8dYba/oZ3LQ1VjEhaH9Vwg=;
        b=GO4NW5rX2c+QLFC/X3hWTj0+eQbb8r+xQf9x1Xtqf+iL6F8EEea2e8o2VcpRM/mszY
         l3iXuIiVxc82d90o1//JNpjOjfbK3GW5jffE8A9gtRxr7LobXir39p8mvqbpT9KiK2qm
         CuGBzcgAhCbMQ0KT5EK86uvabYKX+k+5FZhKvGqiainr3Wd2m0jiHG1pll7GAyDBlU5n
         JN5W+fTaaBOJ6/jUH6w72dGZA5ShvO7Z1NeD0HqSrWS4C/F+XX6UA6SgpzdjS9UfYxry
         TISNgEl/O5Dx08R5x3O+xQV3mddwN+7BOQaBAOKSrHusCxVk+4ctK7j8PcTnrDYyf4fW
         7Jvw==
X-Gm-Message-State: AOAM5328QlsLNEQq0poqnTkqSIXJh6flIYTJTxxYRQwPt2+yGz1sunMV
        52rtm47VJYyLKnuzZdfEqA1Deh5fSNiya7RJ1jg=
X-Google-Smtp-Source: ABdhPJykQ/sWWn4j68w97/fjZ5VLo6olGHmOWcq9LpdD9ZitABQAlhtKZzwrva5Wa1+dRmn2N7hRLQ==
X-Received: by 2002:a17:907:9812:b0:6da:aaaf:7713 with SMTP id ji18-20020a170907981200b006daaaaf7713mr22197728ejc.163.1651707487545;
        Wed, 04 May 2022 16:38:07 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214deesm101195ejc.84.2022.05.04.16.38.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 16:38:06 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id e2so3939715wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 16:38:06 -0700 (PDT)
X-Received: by 2002:a05:6000:c7:b0:20a:d8c1:d044 with SMTP id
 q7-20020a05600000c700b0020ad8c1d044mr18472545wrx.422.1651707485535; Wed, 04
 May 2022 16:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220504154909.1.Iaebd35e60160fc0f2a50fac3a0bf3b298c0637c8@changeid>
 <CAA8EJpqfKKELrkRS89ssDU_bP67_sJ06B6VGGSmR_=D4bV-wZg@mail.gmail.com>
In-Reply-To: <CAA8EJpqfKKELrkRS89ssDU_bP67_sJ06B6VGGSmR_=D4bV-wZg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 May 2022 16:37:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VEHn6QxhN9c6xaceaXBwre4K0Tvnr-ESd+SOqL9D4ZHw@mail.gmail.com>
Message-ID: <CAD=FV=VEHn6QxhN9c6xaceaXBwre4K0Tvnr-ESd+SOqL9D4ZHw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix shutdown
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Sean Paul <sean@poorly.run>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Xu Wang <vulab@iscas.ac.cn>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 4, 2022 at 4:29 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 5 May 2022 at 01:49, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > When rebooting on my sc7280-herobrine based device, I got a
> > crash. Upon debugging, I found that I was in msm_drv_shutdown() and my
> > "pdev" was the one associated with mdss_probe().
> >
> > From source, I found that mdss_probe() has the line:
> >   platform_set_drvdata(pdev, mdss);
> > ...where "mdss" is of type "struct msm_mdss *".msm_drv_probe
> >
> > Also from source, I saw that in msm_drv_shutdown() we have the line:
> >   struct msm_drm_private *priv = platform_get_drvdata(pdev);
> >
> > This is a mismatch and is the root of the problem.
> >
> > Further digging made it apparent that msm_drv_shutdown() is only
> > supposed to be used for parts of the msm display framework that also
> > call msm_drv_probe() but mdss_probe() doesn't call
> > msm_drv_probe(). Let's remove the shutdown functon from msm_mdss.c.
> >
> > Digging a little further, code inspection found that two drivers that
> > use msm_drv_probe() weren't calling msm_drv_shutdown(). Let's add it
> > to them.
> >
> > Fixes: ecb23f2e3009 ("drm/msm: split the main platform driver")
>
> More likely:
> Fixes: 6874f48bb8b0 ("drm/msm: make mdp5/dpu devices master components")

Oh, I see! The commit I tagged is the one that set the shutdown in
msm_mdss.c, but at the time of that commit it actually _did_ call
msm_drv_probe().

v2 coming right up.

-Doug
