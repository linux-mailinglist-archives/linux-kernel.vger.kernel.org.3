Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A195933D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiHORIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHORIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:08:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C2024084
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:08:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so5843151oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc;
        bh=w5mvqeDCehc7GaKrA3r1nsUFJqaSzpg+13M7sA6ODP4=;
        b=EXo9TqZYcqeI62mYaP39HnHFE1Jgu2Gp4yw1YH7g4irL+MqYlSooTegqxrGX/1fPdS
         i7LTVrfmDVZjkoYfavZW6Z5yTUIjGmyuJuTYhLnaTSHQ1Bj0oFKEAXVOWBn2QmHIhso5
         TbJZq75FEa02PtPcpEJJB/M1x7jEHhwEKyvBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc;
        bh=w5mvqeDCehc7GaKrA3r1nsUFJqaSzpg+13M7sA6ODP4=;
        b=ceSWPC8FLeP4Kp8gWZgyt3+KD1mNSqT0gFohBfCQp4byOqbt0LjrYi/DQE4CIa8pcH
         l0DCqfmgocUNFknbMNxUnhEsyUrU3qNZOwakf5ccDoG2uyWdEk6GutcqMT+xiTgEKraT
         Pe++V+YOkWuSbsgT6TRccXi7QgP0LjnFw8PE0eR0c6LVmUzOmpGNWqVoyPVxazkeyE3O
         BDQUHg6R22Bp986CyA97RLJ0GQyOdjkENZN8XQUbz1h5dVsHA1Ijtn3nQdB3xjpx8ILi
         jZeJngqdLfvSQ6VHyx5oGw2Cj3dXIVqIWc/Q1uZmtNLmLSGx8/5kqi5WUVgoWVaEPqxV
         +EMg==
X-Gm-Message-State: ACgBeo03y6Fv96nkWWGpBuVHeHb8H02zeuLO7Fg6da3rviHenCKxlSuz
        S+1IE9DHWzQ01o9KPa8bizT9NbfmSP2YrrwTSghutw==
X-Google-Smtp-Source: AA6agR49gUW9vuHC0Dzoy8S1A7T61B09e5tua3NyVPTV7sd0acqlwzykUCsQVgv29H+kCTLbcY+y6r4riaOarGM+ysQ=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr2917548otk.73.1660583296069; Mon, 15
 Aug 2022 10:08:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Aug 2022 12:08:15 -0500
MIME-Version: 1.0
In-Reply-To: <1e792f49-febf-43bf-d828-8ecf99cbeba3@quicinc.com>
References: <1660159551-13828-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n533SUb3Bg=pR8Fhwo-M5qLWiti4nzLR-rSGVAsrXgEYNQ@mail.gmail.com>
 <dbda8bce-2890-e5e3-4052-073a52eb06a6@quicinc.com> <CAE-0n51NyrP8CikcK_3wj4EEsurmmSZ4RY3pLhJJmkY2_8wNZw@mail.gmail.com>
 <0641a116-5b58-4305-bf2d-f53dcb747276@quicinc.com> <1e792f49-febf-43bf-d828-8ecf99cbeba3@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 15 Aug 2022 12:08:15 -0500
Message-ID: <CAE-0n50QXiJs=k78Tmd7om28MgWChypwC8LPRzF2jx_qB5+0FQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: check hpd_state before push idle pattern
 at dp_bridge_disable()
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-08-11 08:20:01)
>
> On 8/10/2022 6:00 PM, Abhinav Kumar wrote:
> >
> > Even then, you do have a valid point. DRM framework should not have
> > caused the disable path to happen without an enable.
> >
> > I went through the stack mentioned in the issue.
> >
> > Lets see this part of the stack:
> >
> > dp_ctrl_push_idle+0x40/0x88
> > =C2=A0dp_bridge_disable+0x24/0x30
> > =C2=A0drm_atomic_bridge_chain_disable+0x90/0xbc
> > =C2=A0drm_atomic_helper_commit_modeset_disables+0x198/0x444
> > =C2=A0msm_atomic_commit_tail+0x1d0/0x374
> >
> > In drm_atomic_helper_commit_modeset_disables(), we call
> > disable_outputs().
> >
> > AFAICT, this is the only place which has a protection to not call the
> > disable() flow if it was not enabled here:
> >
> > https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/=
drm_atomic_helper.c#L1063
> >
> >
> > But that function is only checking crtc_state->active. Thats set by
> > the usermode:
> >
> > https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/=
drm_atomic_uapi.c#L407
> >
> >
> > Now, if usermode sets that to true and then crashed it can bypass this
> > check and we will crash in the location kuogee is trying to fix.

That seems bad, no? We don't want userspace to be able to crash and then
be able to call the disable path when enable never succeeded.

> >
> > From the issue mentioned in
> > https://gitlab.freedesktop.org/drm/msm/-/issues/17, the reporter did
> > mention the usermode crashed.
> >
> > So this is my tentative analysis of whats happening here.
> >
> > Ideally yes, we should have been protected by the location mentioned
> > above in disable_outputs() but looks to me due to the above hypothesis
> > its getting bypassed.

Can you fix the problem there? Not fixing it means that every driver out
there has to develop the same "fix", when it could be fixed in the core
one time.

Ideally drivers are simple. They configure the hardware for what the
function pointer is asking for. State management and things like that
should be pushed into the core framework so that we don't have to
duplicate that multiple times.

> >
> > Thanks
> >
> > Abhinav
> >
> >
> Ii sound likes that there is a hole either at user space or drm.
>
> But that should not cause dp_bridge_disable() at dp driver to crash.

Agreed.

>
> Therefore it is properly to check hdp_state condition at
> dp_bridge_disable() to prevent it from crashing.
>

Disagree. Userspace shouldn't be able to get drm into a wedged state.
