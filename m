Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905B448F2EF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiANXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiANXXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:23:38 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3584C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:23:38 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id b15-20020a4a878f000000b002dccc412166so3029579ooi.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qDCNZk+YHFKWNX9eKzf4zq71PK1bylZW31lIPLOmEsY=;
        b=H5NbI8kgzCbCfyozFmjg6/uEr7qn6iL5p8UFPpWfMcQpmR/nlKJXRlkUC3bOQSTyQ6
         ySatRAtQEd3zeyO96nkLxISch3EU1dCm8OHaWlMnsurOn9Jc747u7wReSr+lN5aGSpvG
         KI3N8xrb6MvXpomk7+A3w0lc3EIXsXm8vJ+KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qDCNZk+YHFKWNX9eKzf4zq71PK1bylZW31lIPLOmEsY=;
        b=RMM6xHCUz1JZLsQK20wKCZGHGuk2OAyUkIGiNQ1iV4EAMl+606JfCsN3b+ImPsxdiC
         rfEbBA/3gJqKEQsX4RGMPcAsIkAsbdpfh6ZLPT65oL9uCtzlfKEa2vyszDq/bNTElRkk
         p0c7lqhZ7ul4L25ZOeiRYK7jYNPQ4SL5ycBZX0LnHkuzPY5mBW2jLwqfDl0KExVU+BJ5
         hr3WJKPcoPdct/pTL0LP7iJlpqpdxwlAPDa1xqFTEcv2j4Vpc0wyW+y4ztgovbRg9nqU
         jnW9DFmvMkMukAbQLElmyncPtWawQNfOuooCA216HWmVB6AUJO5QMflSpaB2uylTBM2W
         oMwA==
X-Gm-Message-State: AOAM532BHs94F8sQTD03LJy0lpfDcrcmCu8i3Ht0RiB7xdkp6jN31cmU
        HaCFeJK1dbE44evEeMFPoW0kXdqFmBzIBN/HRRpRtg==
X-Google-Smtp-Source: ABdhPJwFIlGlvXAoDe/iKVuwTu1YxkR5y8K8TamhM3kFUbDLWi5fw79LhahGE6BjuvnDxlQiIsIzQ7PVcl4D+uMg3nY=
X-Received: by 2002:a4a:d818:: with SMTP id f24mr8003573oov.25.1642202617985;
 Fri, 14 Jan 2022 15:23:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Jan 2022 17:23:37 -0600
MIME-Version: 1.0
In-Reply-To: <f5a282ed-0b4a-9fb2-fc04-17842745feaa@quicinc.com>
References: <1642194710-2512-1-git-send-email-quic_khsieh@quicinc.com>
 <1642194710-2512-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52UYBajrqGFqppun5oK82V3ppjvQxANU27kL95gCZtURg@mail.gmail.com> <f5a282ed-0b4a-9fb2-fc04-17842745feaa@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 14 Jan 2022 17:23:37 -0600
Message-ID: <CAE-0n53GTt5W8DjVCGJ+D8E6N3HgZ3jhPoZVCw1jLOx4uxJdKA@mail.gmail.com>
Subject: Re: [PATCH v15 1/4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-14 14:28:52)
>
> On 1/14/2022 1:41 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2022-01-14 13:11:47)
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm=
/dp/dp_display.c
> >> index 7cc4d21..7cd6222 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -696,12 +699,9 @@ static int dp_irq_hpd_handle(struct dp_display_pr=
ivate *dp, u32 data)
> >>           * dp core (ahb/aux clks) must be initialized before
> >>           * irq_hpd be handled
> >>           */
> >> -       if (dp->core_initialized) {
> >> -               ret =3D dp_display_usbpd_attention_cb(&dp->pdev->dev);
> >> -               if (ret =3D=3D -ECONNRESET) { /* cable unplugged */
> >> -                       dp->core_initialized =3D false;
> >> -               }
> >> -       }
> >> +       if (dp->core_initialized)
> > When is this condition false? The irq isn't unmasked until the core has
> > been initialized. On the resume path I suppose the irq is enabled in
> > dp_display_host_init() calling dp_ctrl_reset_irq_ctrl(), and then we
> > could immediately get the interrupt but it will block on the event_mute=
x
> > lock.
>
> This is left over form Lazor.
>
> I remember that there is an extreme case that several irq_hpd interrupts
> happen right after dongle plug in=C2=A0 (happen at resume too) and someti=
me
> cause system crash at dpcd read due to AHB clock is not enabled yet. It
> took some time to debug it.
>
>  From looking into code, it does not look likely it will happen. But it
> did happen at real world.

How does it happen after this patch is applied? I remember the duplicate
irq_hpd problem but that should have been solved by de-duplicating the
irq in the hardware by leaving it pending until it was handled. Note,
I'm not suggesting we remove the enabling of the core, just the check
that the core is initialized. Now that the check for core_initialized is
removed from the init function we have to make sure we only call the
function one time to match what was there before.

>
> So that I would like to keep this condition checking.

I'd rather not leave around dead code in this driver. The sharp edges
are what we need to smooth out.
