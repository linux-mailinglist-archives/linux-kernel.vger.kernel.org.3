Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07DF4F4C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579175AbiDEX0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458012AbiDERFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:05:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE68BE29
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:03:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so20930899ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W9jjXhkkwggvTX4fvJBrk+j1Dfql0KOELV0oxfWMhuc=;
        b=Da196R/xzbnxuTIH3vscQpCMovYwydT/AzCJSlQj8Eqi4CvIwtAd/mUQm9MmrSBpfo
         C+EBgKeBCuBKVRkDsHPA8cOoIX8OcoIl86zyYotKiHUopfezjcGIoi0dE+KUYYdh8QMp
         KVzZw8avVxGZB0tQNm3+yFeorwp26KB33gYBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9jjXhkkwggvTX4fvJBrk+j1Dfql0KOELV0oxfWMhuc=;
        b=EV4HC1pVu6oX1dqFGuvlGPHT2VLftquS5PUcc+XWLCYtJ6bTHvX2fE6WK0OwOJVLK2
         7csmlhz58C0b25yYiukzxaA3LMk8T43RH/QXzqwrS93/gdKrUyGYte4AKFziIJrtUDLp
         zQXQAp4/lrYhQ4smMnvUVaH5tfqWyUsiYMSCESj+sCreTgh7f9xXYHFjUWaW7N21QdQ1
         PWDrPyqXP3VDOHrR1ijl2jDoUBLM44MugIHMOnmtKPY4AWoICw0iycIFiVhx04g0pc0/
         oN2rnMBWba91jvtKSv3xDh5pW9eZSDErPYhYZ+mjmMXDdbia2A4mrBvEUoWo2SRascu5
         SgCA==
X-Gm-Message-State: AOAM533gKCnq9o1TGVgQPXmu5/Y7+kBPNyjY1zhp0tQ+WtdnTRwesL0j
        MwExbPEf/KBGX0fwTybWGM3vVctRmYzSA75g
X-Google-Smtp-Source: ABdhPJzX3H4hDjAqc2mHTZ66cAYbl6mIWNZnniUb2HNwhQkp34v9FFq+g7kOWHyjjd99/Xmm2y34JQ==
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id r11-20020a170906280b00b006cef3c7688fmr4575787ejc.468.1649178179171;
        Tue, 05 Apr 2022 10:02:59 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id v5-20020a50c405000000b004161123bf7asm6715819edf.67.2022.04.05.10.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 10:02:57 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so1986173wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:02:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id
 l16-20020a05600c4f1000b0038cae36d305mr3996092wmq.34.1649178175654; Tue, 05
 Apr 2022 10:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
 <392b933f-760c-3c81-1040-c514045df3da@linaro.org> <CAD=FV=W4PYK-t607yjRbfjDjjEZX0KdgHDRukw_vSH8E8EDH6w@mail.gmail.com>
 <CAA8EJppt9XONbgtKfmHmN+==QNqiVJeb8GKJFdZm=yyY-tgmHQ@mail.gmail.com>
 <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com> <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
In-Reply-To: <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Apr 2022 10:02:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
Message-ID: <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 5, 2022 at 5:54 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> > 3. For DP and eDP HPD means something a little different. Essentially
> > there are two concepts: a) is a display physically connected and b) is
> > the display powered up and ready. For DP, the two are really tied
> > together. From the kernel's point of view you never "power down" a DP
> > display and you can't detect that it's physically connected until it's
> > ready. Said another way, on you tie "is a display there" to the HPD
> > line and the moment a display is there it's ready for you to do AUX
> > transfers. For eDP, in the lowest power state of a display it _won't_
> > assert its "HPD" signal. However, it's still physically present. For
> > eDP you simply have to _assume_ it's present without any actual proof
> > since you can't get proof until you power it up. Thus for eDP, you
> > report that the display is there as soon as we're asked. We can't
> > _talk_ to the display yet, though. So in get_modes() we need to be
> > able to power the display on enough to talk over the AUX channel to
> > it. As part of this, we wait for the signal named "HPD" which really
> > means "panel finished powering on" in this context.
> >
> > NOTE: for aux transfer, we don't have the _display_ pipe and clocks
> > running. We only have enough stuff running to do the AUX transfer.
> > We're not clocking out pixels. We haven't fully powered on the
> > display. The AUX transfer is designed to be something that can be done
> > early _before_ you turn on the display.
> >
> >
> > OK, so basically that was a longwinded way of saying: yes, we could
> > avoid the AUX transfer in probe, but we can't wait all the way to
> > enable. We have to be able to transfer in get_modes(). If you think
> > that's helpful I think it'd be a pretty easy patch to write even if it
> > would look a tad bit awkward IMO. Let me know if you want me to post
> > it up.
>
> I think it would be a good idea. At least it will allow us to judge,
> which is the more correct way.

I'm still happy to prototype this, but the more I think about it the
more it feels like a workaround for the Qualcomm driver. The eDP panel
driver is actually given a pointer to the AUX bus at probe time. It's
really weird to say that we can't do a transfer on it yet... As you
said, this is a little sideband bus. It should be able to be used
without all the full blown infra of the rest of the driver.


> And I also think it might help the ti,sn65dsi86 driver, as it won't
> have to ensure that gpio is available during the AUX bus probe.

The ti,sn65dsi86 GPIO issue has been solved for a while, though so not
sure why we need to do something there? I'm also unclear how it would
have helped. In this discussion, we've agreed that the panel driver
would still acquire resources during its probe time and the only thing
that would be delayed would be the first AUX transfer. The GPIO is a
resource here and it's ideal to acquire it at probe time so we could
EPROBE_DEFER if needed.


> BTW, another random idea, before you start coding.
>
> We have the bridge's hpd_notify call. Currently it is called only by
> the means of drm_bridge_connector's HPD mechanism, tied to the bridge
> registering as DRM_BRIDGE_OP_HPD.
> It looks to me like it might be a perfect fit for the first aux-bus
> related reads.
>
> We'd need to trigger it manually once and tie it to the new
> drm_panel_funcs callback, which in turn would probe the aux bus,
> create backlight, etc.
>
> Regarding the Sankeerth's patch. I have been comparing it with the
> hpd_event_thread()'s calls.
> It looks to me like we should reuse dp_display_config_hpd()
> /EV_HPD_INIT_SETUP and maybe others.
>
> What I'm trying to say is that if we split AUX probing and first AUX
> transfers, it would be possible to reuse a significant part of MSM DP
> HPD machine rather than hacking around it and replicating it manually.

I'm not sure I completely understand, but I'm pretty wary here. It's
my assertion that all of the current "HPD" infrastructure in DRM all
relates to the physical presence of the panel. If you start
implementing these functions for eDP I think you're going to confuse
the heck out of everything. The kernel will think that this is a
display that's sometimes not there. Whenever the display is powered
off then HPD will be low and it will look like there's no display.
Nothing will ever try to power it on because it looks like there's no
display.

I think your idea is to "trigger once" at bootup and then it all
magically works, right? ...but what about after bootup? If you turn
the display off for whatever reason (modeset or you simply close the
lid of your laptop because you're using an external display) and then
you want to use the eDP display again, how do you kickstart the
process another time? You can't reboot, and when the display is off
the HPD line is low.

I can't say it enough times, HPD on eDP _does not mean hot plug
detect_. The panel is always there. HPD is really a "panel ready /
panel notify" signal for eDP. That's fully what its function is.

-Doug
