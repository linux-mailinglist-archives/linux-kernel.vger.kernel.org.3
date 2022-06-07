Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBC8542423
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391874AbiFHBw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580018AbiFGXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:40:58 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9F42DFDB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:50:29 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f2cd424b9cso24896019fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nb9SkIgDmJbNtztO2QtRfshc39VCOn3yZ8K4x6tgCI8=;
        b=ZjlbpWnbvwLZ4FcdcujCEGwTzuwR5j3RabAea0KFc0ojHE481b6VfdAHB/R3w6F32w
         69MfYg65z+IjLC8oWaKTO4jAy6xsE95hOxVfPLrmYc4aXFJBdg/FV8ASD1DukEcq6QH/
         qdon7uQbyqqVXP6joVC9OLZi96DdicboXpkL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nb9SkIgDmJbNtztO2QtRfshc39VCOn3yZ8K4x6tgCI8=;
        b=Ou6EDgKtxXPYO5k4WMod9YX4xStG60BcSYqD7ysvUnpdxQuvG7421V3K1YsSAjelqg
         Jg461n6bef8TI+1AvHKYekjrI4Do/7p0FTnex3PppsUo0FMS8JQ822F4XWOqr5uo5O7q
         tmj0KkGrx1gLrZLtT9Fw2bR4PXQP0BFO5kOz2hQuqbR/a6hYT3ABLnrdEjZcC7vzHTzr
         LvQ1xSfN0P35bFtjrM6Id3f25mcT+JyuctsGHNm4NEGSUuVC30r4Sgw7+stVKOqE2iAU
         EIqmkC/OOyz4cGu9Pj++Jvdyi1wwiQesDYdRdTCW7f3ycKYBg2m+FRjptM6ZkjnztC40
         J7cQ==
X-Gm-Message-State: AOAM530NGANsEIzvJj+BV+ciwIlW7CHsS7ZnuXFg//ecYnT4ER8hUJnd
        CuhW/Cu0uZlxI7AmuyR2F6BEPJXc4jKmZ+3S
X-Google-Smtp-Source: ABdhPJyUwgME+dZYoXI7IyumJPlp2hW6mOli3mMq64qnsXsfDfIyAQ8EiD1kPMiS4rwfYhR+KURLgg==
X-Received: by 2002:a05:6870:5621:b0:f5:d454:d7c7 with SMTP id m33-20020a056870562100b000f5d454d7c7mr610360oao.236.1654638628686;
        Tue, 07 Jun 2022 14:50:28 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id k16-20020a056808069000b00325cda1ffa6sm10085205oig.37.2022.06.07.14.50.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 14:50:27 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-e5e433d66dso24878456fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:50:26 -0700 (PDT)
X-Received: by 2002:a05:6870:5702:b0:f2:d904:fd95 with SMTP id
 k2-20020a056870570200b000f2d904fd95mr619948oap.66.1654638626234; Tue, 07 Jun
 2022 14:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220607134405.166704-1-ribalda@chromium.org> <20220607134405.166704-2-ribalda@chromium.org>
 <Yp+hF+HcZUIqC/Pm@pendragon.ideasonboard.com>
In-Reply-To: <Yp+hF+HcZUIqC/Pm@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 7 Jun 2022 23:50:15 +0200
X-Gmail-Original-Message-ID: <CANiDSCt-2RWQqGi9z=fm26NZWodr0yJHrtdJeePcKsKjxsVO4Q@mail.gmail.com>
Message-ID: <CANiDSCt-2RWQqGi9z=fm26NZWodr0yJHrtdJeePcKsKjxsVO4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] media: uvcvideo: Add missing value for power_line_frequency
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Tue, 7 Jun 2022 at 21:04, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.

Thanks for your review :)

