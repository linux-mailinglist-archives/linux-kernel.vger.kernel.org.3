Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D8353673F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354506AbiE0S4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbiE0S4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:56:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44BBE02E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:56:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v15so4065968edl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfwT51YIqiYd5ibTdUamz1XGFhmTQ28EDmG0aaTf+6c=;
        b=Zd43f84anz/1MDnBpNRhme0VM/VDM9efZyg7kzvwJCIPRe7WsoHX6NZEhlRRDgh07F
         CCeI2EYNvK8lwhIjNU81XIyx4oJ4aco7cSoQqCaK3/N8YOd0PmWmcofuENeQZITKhs69
         ZoL9O8f+NtvFHmnkQR5B5xBjvKdlpQhw2b4BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfwT51YIqiYd5ibTdUamz1XGFhmTQ28EDmG0aaTf+6c=;
        b=JAJoTHUZBzD7KYPFNzpwDKvXNt4++hrevBj0DHKT16tZdpKWZylKugAZhNzS5WbVq5
         EKVj4yEgPhkCq+6y8/D733hab0FbTrcFpD/XBgL3uWn4ULQN2WpYAV67dRXOH5/R2b0l
         tj6WT+LB4yxYSnsQid4uTYwCUpDjWcRUfZWOjNAosAxJOQctmp3AXTaiGcvkKNE18w1T
         s/FQqMYdqt1p5P38VT7JZDtxWD1O8Wqzj8yzbXPaDdlyAXfgl3CtFdrL1eBuLuOzS1Cn
         tM+1j6CxK2/2Aio/XXol6WrI7GoLDCslGWTScetkKVSzjlZWcqaGjqQLJ5n2SVCDzUGl
         +z/Q==
X-Gm-Message-State: AOAM532PTX9FIHN0H6PN5z6gimyKJxx6J+GI9xk4oZZjNQo5P9MYX1x9
        hD/74BaON/qTGWxkNIGqkJ+mToTjw2YxhMRY
X-Google-Smtp-Source: ABdhPJxOi9RAGSVR1CvrUQ+CkAbx2QGZm+WjC7RFFXyOUDVaP9366IJ1yPJW7Y6CJ+0sRYGunoXULQ==
X-Received: by 2002:aa7:c487:0:b0:42b:c757:5d71 with SMTP id m7-20020aa7c487000000b0042bc7575d71mr15237852edq.179.1653677799988;
        Fri, 27 May 2022 11:56:39 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id v16-20020a1709062f1000b006fea2705d18sm1691481eji.210.2022.05.27.11.56.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 11:56:39 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id o9so3141616wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:56:39 -0700 (PDT)
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id
 m17-20020a7bcb91000000b0039732250244mr8295511wmi.68.1653677798704; Fri, 27
 May 2022 11:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian>
In-Reply-To: <YpCUzStDnSgQLNFN@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 May 2022 11:56:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
Message-ID: <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 2:07 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
>         declared with attribute error: BUILD_BUG_ON failed: sizeof(*edid) != EDID_LENGTH
>
> And, reverting it on top of mainline branch has fixed the build failure.

Hmm. That BUILD_BUG_ON() looks entirely correct, and if that sizeof()
doesn't work, then the code doesn't work.

I'm not seeing what could go wrong in there, with all the structures I
see being marked as __packed__.

I wonder if the union in 'struct detailed_timing' also wants that
"__attribute__((packed))" but I also wonder what it is that would make
this fail on spear3xx but not elsewhere.

Very strange. It would be interesting to know where that sizeof goes
wrong, but it would seem to be something very peculiar to your build
environment (either that config, or your compiler).

                 Linus
