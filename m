Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33E4F8A47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiDGUxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiDGUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:53:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE374DFD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:48:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so13333432ejd.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTfNEaVRRahWYsVWnvf54Nm0EiMRp3IlprcC5NKfZ9M=;
        b=ekoZS3gvBVuf+fQ1f4FHVgjDw0z8j7KBMigUADUzFOlne+pOb1gNNrHVU4dL0AuEDB
         aIKMEEXRiqPkuOQSlIqAXL0CVFf0RrKTurmLbSjLMqamK13JU/o2haFQT4o8OBnOcthO
         41PguON5ciRBjh21EzOxh0VeKNVgcWYtQ7VxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTfNEaVRRahWYsVWnvf54Nm0EiMRp3IlprcC5NKfZ9M=;
        b=dJwR3g8/mQQYzYBnLXFXZtwgwUkByGHJcLdIw+NDbDQaW4XOiElMrjxw5XD8G4OSHj
         9P8Act9S/WD/rJUrPuLRtn5uxf2v4ZGo20QwuAG38IQ4nCuA2UqjiMafF9Gbi7JncVlb
         4iu3Y1W+IorJDLJC6TPibsVHR9q4LZvjw78uWchXMJexCMyMbeJRV+YuwVrGx6l6bohN
         QmYHeSKjB+AKiEz//jm5w2Lx5RTW9gRF29PiEqlGJFZ6H0o1ne1TsEOZzhpaNKw5ORjs
         ojJXzO8IIc/sonKnYWRDQ0+lzxIsv0FKoOhp9iTSpQpvZWw1dBCyuBwGna6Yz+4afNe3
         CP7A==
X-Gm-Message-State: AOAM533RKpT1U8TfB5sj1adKsuUnUNOZP0b4Ayq2/nCbTMNCZZzwr9p+
        ZEixLQ9fk+LclUD4Vj8P9N4rmpes9+eByI36Pcs=
X-Google-Smtp-Source: ABdhPJwx5oMsgK4Z2AA/mfeQiAs39FuSCLwAcTQf4xf3V/enYO3XBFRdnJc+51uElkU5TCKqdKDaaA==
X-Received: by 2002:a17:907:971c:b0:6e0:d0ef:393e with SMTP id jg28-20020a170907971c00b006e0d0ef393emr15087253ejc.562.1649364491722;
        Thu, 07 Apr 2022 13:48:11 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id q3-20020a50da83000000b0041cdd6e92b1sm4662651edj.27.2022.04.07.13.48.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 13:48:10 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id d3so9615578wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:48:09 -0700 (PDT)
X-Received: by 2002:adf:e591:0:b0:206:1202:214 with SMTP id
 l17-20020adfe591000000b0020612020214mr12251692wrm.342.1649364488679; Thu, 07
 Apr 2022 13:48:08 -0700 (PDT)
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
 <CAD=FV=Wk3U7_bVdiCPp8iQ4bcCA_Botemu4pwHeRtgBa3Xk6KQ@mail.gmail.com> <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com>
In-Reply-To: <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Apr 2022 13:47:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UmU_BVUaL_X75yOEvQPtGUBTR5-jiVWBHq7uSRt6HM4Q@mail.gmail.com>
Message-ID: <CAD=FV=UmU_BVUaL_X75yOEvQPtGUBTR5-jiVWBHq7uSRt6HM4Q@mail.gmail.com>
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

