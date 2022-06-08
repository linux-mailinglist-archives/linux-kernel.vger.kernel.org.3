Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5E5427F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiFHHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiFHH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:26:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCA1E6F82;
        Tue,  7 Jun 2022 23:57:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8BBD380A;
        Wed,  8 Jun 2022 08:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654671390;
        bh=x9REXVP2Zsl5mDhiMiXfmICxPUpmNWGsk0CwsHnbLpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnFfN1Jol/zeM7/cVePA4ZDabkTrP6IO/6LNmZZRDAAQx9AHbfMawsCCg336NK0+r
         /hs7+FWItCQrVFddTV6HCqASlYkrS7r6zZG4Aw+rVPLPaC19ZdfQjpmSTeMLntTgVu
         aRPSCUsnhY6pqHtdzof4WPtyKB5vc2kSnh5McZLE=
Date:   Wed, 8 Jun 2022 09:56:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Subject: Re: [PATCH v3 1/7] media: uvcvideo: Add missing value for
 power_line_frequency
Message-ID: <YqBIGjTluERqyso/@pendragon.ideasonboard.com>
References: <20220607134405.166704-1-ribalda@chromium.org>
 <20220607134405.166704-2-ribalda@chromium.org>
 <Yp+hF+HcZUIqC/Pm@pendragon.ideasonboard.com>
 <CANiDSCt-2RWQqGi9z=fm26NZWodr0yJHrtdJeePcKsKjxsVO4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCt-2RWQqGi9z=fm26NZWodr0yJHrtdJeePcKsKjxsVO4Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Tue, Jun 07, 2022 at 11:50:15PM +0200, Ricardo Ribalda wrote:
