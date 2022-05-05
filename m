Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E465151C42C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381401AbiEEPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381395AbiEEPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:48:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B245A174
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:44:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p4so5713154edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1imTbFvxSu0eMtn2Ea7a1QwVSeRsNsaWdQpXFh00o/s=;
        b=JfpSQd3gaJ+Ed4G9YtnYm6kZ+FIOM5VXR603FG7MY0xIZqMeY7V4l9wEpXstNwsAHP
         cDfh4ZcNUGOGdlbv+HwQWvDMXX3/9wCujtPuU5aEMRr0agBAlVueTJrufPNjOVTdCUG7
         eY47+K/EnXB1451xaJMDLF2X/0Wn3e5z2TpVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1imTbFvxSu0eMtn2Ea7a1QwVSeRsNsaWdQpXFh00o/s=;
        b=N8iGrTZ5EF5jKt/8HFXo9Zl/jccerXa7wW1RfLgaLFtCeT+bZHnnnlK4uTq3qsZBDW
         0JCst2274QGgC6hJxeIo4b/ZEsp0DkVuPyVG/dUfXXBKYEk2D5XA6gpbFvdX9qZedMVl
         pHA8O3pFrquMXAbxHf/U8RhMWk/Q4p1yi6AnFqgicy0a/wY8MQZtwGEEnrQev4pMJizU
         65fNLBsZ+XAM/EVaifFBP9bAHL6dGHZ9tHGZVJHgXK3bTu/7PkChlIILzaWXg2Z73Oot
         HE9UNNg7aHhe4Q9CYrQ8BFaxd8A64NZviqgOaftS5ODjWUGY7iZiAlC5b9R4rPfK4SqX
         ZVtw==
X-Gm-Message-State: AOAM530AawMgU3UQzicqdRgy21oOx/SBli7Us9wR1Okc0TsswAham1jh
        K3bDoLhkuKT1SBHNseb6igZuAzYpZyEBm0YeqmU=
X-Google-Smtp-Source: ABdhPJzoMZWzr661sUJOWgSiCALsVaKOOoKWPvaeNLUqEs0jwG6WPWf6/grZqeAyCWn0DmUWNzMt0Q==
X-Received: by 2002:a05:6402:42c3:b0:427:d0e6:77e4 with SMTP id i3-20020a05640242c300b00427d0e677e4mr19692436edc.49.1651765498120;
        Thu, 05 May 2022 08:44:58 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id v8-20020a50a448000000b0042617ba6394sm963316edb.30.2022.05.05.08.44.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 08:44:55 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id k126so2905266wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:44:55 -0700 (PDT)
X-Received: by 2002:a7b:c7c2:0:b0:394:18b:4220 with SMTP id
 z2-20020a7bc7c2000000b00394018b4220mr5628302wmk.118.1651765494778; Thu, 05
 May 2022 08:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
In-Reply-To: <20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 May 2022 08:44:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XViHtOoQH3fm4yoRcUAkLkf0Wf4zPXUH0Zq5_09tZmjw@mail.gmail.com>
Message-ID: <CAD=FV=XViHtOoQH3fm4yoRcUAkLkf0Wf4zPXUH0Zq5_09tZmjw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/edid: drm_add_modes_noedid() should set lowest
 resolution as preferred
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ville,

On Tue, Apr 26, 2022 at 1:21 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> If we're unable to read the EDID for a display because it's corrupt /
> bogus / invalid then we'll add a set of standard modes for the
> display. When userspace looks at these modes it doesn't really have a
> good concept for which mode to pick and it'll likely pick the highest
> resolution one by default. That's probably not ideal because the modes
> were purely guesses on the part of the Linux kernel.
>
> Let's instead set 640x480 as the "preferred" mode when we have no EDID.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/drm_edid.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Someone suggested that you might have an opinion on this patch and
another one I posted recently [1]. Do you have any thoughts on it?
Just to be clear: I'm hoping to land _both_ this patch and [1]. If you
don't have an opinion, that's OK too.

[1] https://lore.kernel.org/r/20220426114627.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid

-Doug
