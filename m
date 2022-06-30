Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A5560E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiF3AhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiF3AhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:37:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23028717
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:37:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so35766091eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD/TmTcrQEiZqX2Bjoyo72hV/tgqwsB/VS7liK0M4hY=;
        b=HeIA5Da9l8UvD4H4iDgPRtvuycOMJXJpAAfo8lblN1BJG1Th+zubJ+VY5Im1UUxsQe
         2pZfW8CNWgyPy0WDAjKew+yjU3CQSjl56GNR5fKp0NRCndcOmqKoTe0IbTZgraD/kuWb
         TWXX9BCr+B1GfCA33OQtCqwDt5TssQC2VynmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD/TmTcrQEiZqX2Bjoyo72hV/tgqwsB/VS7liK0M4hY=;
        b=8PEM7zT1smVYuTXYMES5ww9+BI+k4Am8uJ7Y+Fx2O95BZJLFlAFwsm0IuUpXaxahGK
         TSeLbZTrYR98chZ/Sm9aM63eM0Hsdvx69cBjq2kNmVTdEYBf7pueVQIr7Tddbm+bDrSr
         O1yr846f2UgEQjkmGFoImvpP5iMzJH3SfZ2x8EMct1y/AzrqU1wrJ5fYZeiV4b+2X3YT
         XjlaZunYIZYg7kRJGC+I1kfI8S3TEnXVxpJhDspjoDE2NC/VK+9Sm2m18hpgqJ7I15eW
         GkZtccYnEyxu2ekK6v+AJ7MiBin7dnFcfr+Gr6IljUliWadWs6qN6+qcUjbQ0n1tZJIR
         U45Q==
X-Gm-Message-State: AJIora+oRZSrUkjZfTnih+5g4598bn9LmxLqzXfC0EV8y9qVBzSJ1zns
        CcV4WzxPyc7DGsZCNU7etEAgxgLVjmKccxa4fpE=
X-Google-Smtp-Source: AGRyM1s/YqpKkMBlfzGPD9B+kadYSqOeW2ylfsaz7yhD24QSKHHFwd91ZKPjnIswm0AE+PzDf9JcCw==
X-Received: by 2002:a17:907:7b84:b0:726:c8a0:c9e7 with SMTP id ne4-20020a1709077b8400b00726c8a0c9e7mr5900788ejc.375.1656549421326;
        Wed, 29 Jun 2022 17:37:01 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709064e4600b007121b22b376sm8286710ejw.105.2022.06.29.17.36.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 17:37:00 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id i25so19303546wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:36:59 -0700 (PDT)
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id
 b1-20020adfd1c1000000b0021ba5e9b7b2mr5938881wrd.405.1656549418843; Wed, 29
 Jun 2022 17:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <1656429606-2765-1-git-send-email-quic_khsieh@quicinc.com> <F35C87BF-46A5-41D3-B8A5-B2AB4A24252D@linaro.org>
In-Reply-To: <F35C87BF-46A5-41D3-B8A5-B2AB4A24252D@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Jun 2022 17:36:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X3cv=Q30pODyi__OyRY+LbFT14RfEELvm_DAeHafF70g@mail.gmail.com>
Message-ID: <CAD=FV=X3cv=Q30pODyi__OyRY+LbFT14RfEELvm_DAeHafF70g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: make eDP panel as the first connected connector
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi,

On Tue, Jun 28, 2022 at 1:14 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 28 June 2022 18:20:06 GMT+03:00, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >Some userspace presumes that the first connected connector is the main
> >display, where it's supposed to display e.g. the login screen. For
> >laptops, this should be the main panel.
> >
> >This patch call drm_helper_move_panel_connectors_to_head() after
> >drm_bridge_connector_init() to make sure eDP stay at head of
> >connected connector list. This fixes unexpected corruption happen
> >at eDP panel if eDP is not placed at head of connected connector
> >list.
>
> The change itself is a good fix anyway. (And I'd ack it.) However I would like to understand why does it fix the corruption issue. What is we have eDP and DSI, with DSI ending up before the eDP? Would we see the issue?
> Also could you please describe the mind of corruption you are observing?

I've spent a whole bunch of time poking at this and in the end my
conclusion is this:

1. The glitchyness seems to be a result of the Chrome OS userspace
somehow telling the kernel to do something wrong.

2. I believe (though I have no proof other than Kuogee's patch fixing
things) that the Chrome OS userspace is simply confused by the eDP
connector being second. This would imply that Kuogee's patch is
actually the right one.

3. It would be ideal if the Chrome OS userspace were fixed to handle
this, but it's an area of code that I've never looked at. It also
seems terribly low priority to fix since apparently other OSes have
similar problems (seems like this code was originally added by
RedHat?)


Specifically, I tested with a similar but "persistent" glitch that I
reproduced. The glitch Kuogee was digging into was a transitory glitch
on the eDP (internal) display when you plugged in a DP (external)
display. It would show up for a frame or two and then be fixed. I can
get a similar-looking glitch (vertical black and white bars) that
persists by doing these steps on a Chrome OS device (and Chrome OS
kernel):

a) Observe screen looks good.
b) Observe DP not connected.
c) Plug in DP
d) See transitory glitch on screen, then it all looks fine.
e) set_power_policy --ac_screen_dim_delay=5 --ac_screen_off_delay=10
f) Wait for screen to turn off
g) Unplug DP
h) Hit key on keyboard to wake device.
i) See glitchy.
j) Within 5 seconds: set_power_policy --ac_screen_dim_delay=5000
--ac_screen_off_delay=10000

Once I'm in the persistent glitch:

* The "screenshot" command in Chrome OS shows corruption. Not exactly
black and white bars, but the image produced has distinct bands of
garbage.

* I can actually toggle between VT2 and the main screen (VT1). Note
that VT1/VT2 are not quite the normal Linux managed solution--I
believe they're handled by frecon. In any case, when I switch to VT2
it looks normal (I can see the login prompt). Then back to VT1 and the
vertical bars glitch. Back to VT2 and it's normal. Back to VT1 and the
glitch again. This implies (especially with the extra evidence of
screenshot) that the display controller hardware is all fine and that
it's the underlying data that's somehow messed up.

When I pick Kuogee's patch then this "persistent" glitch goes away
just like the transitory one does.

I'm going to go ahead and do:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
