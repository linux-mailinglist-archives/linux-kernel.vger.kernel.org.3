Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D59510AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355153AbiDZU4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355145AbiDZU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:56:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0E48888
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:53:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so18108439ejo.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+6smG6ZsaikM1dg09vZip/ZwNi93PfiwahWrVpAv9A=;
        b=hJIZi6xaEIf7LJsIqr6G55r7hJou56/b/P3bACckDThw8eadVK4SdjrGaWfAee4zN4
         6TeH/YbjnzVAyl/zOKMMRvgLHGPqu9gyRKWTE0HjuunYksv8Wkja294rzR9FVDeeMnC1
         zb7rGNPS6Q8lK1WtG3/29Ko/NFQH0MCJEIteI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+6smG6ZsaikM1dg09vZip/ZwNi93PfiwahWrVpAv9A=;
        b=zfx9FDEa1Q6+T+EQDdOEf7QaRDjmDveFefDIvEyusH5ndDleUltMLeW0gx+vLeSi2m
         qEqMZw4qSkw4AfdWborCA9y9TNrQ4Ud1aHZ20z0xaZ+Xtbtl/wxOF3BVDNham7TOZ5pf
         /FAfo3cjCkESM4PfiW5rdAXhM9KdFbMQZQGk/34CpIOSb5Z4063pyd9APacClYR9Ko3F
         BluTJjbUFlP85bZ1qyGALMZP71OjUViHT5NBF73E1dHpWsap4SPrVNgkCjxmRfHezZd1
         WH6DmFSlz4jPwKeV9Eg+CXn6aMMW79hrlk0lsbC/vbnWnYIDusUW0JIoxunYUzseT+3D
         3enQ==
X-Gm-Message-State: AOAM530s7U5tKxbRszf2cIMW8qwRQLA9oBknvWc+avP8CKBdT8I1DxmM
        eDShH01e16v6iVHgqD7C4MUc0dhXGz2Fh3hB05E=
X-Google-Smtp-Source: ABdhPJzDstuvTZEAMhRjFM6PWsUzd9IgqueemtPVSEQ3KtWZqZPMaT1KfQXFhGTVjb/+Wmr/5dNxvA==
X-Received: by 2002:a17:907:9811:b0:6f3:a389:a203 with SMTP id ji17-20020a170907981100b006f3a389a203mr8666178ejc.381.1651006386648;
        Tue, 26 Apr 2022 13:53:06 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id ek21-20020a056402371500b0042025e47eddsm6522286edb.7.2022.04.26.13.53.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 13:53:05 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso24592wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:53:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3d0e:b0:38f:f83b:e7dc with SMTP id
 bh14-20020a05600c3d0e00b0038ff83be7dcmr31516102wmb.29.1651006385011; Tue, 26
 Apr 2022 13:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
 <a21a6ad5-5ed3-6207-8af7-655d19197041@quicinc.com>
In-Reply-To: <a21a6ad5-5ed3-6207-8af7-655d19197041@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Apr 2022 13:52:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XOWfz39imimoijNM14dUJNiwr8_aqPFCR=LmgH7yYzQQ@mail.gmail.com>
Message-ID: <CAD=FV=XOWfz39imimoijNM14dUJNiwr8_aqPFCR=LmgH7yYzQQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/edid: drm_add_modes_noedid() should set lowest
 resolution as preferred
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 1:46 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> On 4/26/2022 1:21 PM, Douglas Anderson wrote:
> > If we're unable to read the EDID for a display because it's corrupt /
> > bogus / invalid then we'll add a set of standard modes for the
> > display. When userspace looks at these modes it doesn't really have a
> > good concept for which mode to pick and it'll likely pick the highest
> > resolution one by default. That's probably not ideal because the modes
> > were purely guesses on the part of the Linux kernel.
> >
> > Let's instead set 640x480 as the "preferred" mode when we have no EDID.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> drm_dmt_modes array is sorted but you are also relying on this check to
> eliminate the non-60fps modes
>
> 5611            if (drm_mode_vrefresh(ptr) > 61)
> 5612                    continue;
>
> I am not sure why we filter out the modes > 61 vrefresh.
>
> If that check will remain this is okay.
>
> If its not, its not reliable that the first mode will be 640x480@60

I suspect that the check will remain. I guess I could try to do
something fancier if people want, but I'd be interested in _what_
fancier thing I should do if so. Do we want the rule to remain that we
always prefer 640x480, or do we want to prefer the lowest resolution?
...do we want to prefer 60 Hz or the lowest refresh rate? Do we do
this only for DP (which explicitly calls out 640x480 @60Hz as the best
failsafe) or for everything?

For now, the way it's coded up seems reasonable (to me). It's the
lowest resolution _and_ it's 640x480 just because of the current
values of the table. I suspect that extra lower resolution failsafe
modes won't be added, but we can always change the rules here if/when
they are.

-Doug
