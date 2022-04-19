Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E8506C28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352198AbiDSMVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352122AbiDSMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:21:33 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED62CC90
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:18:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z8so17894277oix.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrmfRSGXipf3L8+lkjXlVpaFbU4A+o7VmUyP1jAwbak=;
        b=Q3tIOnUaas1Yp+PFbgUzB4IUsepB+uNY6tIWTwONet91Fa90m0aTqeiZOJg6BZjotn
         pMorWvoxSPvGKLaMXPIURGwW6qrk90tqc/OOC7xjLhgvh+cv5oJjtTNBdNmN61puW3aa
         7hzrMKzGeaMt+0h7jg3y/9hQ9kRkxKM3pA0L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrmfRSGXipf3L8+lkjXlVpaFbU4A+o7VmUyP1jAwbak=;
        b=ByCVsUKtx97MTo2DHiNT9QheUAbz57t+IoSvyxywgoNDSPNDPx5NiDNLUIoMKscd22
         CFCeH+DbyrGLOVoZnWJOciQag83z1VRZadgRZzqxWNcpXrIg9AXjQc0JBGX2mQc/Ulc4
         RyIupDuL99nNSmanA6vUX9BNRSSfE/EmiykS5AatFmGAL3HTuzWljI41d6Z94LKPvorU
         GqpxAXxrNa4bjRLkt0rZ6ensbiCLE54gqcbAh2MygFiD7zZ11Ga6cG8OK9efTZCabShQ
         KpeoC01MteRIN/x46sBrufH3spB03svm2TLYaIlPKp5ibKx7/vczQ3qlxgIz/YKsxLzT
         Dehg==
X-Gm-Message-State: AOAM533R55FJWYzPocg1fuw8YjombMVuNOFbCjjw/XbTIObRb5npFfMp
        iQ+KZmJ+adtsibtCb902G6PiJFkaTyjISA==
X-Google-Smtp-Source: ABdhPJyZnzAwMjGD0Va10J5Vfq6g19JKsekkStn5rUQjKsOgQV/EGcUSC+4myiWDQAoQeoIpJURkbg==
X-Received: by 2002:a05:6808:d50:b0:2fa:5f18:55fb with SMTP id w16-20020a0568080d5000b002fa5f1855fbmr7015828oik.116.1650370730513;
        Tue, 19 Apr 2022 05:18:50 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id q11-20020a05683033cb00b005e686fd52d6sm5264586ott.17.2022.04.19.05.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:18:49 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e5e433d66dso5897439fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:18:49 -0700 (PDT)
X-Received: by 2002:a05:6871:5cb:b0:e5:db16:5297 with SMTP id
 v11-20020a05687105cb00b000e5db165297mr4428783oan.66.1650370728811; Tue, 19
 Apr 2022 05:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220418090652.3156-1-Ping-lei.Lin@mediatek.com>
 <CANiDSCvLb785H7qyAzSfTSBRpO2eM-oJFF5SgVHXdL1O-GusLA@mail.gmail.com> <Yl6oYlv+t63+5dVP@pendragon.ideasonboard.com>
In-Reply-To: <Yl6oYlv+t63+5dVP@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 19 Apr 2022 14:18:37 +0200
X-Gmail-Original-Message-ID: <CANiDSCv0BA5C8ijO-T_3c2rxGD_yC0LGuG77THkC7_52GZ-dtA@mail.gmail.com>
Message-ID: <CANiDSCv0BA5C8ijO-T_3c2rxGD_yC0LGuG77THkC7_52GZ-dtA@mail.gmail.com>
Subject: Re: [PATCH v3] media: usb: uvc: Add UVC_GUID_FORMAT_H265
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     James_Lin <Ping-lei.Lin@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, sherlock.chang@mediatek.com,
        lecopzer.chen@mediatek.com, max.yan@mediatek.com,
        tm.wu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 14:17, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hello,
>
> On Tue, Apr 19, 2022 at 01:46:15PM +0200, Ricardo Ribalda wrote:
> > On Mon, 18 Apr 2022 at 11:07, James_Lin <Ping-lei.Lin@mediatek.com> wrote:
> > >
> > > This patch aims to add UVC_GUID_FORMAT_H265
> > > High Efficiency Video Coding (HEVC), also known as H.265 and MPEG-H Part 2.
> > > They describe the same video encoding method.
> > > So for handling their behavior is the same.
> > > However, when external camera device describes this encoding method,
> > > some use hevc, some use h265.
> > > There is no uniform specification to describe this encoding method.
> > > So if an external camera device use h265 to describe this encoding method,
> > > driver will not recognize it.
> > > Therefore, this patch is to enable driver to read HEVC/H265
> > > and convert it to V4L2_PIX_FMT_HEVC.
> > >
> > > Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> >
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_driver.c | 5 +++++
> > >  drivers/media/usb/uvc/uvcvideo.h   | 3 +++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > index dda0f0aa78b8..e437e9f95890 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] = {
> > >                 .guid           = UVC_GUID_FORMAT_H264,
> > >                 .fcc            = V4L2_PIX_FMT_H264,
> > >         },
> >
> > Maybe I would add a comment here saying that some cameras represent
> > hevc as h265.
>
> I wish there would be a 4CC and GUID standard with a centralized
> registry...

Thought that was the kernel codebase :)

>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > > +       {
> > > +               .name           = "H.265",
> > > +               .guid           = UVC_GUID_FORMAT_H265,
> > > +               .fcc            = V4L2_PIX_FMT_HEVC,
> > > +       },
> > >         {
> > >                 .name           = "Greyscale 8 L/R (Y8I)",
> > >                 .guid           = UVC_GUID_FORMAT_Y8I,
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index 143230b3275b..41f4d8c33f2a 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -139,6 +139,9 @@
> > >  #define UVC_GUID_FORMAT_H264 \
> > >         { 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
> > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > +#define UVC_GUID_FORMAT_H265 \
> > > +       { 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
> > > +        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > >  #define UVC_GUID_FORMAT_Y8I \
> > >         { 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
> > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
