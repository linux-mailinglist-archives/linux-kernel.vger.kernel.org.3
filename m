Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1556906A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGFROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiGFROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:14:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103226AF0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:14:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id q16so19153866qtn.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gdl58Y6eruxO/UF9iHebd7iAX1fPwcfZcdGK1G6I67A=;
        b=NcYmRAhNkr+Sej+dUBW/rUemcu4qhrB0eGXwYx5FTFmtQ8tKRufDlwJ/lkS7wER2zJ
         jV6wRoRmAMNdAQSXMkcvIOLC2e60hR5mw9xUwmncmRINM3JFeYMHnzmNaXHfIjFlbf7S
         LDX+d7jVDzt3eROD00YFUpwlzzpN+FGYYubdZ94XUT/jDUnTLGCPskgT+K5yZnTAH4nR
         9KN4M7fzv63p/y1wtxjpDfTTuC85SufMiPGqenPoHFa91gprzBOo9A8iG+THujkecbCy
         fhtfwsTjXDPXOWFw8PTjz5echkBOFR7P9QzIipHzfLD0oVava1d+90rXJYk2Old6RtK3
         GuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gdl58Y6eruxO/UF9iHebd7iAX1fPwcfZcdGK1G6I67A=;
        b=0szs9Mdy9ATaSH+EUhaOgOuS+yZRikuw943s45dE9+ChxmE750p8+LvCGrjvPrBZbn
         MBc3ImIMay0FjnKVI52RnVf7XPE3IrmhTq5FvlTlFOpeFHwd5ZzxfOpdKpsFElV/fmZM
         BFbE9oAHcuc0+U+BkAkjPK84xiR24UiZFWpyG+ECQdQKGLyDpGz3NUHqTHWzw8ai+AHr
         eBrMJONaAypoT7Vck4Hwi7tfamQbOVKlQucxP/ErrC5KquY2auZ0+HitKtKSUFjz6kET
         LlFVVP8kbGSrabnsv+NaWmLIqeWJOxiCSEUNqUS+U56l5KR4N8ZOeVzQnY/FYYLKyfgA
         bQqg==
X-Gm-Message-State: AJIora/ZqcNzr2OgP8DnKB3qfODpRXrBtW2RtdBMi+GL0aA9rHikkZUi
        Wrg0PWGK3equ0mBO6uXH84gzFgZMrs4n62gAusRv1w==
X-Google-Smtp-Source: AGRyM1siyHqhjYbCijMakD/a+R1/ORAjQrKAxonXg7rZEccsGYIKNljc2HpasXRM2tM13BML+/t+aFxBEkjO+7fgSBU=
X-Received: by 2002:ac8:5c96:0:b0:31a:c19a:7da1 with SMTP id
 r22-20020ac85c96000000b0031ac19a7da1mr33974182qta.62.1657127656137; Wed, 06
 Jul 2022 10:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <0083bc7e23753c19902580b902582ae499b44dbf.1657113388.git.geert@linux-m68k.org>
In-Reply-To: <0083bc7e23753c19902580b902582ae499b44dbf.1657113388.git.geert@linux-m68k.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 20:14:05 +0300
Message-ID: <CAA8EJpp2u4NuimhvkXwcO2kPQCopgbDV5x=B+LEkyqoQrSW5rg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: Do not propagate void return values
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
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

On Wed, 6 Jul 2022 at 16:18, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> With sparse ("make C=2"), lots of
>
>   error: return expression in void function
>
> messages are seen.
>
> Fix this by removing the return statements to propagate void return
> values.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> v2:
>   - Add Reviewed-by.

-- 
With best wishes
Dmitry
