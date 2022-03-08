Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06944D20D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349446AbiCHTAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiCHTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:00:44 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66FE0C4;
        Tue,  8 Mar 2022 10:59:46 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so112823wmb.3;
        Tue, 08 Mar 2022 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlEBP0dYqZ3fyLNSyiw8KHK9YhpTqiBMFquOs6BvLfo=;
        b=Xall2NrXYxCvpO+k2IRdt458PZkUo48IXE0jneqg59khrwXsl5iewYj2Eb8LIUrZZe
         FVE/jff4cGANSH0wf4dLwbtFEn/gXsXiBA3+1rlgNdAffWUeAlYtw2waUrVIil6tk/VY
         E3BmxeV8Bnufneps3gq9MfbZ90VZG1WMdr9fwdAo/oNUh5n8eeJjca1u2K4Jg5ZsosP5
         o8hXDXJQpG8Xn0AtDpOvoj6/6lf9oSSGc8hgLTaOUlE2qDvGNTdPMc3gU1I4hMML7Kgl
         1ZGunPmBieoXBd9wvRj5dhY1QJ/3eTqEg1ukLa4h1hwrFlo9oLpVhtsa4B2LbDqgevX+
         0iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlEBP0dYqZ3fyLNSyiw8KHK9YhpTqiBMFquOs6BvLfo=;
        b=PzNlEaUPoSfmjQN+mjqGUOQTmrEQcgLv8NCsNVf2BubkrAa7QQ676aYzL+EhXiqej7
         bKJhHmg0U3ZRWqc2m/LB+rsg/WPR0vqjxeRcCPIYUyZDsYtv3z5s4pzcFtqVBwJOk6yp
         D4pgjmn1RUq0sPhnoDROc2D8yxD2LJPj3f5qoAX+9hV7OoL/Gr3aJ5u59l5Glqgrg3bG
         5QCA3iuTBEXFMV0O5itMpSSny8YRn5gubDmBz7Jt9LjZviFiD36u9H70N9Y1l6wvzjsL
         6CyDeAs5G83oqXahJwMUNwEDjFGRjv3miRX0eOoZSTRoCon117ppOb7q90M5XvlUWelZ
         sOIA==
X-Gm-Message-State: AOAM532ASJFsCHVSWLBMaXjcCkvcevEWyMGccc1OHd/ZvDb75I4GuybF
        W/8Bkp2BK52UfYZrTHk3EUrC5BINJSP0zGK1zVA=
X-Google-Smtp-Source: ABdhPJxRLMgBSW3C5vVIU9Jzb/aKdPhWN3yZiBXjWHOvBgCS/dLX7GeDxuJWaQ/PI8AjZCkHayN5eHMLHehGkhRtfOg=
X-Received: by 2002:a1c:f616:0:b0:37d:1e1c:f90a with SMTP id
 w22-20020a1cf616000000b0037d1e1cf90amr4597415wmc.148.1646765985128; Tue, 08
 Mar 2022 10:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20220308184844.1121029-1-robdclark@gmail.com> <CAOMZO5Dkr7PqvgYpNp1fBR7P91T-x1ke2pRN6A6GWFJ7zBQo7g@mail.gmail.com>
In-Reply-To: <CAOMZO5Dkr7PqvgYpNp1fBR7P91T-x1ke2pRN6A6GWFJ7zBQo7g@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 8 Mar 2022 11:00:14 -0800
Message-ID: <CAF6AEGvfdyK2oNyLVrN5WJV0VV-EkvyD+EJ0rtGP7u7CA3kDXg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support (v2)
To:     Fabio Estevam <festevam@gmail.com>
Cc:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
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

On Tue, Mar 8, 2022 at 10:53 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Mar 8, 2022 at 3:48 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Avoid going down devfreq paths on devices where devfreq is not
> > initialized.
> >
> > v2: Change has_devfreq() logic [Dmitry]
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>

Fixes: 6aa89ae1fb04 ("drm/msm/gpu: Cancel idle/boost work on suspend")

> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Does this need a Fixes tag?

Yes, sorry, patchwork had picked up the fixes tag from previous
version but I'd forgot to add it locally

BR,
-R
