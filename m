Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6000E55558B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiFVUyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiFVUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:54:09 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7911B7B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:54:03 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id u8-20020a4ae688000000b0041b8dab7f71so3549542oot.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=zLM3H6dXb+4yal/kJHLEaxquP6RiiCYcAQJiPFIPgC8=;
        b=HskBGcQ2b9PGCBZ6Tnzgt6AnYSaE04gY5FShwZziCicLLASoVTQ/m5/Nx62jqEvxzq
         FaAqhHz0/i4OzvdA7rYGg/GbwDArNnQaPgeHYJP9iHp4LndZjDAOtSXD/H/u8Diu6s2v
         RRkvk/2yXmGKDKXqZnaanEF3T74mHT9aLGlKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=zLM3H6dXb+4yal/kJHLEaxquP6RiiCYcAQJiPFIPgC8=;
        b=qZDxXeLu5BLPaNPJrAbS1Uk/SFgwKT4qOwvuFZZ6oYrjK9s2RKtPxJJX/dKLrX88cc
         jpsJozWECsnvP6o2w1nYJdcq0uxDZmyoimcfNwYTDRlGghSk99Zj9bzFXokIJKeVHDaI
         1gneu4u7BrDrXggwH1gdfEd95V46F5ve1wcamnaxOiAwis8Bpi8imjO8gdia3r/3G9Cx
         6LEvmeFU74XDZClXRYyoCYrvX01kG5CcgfK+DwATuS9rmax/IVcsQbUjkjQJJvGej1jd
         Rq2uiGVP2LhyioSY0pdZ6thtiO/ErAq8gTSFL+3dgFTjqfNswUj/m6o8A1BpfPx/jTeX
         6RkQ==
X-Gm-Message-State: AJIora8xBvBBs6WvAW0s7fsj6ZSwRG+h+INjj+L+0q5NmYqB36xGsFjD
        JKbI99w+iGCZzFXvS4XH4TZMHIi5sN4Sa0j+lrdFIg==
X-Google-Smtp-Source: AGRyM1vqwuYKRd2OLI2EjFJb+t6z5KjjkxkIrqC3zFBPKs8L9JJgfehG5mxRD8VQ6NVJjmHBWycT3gs/lPSd5dKK+JM=
X-Received: by 2002:a4a:ca95:0:b0:41c:e2c:ab2d with SMTP id
 x21-20020a4aca95000000b0041c0e2cab2dmr2199697ooq.1.1655931243137; Wed, 22 Jun
 2022 13:54:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jun 2022 16:54:02 -0400
MIME-Version: 1.0
In-Reply-To: <1655830891-19025-2-git-send-email-quic_khsieh@quicinc.com>
References: <1655830891-19025-1-git-send-email-quic_khsieh@quicinc.com> <1655830891-19025-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 22 Jun 2022 16:54:02 -0400
Message-ID: <CAE-0n52xHB4THaBztNY4THc8+vDGzD0YF-5_T9Baaj-Xdu4zGA@mail.gmail.com>
Subject: Re: [PATCH v15 1/3] phy: qcom-edp: add regulator_set_load to edp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-06-21 10:01:29)
> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
