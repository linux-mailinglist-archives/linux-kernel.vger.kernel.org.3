Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8304F8B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiDGXnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiDGXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:43:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E712559393
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:41:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so8214773edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXiBIIFiJjTdv9E83/uwZVlQQFm8dnfKzszAoE2+zrc=;
        b=VB2ydLD7fi3NnUXEJcsOXMiPbD5aGo2ygn841l5W/JHCTo8kfNwrKn3VyEGqxbAUP4
         cV0NE5LvP2EaLqHeox4zbqSTpRqNgwhZjNpsbJRKSY/SaeNBw13sonZblc4yZ3V+z/vp
         KUexmCUMr3kLd/k7hh4RTqvee5yNQOUqpUV+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXiBIIFiJjTdv9E83/uwZVlQQFm8dnfKzszAoE2+zrc=;
        b=IJYjv2mh/lxlVzUUerSnsVvqgJW9Tqcp3gNDttztGmDmoYic+kBtbBUoBIolc3nOKj
         ucNAUL+j5rFybXZHzYXh4eZfp6Rno02xQ4AZmbkbWmN+webxyYLmrCOZXgYw+dClPneY
         jMVYJ96b9MvlVFdXRymK0nHQlM2Sw+YKFMANBzbPUuAA6v0KLkpLi6oZfd3LFO4qAB9f
         M53gT2DFHeMrrPxKUfOwf2DKumADdniJHtcGNje284vGwpgKVKaVmmHdACXNjqc2qYEN
         ncadAfLvE6qkXSWexjyMFeoG1W3aB5us9rBx6N62UJSG8GjjDWLk6Gjfr/6BWv2FWcnB
         eI0w==
X-Gm-Message-State: AOAM532iDypgivDDe8aqwNjxeZBFHTlQstAQMnTyOndbFFJ1Dm7JmRjC
        Dp9Faam2WLBuZUv6L3F3NWnwo8HHTgNxPp1Mw2A=
X-Google-Smtp-Source: ABdhPJzAVjjyvN6bbiGU64lzH/7XJJtMhP9ZMySAPqonEVVJ9Z6fF0c3hkXYX0Ad0PoAB784gHCXFQ==
X-Received: by 2002:a05:6402:5193:b0:419:3d19:ce9e with SMTP id q19-20020a056402519300b004193d19ce9emr16687344edd.199.1649374908119;
        Thu, 07 Apr 2022 16:41:48 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906124600b006e843964f9asm516949eja.55.2022.04.07.16.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 16:41:47 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id n6so13908414ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:41:47 -0700 (PDT)
X-Received: by 2002:a5d:568e:0:b0:207:8d1a:46c6 with SMTP id
 f14-20020a5d568e000000b002078d1a46c6mr3088163wrv.422.1649374513273; Thu, 07
 Apr 2022 16:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
 <392b933f-760c-3c81-1040-c514045df3da@linaro.org> <CAD=FV=W4PYK-t607yjRbfjDjjEZX0KdgHDRukw_vSH8E8EDH6w@mail.gmail.com>
 <CAA8EJppt9XONbgtKfmHmN+==QNqiVJeb8GKJFdZm=yyY-tgmHQ@mail.gmail.com>
 <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com>
 <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
 <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
 <3e5fa57f-d636-879a-b98f-77323d07c156@linaro.org> <CAD=FV=Uibu-kZyix7K4_WVc-+C8xpzTqU4WFy7O=6sukMZrX5g@mail.gmail.com>
 <MW4PR02MB7186245772DAC3E04FA8D1C0E1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=Wk3U7_bVdiCPp8iQ4bcCA_Botemu4pwHeRtgBa3Xk6KQ@mail.gmail.com>
 <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com> <CAD=FV=UmU_BVUaL_X75yOEvQPtGUBTR5-jiVWBHq7uSRt6HM4Q@mail.gmail.com>
 <225d2c0a-42ec-28ad-688c-e7e9e2035ee1@quicinc.com>