> On Tue, 7 Jun 2022 at 21:04, Laurent Pinchart wrote:
> > On Tue, Jun 07, 2022 at 03:43:58PM +0200, Ricardo Ribalda wrote:
> > > UVC 1.5 class defines 4 values for this control on:
> > > 4.2.2.3.6 Power Line Frequency Control
> > >
> > > Add the missing value when the uvc version is 1.5.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_ctrl.c | 67 ++++++++++++++++++++++++++------
> > >  1 file changed, 55 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > index 0e78233fc8a0..f9d4ac81e62f 100644
> > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > @@ -362,12 +362,19 @@ static const u32 uvc_control_classes[] = {
> > >       V4L2_CID_USER_CLASS,
> > >  };
> > >
> > > -static const struct uvc_menu_info power_line_frequency_controls[] = {
> > > +static const struct uvc_menu_info power_line_frequency_controls_uvc11[] = {
> > >       { 0, "Disabled" },
> > >       { 1, "50 Hz" },
> > >       { 2, "60 Hz" },
> > >  };
> >
> > Let's drop this, and ...
> >
> > >
> > > +static const struct uvc_menu_info power_line_frequency_controls_uvc15[] = {
> >
> > ... rename this to power_line_frequency_controls, and ...
> >
> > > +     { 0, "Disabled" },
> > > +     { 1, "50 Hz" },
> > > +     { 2, "60 Hz" },
> > > +     { 3, "Auto" },
> > > +};
> > > +
> > >  static const struct uvc_menu_info exposure_auto_controls[] = {
> > >       { 2, "Auto Mode" },
> > >       { 1, "Manual Mode" },
> > > @@ -504,17 +511,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> > >               .v4l2_type      = V4L2_CTRL_TYPE_INTEGER,
> > >               .data_type      = UVC_CTRL_DATA_TYPE_UNSIGNED,
> > >       },
> > > -     {
> > > -             .id             = V4L2_CID_POWER_LINE_FREQUENCY,
> > > -             .entity         = UVC_GUID_UVC_PROCESSING,
> > > -             .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> > > -             .size           = 2,
> > > -             .offset         = 0,
> > > -             .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > > -             .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > > -             .menu_info      = power_line_frequency_controls,
> > > -             .menu_count     = ARRAY_SIZE(power_line_frequency_controls),
> > > -     },
> > >       {
> > >               .id             = V4L2_CID_HUE_AUTO,
> > >               .entity         = UVC_GUID_UVC_PROCESSING,
> > > @@ -730,6 +726,32 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> > >       },
> > >  };
> > >
> > > +static const
> > > +struct uvc_control_mapping power_line_mapping_uvc11 = {
> > > +     .id             = V4L2_CID_POWER_LINE_FREQUENCY,
> > > +     .entity         = UVC_GUID_UVC_PROCESSING,
> > > +     .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> > > +     .size           = 2,
> > > +     .offset         = 0,
> > > +     .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > > +     .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > > +     .menu_info      = power_line_frequency_controls_uvc11,
> > > +     .menu_count     = ARRAY_SIZE(power_line_frequency_controls_uvc11),
> >
> > ... use
> >
> >         .menu_count     = ARRAY_SIZE(power_line_frequency_controls) - 1,
> >
> > here. It will avoid duplicating the common menu items.
> >
> > > +};
> > > +
> > > +static const
> > > +struct uvc_control_mapping power_line_mapping_uvc15 = {
> >
> > This holds on a single line (and same for uvc11).
> >
> > > +     .id             = V4L2_CID_POWER_LINE_FREQUENCY,
> > > +     .entity         = UVC_GUID_UVC_PROCESSING,
> > > +     .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> > > +     .size           = 2,
> > > +     .offset         = 0,
> > > +     .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > > +     .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > > +     .menu_info      = power_line_frequency_controls_uvc15,
> > > +     .menu_count     = ARRAY_SIZE(power_line_frequency_controls_uvc15),
> > > +};
> >
> > How about turning those two into arrays (named uvc_ctrl_mappings_uvc11
> > and uvc_ctrl_mappings_uvc15) ? uvc_ctrl_init_ctrl() would first loop
> > over uvc_ctrl_mappings, and then over the version-specific arrays. This
> > would ease support of further version-specific controls.
> 
> I like the idea, but in this particular case, we have to add a third
> value for limited_powerline, which defeats the purpose :(.
> 
> What about  something like this:
> https://git.kernel.org/pub/scm/linux/kernel/git/ribalda/linux.git/commit/?h=uvc-powerline-v4&id=f1ad7c4d8552843c785d4a22bba233d21f3aed45
> 
> Basically, leave an array with all the powerline definitions
> (Disabled, 50,  60 and auto), and then hack around the index and
> sizes.

That's also an option. I have however sent a v4/RFC with a more generic
approach than a quirk, could you have a look at it ? Testing would be
appreciated too.

> > > +
> > >  /* ------------------------------------------------------------------------
> > >   * Utility functions
> > >   */
> > > @@ -2376,6 +2398,22 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
> > >       }
> > >  }
> > >
> > > +/*
> > > + * The powerline control has different valid values depending on the
> > > + * uvc version.
> > > + */
> > > +static void uvc_ctrl_init_powerline(struct uvc_video_chain *chain,
> > > +                                 struct uvc_control *ctrl)
> > > +{
> > > +     if (chain->dev->uvc_version < 0x0150) {
> > > +             __uvc_ctrl_add_mapping(chain, ctrl,
> > > +                                    &power_line_mapping_uvc11);
> > > +             return;
> > > +     }
> > > +
> > > +     __uvc_ctrl_add_mapping(chain, ctrl, &power_line_mapping_uvc15);
> > > +}
> > > +
> > >  /*
> > >   * Add control information and hardcoded stock control mappings to the given
> > >   * device.
> > > @@ -2385,6 +2423,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> > >  {
> > >       const struct uvc_control_info *info = uvc_ctrls;
> > >       const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
> > > +     static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
> >
> > Please move this first, the driver declares static variables before the
> > non-static ones.
> 
> Ack
> 
> > >       const struct uvc_control_mapping *mapping = uvc_ctrl_mappings;
> > >       const struct uvc_control_mapping *mend =
> > >               mapping + ARRAY_SIZE(uvc_ctrl_mappings);
> > > @@ -2415,6 +2454,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> > >       if (!ctrl->initialized)
> > >               return;
> > >
> > > +     if (uvc_entity_match_guid(ctrl->entity, uvc_processing_guid) &&
> > > +         ctrl->info.selector == UVC_PU_POWER_LINE_FREQUENCY_CONTROL)
> > > +             return uvc_ctrl_init_powerline(chain, ctrl);
> > > +
> > >       for (; mapping < mend; ++mapping) {
> > >               if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> > >                   ctrl->info.selector == mapping->selector)

-- 
Regards,

Laurent Pinchart
