Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307CC4EA701
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiC2FLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiC2FL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:11:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC2A1AE;
        Mon, 28 Mar 2022 22:09:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z128so13880049pgz.2;
        Mon, 28 Mar 2022 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PwLiTiTuuYmEGZBEZtdx16O1EnIQcxEG7NDHX0bTC8=;
        b=YB30imApYvtayRV4JvgPo5u3HRnQVgALbM9YuxcvwsM8JayVOdaI6wh+jc1LpdQSFU
         f5eoVbU3xdiHjiQp8NotQRM80mHrGyY4HrBGyDECQDN7c/Zik+porDW5FNF1B9NvLegl
         qKx7Yp974Eol9lThz8Q4IpjkwDPY/IsIg4K4irB5jesIMpr6q9R6dRdAp8mSEyeIBFsT
         NvZDnJit1aZR6Uc1bpdQPDprjWVW9bDxxA3kyhk3pLJZIMXFSeimTZFFgnnGpZn2ijjP
         6s8QWvyXeOiSGVupakV3wa8sTHXxwRDyCbT1mAUnhjCpZZwNSTejxWTmwB67B96SRHG+
         f63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5PwLiTiTuuYmEGZBEZtdx16O1EnIQcxEG7NDHX0bTC8=;
        b=C9R2EoVdOKUiRPzRu13HFp0os4QDByn8Yqp5SICWiDBe0UMVZ/fmolz7s+27i9X1N8
         6Eks3Sfin1ckVlUA5Q+1mv8o2ajVmCuTmlg83fwKAD7YySh3A3vURLIuif2RFvbnz4Dm
         KlyOeanPURU+QT+6vH2yp9K4ww9o1hmPxm4vbzN0U5bZ45uP3uZ/oHJGMcCq/R7paj2n
         kcUG4i+MxXociDNOjY3Cv9tnTJlSTGCjV7YUR/bTL6txteI/Funv8GlY2gMjYDlCJinc
         blYNRvYbI74kTE40CvLA3dUeJCKYNbW9EVWDMeviZd8lK/FcGs4W9AnkPc4RHoEVPlzm
         8qPw==
X-Gm-Message-State: AOAM533iGrKNmalq9xjn2Rf2U8v1bz+BOrAUY17E7Xwjf/z4Bwvu7Dac
        2ufzpEglQRggCXBF0u32lAJnzHnnIEt5/A==
X-Google-Smtp-Source: ABdhPJwH6pO8XbEUS3UDYoGSPlu3fuPxiyYjat8pKXdmVIhUjGoVgyLmMqmSnvoHmD9T+oA8dDl+0g==
X-Received: by 2002:a05:6a00:1741:b0:4fa:f5bc:30bd with SMTP id j1-20020a056a00174100b004faf5bc30bdmr23205283pfc.0.1648530571620;
        Mon, 28 Mar 2022 22:09:31 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id k22-20020aa788d6000000b004faaf897064sm17645954pff.106.2022.03.28.22.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 22:09:31 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, ribalda@chromium.org, xiam0nd.tong@gmail.com
Subject: Re: [PATCH] uvc: fix missing check to determine if element is found in list
Date:   Tue, 29 Mar 2022 13:09:25 +0800
Message-Id: <20220329050925.15300-1-xiam0nd.tong@gmail.com>
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

On Tue, 22 Mar 2022 15:10:21 +0200, Laurent Pinchart wrote:

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

Thank you, i have resend a Patch v2 with changes as you suggested, please check it.

--
Xiaomeng Tong
