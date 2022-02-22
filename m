Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9814C0215
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiBVTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiBVTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:32:51 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B2C939C2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:32:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a23so45885391eju.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxPYkxQ6mY3MfEsJx+8iE64/URTY/HAr2HMcmjeViMQ=;
        b=V83V6RXAXvourhNVZvf2jgxzgWgbvwcqNI4r4pat82eR93ldTr1f7UnyLwwf2qycr7
         a0xsJu4B7LJ0a8fb9YtI8NKspnKLSg3ZkC5edbZCl0z9GiEPzizCh1VTsL6b55uhFAT8
         5XLvUxqQKyaIUvk9UTZ0CbvKc9mBw+5pp329s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxPYkxQ6mY3MfEsJx+8iE64/URTY/HAr2HMcmjeViMQ=;
        b=npkyVT25ICOaVtwHyVVGagxHqC2ZbzLKRT2zJ3rOUvl0zEh6R50K4oHx0GmR8no3SF
         EBY6tP8aACwrotQ22RJBf70i1TCtaPlPwco9YYa5Rvx43k7WcBVn0PNPiKE/hFnvQG2L
         WIqZbFXFobFzVLdSw4NsaliZ/zXWHNYWc6cY8XAnEge6VOWLnZi9Fymm0PlMFYJSS/1P
         WOVBkW4extX7wuwqdWzmMOTLufrm1JUDDcXTaDYjnXmensD7CGx7bQkOnTneQYpBfUnB
         34N8lPWOFfbqiOtnkxLLb/UNl+aGu7MVhl9eF98YxjvTOyY7eRRym/qbFW6xdpeaAhZB
         EnCw==
X-Gm-Message-State: AOAM5307dk9cZPsS9FD82U1kEa4LTXYs5opSqsGdc8oo4KWzkqPqzCN4
        2+7OpW7aJe9NyHvh+h4qv0MNThSIQigDsF+5UIo=
X-Google-Smtp-Source: ABdhPJwwtz/1tCA02ibWodeBzWo8RkC8ueCcBtcArw/7W4ue4ciZSkJqd0/h0iR5yQIyi/o5YyJNRw==
X-Received: by 2002:a17:906:c788:b0:6ce:98db:d9eb with SMTP id cw8-20020a170906c78800b006ce98dbd9ebmr20894222ejb.139.1645558343684;
        Tue, 22 Feb 2022 11:32:23 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id eq6sm10210253edb.83.2022.02.22.11.32.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 11:32:23 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id gb39so46164880ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:32:23 -0800 (PST)
X-Received: by 2002:adf:e4c2:0:b0:1e3:3e5d:bd65 with SMTP id
 v2-20020adfe4c2000000b001e33e5dbd65mr21065461wrm.422.1645557950867; Tue, 22
 Feb 2022 11:25:50 -0800 (PST)
MIME-Version: 1.0
References: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com>
 <1645455086-9359-2-git-send-email-quic_vpolimer@quicinc.com> <CAA8EJppRUZ5OHSMS1NdFXDDvRXJFNsdoJDWgU7ZPUoAW9OD+eQ@mail.gmail.com>
In-Reply-To: <CAA8EJppRUZ5OHSMS1NdFXDDvRXJFNsdoJDWgU7ZPUoAW9OD+eQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 11:25:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W2wi47egKmWDS+BZGSy85K+A8jX0gvi6CYhmFgoBBRmw@mail.gmail.com>
Message-ID: <CAD=FV=W2wi47egKmWDS+BZGSy85K+A8jX0gvi6CYhmFgoBBRmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/msm/dp: Add basic PSR support for eDP
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, quic_kalyant@quicinc.com,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        quic_vproddut@quicinc.com
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

Hi,

On Mon, Feb 21, 2022 at 7:12 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > +static int dp_link_psr_status(struct dp_link_private *link)
> > +{
> > +       u8 status[2];
> > +
> > +       drm_dp_dpcd_read(link->aux, DP_PSR_ERROR_STATUS, status, 2);
> > +
> > +       if (status[0] & DP_PSR_LINK_CRC_ERROR)
> > +               DRM_ERROR("PSR LINK CRC ERROR\n");
> > +       else if (status[0] & DP_PSR_RFB_STORAGE_ERROR)
> > +               DRM_ERROR("PSR RFB STORAGE ERROR\n");
> > +       else if (status[0] & DP_PSR_VSC_SDP_UNCORRECTABLE_ERROR)
> > +               DRM_ERROR("PSR VSC SDP UNCORRECTABLE ERROR\n");
> > +       else if (status[1] & DP_PSR_CAPS_CHANGE)
> > +               DRM_INFO("PSR Capability Change\n");
>
> DRM_DEBUG_DP

Not sure I'll have time to go back and review the series, but one
thing that caught my eye as this flashed through my inbox is that I
think all of these "shouting" are deprecated. It's even officially
documented now as of commit d2f0a8afc1be ("UPSTREAM: drm/print: Add
deprecation notes to DRM_...() functions").

-Doug
