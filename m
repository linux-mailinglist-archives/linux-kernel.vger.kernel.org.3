Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7C4CC927
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiCCWhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiCCWhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:37:09 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85846169384
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:36:18 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q5so6197314oij.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+IxH+v4af7VzrKdvTOvKB5ZMTKZ+t8ui6EDkfQqlJ0s=;
        b=PJEWLzqqseHPPRxvwZuM6uOTCWfL7xJ4o5KBWyKiuf78oArICZi8oBY5JN41+D6+U4
         1V9U45UN69k8kRFLyAd9as/9FWGo1nF+iiwSB/r4fL96T8nXvfeocBGPnibJfvM2El6W
         4MoTqRyW2rvnGjSsyvxThTWme7V1vFH2sns3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+IxH+v4af7VzrKdvTOvKB5ZMTKZ+t8ui6EDkfQqlJ0s=;
        b=rV/eXd3RFi9ifIHoUfBtcB6Y2NifWyvNEDBniTvNWpuogMKc8NKuDKz8SJl945MAaR
         l9OwF14yhr/6iYwsorAKTf3gUZ+O6Z2gETfYx33V8D6gLVYZsAIFkqeCjEF6YB2xmBO2
         THk+AnNck8iSOXY8A04p98qhLzeUrjBesTXpbV3ircqpFBO0VE/Pdq2cCFX9skIdu0eM
         Upsco0YfQ4aqiI+D9dj9CP91T51uILJqKjerQF4dLMTnHbunVQRwlEkwSwp+sKeppOZM
         2vIhIAU1W3MEkTKpfPmkTtIB6H2zHSgC8NI9+YL/un7jmnmqbbU6EUF6gSdHltSf5byO
         FLHA==
X-Gm-Message-State: AOAM532w8Bbl8hPWmHf8ofuQji3sDQUHctRZo3aJ7nU/fKY24JitMe4c
        Dx0Ll5YF3NNiXl8DnaCCmm8P4R/BMtisXaiTbJ4jRA==
X-Google-Smtp-Source: ABdhPJwzE9l5wF1WBh0ZzcfsjbubuW7clbOvgM6f0zoFQo0kH1jqpjN6+RqUObMiyusKhqmjRdcZskOhtJ9BSyNvUUE=
X-Received: by 2002:aca:3346:0:b0:2d9:91f9:a7f2 with SMTP id
 z67-20020aca3346000000b002d991f9a7f2mr922767oiz.32.1646346977864; Thu, 03 Mar
 2022 14:36:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Mar 2022 14:36:17 -0800
MIME-Version: 1.0
In-Reply-To: <CAF6AEGuaYEC2rYxi1uU0S_Hkx-DbjT6wO4zz6sKSRON=eX10ng@mail.gmail.com>
References: <20220303194758.710358-1-robdclark@gmail.com> <20220303194758.710358-4-robdclark@gmail.com>
 <CAE-0n532ZX=qXTBKSFyRYAmkqFN7oqKyPvJHBuVMmr2eHY+O4A@mail.gmail.com>
 <CAF6AEGstzPaLFf-9z9Gf+S4G8n6twxExLvKaqLZk9ML2tUWiLw@mail.gmail.com> <CAF6AEGuaYEC2rYxi1uU0S_Hkx-DbjT6wO4zz6sKSRON=eX10ng@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Mar 2022 14:36:17 -0800
Message-ID: <CAE-0n52xXJG3kohetn3sDBmsBpMqL5zvS2yRzP+sPdq5+7vHgQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/msm: Add SYSPROF param
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Emma Anholt <emma@anholt.net>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2022-03-03 13:47:14)
> On Thu, Mar 3, 2022 at 1:17 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Thu, Mar 3, 2022 at 12:47 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Rob Clark (2022-03-03 11:46:47)
> > > > +
> > > > +       /* then apply new value: */
> > >
> > > It would be safer to swap this. Otherwise a set when the values are at
> > > "1" would drop to "zero" here and potentially trigger some glitch,
> > > whereas incrementing one more time and then dropping the previous state
> > > would avoid that short blip.
> > >
> > > > +       switch (sysprof) {
> > > > +       default:
> > > > +               return -EINVAL;
> > >
> > > This will become more complicated though.
> >
> > Right, that is why I took the "unwind first and then re-apply"
> > approach.. in practice I expect userspace to set the value before it
> > starts sampling counter values, so I wasn't too concerned about this
> > racing with a submit and clearing the counters.  (Plus any glitch if
> > userspace did decide to change it dynamically would just be transient
> > and not really a big deal.)
>
> Actually I could just swap the two switch's.. the result would be that
> an EINVAL would not change the state instead of dropping the state to
> zero.  Maybe that is better anyways
>

Yeah it isn't clear to me what should happen if the new state is
invalid. Outright rejection is probably better than replacing the
previous state with an invalid state.
