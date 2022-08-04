Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E921B5896CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiHDECy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHDECv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:02:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592CE47B9B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:02:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id c24so3948214ejd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PnuQJw20lFgf6lictocgrukbVyZz4GO4xw4KHJCExoA=;
        b=IHZhJYNYi4waXA7SLGcJwbFPPDe49qbv1kLm01qI3ZZ3Wie5Sn3rNuCtwGyTiq07if
         z+6sN2Bf6t3RgFc21xyO8Xp07JoaVwfVQQtrNX8y5DWsZFj6IV5msPJ9lmA3zweOkkYl
         76tUFnCugJUi8gTv+vtcSxCfLMwgD7HnMjQIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PnuQJw20lFgf6lictocgrukbVyZz4GO4xw4KHJCExoA=;
        b=7bSPpgBFw/JITQcNWA9BpXuZpgBbxi4YbEb+criPVx5AO1+N44E8HWaCRbkgSz9tNY
         3Z+ZQ5rfKhV0l7aUC17qSvVlxAq2tbayQWVlElh3klJY6L5EKI4cAwZ+lr4EGZmwGLa3
         EgSbfuDWisTFv2JQG+qBYnrRqK4uQ+Fk7f9HcEt/ke2taCAC17yIoda+BuwYS4TdGgXf
         +5hIa9b02qZ33pQR+L3M3H2eULyTW9Bp3OJcGqIobY2TqJwY7oJgvUoEpif3+/cKTkdf
         Uvzes9sm7MWRWdnDAPqDWJfaBJ63ZBGBV6okGCnpH+9KkTmvjmVyQ7UtYDgTTx8TEfUd
         9Dow==
X-Gm-Message-State: AJIora9ukVwHCJFxJTWy1ZnL0VCJeo3jaoVhsj6OfDkNc8Q1Nqp8LXpW
        BWlLTNlrpgzilcdxksocZv8GmmtWu2CDNQFW
X-Google-Smtp-Source: AGRyM1sAyg7oYi1wurqNr2p8Xoa0aLQx6o2O4QiciOR8EU2byyvV124eftmnvdwpWRSqBByr+/rEOw==
X-Received: by 2002:a17:907:6d99:b0:72e:e7b4:e9cc with SMTP id sb25-20020a1709076d9900b0072ee7b4e9ccmr21587784ejc.315.1659585768666;
        Wed, 03 Aug 2022 21:02:48 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0072b91a3d7e9sm7935413eja.28.2022.08.03.21.02.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 21:02:48 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id c22so9684190wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:02:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr4550604wmq.145.1659585767868; Wed, 03
 Aug 2022 21:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
 <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
 <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com> <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com>
In-Reply-To: <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 21:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com>
Message-ID: <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 8:53 PM Dave Airlie <airlied@gmail.com> wrote:
>
> > It works on my intel laptop, so it's amdgpu somewhere.
>
> I'll spin my ryzen up to see if I can reproduce, and test against the
> drm-next pre-merge tree as well.

So it's not my merge - I've had a bad result in the middle of the DRM
history too.

On a positive note, my arm64 machine works fine, but that's just using
fbdev so ...

But another datapoint to say that it's amdgpu-specific. Not that that
was really in doubt.

                Linus