On Thu, Apr 7, 2022 at 1:11 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Doug and Dmitry
>
> Sorry, but I caught up on this email just now.
>
> Some comments below.
>
> Thanks
>
> Abhinav
> On 4/7/2022 10:07 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Apr 7, 2022 at 7:19 AM Sankeerth Billakanti (QUIC)
> > <quic_sbillaka@quicinc.com> wrote:
> >>
> >> Hi Dmitry and Doug,
> >>
> >>> Hi,
> >>>
> >>> On Tue, Apr 5, 2022 at 10:36 AM Dmitry Baryshkov
> >>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>
> >>>> On 05/04/2022 20:02, Doug Anderson wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Tue, Apr 5, 2022 at 5:54 AM Dmitry Baryshkov
> >>>>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>>>> 3. For DP and eDP HPD means something a little different.
> >>>>>>> Essentially there are two concepts: a) is a display physically
> >>>>>>> connected and b) is the display powered up and ready. For DP, the
> >>>>>>> two are really tied together. From the kernel's point of view you
> >>>>>>> never "power down" a DP display and you can't detect that it's
> >>>>>>> physically connected until it's ready. Said another way, on you
> >>>>>>> tie "is a display there" to the HPD line and the moment a display
> >>>>>>> is there it's ready for you to do AUX transfers. For eDP, in the
> >>>>>>> lowest power state of a display it _won't_ assert its "HPD"
> >>>>>>> signal. However, it's still physically present. For eDP you simply
> >>>>>>> have to _assume_ it's present without any actual proof since you
> >>>>>>> can't get proof until you power it up. Thus for eDP, you report
> >>>>>>> that the display is there as soon as we're asked. We can't _talk_
> >>>>>>> to the display yet, though. So in get_modes() we need to be able
> >>>>>>> to power the display on enough to talk over the AUX channel to it.
> >>>>>>> As part of this, we wait for the signal named "HPD" which really means
> >>> "panel finished powering on" in this context.
> >>>>>>>
> >>>>>>> NOTE: for aux transfer, we don't have the _display_ pipe and
> >>>>>>> clocks running. We only have enough stuff running to do the AUX
> >>> transfer.
> >>>>>>> We're not clocking out pixels. We haven't fully powered on the
> >>>>>>> display. The AUX transfer is designed to be something that can be
> >>>>>>> done early _before_ you turn on the display.
> >>>>>>>
> >>>>>>>
> >>>>>>> OK, so basically that was a longwinded way of saying: yes, we
> >>>>>>> could avoid the AUX transfer in probe, but we can't wait all the
> >>>>>>> way to enable. We have to be able to transfer in get_modes(). If
> >>>>>>> you think that's helpful I think it'd be a pretty easy patch to
> >>>>>>> write even if it would look a tad bit awkward IMO. Let me know if
> >>>>>>> you want me to post it up.
> >>>>>>
> >>>>>> I think it would be a good idea. At least it will allow us to
> >>>>>> judge, which is the more correct way.
> >>>>>
> >>>>> I'm still happy to prototype this, but the more I think about it the
> >>>>> more it feels like a workaround for the Qualcomm driver. The eDP
> >>>>> panel driver is actually given a pointer to the AUX bus at probe
> >>>>> time. It's really weird to say that we can't do a transfer on it
> >>>>> yet... As you said, this is a little sideband bus. It should be able
> >>>>> to be used without all the full blown infra of the rest of the driver.
> >>>>
> >>>> Yes, I have that feeling too. However I also have a feeling that just
> >>>> powering up the PHY before the bus probe is ... a hack. There are no
> >>>> obvious stopgaps for the driver not to power it down later.
> >>>
>
> Lets go back to why we need to power up the PHY before the bus probe.
>
> We need to power up PHY before bus probe because panel-eDP tries to read
> the EDID in probe() for the panel_id. Not get_modes().
>
> So doug, I didnt follow your comment that panel-eDP only does EDID read
> in get_modes()
>
>         panel_id = drm_edid_get_panel_id(panel->ddc);
>         if (!panel_id) {
>                 dev_err(dev, "Couldn't identify panel via EDID\n");
>                 ret = -EIO;
>                 goto exit;
>         }
>
> If we do not need this part, we really dont need to power up the PHY
> before the probe(). The hack which dmitry was referring to.

Right. ...so we _could_ remove the above from the panel-edp probe and
defer it to get_modes() and it wouldn't be that hard. ...but:

