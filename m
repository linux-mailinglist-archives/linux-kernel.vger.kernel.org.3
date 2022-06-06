Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25153EF46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiFFUMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiFFUMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:12:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055C7108F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:12:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id me5so30557105ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCWIcD+SfRMw/M9RRt+jg58AphPseq4gfsJ1F6OVZZU=;
        b=L64JkmvDNh1FIACsNToXduJszZ5RYI3mnVnXlEJgBMBcVUIJznBmtDp/P0EKumXSX/
         zad6k3tZainA3cYz+aKtsb03+xotN0Og3MtfFmorTrxvRWwPwuEKwx8H4Vj5ghwhAf3G
         CWzDhBbC4GdfPTWfSGrqktycegGjlYT4PyutU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCWIcD+SfRMw/M9RRt+jg58AphPseq4gfsJ1F6OVZZU=;
        b=H4vtqqT0dSobNmRxor8HINObXpnonUADc9XcKjcB96E5SjUT0qwXzmts+U1qTaoZmM
         Tn5+Kcy0ifDSVwNO8dGhnc3zk4jKNE8nyB58Un2rBXlRaoHhKB2dECyKOFSrUgBlsP+6
         nlwtXs3rKgiQ8tenUh55fPB/dyjAGMahxj5ioYie5qPj0rGOGd9Ow6ObmEe5bWs0u4F5
         UWsoCKBtpAiCl+i3yYE3KdDk6T8L/WFxf0mQ/hQxfym3YBurSJt6JM9ZhlGioKgS8j07
         D+Hn+mt83sOg3vANZL6CIs+IqKIZyKWgxhW0qF/CbXPzM/U4FHJ0e1uFA8FivfgNwxtt
         IzMQ==
X-Gm-Message-State: AOAM532p4w6V5fBmcWQzkiiPNlCqt0ZLzQezWJf+koRCwpTjA4WR4uOa
        ENJAICq++FLc/+dv1nppWqhyjOBub1XeFdARJ/Q=
X-Google-Smtp-Source: ABdhPJz1sUPxvwLE3fVYK8J0eBSzuVP/zqcXtfeyOP7OAwr6mjNj3QaHJh/k1S8c429ct8Ki9uyQfw==
X-Received: by 2002:a17:907:7294:b0:6ff:200e:8d62 with SMTP id dt20-20020a170907729400b006ff200e8d62mr23124456ejc.719.1654546320956;
        Mon, 06 Jun 2022 13:12:00 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id be5-20020a0564021a2500b0042e09f44f81sm7845341edb.38.2022.06.06.13.11.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 13:12:00 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso8440583wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:11:59 -0700 (PDT)
X-Received: by 2002:a05:600c:591:b0:39c:4544:b814 with SMTP id
 o17-20020a05600c059100b0039c4544b814mr14648542wmd.118.1654546319242; Mon, 06
 Jun 2022 13:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
In-Reply-To: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 13:11:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKWNeXzDZ=DdXi=U218xghLJAeAQah_uFOjM9WrGZ5sQ@mail.gmail.com>
Message-ID: <CAD=FV=VKWNeXzDZ=DdXi=U218xghLJAeAQah_uFOjM9WrGZ5sQ@mail.gmail.com>
Subject: Re: [PATCH v4] drm/probe-helper: Default to 640x480 if no EDID on DP
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 1, 2022 at 11:23 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If we're unable to read the EDID for a display because it's corrupt /
> bogus / invalid then we'll add a set of standard modes for the
> display. Since we have no true information about the connected
> display, these modes are essentially guesses but better than nothing.
> At the moment, none of the modes returned is marked as preferred, but
> the modes are sorted such that the higher resolution modes are listed
> first.
>
> When userspace sees these modes presented by the kernel it needs to
> figure out which one to pick. At least one userspace, ChromeOS [1]
> seems to use the rules (which seem pretty reasonable):
> 1. Try to pick the first mode marked as preferred.
> 2. Try to pick the mode which matches the first detailed timing
>    descriptor in the EDID.
> 3. If no modes were marked as preferred then pick the first mode.
>
> Unfortunately, userspace's rules combined with what the kernel is
> doing causes us to fail section 4.2.2.6 (EDID Corruption Detection) of
> the DP 1.4a Link CTS. That test case says that, while it's OK to allow
> some implementation-specific fall-back modes if the EDID is bad that
> userspace should _default_ to 640x480.
>
> Let's fix this by marking 640x480 as default for DP in the no-EDID
> case.
>
> NOTES:
> - In the discussion around v3 of this patch [2] there was talk about
>   solving this in userspace and I even implemented a patch that would
>   have solved this for ChromeOS, but then the discussion turned back
>   to solving this in the kernel.
> - Also in the discussion of v3 [2] it was requested to limit this
> 83;40900;0c  change to just DP since folks were worried that it would break some
>   subtle corner case on VGA or HDMI.
>
> [1] https://source.chromium.org/chromium/chromium/src/+/a051f741d0a15caff2251301efe081c30e0f4a96:ui/ozone/platform/drm/common/drm_util.cc;l=488
> [2] https://lore.kernel.org/r/20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> I put Abhinav's Reviewed-by tag from v2 here since this is nearly the
> same as v2. Hope this is OK.
>
> Changes in v4:
> - Code is back to v2, but limit to just DP.
> - Beefed up the commit message.
>
> Changes in v3:
> - Don't set preferred, just disable the sort.
>
> Changes in v2:
> - Don't modify drm_add_modes_noedid() 'cause that'll break others
> - Set 640x480 as preferred in drm_helper_probe_single_connector_modes()
>
>  drivers/gpu/drm/drm_probe_helper.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Pushed to drm-misc-next after cleaning up the turd that I somehow left
in the commit message.

fae7d186403e drm/probe-helper: Default to 640x480 if no EDID on DP

-Doug
