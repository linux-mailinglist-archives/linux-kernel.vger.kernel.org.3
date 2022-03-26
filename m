Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DCB4E7FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiCZHCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiCZHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:02:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D658808;
        Sat, 26 Mar 2022 00:00:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so14144133pjb.4;
        Sat, 26 Mar 2022 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fa1rbYBBQP7PEVMDPwY0RhuBW3Duf2ev3235JlZkbm8=;
        b=dEfsbVUQovawKbYpYISbhgtuU7fgE7yavOpkeXww/POh3OchS+0npy1MdGhfCEdqXq
         PPfJ6Dmm8xhzVwUiVgeJMLXlEhAJQaR1uAnNKzJdykgZjlc4Vo6oofie3D8NXzpgvEMc
         PLXJoNaA/CTyJISTdqpjLDZ4PIYyK3IK1ULRtfZGECU7JLAsOLFSBhm7x6MwAHXKcO8o
         8IiFyWayY2EESn/NSal5BVJ6xECKp1Nlvy3oJRe0/oX/MDZoKvePdYMui70Kw9/1XGRG
         PiroFgpwGsvWJ2m+NNn4Y5WaHWpq4rSU9U/j/SatIsavWorRFBkv721jisgA9omIWPRF
         IMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fa1rbYBBQP7PEVMDPwY0RhuBW3Duf2ev3235JlZkbm8=;
        b=kgmevmECC2aUVaAJ8LOc9UH1fnCykN95hqMEKdtYGyHnTkdX79p2aLZYNPDbP+BWuI
         4BaXlxIvMu9hauCA8PC2h5spUbZkKUV1ombIo3YpAw+Pq44tguDXNDKBM6YFcVjqietq
         CSRnAVQ/sMGnAnY5kbF/5GcyFtZpClPDSPUfJQxgcBHU3MDW+MdJ5ePYWbxzU7kqy+tC
         8HFRi9Gk7N6YqnxiwlwfMq9ZMlEDHaDOucYOyhQlBec/PgAICLV4q/PuvfbQnt1pp8hN
         hxfAv1moGTWsG6bUzRhLK8BOM120Sq6GcdUvckydCrnGDNuWuUtSQMGF1JzdKAynl8dw
         WbBg==
X-Gm-Message-State: AOAM532OCkYyfv3WzeatP6Z8k1EseoYsbFqJONvjUpWIeed3yQyXp1kk
        vgvSDra4M6OZyX4lbFsgdrk=
X-Google-Smtp-Source: ABdhPJy/e2ZxNG4VTgxt+WXRzQezqLk4FSWFEC1dDVoNj1/UEUFo3DWg3fUl0nNHoPoUgdD+0/DAiQ==
X-Received: by 2002:a17:903:2351:b0:154:5ab7:873d with SMTP id c17-20020a170903235100b001545ab7873dmr15352605plh.57.1648278056094;
        Sat, 26 Mar 2022 00:00:56 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id w13-20020a17090a5e0d00b001c7d4099670sm5477247pjf.28.2022.03.26.00.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 00:00:55 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, ribalda@chromium.org, xiam0nd.tong@gmail.com
Subject: Re: [PATCH] uvc: fix missing check to determine if element is found in list
Date:   Sat, 26 Mar 2022 15:00:49 +0800
Message-Id: <20220326070049.10055-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YjnKvQZot2wnljmW@pendragon.ideasonboard.com>
References: <YjnKvQZot2wnljmW@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 15:10:21 +0200, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> > > Fixes: d5e90b7a6cd1c ("[media] uvcvideo: Move to video_ioctl2")
> > > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> > > ---
> > >  drivers/media/usb/uvc/uvc_v4l2.c | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > index 711556d13d03..e7cdc01ad277 100644
> > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > @@ -871,6 +871,7 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
> > >         struct uvc_video_chain *chain = handle->chain;
> > >         const struct uvc_entity *selector = chain->selector;
> > >         struct uvc_entity *iterm = NULL;
> > > +       struct uvc_entity *it;
> > >         u32 index = input->index;
> > >         int pin = 0;
> > >
> > > @@ -878,22 +879,27 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
> > >             (chain->dev->quirks & UVC_QUIRK_IGNORE_SELECTOR_UNIT)) {
> > >                 if (index != 0)
> > >                         return -EINVAL;
> > > -               list_for_each_entry(iterm, &chain->entities, chain) {
> > > -                       if (UVC_ENTITY_IS_ITERM(iterm))
> > > +               list_for_each_entry(it, &chain->entities, chain) {
> > > +                       if (UVC_ENTITY_IS_ITERM(it)) {
> > > +                               iterm = it;
> > >                                 break;
> > > +                       }
> > >                 }
> > > -               pin = iterm->id;
> > > +               if (iterm)
> > > +                       pin = iterm->id;
> 
> You can drop this, pin is not used anymore in the rest of the function.
> 
> > >         } else if (index < selector->bNrInPins) {
> > >                 pin = selector->baSourceID[index];
> > > -               list_for_each_entry(iterm, &chain->entities, chain) {
> > > -                       if (!UVC_ENTITY_IS_ITERM(iterm))
> > > +               list_for_each_entry(it, &chain->entities, chain) {
> > > +                       if (!UVC_ENTITY_IS_ITERM(it))
> > >                                 continue;
> > > -                       if (iterm->id == pin)
> > > +                       if (it->id == pin) {
> 
> And here you could use
> 			if (it->id == selector->baSourceID[index]) {
> 
> and drop the local pin variable.
> 
> If you're fine with those small changes I can handle them when applying
> the patch to my tree.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'm fine with those small changes, thank you.

--
Xiaomeng Tong
