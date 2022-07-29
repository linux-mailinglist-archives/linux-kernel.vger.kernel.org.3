Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853795848F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiG2ASp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiG2ASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:18:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238C07B1DB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:18:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ez10so5744290ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PyBgADkFmRZGD19YV3bJfXKekitzQhA7zmplwDjvl4A=;
        b=EBDfKbN161jfJ2QBSHpfJwdM19oVk8aVJ4xikkdC2kuXRN+8QRATaPmhq8E7nW+CwY
         0BgTL+iXQpYb3/SFbGQJMC8MumsErqG7MH3njWLFzrqPP1pRCjSDD9mvh9NlaP21SyHV
         gJmZF+TK74SlIlGljuDFIZFOnwtouZg04HSZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PyBgADkFmRZGD19YV3bJfXKekitzQhA7zmplwDjvl4A=;
        b=6HsLV2nJeWSlRT07X/y9eQrgl4th0C2tFDKum2c821yNSyVZa7XR4dfBU5PszT1R+a
         GmFDprCP5/fnsKOIkLDXLhFw3r7nO6v2ZOHdLTaWozZyoZQgfJhGNxB/Nmu/tvcWvW66
         aV307zoBZeVui0kNgnI57kkftx9qEv32h9uvhv3LSGhX0/OUYgKPL1sMPZgPuLNbJbv1
         JEuY0kJYwxhTC0exqHge3belu6IkQZdYlCsGZyaUI6mHqOzqCa+o98wb+e2wz1wkEXTV
         EwfxHVLaEeYtZaN2ySEZ5GP+7XwdawLSTU/rfBlUddHi4hUFyOUs7yys9L44EREmbmS1
         p8fg==
X-Gm-Message-State: AJIora+NH6ZDVH0gACSIo84qFp8l88ge62FYs/ZteLrhK0NSYGfEki2Z
        KHYGE6EgCc8Kr4S+kMRF8JPH2MUkuvbPRj+A
X-Google-Smtp-Source: AGRyM1uqKT6kfo3HF2ohDcKWohbVz1KKJdQc9CfrTKhC0fHB55t7xQcQYyy13ElH7N9p3+j59Kd+Nw==
X-Received: by 2002:a17:906:dc8a:b0:72b:7649:f5bb with SMTP id cs10-20020a170906dc8a00b0072b7649f5bbmr953139ejc.637.1659053916167;
        Thu, 28 Jul 2022 17:18:36 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b0043a78236cd2sm1493304edt.89.2022.07.28.17.18.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 17:18:34 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h8so4176091wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:18:33 -0700 (PDT)
X-Received: by 2002:a5d:6843:0:b0:21f:1114:fc54 with SMTP id
 o3-20020a5d6843000000b0021f1114fc54mr146662wrw.138.1659053913662; Thu, 28 Jul
 2022 17:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com> <1657544224-10680-3-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1657544224-10680-3-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 17:18:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2Ci6G5c4LNibKTWu5ZC962j8QeHpG2nn7uCCoRCuFdw@mail.gmail.com>
Message-ID: <CAD=FV=X2Ci6G5c4LNibKTWu5ZC962j8QeHpG2nn7uCCoRCuFdw@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] drm: add helper functions to retrieve old and
 new crtc
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
> Add new helper functions, drm_atomic_get_old_crtc_for_encoder
> and drm_atomic_get_new_crtc_for_encoder to retrieve the
> corresponding crtc for the encoder.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic.h     |  7 ++++++
>  2 files changed, 67 insertions(+)

I don't have a lot of intuition about the code here since I haven't
messed much at this level, but what you have here looks right and
matches other similar helpers. I'm happy enough with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
