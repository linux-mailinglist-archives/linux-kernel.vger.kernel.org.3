Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58DC4762A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhLOUIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:08:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC264C061574;
        Wed, 15 Dec 2021 12:08:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t9so40168416wrx.7;
        Wed, 15 Dec 2021 12:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w4bLnhbXz+gy4SSpVMo/9wv7aCJ9iSr/1jbBUNhCaU=;
        b=ATdR/dyVoQdaZhzVXDf29nzCxot+WfN8B5xJ5jG/FBPbFWGWJL839oattpLc20+WTL
         ps4AtKHyz3T0ot0009a+eTOiax5HNoybFydP6fHKZ/s4duQBZ+pGmTri8MS44+TTD0sr
         GqDvBWRokjMBZpxYDx7UEPltGDcUDq8TRnwXzW6WwD/qma3ZvsyVjpRLkOd77stfF/gW
         s+TZPOIZbHPeIvpVRhjMlJRXgJrZjkA/o6KVVx98ewUoD0GCHgutzioMPOa9yjN6CG+S
         NG0P1pLPsf2fHuj4+ImCnhItud7ra/q/NKaV2BPlM8iCy6dNKSmuTwZTv2RzSVtysBS2
         o7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w4bLnhbXz+gy4SSpVMo/9wv7aCJ9iSr/1jbBUNhCaU=;
        b=8GsRwS1Q0ZgyYQOGtkd7E/evMzaqYWLp6BLwJ4+voLNgH41KMcrCskFmls3WkWA7vV
         2UFWGvrc5n6rOQWzZJE+3dNXI/Vv2UgSqaVaE8Mr5Suy0O/SG4qUsZi6TFNMrEIhTQlE
         i/JkPo4XiCmtUko37sN07LJbbbYmk4fiTsnNr7qU4VRIX98tWUJrk8LyvzNolyypPGil
         y8xwsV1TLETGX0TNrtDokVI+pyY2O1JqqpxGEu5at60pkxlYA1SjP0MSJMuM6sT4A+lx
         53mDNxS6Q5FTcKoG+d+VoM4FCb0JSh5FBMZEIqX4MqdYXRN/8g1hZx/409bEK96FSgZ1
         1YsQ==
X-Gm-Message-State: AOAM533hkl1T/bc1fa+uX6alsMWffxjM63e/s2p2OvkAFtELqpRgykx+
        /oUE47ZQvUJkk2Xu7i/ed93EukGWXnhaMnvIAzo=
X-Google-Smtp-Source: ABdhPJwK7KInIW25AHd0uB7Kp/T+/V2CIAVdobV+Z7fppew3Fl124A1Bw4BeAJs0FQtE816PMicxsU+qug0RS1Ov6Vo=
X-Received: by 2002:a5d:5986:: with SMTP id n6mr6090673wri.297.1639598911879;
 Wed, 15 Dec 2021 12:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20211215175910.1744151-1-robdclark@gmail.com> <CAE-0n52CHwYAEwAC0Hthgbamjj2x4K3B2w=kTRw_AFLzVgDF-Q@mail.gmail.com>
In-Reply-To: <CAE-0n52CHwYAEwAC0Hthgbamjj2x4K3B2w=kTRw_AFLzVgDF-Q@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 15 Dec 2021 12:13:52 -0800
Message-ID: <CAF6AEGsrCssqo3v3uw00C0YmGAXd6DpqeCRpioqxKRkXeN27gg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Don't use autosuspend for display
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:10 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rob Clark (2021-12-15 09:59:02)
> > From: Rob Clark <robdclark@chromium.org>
> >
> > No functional change, as we only actually enable autosuspend for the GPU
> > device.  But lets not encourage thinking that autosuspend is a good idea
> > for anything display related.
>
> I'd prefer to see a small blurb about why it's not a good idea to use
> autosuspend for display things. Then this commit can be dug out of the
> history and someone new can quickly understand the reasoning behind it.
> Just saying it's not a good idea doesn't really help.

The issue is that we have multiple different devices at play, and
potentially specific requirements about power sequencing when lighting
up or shutting down the display.. autosuspend would just turn that
into a giant race condition.  I'll squash something about this into
the commit msg

BR,
-R

> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
