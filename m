Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9338159CDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiHWBQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiHWBPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:15:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8353D03
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:15:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g18so12675414pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PelRXkP8M5TiHnLKSnI/5v9U+UgZU9j1GaqlXXKduyY=;
        b=B2JIlNZDNtkAju6sTNbwCPjM8x/JWnCzOcTOwka5GmJ4uCKJi/4bxcBniEAharzhIt
         pVMSoZo1FiYj4gM/Vq8WdP9AOqs2uegecxzWIaHrIaKIJq+Y0rRz+8iEQ0Q1aY+Xn3N4
         fB1BhoUyJabIdwYV2Lk6fRXWfYU80GAZwMjtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PelRXkP8M5TiHnLKSnI/5v9U+UgZU9j1GaqlXXKduyY=;
        b=n+8s4zbUHwqX6zO6dKaLUP8c4Wj4c4PVUo0ood98V5I05lrMnF3962muu/zcWnH700
         yGa4/k86hXmmAZ7eQkSS5NyPUAKTT48cqavjPGwiLW83LBQwb39tuo/yzOEYwZwC0nzC
         aDJrR3JUGf/rWApDvELApGC2o6KD2SzyxnQldpKC2LAlB0nPp0vRh6TPvOQ/4lDIoBgF
         r5LVBg3k7bBmR76uxVRsWDBgfjBcK/ijVEdpi4g53i9REgQh0tOR09U/jtEUMc+YhyAO
         0EHSAQYAjqkQTuvSAKoleRRtDitPJrZPa2+Z3Z1RxR37PxMHgBt/3REdJ7BOCvb6+Cwj
         oD5g==
X-Gm-Message-State: ACgBeo0qT41Am5G6L7FJhyYRUxX/whIvYubjFUM3ZrWnVzGoU2xvGdaS
        D/mxCDGzKaFgerU5h/MSrGKjog==
X-Google-Smtp-Source: AA6agR7U5Fy+osz2wQ91YXA6qrn9tSnO+fvkSNnn0uzp92ozDgtZmxR+K+t6JFtFOoJZjKJP70f0lw==
X-Received: by 2002:a17:90b:4a8a:b0:1fa:fc0a:6404 with SMTP id lp10-20020a17090b4a8a00b001fafc0a6404mr933997pjb.127.1661217331786;
        Mon, 22 Aug 2022 18:15:31 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:34e2:c40e:42d3:27e0])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016d4f05eb95sm8938487plk.272.2022.08.22.18.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:15:31 -0700 (PDT)
Date:   Mon, 22 Aug 2022 18:15:28 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        xuqiang36@huawei.com
Subject: Re: [PATCH -next] drm/bridge: Add missing clk_disable_unprepare() in
 analogix_dp_resume()
Message-ID: <YwQqMCNBiafBjDSw@google.com>
References: <20220816064231.60473-1-zhangzekun11@huawei.com>
 <CA+ASDXMGbJSJ2PC_4_2HL_01hO2aDoiWyxmosvtOze43aaeWpw@mail.gmail.com>
 <Yv2CPBD3Picg/gVe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv2CPBD3Picg/gVe@google.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 17, 2022 at 05:05:25PM -0700, Brian Norris wrote:
> Hmm, actually I'm going to have to retract that now that I've given it
> some more testing locally. I happen to have a system where I commonly
> hit this error case, and I'm thinking commit 211f276ed3d9 is actually
> wrong, and so we shouldn't be "fixing" its error handling -- we should
> be reverting it.

I've submitted that for review here:
https://lore.kernel.org/all/20220822180729.1.I8ac5abe3a4c1c6fd5c061686c6e883c22f69022c@changeid/
[PATCH] Revert "drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time"

I'd appreciate your review/testing.

(NB: I failed to honor the .mailmap for Andrzej Hajda.)

> Now separately, I have to figure out why I'm hitting this error case in
> the first place...

FWIW, I captured the reason in point 3 on the above Revert. The
pm_runtime_*() handling in the panel driver fails (-EACCES) because the
bridge driver is resuming before the panel. (The DRM suspend/resume
helpers handle things in the correct order.)

This problem is also resolved by simply reverting.

Brian
