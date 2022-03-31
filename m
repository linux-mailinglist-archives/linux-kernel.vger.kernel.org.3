Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A54ED0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiCaAfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCaAfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:35:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3917744A27
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:33:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id p15so44749774ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYujwTSODoLsl28pxL/Kco6cVNKp164PEtJvRGhch7g=;
        b=LIfdAANbRqTkPOnpxYpODahOeq58jhaQDCbRX0ewZFvKdXZeAW4AkHth/rY399jQeA
         s29OfqcQ4X/oZAuMTJw1TZ+twD9KjvNly58+Betnq8PEp5NRg2YclK4NhtOUXif3D+OG
         B9DpasiswvJSuUWGNYlmZLBqNlkOp2jMpijmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYujwTSODoLsl28pxL/Kco6cVNKp164PEtJvRGhch7g=;
        b=dQpjmiZ/sW+EBOO76QHZa5t29yM8kzPsWcTS/tQluJG3KaJ43x12b6sOJfNe/zLg8d
         X3dIcKg2YhxR6qow7rZ1znhUhZIi3ojv5ACBYknHYxH/msyJi9q4iSD/0c0ol5LqWAUF
         xWkyUHnaiM9hKYdjH+EojOLQnMD+NX0uPY7KO/Cd/sUXGiC6EFagVDLebZu7sZw/kA0/
         YELR9nMBFSfnI5XKUJs5G2y6iZgY6tfJKgvU1mBMvxJ5SQuENx1o+upaSrwfIHc/AEy7
         t7L6kEdxvFf4+QQ0Ceuy5JrH2WZQQpqTHB69X2uTfDo+ty/8+/Uqx30FIPtp8d9aXhWu
         76GQ==
X-Gm-Message-State: AOAM532gKsit59XMzj9c2+y2WgV85vD7R+pp0CrP7oBkuz0Jdeo0M0fe
        srvp/BWjbOnnjTJ+VoKCnhommpKQZ4GJeTb4
X-Google-Smtp-Source: ABdhPJwKBBfJ8XAhuEv9/WG0tRfleJFRzSqVEuJ+SmQfXqgKH44+wFroV0Tmm85ICC9bzq1X86bqFQ==
X-Received: by 2002:a17:906:3101:b0:6d6:5b64:906f with SMTP id 1-20020a170906310100b006d65b64906fmr2460302ejx.513.1648686833849;
        Wed, 30 Mar 2022 17:33:53 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090677d500b006df766974basm8968639ejn.3.2022.03.30.17.33.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 17:33:53 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso1037071wmn.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:33:52 -0700 (PDT)
X-Received: by 2002:a05:600c:19ca:b0:38c:b84f:421a with SMTP id
 u10-20020a05600c19ca00b0038cb84f421amr2260341wmq.118.1648686832035; Wed, 30
 Mar 2022 17:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com> <daec6ea4-abb1-05e6-ad49-b0a418a1f43e@linaro.org>
In-Reply-To: <daec6ea4-abb1-05e6-ad49-b0a418a1f43e@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Mar 2022 17:33:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UTYQXngXmA_civiCMDctZr6tJNjNXynQuCwxvgiJijLg@mail.gmail.com>
Message-ID: <CAD=FV=UTYQXngXmA_civiCMDctZr6tJNjNXynQuCwxvgiJijLg@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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
        quic_vproddut <quic_vproddut@quicinc.com>,
        quic_aravindh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 30, 2022 at 4:19 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> > +             bridge->ops =
> > +                     DRM_BRIDGE_OP_DETECT |
> > +                     DRM_BRIDGE_OP_HPD |
> > +                     DRM_BRIDGE_OP_MODES;
>
> I think OP_MODES should be used for eDP, shouldn't it?

No. It's confusing, but basically to get the power sequencing correct
we end up driving the EDID read from the panel driver in the eDP case.

-Doug
