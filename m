Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103725538C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353223AbiFURST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353074AbiFURSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:18:15 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1EC2711
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:18:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p63so10607640qkd.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwgcxcNcyUJ2NZcZ15e/v3/JFQqPvu5+AV1dXV2vsco=;
        b=TRn64fJDhOElfdcTPwyz6sItOyqoiDKFp52IyHdMNOTBQcCEhFotFhbieaj7qSREL8
         3kGY1lhmsXg3/711w7p4yz2xDmezK97ZjDhH25hVdCPA/4g4FUTMDfgN2vSWX/ZhArl0
         nNZETnIyH2zeO4mPe268fsAerKKK5cWu6jwDZJaN4Y1VTofp0cWGYy7YtPNfrcyKxeX1
         y2CUij5/SY1Qv53A/TY/LJpo4tbrvweyd9Evb7XGjxNlMjDc/es/LordtDmcKhzYuguh
         xSlzNflRpZl8OppZX6apzOLrVnhL2PUvipQoqWarhBbf7mk012ZXQ8zb+/Kj8HpdvrbZ
         41Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwgcxcNcyUJ2NZcZ15e/v3/JFQqPvu5+AV1dXV2vsco=;
        b=jd53UXXpMWfZTSx2h028Xpv4zEnPKz8Htd4f7YNej4jBBpY8Da47kbZlJnN7zTBjIm
         L5MB9hvXD7tFYwdJpCJ7phNXjgdPAKQkADVJHRkh2uQAPZ9fghuYvriCO1I0e67YKC0f
         IDbsqfDUlLwnPZDU2pXKxFeyXDALUbSIgO4yXjd6t9/L5UpxpEkNBIaLvbhDKGUGkkkx
         Z6EZ5jirocm4/+rkaA/onf6LlhNJ2+iSCcND8eMb+xFbdd0j/v8XfwIzuM5mfPgq550/
         OX7GVqZ5Gmiv6xl+JzwGuhbUkJI+CIseg3vUTKO/iZD7fVDgTu8KPfHkabIJ12pcr8mx
         LwLw==
X-Gm-Message-State: AJIora/awiakroA2z86wyNTowGdIORtNuXWR8eqibMIyGY3lHoJ1ZhsP
        q1kc+HDBrzqffXdhgZenTpkY4YU/Zf0XEaimdQ97yw==
X-Google-Smtp-Source: AGRyM1smc0gwmosrHI+DQL1uoC4Ig2j2XwTOLwa6CjLVbxx4AvthhD2XSWSsKcJldKX7/++f3DvVCyYjrta4Yu1yNpk=
X-Received: by 2002:a05:620a:4156:b0:6a6:f8d2:6d9e with SMTP id
 k22-20020a05620a415600b006a6f8d26d9emr21165057qko.30.1655831893778; Tue, 21
 Jun 2022 10:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <1655830891-19025-1-git-send-email-quic_khsieh@quicinc.com> <1655830891-19025-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1655830891-19025-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:18:02 +0300
Message-ID: <CAA8EJppZSuEOAh_K-wqQtC4Zx-W5ig02Oe7ZukJnF_Z=6pEDfA@mail.gmail.com>
Subject: Re: [PATCH v15 2/3] phy: qcom-qmp: add regulator_set_load to dp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 20:02, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() before enable regulator at
> DP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 43 ++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>

-- 
With best wishes
Dmitry
