Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D044E3F30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiCVNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiCVNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:12:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5C63521;
        Tue, 22 Mar 2022 06:10:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA371DFA;
        Tue, 22 Mar 2022 14:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647954638;
        bh=4/zDggOfdRrl+UUfNTaaa9LlWfBAHXPBbJUpBU72Ais=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d09MxOhzbYU4/sEvMW+7fm2xLqi0xkXExEgBJBkcIqzSiG/tVNhXbvIkYEsSrinKx
         OOpGI7f7JQ/rO3xh7qfp70Y2SBsUhBcYdOlSvaYCvvyJMmwwS4a0MSjAT0WIAAAN6X
         2b8MuBeZ4t+TQlsa0vEbRK1UgbE3jlxDrYAKw6fk=
Date:   Tue, 22 Mar 2022 15:10:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Xiaomeng Tong <xiam0nd.tong@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uvc: fix missing check to determine if element is found
 in list
Message-ID: <YjnKvQZot2wnljmW@pendragon.ideasonboard.com>
References: <20220319102222.3079-1-xiam0nd.tong@gmail.com>
 <CANiDSCugwwNc8HjqNX2Mp8GdFN0s=jgPkT_2d4kiVygp=XZa4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCugwwNc8HjqNX2Mp8GdFN0s=jgPkT_2d4kiVygp=XZa4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:40:07PM +0100, Ricardo Ribalda wrote:
> Hi Xiaomeng
> 
> Thanks for the patch. Maybe it would be better to just make a function
> to find the ITERM entity with a given id?

We already have a uvc_entity_by_id() which could be used for that, but
only for the second loop iteration. The first one finds any input
terminal. Also, the second loop restricts the search to a chain, while
uvc_entity_by_id() it global to the device. I think the proposed patch
is fine.

> On Mon, 21 Mar 2022 at 16:33, Xiaomeng Tong wrote:
> >
> > The list iterator will point to a bogus position containing HEAD if
> > the list is empty or the element is not found in list. This case
> > should be checked before any use of the iterator, otherwise it will
> > lead to a invalid memory access. The missing check here is before
> > "pin = iterm->id;", just add check here to fix the security bug.
> >
> > In addition, the list iterator value will *always* be set and non-NULL
> > by list_for_each_entry(), so it is incorrect to assume that the iterator
> > value will be NULL if the element is not found in list, considering
> > the (mis)use here: "if (iterm == NULL".
> >
> > Use a new value 'it' as the list iterator, while use the old value
> > 'iterm' as a dedicated pointer to point to the found element, which
> > 1. can fix this bug, due to 'iterm' is NULL only if it's not found.
> > 2. do not need to change all the uses of 'iterm' after the loop.
> > 3. can also limit the scope of the list iterator 'it' *only inside*
> >    the traversal loop by simply declaring 'it' inside the loop in the
> >    future, as usage of the iterator outside of the list_for_each_entry
> >    is considered harmful. https://lkml.org/lkml/2022/2/17/1032

Looking forward to that :-)

> > Fixes: d5e90b7a6cd1c ("[media] uvcvideo: Move to video_ioctl2")
> > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> > ---
> >  drivers/media/usb/uvc/uvc_v4l2.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 711556d13d03..e7cdc01ad277 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -871,6 +871,7 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
> >         struct uvc_video_chain *chain = handle->chain;
> >         const struct uvc_entity *selector = chain->selector;
> >         struct uvc_entity *iterm = NULL;
> > +       struct uvc_entity *it;
> >         u32 index = input->index;
> >         int pin = 0;
> >
> > @@ -878,22 +879,27 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
> >             (chain->dev->quirks & UVC_QUIRK_IGNORE_SELECTOR_UNIT)) {
> >                 if (index != 0)
> >                         return -EINVAL;
> > -               list_for_each_entry(iterm, &chain->entities, chain) {
> > -                       if (UVC_ENTITY_IS_ITERM(iterm))
> > +               list_for_each_entry(it, &chain->entities, chain) {
> > +                       if (UVC_ENTITY_IS_ITERM(it)) {
> > +                               iterm = it;
> >                                 break;
> > +                       }
> >                 }
> > -               pin = iterm->id;
> > +               if (iterm)
> > +                       pin = iterm->id;

You can drop this, pin is not used anymore in the rest of the function.

> >         } else if (index < selector->bNrInPins) {
> >                 pin = selector->baSourceID[index];
> > -               list_for_each_entry(iterm, &chain->entities, chain) {
> > -                       if (!UVC_ENTITY_IS_ITERM(iterm))
> > +               list_for_each_entry(it, &chain->entities, chain) {
> > +                       if (!UVC_ENTITY_IS_ITERM(it))
> >                                 continue;
> > -                       if (iterm->id == pin)
> > +                       if (it->id == pin) {

And here you could use
			if (it->id == selector->baSourceID[index]) {

and drop the local pin variable.

If you're fine with those small changes I can handle them when applying
the patch to my tree.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > +                               iterm = it;
> >                                 break;
> > +                       }
> >                 }
> >         }
> >
> > -       if (iterm == NULL || iterm->id != pin)
> > +       if (iterm == NULL)
> >                 return -EINVAL;
> >
> >         memset(input, 0, sizeof(*input));

-- 
Regards,

Laurent Pinchart
