Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09284D55D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbiCJXv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344975AbiCJXvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:51:22 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344A1A06CD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:50:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w127so7653158oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSs+OWs1rd3swR36O2vNgKkkBCsIMZuIXdZ0u3m8Xik=;
        b=ms4RRU4ZyttsdToiIH3Sv1ehttlkGOuaHMYlv/yrwCG7GfF7G7ADyQ3pLWcdiSPTLg
         /4ZHSGavGVyd5cosnBfTPmshSYtXWjyiVV/xQKK2e9sj3fJDlRx4IJ1FsJWQA/Kyuq76
         pddpVo6STWfBplBRrZyUbSlTYnT84S1d69lbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSs+OWs1rd3swR36O2vNgKkkBCsIMZuIXdZ0u3m8Xik=;
        b=2Of1KdPPWIwOsDMp88wWGMojoGxugqOW0oT5Iq8TRqWogj5J5UXbiH68P8Z8IbjvKS
         JVyl+K6lG6UtYlwPLfIhseLfLm9jqU/fnE+J4aZzObs4h3PEsv1xKIBGvMI/2EgKOegr
         Z2LJKW0psC4e0mZRVS8T7vAZorF5V9c86Sm2Kwy2uO9stRgFjA3ft/kPBIXBJzy4o6iX
         WKFAk7PCdZW1E9bc0MO8t6uwPyD6ZCNQrs+IA+winm7S50Gb+W+S9AudW/b86h+xG4t9
         2uwvCY/jrOQY2eyRKWkSJolslnQq2tXRlKYztkOSdegQ4yvQM0gt5cGP/lqUx50xwzcH
         ZXfg==
X-Gm-Message-State: AOAM5326Mgaw/oslxc3Kt299GspH3JGrqeHFNGLRTs7Nggpo1W/dWxUE
        43aTFi26yN8GtQbi52HAtR1x/McWJWizYQ==
X-Google-Smtp-Source: ABdhPJwKYhe3mmNREo9RGWmpQ2m8OD5QfHadf2sdpdiJthhYbU4a17pT4iyQfTRhEqfE2LGVFEhidw==
X-Received: by 2002:a05:6808:13cc:b0:2da:7639:aec8 with SMTP id d12-20020a05680813cc00b002da7639aec8mr2485506oiw.13.1646956214110;
        Thu, 10 Mar 2022 15:50:14 -0800 (PST)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id t15-20020a056808158f00b002e331356c87sm211867oiw.39.2022.03.10.15.50.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 15:50:12 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so8729762ooh.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:50:11 -0800 (PST)
X-Received: by 2002:a05:6870:b52c:b0:da:b3f:3273 with SMTP id
 v44-20020a056870b52c00b000da0b3f3273mr4139015oap.291.1646956211126; Thu, 10
 Mar 2022 15:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20220228202532.869740-1-briannorris@chromium.org>
In-Reply-To: <20220228202532.869740-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 10 Mar 2022 15:50:00 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com>
Message-ID: <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: analogix_dp: Self-refresh state
 machine fixes
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liu Ying <victor.liu@oss.nxp.com>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 12:25 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi,
>
> I've been investigating several eDP issues on a Rockchip RK3399 system
> and have two proposed bugfixes. RK3399 has two CRTCs, either of which
> can be used for eDP output. For both fixes, we have bugs due to the
> relationship between the generalized "self refresh helpers" and the
> analogix-dp bridge driver which controls much of the PSR mechanics.
> These bugs are most visible when switching between CRTCs.
>
> I'm not a DRM expert, but I've been poking at a lot of Rockchip display
> drivers recently. I'd love some skeptical eyes, so feel free to ask
> questions if I haven't explained issues well, or the proposals look
> fishy.
>
> Regards,
> Brian

Ping for review? Sean, perhaps? (You already reviewed this on the
Chromium tracker.)

Brian