In-Reply-To: <225d2c0a-42ec-28ad-688c-e7e9e2035ee1@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Apr 2022 16:34:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=WjSACHvRDFBnkLUp-LU2c4XMu3=FTzTx=zexNF5PAw@mail.gmail.com>
Message-ID: <CAD=FV=W=WjSACHvRDFBnkLUp-LU2c4XMu3=FTzTx=zexNF5PAw@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 7, 2022 at 3:03 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Doug
>
> Thanks for the response, some comments below.
>
> Abhinav
> On 4/7/2022 1:47 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Apr 7, 2022 at 1:11 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Hi Doug and Dmitry
> >>
> >> Sorry, but I caught up on this email just now.
> >>
> >> Some comments below.
> >>
> >> Thanks
> >>
> >> Abhinav
> >> On 4/7/2022 10:07 AM, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Thu, Apr 7, 2022 at 7:19 AM Sankeerth Billakanti (QUIC)
> >>> <quic_sbillaka@quicinc.com> wrote:
> >>>>
> >>>> Hi Dmitry and Doug,
> >>>>
> >>>>> Hi,
> >>>>>
> >>>>> On Tue, Apr 5, 2022 at 10:36 AM Dmitry Baryshkov
> >>>>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>>>
> >>>>>> On 05/04/2022 20:02, Doug Anderson wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On Tue, Apr 5, 2022 at 5:54 AM Dmitry Baryshkov
> >>>>>>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>>>>>> 3. For DP and eDP HPD means something a little different.
> >>>>>>>>> Essentially there are two concepts: a) is a display physically
> >>>>>>>>> connected and b) is the display powered up and ready. For DP, the
> >>>>>>>>> two are really tied together. From the kernel's point of view you
> >>>>>>>>> never "power down" a DP display and you can't detect that it's
> >>>>>>>>> physically connected until it's ready. Said another way, on you
> >>>>>>>>> tie "is a display there" to the HPD line and the moment a display
> >>>>>>>>> is there it's ready for you to do AUX transfers. For eDP, in the
> >>>>>>>>> lowest power state of a display it _won't_ assert its "HPD"
> >>>>>>>>> signal. However, it's still physically present. For eDP you simply
> >>>>>>>>> have to _assume_ it's present without any actual proof since you
> >>>>>>>>> can't get proof until you power it up. Thus for eDP, you report
> >>>>>>>>> that the display is there as soon as we're asked. We can't _talk_
> >>>>>>>>> to the display yet, though. So in get_modes() we need to be able
> >>>>>>>>> to power the display on enough to talk over the AUX channel to it.
> >>>>>>>>> As part of this, we wait for the signal named "HPD" which really means
> >>>>> "panel finished powering on" in this context.
> >>>>>>>>>
> >>>>>>>>> NOTE: for aux transfer, we don't have the _display_ pipe and
> >>>>>>>>> clocks running. We only have enough stuff running to do the AUX
> >>>>> transfer.
> >>>>>>>>> We're not clocking out pixels. We haven't fully powered on the
> >>>>>>>>> display. The AUX transfer is designed to be something that can be
> >>>>>>>>> done early _before_ you turn on the display.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> OK, so basically that was a longwinded way of saying: yes, we
> >>>>>>>>> could avoid the AUX transfer in probe, but we can't wait all the
> >>>>>>>>> way to enable. We have to be able to transfer in get_modes(). If
> >>>>>>>>> you think that's helpful I think it'd be a pretty easy patch to
> >>>>>>>>> write even if it would look a tad bit awkward IMO. Let me know if
> >>>>>>>>> you want me to post it up.
> >>>>>>>>
> >>>>>>>> I think it would be a good idea. At least it will allow us to
> >>>>>>>> judge, which is the more correct way.
> >>>>>>>
> >>>>>>> I'm still happy to prototype this, but the more I think about it the
> >>>>>>> more it feels like a workaround for the Qualcomm driver. The eDP
> >>>>>>> panel driver is actually given a pointer to the AUX bus at probe
> >>>>>>> time. It's really weird to say that we can't do a transfer on it
> >>>>>>> yet... As you said, this is a little sideband bus. It should be able
> >>>>>>> to be used without all the full blown infra of the rest of the driver.
> >>>>>>
> >>>>>> Yes, I have that feeling too. However I also have a feeling that just
> >>>>>> powering up the PHY before the bus probe is ... a hack. There are no
> >>>>>> obvious stopgaps for the driver not to power it down later.
> >>>>>
> >>
> >> Lets go back to why we need to power up the PHY before the bus probe.
> >>
> >> We need to power up PHY before bus probe because panel-eDP tries to read
> >> the EDID in probe() for the panel_id. Not get_modes().
> >>
> >> So doug, I didnt follow your comment that panel-eDP only does EDID read
> >> in get_modes()
> >>
> >>          panel_id = drm_edid_get_panel_id(panel->ddc);
> >>          if (!panel_id) {
> >>                  dev_err(dev, "Couldn't identify panel via EDID\n");
> >>                  ret = -EIO;
> >>                  goto exit;
> >>          }
> >>
> >> If we do not need this part, we really dont need to power up the PHY
> >> before the probe(). The hack which dmitry was referring to.
> >
> > Right. ...so we _could_ remove the above from the panel-edp probe and
> > defer it to get_modes() and it wouldn't be that hard. ...but:
> >
> > 1. It feels like a hack to work around the Qualcomm driver. The way
> > the AUX bus is designed is that a pointer to the AUX bus is passed to
> > the panel-edp probe. It seems kinda strange to say that the panel
> > isn't allowed to do transfers with the pointer that's passed in.
> >
>
> And thats why to satisfy the requirements of passing an initialized AUX,
> sankeerth is delaying devm_of_dp_aux_populate_ep_devices() till PHY is
> initialized which seems reasonable to satisfy the probe() time requirements.
>
> Even if we move to pm_runtime(), yes I agree it will club all the
> resources needed to control AUX in one place but you will still have to
> initialize PHY before probe() under the hood of pm_runtime().
>
> So how will it help this cause?
>
> We just have to accept that initializing PHY is a requirement to use AUX
> and before calling panel-eDP's probe(), we have to have an initialized AUX.
>
> So we are not working around the driver but just satisfying the hardware
> requirements to be able to satisfy panel-edp's and
> drm_panel_dp_aux_backlight()'s aux bus requirements.

