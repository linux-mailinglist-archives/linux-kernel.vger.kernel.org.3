Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25769523F79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348167AbiEKVcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiEKVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:32:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CAD72211
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:32:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f4so3451738iov.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6pxwbhOL58efAEpspYDSg6HtmNXrpN7C08+cjeITwQ=;
        b=Bun6KWZaMx96+9+uXGZgUChN1x9/Aj4KQGLniflfQhrzj3QoS7dDf8YRxNsH4jJGam
         gBzzT9mfcPztSxGb2V3qWAN2pD0bT2izPpALbOjJUsUrp55Yx+pIEMIbQxVHohM5Nqqv
         UDD4ougcotvewCQD2tIHFSU/bC9430Tj7rFPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6pxwbhOL58efAEpspYDSg6HtmNXrpN7C08+cjeITwQ=;
        b=mba1ZlpQlzNYnBRpFHuCX06UWZrXxSgu9T/h7PmSXlOYk7ZWfngns6mHh5TnUEtQh6
         wl2PYCg6pS+g6BsDX/d8uO1XE89zaTJaQrePXMH3+/kYKXRzsYFcgh661flpFqSm2MM4
         vzX0SQvvQy8a6aVAcE7T/dglMK7paBDi3Bjw3diwrPpfT1fMAIv4aGTCMJEk0YIAT5xN
         lH15L4cefvy/UzJp4aR6sNFCIs/BHVSwJqpygYQHfwM3bcipy+HvsWslgkwEObw0JxYm
         kog3wpNXxV6Vqf7H1NBfrXN2b+4BcA25/SbMpIgo6kqcVM2RUUYkPVryYJGZDb8Se9/y
         6Zrw==
X-Gm-Message-State: AOAM531XcHQEi5nL3eMyv45PfvRqoRtSVWaui3to3zu//lChY66JJjF0
        iNOKah4wgq2X26bP4C/3ATMpev5laG4ftup2
X-Google-Smtp-Source: ABdhPJxHxIsJZbS7mDvh4CPkHOxuEJZl/eChdfGtV+Xh2v4YJLUx674IUnIYh75zwcsbhp1nKUVGNw==
X-Received: by 2002:a05:6638:3813:b0:32b:bc69:6783 with SMTP id i19-20020a056638381300b0032bbc696783mr13249982jav.47.1652304761810;
        Wed, 11 May 2022 14:32:41 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id z15-20020a92d6cf000000b002cde6e352e8sm900560ilp.50.2022.05.11.14.32.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 14:32:40 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id a10so3418329ioe.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:32:40 -0700 (PDT)
X-Received: by 2002:a05:6638:3589:b0:32b:858c:6cc3 with SMTP id
 v9-20020a056638358900b0032b858c6cc3mr13931855jal.229.1652304760140; Wed, 11
 May 2022 14:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220510135101.v2.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
 <db7a2b7f-3c94-d45d-98fd-7fd0b181e6aa@suse.de>
In-Reply-To: <db7a2b7f-3c94-d45d-98fd-7fd0b181e6aa@suse.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 May 2022 14:32:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WoSTcSOB_reDbayNb=q7w00rd7p-zHUDt+evTkSjQ=2g@mail.gmail.com>
Message-ID: <CAD=FV=WoSTcSOB_reDbayNb=q7w00rd7p-zHUDt+evTkSjQ=2g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/probe-helper: Default to 640x480 if no EDID
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 11, 2022 at 12:14 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 10.05.22 um 22:51 schrieb Douglas Anderson:
> > If we're unable to read the EDID for a display because it's corrupt /
> > bogus / invalid then we'll add a set of standard modes for the
> > display. When userspace looks at these modes it doesn't really have a
> > good concept for which mode to pick and it'll likely pick the highest
> > resolution one by default. That's probably not ideal because the modes
> > were purely guesses on the part of the Linux kernel.
>
> I'm skeptical. Why does the kernel do a better job than userspace here?
> Only the graphics driver could possibly make such a decision.
>
> Not setting any preferred mode at least gives a clear message to userspace.

OK, that's a fair point. So I tried to find out what our userspace is
doing. I believe it's:

https://source.chromium.org/chromium/chromium/src/+/main:ui/ozone/platform/drm/common/drm_util.cc;l=529

Specifically this bit of code:

  // If we still have no preferred mode, then use the first one since it should
  // be the best mode.
  if (!*out_native_mode && !modes.empty())
    *out_native_mode = modes.front().get();

Do you agree with what our userspace is doing here, or is it wrong?

If our userspace is doing the right thing, then I guess the problem is
the call to "drm_mode_sort(&connector->modes);" at the end of
drm_helper_probe_single_connector_modes(). Would you be OK with me
_not_ sorting the modes in the "bad EDID" case? That also seems to fix
my problem...

-Doug