1. It feels like a hack to work around the Qualcomm driver. The way
the AUX bus is designed is that a pointer to the AUX bus is passed to
the panel-edp probe. It seems kinda strange to say that the panel
isn't allowed to do transfers with the pointer that's passed in.

2. There's a second place where we might do an AUX transfer at probe
time which is when we're using the DP AUX backlight. There we call
drm_panel_dp_aux_backlight(). Conceivably this too could be deferred
until the get_modes(), but now it feels even more like a hack. We're
going to be registering the backlight in the first call to
get_modes()? That's, ummm, unexpected. We could look at perhaps
breaking the "DP AUX backlight" in two parts also, but that gets
involved. I think we're supposed to know the number of backlight
levels at device init time for backlight devices and we need an AUX
transfer to that.


So the answer is that we could probably make it work, but it seems
like an uglier solution than just making the Qualcomm driver able to
do AUX transfers when it should be able to.

> So this is boiling down to why or how panel-eDP was originally designed.
>
> >>> This is why I think we need to move to Runtime PM to manage this. Basically:
> >>>
> >>> 1. When an AUX transfer happens, you grab a PM runtime reference that
> >>> _that_ powers up the PHY.
>
> This will not be trivial and needs to be scoped out as sankeerth said
> but if the above is the only concern, why do we need to do this? There
> seems to be an explanation why we are doing this and its not a hack.
>
> How would Dmitry's rework address this? We need some RFC to conclude on
> that first.
>
> >>>
> >>> 2. At the end of the AUX transfer function, you do a "put_autosuspend".
> >>>
> >>> Then it becomes not a hack, right?
> >>>
> >>>
> >>
> >> pm runtime ops needs to be implemented for both eDP and DP. This change
> >> take good amount of planning and code changes as it affects DP also.
> >>
> >> Because this patch series consist of basic eDP changes for SC7280 bootup,
> >> shall we take this pm_runtime implementation in subsequent patch series?
> >
> > Dmitry is the real decision maker here, but in my opinion it would be
> > OK to get something landed first that worked OK and wasn't taking us
> > too far in the wrong direction and then we could get a follow up patch
> > to move to pm_runtime.
>
> I would say the discussion changed into a direction of implementing
> pm-runtime because the current patch series does what it takes to adhere
> to panel-eDP's design along with aux bus requirements of PHY needing to
> be on.
>
> So doug, to answer your questions here:
>
> "So I guess the net result is maybe we should just keep it where it is.
> Long term I'd be interested in knowing if there's a reason why we
> can't structure the driver so that AUX transfers can happen with less
> intertwining with the rest of the code, but that can happen later. I
> would expect that you'd basically just need clocks and regulators on
> and maybe your PHY on."
>
> Yes PHY needs to be absolutely on and configured before aux transfers.
>
> If we want to change that up to stop reading the panel_id in the panel
> probe() and do it later, perhaps some of the changes done here are not
> needed.
>
> It only seems reasonable that we first prototype that in a separate
> patch even a RFC perhaps and take this further as these set of changes
> are needed for basic display functionality on sc7280 chromebooks.
>
> Let us know what are the concerns with doing it in a follow up change.

As per above, I'm not objecting to it being a follow-up change, but I
do believe it's the right design and will lead to an overall cleaner
solution. I think I even mentioned in my reviews that the current
patch series seems to "scattershot" enable resources and that's how we
end up with patches like patch #5 in this series ("drm/msm/dp: prevent
multiple votes for dp resources"). IMO there should be be a 1-to-1
mapping between "turn on resources" and "turn off resources" and it
should be reference counted. So if your codepath turned on resources
then it's up to your codepath to turn resources off when done. If a
seconde code path might be running at the same time then it should
also turn on/off resources itself. ...and it should all be managed by
pm_runtime which is _exactly designed_ for this specific use case.

-Doug
