Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8249A802
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315855AbiAYCyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3409268AbiAYAZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:25:20 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7757C04590A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:07:24 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so869143oot.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/aLnHFuStZ5orf+mOt/+JIQklpQVMq3vUHjZ6F6RUME=;
        b=oVOpoQrs7lAhfFdYwpI0Rbzn4piuzf9e5etUCLba1zcBTLVJXNv0oO+H7iWuBfLpPF
         ASNNSRyIUHiyAlE1wrc8sjhJTg7yluaGRdSE38M+06TBKdyjDXmPU4bzAnn+0kwjb55o
         Xh651eHtRdmJG65PfUKKbclnQeEXW8CKWcSjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/aLnHFuStZ5orf+mOt/+JIQklpQVMq3vUHjZ6F6RUME=;
        b=G9VXoVcTQWcZK3TL61knhK19pn2Tnf34+GL8ZtClBYsWGLc8jqQLHJRPt/+Kn4O0Jp
         ZZhxrEPDpAOnHkYxAXn/HIBVGgIaujzuztVrIiM3fugOyIoYXuWH6ABWQ9ZuxqRPol8G
         3sCVCRplonPyvsXAoE3hJzkxiA1JdaYK0gPQC6Nfw/QzVizHUscHVb6E5TlV4zd2TZiT
         WFhmSo9sUfts2V1+hovFDjgCYjrf6+mnR39UitjN5t4mnGgvr2ZLatJXHFz/EzY01Czq
         4ZsGqgE+guEEx0q8V6itMjgMhsgtrJ8HNbLeUVV7N25yU49OiG1LGwD+AQuTKCjL5P4i
         Hzpw==
X-Gm-Message-State: AOAM530YTbXQVvpKiToJgYHeeb/ZIlK415SffmF0CgQAUa2oLrMIehAq
        c8hTEf4LFNtPLJdzmijNjW8Mgm0kvvUTiU+oOezwLg==
X-Google-Smtp-Source: ABdhPJyc/dz2yM6w+iD9kilsMJPwY0RIbV00zr4BPr32NKAK/72Bw+/QQmFbTMkH7urzwVaB7eMehwTkn+zmuRw96G8=
X-Received: by 2002:a4a:d51a:: with SMTP id m26mr4897764oos.1.1643062044068;
 Mon, 24 Jan 2022 14:07:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 14:07:23 -0800
MIME-Version: 1.0
In-Reply-To: <28734c1c-a30c-d47f-3fc1-95035adcd33d@quicinc.com>
References: <1643057170-10413-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53nFcMzuKfqVRac6PRTkoPrftXL+uVK56ZQsHVWHmivkQ@mail.gmail.com> <28734c1c-a30c-d47f-3fc1-95035adcd33d@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 14:07:23 -0800
Message-ID: <CAE-0n51wjxd+6azct0ENNBZuE7oVSH6tXfSfEUhT4LRX6kesdw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: always add fail-safe mode into connector mode list
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-24 13:24:25)
>
> On 1/24/2022 1:04 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2022-01-24 12:46:10)
> >> Some of DP link compliant test expects to return fail-safe mode
> >> if prefer detailed timing mode can not be supported by mainlink's
> >> lane and rate after link training. Therefore add fail-safe mode
> >> into connector mode list as backup mode. This patch fixes test
> >> case 4.2.2.1.
> >>
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > Any Fixes tag? I also wonder why this isn't pushed into the DP core code
> > somehow. Wouldn't every device need to add a 640x480 mode by default?
>
> Original test case 4.2.2.1 always passed until we did firmware upgrade
> of our compliance test tester (Unigraph) recently.

Ok. So the Fixes tag should be the introduction of the driver or at
least whenever compliance testing support was added.

>
> The new firmware of tester use newer edid contains 1080p with 145.7 mhz
> which can not be supported by 2 lanes with 1.6G rate. Hence we failed
> this test case.

Interesting. So the test case wouldn't fail unless the number of lanes
were limited by the hardware? Seems that the test isn't thorough.

>
> After discuss with Vendor, they claims we have to return fail-safe mode
> if prefer detailed timing mode can not be supported.
>
> I think would be good to add fail-safe mode into connector mode list.
>
>
>
>
> > we just run into this problem recently.


Sure I'm not saying it's incorrect, just wondering why a connector
that's DP wouldn't have the 640x480 resolution by default somewhere in
the drm core.
