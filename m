Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0254D20BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbiCHSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349636AbiCHSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:54:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDBA31360;
        Tue,  8 Mar 2022 10:53:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w4so23193446edc.7;
        Tue, 08 Mar 2022 10:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbj3xN0iDcD9/ITu0QYceYztDmj5HBmZeXlHsmQyrHw=;
        b=B618Sz+Xe0Jlwlh7LCH+brDIS/apTr66CGVdpWmDijL1AfVKPArkwxSnfq3nIRELa6
         TUXfrPY1cssYxeKbeY+Ip/mOslS0mP/E1k6W0H2j2Y91NMPfkDtML8bJWVY8DCo1TyKk
         gTyIXNUYexF/C22ReOOhfIEDkTBOo8Fs8MLg5nnPeuPooL1PhgDOxoudzwiFWU5bUOo7
         lmxV2L+z26Wi42uHoPFYo2khhsU9eEyzNz0hc7z+McfjGRvcR8cxNDpSgOy6CUuwPU75
         pHcWFGSBqKOoOlM8Hg/NRfAPK7fnu9yWDoMzm+Yfdzk0jAf5WsyDy+XULVjTMg4K82m3
         FBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbj3xN0iDcD9/ITu0QYceYztDmj5HBmZeXlHsmQyrHw=;
        b=BxIsxdJ1VAnXp8kQ33gclTa8F0MOQuNib7p969KPbMqu9yRjv8Mora5Pus3HjUvsnh
         WSvP24wInjbZXhVooZ7QbJWsMtArUUyAQpFPscSiCepsZAjryXaNlrQNyrmCemcVJUE9
         hPJt3R68TAhCwukvmbM7MC9yWERfAL5KkpEemD2iosyYxP6dqrUbBwOtPxxYjVLPXdtx
         y/NsqaVd6dgUVQNP4LK3aqoTfdY8gLkrdQU+KT8yIOYNx0KJTU+aF4G9AdTNgstCCZqP
         313zUYMhGuMzsJAtmHTT7oonlOL8bm7eMPbrPbAE8uG3WBA0ZahoyL1ZMuCLiS0IrEEP
         7PGA==
X-Gm-Message-State: AOAM532nt3P8V75ASOz2M5XNPFLbYAIPH6F5R35UScJ+ydcjTuGnlE5n
        zDibOVv+ElY0fVGZ0YKpfT99noxaoYJ4yAq5pwY=
X-Google-Smtp-Source: ABdhPJwOJAgm8wr1+UkxQb7mNwouA+rAJXuJwzkhiCZQ1YADoQAKP9kdCqJXn9nLHZLfoyyEyfV4Hifbp+0BVDY0Ivc=
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id
 f11-20020a0564021e8b00b003da58e69a09mr17146759edf.155.1646765581293; Tue, 08
 Mar 2022 10:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20220308184844.1121029-1-robdclark@gmail.com>
In-Reply-To: <20220308184844.1121029-1-robdclark@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 8 Mar 2022 15:52:49 -0300
Message-ID: <CAOMZO5Dkr7PqvgYpNp1fBR7P91T-x1ke2pRN6A6GWFJ7zBQo7g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support (v2)
To:     Rob Clark <robdclark@gmail.com>
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

On Tue, Mar 8, 2022 at 3:48 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Avoid going down devfreq paths on devices where devfreq is not
> initialized.
>
> v2: Change has_devfreq() logic [Dmitry]
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Does this need a Fixes tag?