>
> On Tue, Jun 07, 2022 at 03:43:58PM +0200, Ricardo Ribalda wrote:
> > UVC 1.5 class defines 4 values for this control on:
> > 4.2.2.3.6 Power Line Frequency Control
> >
> > Add the missing value when the uvc version is 1.5.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 67 ++++++++++++++++++++++++++------
> >  1 file changed, 55 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 0e78233fc8a0..f9d4ac81e62f 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -362,12 +362,19 @@ static const u32 uvc_control_classes[] = {
> >       V4L2_CID_USER_CLASS,
> >  };
> >
> > -static const struct uvc_menu_info power_line_frequency_controls[] = {
> > +static const struct uvc_menu_info power_line_frequency_controls_uvc11[] = {
> >       { 0, "Disabled" },
> >       { 1, "50 Hz" },
> >       { 2, "60 Hz" },
> >  };
>
> Let's drop this, and ...
>
> >
> > +static const struct uvc_menu_info power_line_frequency_controls_uvc15[] = {
>
> ... rename this to power_line_frequency_controls, and ...
>
> > +     { 0, "Disabled" },
> > +     { 1, "50 Hz" },
> > +     { 2, "60 Hz" },
> > +     { 3, "Auto" },
> > +};
> > +
> >  static const struct uvc_menu_info exposure_auto_controls[] = {
> >       { 2, "Auto Mode" },
> >       { 1, "Manual Mode" },
> > @@ -504,17 +511,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> >               .v4l2_type      = V4L2_CTRL_TYPE_INTEGER,
> >               .data_type      = UVC_CTRL_DATA_TYPE_UNSIGNED,
> >       },
> > -     {
> > -             .id             = V4L2_CID_POWER_LINE_FREQUENCY,
> > -             .entity         = UVC_GUID_UVC_PROCESSING,
> > -             .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> > -             .size           = 2,
> > -             .offset         = 0,
> > -             .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > -             .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > -             .menu_info      = power_line_frequency_controls,
> > -             .menu_count     = ARRAY_SIZE(power_line_frequency_controls),
> > -     },
> >       {
> >               .id             = V4L2_CID_HUE_AUTO,
> >               .entity         = UVC_GUID_UVC_PROCESSING,
> > @@ -730,6 +726,32 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> >       },
> >  };
> >
> > +static const
> > +struct uvc_control_mapping power_line_mapping_uvc11 = {
> > +     .id             = V4L2_CID_POWER_LINE_FREQUENCY,
> > +     .entity         = UVC_GUID_UVC_PROCESSING,
> > +     .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> > +     .size           = 2,
> > +     .offset         = 0,
> > +     .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > +     .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > +     .menu_info      = power_line_frequency_controls_uvc11,
> > +     .menu_count     = ARRAY_SIZE(power_line_frequency_controls_uvc11),
>
> ... use
>
>         .menu_count     = ARRAY_SIZE(power_line_frequency_controls) - 1,
>
> here. It will avoid duplicating the common menu items.
>
> > +};
> > +
> > +static const
> > +struct uvc_control_mapping power_line_mapping_uvc15 = {
>
> This holds on a single line (and same for uvc11).
>
> > +     .id             = V4L2_CID_POWER_LINE_FREQUENCY,
> > +     .entity         = UVC_GUID_UVC_PROCESSING,
> > +     .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> > +     .size           = 2,
> > +     .offset         = 0,
> > +     .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > +     .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > +     .menu_info      = power_line_frequency_controls_uvc15,
> > +     .menu_count     = ARRAY_SIZE(power_line_frequency_controls_uvc15),
> > +};
>
> How about turning those two into arrays (named uvc_ctrl_mappings_uvc11
> and uvc_ctrl_mappings_uvc15) ? uvc_ctrl_init_ctrl() would first loop
> over uvc_ctrl_mappings, and then over the version-specific arrays. This
> would ease support of further version-specific controls.
>

I like the idea, but in this particular case, we have to add a third
value for limited_powerline, which defeats the purpose :(.

What about  something like this:
https://git.kernel.org/pub/scm/linux/kernel/git/ribalda/linux.git/commit/?h=uvc-powerline-v4&id=f1ad7c4d8552843c785d4a22bba233d21f3aed45

Basically, leave an array with all the powerline definitions
(Disabled, 50,  60 and auto), and then hack around the index and
sizes.


> > +
> >  /* ------------------------------------------------------------------------
> >   * Utility functions
> >   */
> > @@ -2376,6 +2398,22 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
> >       }
> >  }
> >
> > +/*
> > + * The powerline control has different valid values depending on the
> > + * uvc version.
> > + */
> > +static void uvc_ctrl_init_powerline(struct uvc_video_chain *chain,
> > +                                 struct uvc_control *ctrl)
> > +{
> > +     if (chain->dev->uvc_version < 0x0150) {
> > +             __uvc_ctrl_add_mapping(chain, ctrl,
> > +                                    &power_line_mapping_uvc11);
> > +             return;
> > +     }
> > +
> > +     __uvc_ctrl_add_mapping(chain, ctrl, &power_line_mapping_uvc15);
> > +}
> > +
> >  /*
> >   * Add control information and hardcoded stock control mappings to the given
> >   * device.
> > @@ -2385,6 +2423,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> >  {
> >       const struct uvc_control_info *info = uvc_ctrls;
> >       const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
> > +     static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
>
> Please move this first, the driver declares static variables before the
> non-static ones.
Ack
>
> >       const struct uvc_control_mapping *mapping = uvc_ctrl_mappings;
> >       const struct uvc_control_mapping *mend =
> >               mapping + ARRAY_SIZE(uvc_ctrl_mappings);
> > @@ -2415,6 +2454,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> >       if (!ctrl->initialized)
> >               return;
> >
> > +     if (uvc_entity_match_guid(ctrl->entity, uvc_processing_guid) &&
> > +         ctrl->info.selector == UVC_PU_POWER_LINE_FREQUENCY_CONTROL)
> > +             return uvc_ctrl_init_powerline(chain, ctrl);
> > +
> >       for (; mapping < mend; ++mapping) {
> >               if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> >                   ctrl->info.selector == mapping->selector)
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
