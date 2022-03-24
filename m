Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA19E4E6A72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353185AbiCXV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXV6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:58:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7CB7C4E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:56:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c62so7178328edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vhw38vbXipX7u0NiS9SPzi2ny2npVGnBq44scC9ARHk=;
        b=fE82jSKgfioc5LwK3WEfeXoniU1mEx+i9pOUZcUQHAk/i3Omm20L1YiD9F+oLGK+0z
         xxQPpUStahq3oJN6w8EzYFkt0iiq3wyOTXFHjvp0NRl/EYgGysEBqN4s4ZmzSAZ858Cr
         nM+xA25PIXSxzRwVvJh0B8LSj5OeJ1bN6SOHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vhw38vbXipX7u0NiS9SPzi2ny2npVGnBq44scC9ARHk=;
        b=QSg3lufEp/3SOuL9Z8ESwl0mxWqHi1dIN3ceEqZlDZNgEKS8n54a0C/KK0Y7xeE6NK
         DtDCaxhrtvgFio/tGn7csoEfFBxaVwTvxaUmuGDdjE9uRfZrIeMvDmjLrITS8BRVXH+F
         AKYnC3M82CquJkpFgDMvbHuC3hOmhOOoccO07dTOLLgsDACNP9U+93areVo+7gDIl7M8
         2gGZHZTxL+SKm+4ly2oi0pdNzp6ONRhIDj5CUJuzT9nutljR+RCkuJp9KVxTFNjDprdV
         tXYiY9K57SJLEnXd+WkumF4Df8x3p1rBZTOJ4kEMg58CBj4mZZmBM/aYqIDPgtkUYhNN
         1ZZQ==
X-Gm-Message-State: AOAM532VyNDs15lp97hYmsT9lEBeYrJ+K9vincRjt7G5u4RvcJG3woJu
        s+9X1v8tZrb41DhJyB7C0lzy3Wmg9Sw/kg==
X-Google-Smtp-Source: ABdhPJzNJDkn1Nh/9AkHb3FRwR0KzOZS7CQHMC6D0pjrQq/LtKOXFWUYzT3X4iFDp8GS86d7fmKclA==
X-Received: by 2002:a05:6402:50cf:b0:418:ee57:ed9 with SMTP id h15-20020a05640250cf00b00418ee570ed9mr9170900edb.37.1648159009572;
        Thu, 24 Mar 2022 14:56:49 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm362004ejc.109.2022.03.24.14.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 14:56:48 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id y10so7166336edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:56:48 -0700 (PDT)
X-Received: by 2002:a05:6402:350b:b0:419:1c11:23ed with SMTP id
 b11-20020a056402350b00b004191c1123edmr9290598edd.8.1648159008224; Thu, 24 Mar
 2022 14:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220215184228.2531386-1-ribalda@chromium.org> <YjzTnlf92rY/X6Lv@pendragon.ideasonboard.com>
In-Reply-To: <YjzTnlf92rY/X6Lv@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Mar 2022 22:56:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCupfHeXk_VcwyqQBbaOBQeb3ProsP=+HGf0g9eXCWAGqw@mail.gmail.com>
Message-ID: <CANiDSCupfHeXk_VcwyqQBbaOBQeb3ProsP=+HGf0g9eXCWAGqw@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix handling on Bitmask controls
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
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

Thanks for your review :) :)

On Thu, 24 Mar 2022 at 21:25, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tue, Feb 15, 2022 at 06:42:28PM +0000, Ricardo Ribalda wrote:
> > Minimum and step values for V4L2_CTRL_TYPE_BITMASK controls should be 0.
> > There is no need to query the camera firmware about this and maybe get
> > invalid results.
> >
> > Also value should be clamped to the min/max value advertised by the
> > hardware.
> >
> > Fixes v4l2-compliane:
> > Control ioctls (Input 0):
> >                 fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
> >       test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL
>
> What bitmask control do you have ? The driver has no standard control
> that use the V4L2_CTRL_TYPE_BITMASK type.
>
> UVC doesn't formally define bitmask control type
> (UVC_CTRL_DATA_TYPE_BITMASK). In UVC 1.1 only the UVC_CT_AE_MODE_CONTROL
> control has a bitmap type, and only one bit can be set at a type. It
> thus maps to a V4L2 menu control.
>
> In UVC 1.5 there are other controls documented as bitmap controls,
> which could map to the V4L2 bitmask control type. Those don't support
> GET_MIN and GET_MAX, but use GET_RES to report the list of bits that can
> be set. This should be mapped to the V4L2 control maximum value, which
> isn't handled by this patch. The last hunk is also incorrect, as it
> clamps the value to what is reported by GET_MIN and GET_MAX, instead of
> [0, GET_RES], but more than that, it should not just clamp the value,
> but check that all bits are valid.

I am particularly looking at bmAutoControls from CT_REGION_OF_INTEREST_CONTROL

The doc says that:
"""
 To detect if a device supports a particular Auto Control, use GET_MAX
which returns a mask indicating all supported Auto Controls.
"""

GET_RES does not seem to return the max_value accoring to the uvc
class spec, but I will try to validate tomorrow with real hardware,
maybe we are lucky.

And I definitely have to fix the clamp, thanks for pointing that out :)

>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index b4f6edf968bc0..d8b9ab5b7fb85 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1156,7 +1156,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >               break;
> >       }
> >
> > -     if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
> > +     if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN &&
> > +         mapping->v4l2_type != V4L2_CTRL_TYPE_BITMASK)
> >               v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
> >                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> >
> > @@ -1164,7 +1165,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >               v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
> >                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> >
> > -     if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
> > +     if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES &&
> > +         mapping->v4l2_type != V4L2_CTRL_TYPE_BITMASK)
> >               v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
> >                                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> >
> > @@ -1721,6 +1723,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >       /* Clamp out of range values. */
> >       switch (mapping->v4l2_type) {
> >       case V4L2_CTRL_TYPE_INTEGER:
> > +     case V4L2_CTRL_TYPE_BITMASK:
> >               if (!ctrl->cached) {
> >                       ret = uvc_ctrl_populate_cache(chain, ctrl);
> >                       if (ret < 0)
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
