Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81310526AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384057AbiEMUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346040AbiEMUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:07:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20CBF48
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:07:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y21so11229898edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjLYKQz9W+b9Ub9U9HIkTaFYWELaFcx+tDToyM0Q0Is=;
        b=Z8kJgkrl1ICP+BHtwk0Kv0Ik1kTt5soCfHi56pWTcJMzYbpRkqUX6jgW6iVpuM01bP
         dUCoGTDtoou29KeWoXgevvlN94X1JwMBX+3AxqZRfib5zFYYWhL3QUauNdrp4YwUf081
         Ei6HAkxKxBgT9UY+3J7C2pJspiT8AMzk0Axq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjLYKQz9W+b9Ub9U9HIkTaFYWELaFcx+tDToyM0Q0Is=;
        b=b59OZzVjnJHu6HswftjNDwxm3OjfXsPc0/cl2gjfjATOOOBRIzVGtHIFh4pxGWCRFD
         Y/hYQkY0otK74NX9jHg2pZrHoorjaBbgcCbs8a57TZ+A0ZRCuHaGe5AJxsfkJr8ExYOF
         DlW6jSugqucT0eVQjkJeUqD3zVlQw9w/LIc237MEQPxEpBhkiCnCZ9LjWGTVBrFQThAZ
         rG2yolSxjtpQeJL22h7Kfd1I4/c7tnAmHu69St+8J46aGPPdhQrQo3ZVb8vyLxq4qH6b
         6lJyQnzadgNYZ6ekpXBrTJAAgB1pGqbot9TSbciFyLPPkPXb+XNmjqWDVtNENVlPMy6o
         Dc9w==
X-Gm-Message-State: AOAM530VubBpF5WD61cP7ZRJKZfX3arFGc0HVnRZxzgPQyPBlXWOxRSO
        D2PJotww4vS23fwvPyXuz9hvg54S7w+CKhUkINU=
X-Google-Smtp-Source: ABdhPJw5xz7vCcwOiT2e8B2HeJiaCJtVM60IjiXmwaZyr+GcGTxQbMq/OGvDVdbekX5tyLxQo+56hA==
X-Received: by 2002:a05:6402:364:b0:425:f88d:7d4a with SMTP id s4-20020a056402036400b00425f88d7d4amr398837edw.68.1652472469197;
        Fri, 13 May 2022 13:07:49 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id i6-20020a50c3c6000000b0042617ba63besm1316587edf.72.2022.05.13.13.07.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 13:07:48 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id j25so11734996wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:07:48 -0700 (PDT)
X-Received: by 2002:a05:6000:c7:b0:20a:d8c1:d044 with SMTP id
 q7-20020a05600000c700b0020ad8c1d044mr5361193wrx.422.1652472467490; Fri, 13
 May 2022 13:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220510135101.v2.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
 <db7a2b7f-3c94-d45d-98fd-7fd0b181e6aa@suse.de> <CAD=FV=WoSTcSOB_reDbayNb=q7w00rd7p-zHUDt+evTkSjQ=2g@mail.gmail.com>
In-Reply-To: <CAD=FV=WoSTcSOB_reDbayNb=q7w00rd7p-zHUDt+evTkSjQ=2g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 13 May 2022 13:07:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VbwkK-z8T-98aPSiybd2c94n8p46oBxY_MtPjV608YRQ@mail.gmail.com>
Message-ID: <CAD=FV=VbwkK-z8T-98aPSiybd2c94n8p46oBxY_MtPjV608YRQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 11, 2022 at 2:32 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, May 11, 2022 at 12:14 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Hi
> >
> > Am 10.05.22 um 22:51 schrieb Douglas Anderson:
> > > If we're unable to read the EDID for a display because it's corrupt /
> > > bogus / invalid then we'll add a set of standard modes for the
> > > display. When userspace looks at these modes it doesn't really have a
> > > good concept for which mode to pick and it'll likely pick the highest
> > > resolution one by default. That's probably not ideal because the modes
> > > were purely guesses on the part of the Linux kernel.
> >
> > I'm skeptical. Why does the kernel do a better job than userspace here?
> > Only the graphics driver could possibly make such a decision.
> >
> > Not setting any preferred mode at least gives a clear message to userspace.
>
> OK, that's a fair point. So I tried to find out what our userspace is
> doing. I believe it's:
>
> https://source.chromium.org/chromium/chromium/src/+/main:ui/ozone/platform/drm/common/drm_util.cc;l=529
>
> Specifically this bit of code:
>
>   // If we still have no preferred mode, then use the first one since it should
>   // be the best mode.
>   if (!*out_native_mode && !modes.empty())
>     *out_native_mode = modes.front().get();
>
> Do you agree with what our userspace is doing here, or is it wrong?
>
> If our userspace is doing the right thing, then I guess the problem is
> the call to "drm_mode_sort(&connector->modes);" at the end of
> drm_helper_probe_single_connector_modes(). Would you be OK with me
> _not_ sorting the modes in the "bad EDID" case? That also seems to fix
> my problem...

I've implemented the "don't mark preferred, but don't sort" as a v3.
Hopefully it looks good.

https://lore.kernel.org/r/20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid

-Doug