The way I'm arguing it should work is that:

1. A whole bunch of the DP init code should move to the DP driver's
probe function. This includes parsing the DT, acquiring clocks,
getting a handle to our PHY, and IO mapping registers. As far as I
know, there's no reason to wait on all the components being probed in
order to do this stuff.

2. Once we have done the above things, it should be possible to do AUX
transfers, correct? ...and then we can populate the AUX bus from the
probe function too.

3. Any other init (setting up pixel clocks) can continue to happen
where it is today.


> > 2. There's a second place where we might do an AUX transfer at probe
> > time which is when we're using the DP AUX backlight. There we call
> > drm_panel_dp_aux_backlight(). Conceivably this too could be deferred
> > until the get_modes(), but now it feels even more like a hack. We're
> > going to be registering the backlight in the first call to
> > get_modes()? That's, ummm, unexpected. We could look at perhaps
> > breaking the "DP AUX backlight" in two parts also, but that gets
> > involved. I think we're supposed to know the number of backlight
> > levels at device init time for backlight devices and we need an AUX
> > transfer to that.
> >
>
>
> >
> > So the answer is that we could probably make it work, but it seems
> > like an uglier solution than just making the Qualcomm driver able to
> > do AUX transfers when it should be able to.
>
> Correct and by delaying the panel-edp's probe(), we are doing exactly that?

Right. Where you put the probe now makes it work OK from an AUX
transfer point of view and it's probably OK for the short term, but
I'm not 100% convinced it would handle the -EPROBE_DEFER case, though
I haven't actually tested it.

Imagine this case:

1. 100% of your code is built-in to the kernel except for your PWM
driver, which is a module.

2. You start booting up. All the DRM components for MSM are finished
and eventually modeset_init() gets called.

3. We try to probe the panel. When the panel tries to acquire the PWM
backlight, it finds that the PWM driver hasn't been loaded yet. It
gets back -EPROBE_DEFER which prevents the panel driver from probing.

The question is: does modeset_init() handle that -EPROBE_DEFER
elegantly? Normally that's something that would only be returned by
probe functions. Maybe this is all handled, though? I definitely
haven't followed enough of the code and haven't tested it myself.

The above is probably not a giant deal, but I think long term it would
be better to be acquiring resources earlier.
