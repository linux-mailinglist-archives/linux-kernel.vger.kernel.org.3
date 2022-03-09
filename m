Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D14D3071
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiCINtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiCINt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:49:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCBA149BB6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:48:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so5283722pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Awv2807Q48rVf5K7n4tpsQ5KWBJDVYHY3kmCWNGk/aI=;
        b=wcsOfALNDGWwsppDVr612z56RIFdWApQ9M7wYfkJMq8/nhsKXsyw0kUUx2ytQ3ByPz
         zxpSHo1d+oR+6+rDhvl/kyJW7BR7yQAr/q++8bz8KhQVUiUscD8mN7mE4ATjdySjvqnq
         einFiM8EQ7zx0LK5iXHZClxZkmp13xYREyuO/zvxbFnzaxyub6tECJA89p37uOCS9WUa
         j0bT5jMYmF+ZZRn6G/BQ02rNDkquRPi5dwKuD+O6u2EX14z1GLCiPowGsop2oYdThZIL
         u4gd1htJyC834tEP9cAT+ZzpmcnuaD6AADdllgz/iFBuh31TRqz9TQwAuG1DUu8vor1y
         B50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Awv2807Q48rVf5K7n4tpsQ5KWBJDVYHY3kmCWNGk/aI=;
        b=s7ahhuiVHI/1iMEx+4J2RBEyJZBRRWBUs49wuUUJyjdFuAl8X79j7Rd5McUMv+NZkg
         xsFIzbIXPoo8hjlEETWnfP58bD1jjR308+KT3b25HFAcGDEq7edq6KyxuKuPyNSCSAjw
         47TN+1UobZIrm9gg32+HIYOEUY1hNJOdARfqpk3TZJhPpusgAbWbRpn98k9XIw2gPq0y
         gL5V0KQXvVsaznKgDJvqr9jC1NjYVMea1hwY84A8vKzHI3618ZV6gWQBMG6mto0Lh/8x
         hrHdi8/89RkrwlA7tIEOrUsxl3/macg3W9bZOoS4OPtkU9i39AEJiEMqBqS7yY52N8w1
         2+xg==
X-Gm-Message-State: AOAM531qaGe8NPFW6jKb/OQBZtzpFeOflDuHW9BDS4HFm4W/luB28MBa
        GpXVI6PFzuN3ziPYkNXfJ84B02VXGyEV0kh00TLPYQ==
X-Google-Smtp-Source: ABdhPJxxGgkv/4ONjg/97nbBdxzNOqwNnUzRdkuGoFC3g9OqxkCMUZRKN+0ZNpfJPSVMPuq50dxWQN74mQ3jU4SqXbA=
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id
 gx12-20020a17090b124c00b001bc369b7db5mr10521690pjb.179.1646833709168; Wed, 09
 Mar 2022 05:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20220303201943.501746-1-trix@redhat.com> <CAKwvOdnoV_SsFuWWJd4nOOd1vGG6_-gg-KvdOg4_NHuRp7_WfA@mail.gmail.com>
 <5b6a10bd-5650-2924-d1cc-e4664a0e7255@redhat.com>
In-Reply-To: <5b6a10bd-5650-2924-d1cc-e4664a0e7255@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 9 Mar 2022 14:48:18 +0100
Message-ID: <CAG3jFyuBuJmr=NJROWHyEQqW9qng6KtwhJ1a9ACUEGfZ7g-Mxg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: check the return on anx7625_aux_trans
To:     Tom Rix <trix@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, xji@analogixsemi.com, sam@ravnborg.org,
        tzungbi@google.com, pihsun@chromium.org, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, hsinyi@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 02:45, Tom Rix <trix@redhat.com> wrote:
>
>
> On 3/8/22 2:57 PM, Nick Desaulniers wrote:
> > On Thu, Mar 3, 2022 at 12:19 PM <trix@redhat.com> wrote:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> Clang static analysis reports this issue
> >> anx7625.c:876:13: warning: The left operand of '&' is
> >>    a garbage value
> >>    if (!(bcap & 0xOA01)) {
> >>          ~~~~ ^
> >>
> >> bcap is only set by a successful call to
> >> anx7625_aux_trans().  So check.
> >>
> >> Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")
> > Is this the correct Fixes tag?
> yes
> > I think it should be
> >
> > Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid
> > through aux channel")
>
> This one changes the name of the function
>
> -       anx7625_aux_dpcd_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
> +       anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
>
> A return check from the earlier commit, when this block of code came
> into existence, is when it was first needed.
>
> Tom
>
> >
> > instead.
> >
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> >> ---
> >>   drivers/gpu/drm/bridge/analogix/anx7625.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> index 633618bafd75d..f02ac079ed2ec 100644
> >> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> @@ -872,7 +872,10 @@ static int anx7625_hdcp_enable(struct anx7625_data *ctx)
> >>          }
> >>
> >>          /* Read downstream capability */
> >> -       anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
> >> +       ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
> >> +       if (ret < 0)
> >> +               return ret;
> >> +
> >>          if (!(bcap & 0x01)) {
> >>                  pr_warn("downstream not support HDCP 1.4, cap(%x).\n", bcap);
> >>                  return 0;
> >> --
> >> 2.26.3
> >>
> >
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
