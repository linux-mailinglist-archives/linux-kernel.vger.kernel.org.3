Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D76501C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbiDNTpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiDNTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:45:34 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0445ED911
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:43:07 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-df22f50e0cso6302131fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=M9L3tL+brKffWDgtUhXXfH8uZus62KDBQoX+osGMsUs=;
        b=e+Y+QuSlCn4jI8BvhXLSmvpouUteQs8jzSmaSIV+AdFdIQpBkCcJuV17qvkWx3NE8Z
         oebQOf8umqim6moUjx101cZmivWwb2Md3H3//Vs0jL2mcCJXh8ueaQAf96pcpwV15tzJ
         rPK4K90cf8DTJI6xoHi1aicz0/aqeT2c33P3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=M9L3tL+brKffWDgtUhXXfH8uZus62KDBQoX+osGMsUs=;
        b=lkD7zFAUa7HCFW3Bhr7CpGHRnT2UaoYy5QlNgw6q9ZkMSjH7XwpwN4cmrUhgBCHR8I
         qgzLQrjNCn9OgubtbCWXC9q6Veo5gKfAmYhcZ9PeT7hOQfkwUgpGvgxPcMcSVKVkJfRK
         TXtp3mFTKSolOQcrEcxH/dJD28XjXcoOJRbBlaL0mu1qxm3N5c4Wusn3jmUizDixlIkN
         /bPgKEdS5nMWVILsdL1Y6czZdLDdIrj6pUnZbtKh92s+EvRfaS2Ix3pJNQ2+1IMCWddf
         YFC9QjIrxihodD4TE1eevJLmjBuJalXWg6SsgFx/bYXbCiCi9HDTBaCKGHsaZlNDlpim
         scHA==
X-Gm-Message-State: AOAM530JFP8bRJ0iMKBnaF7n4CiY+iuQZXcY/K4/LLgqJfTs09Yp8qQy
        EYlUfO2PipeG80eOmdocB+YYCfG4UDLEL++v5tqawg==
X-Google-Smtp-Source: ABdhPJx8y+gx6rmS1IvAfn46VUdpA7EEYkTfX60jfg/bWjvKcPHAqhr185v+4LGpoLPKf+zIfWtOt4ow1k0ubmFVnzE=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr71987oao.63.1649965387170; Thu, 14 Apr
 2022 12:43:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Apr 2022 12:43:06 -0700
MIME-Version: 1.0
In-Reply-To: <20afcd97-4b8d-f770-151a-268b893b7c5a@linaro.org>
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=Ui6BAsnTaJ2_TMh1Tnjtaw7FR92aWoUysS+UT=c0qB3Q@mail.gmail.com> <20afcd97-4b8d-f770-151a-268b893b7c5a@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 14 Apr 2022 12:43:06 -0700
Message-ID: <CAE-0n51fc-b-8VF7XP29=o8Xi86HQALGB-1u8n3b_3NjVyyJYw@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add support for the eDP panel over aux_bus
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        Aravind Venkateswaran <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-04-14 12:20:31)
> On 14/04/2022 19:40, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Apr 14, 2022 at 5:19 AM Sankeerth Billakanti
> > <quic_sbillaka@quicinc.com> wrote:
> >>
> >> This series adds support for generic eDP panel over aux_bus.
> >>
> >> These changes are dependent on the following series:
> >> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=613654&state=*
> >
> > You're basically depending on the last two patches of that series.
> > What's the plan there? In patchwork they're marked as "Not
> > Applicable". If they're good to go, maybe we should land them? If not,
> > maybe you should include them (with Dmitry as the author, of course)
> > at the beginning of your series?
>
> No, please do not resend patches. The patches in question are marked as
> 'Not applicable' as they are really not applicable to Bjorn's tree.
> It would be better to point to the correct patchwork:
>
> https://patchwork.freedesktop.org/series/98585/
>
> Note those patches still lack the R-B tag. I can include them anyway,
> basing on Sankeerth's Tested-by tag, but the formal R-B would also be good.
>

Can you resend those as not RFC?
