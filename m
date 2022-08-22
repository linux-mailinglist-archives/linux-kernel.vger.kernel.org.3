Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38859C34A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiHVPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiHVPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:42:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0C27154
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:42:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso6064173pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nSOJmzz8FKLZ+aQzB03j8a24xuRTz7j+vJV5QntIObE=;
        b=VJPk1mdRqKLL7wk8+sp0hf3sEZ1CzpxGNzCOfFiiwyzqI9EpkI4q39h4WL8vkWJmLn
         pchUUPA7z2kr3aB8+u5Jw5Pqmt+K/XhSfyIlDOMlFL7crU6B69R8N5wb3+TakeKBdspZ
         MCleAtNIxNrvmE+gsljTRn1fcNdNX/f+dw7vCEZkLY5XeYP5gkGGmQAauixO9q51D0F+
         RDKUvzzCfq0zXBp7qXUmpfNiUqq5DgbKNO8qiyNHQfiZREAOr6Dv+6oJL609Yv6t0MYc
         6vu4ITw/4Jg0kRk4ThKQfWY/sFcgez0tQvBfQ3E/SAc2vkwQFDWouV1gcxCM//8MOCzM
         nL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nSOJmzz8FKLZ+aQzB03j8a24xuRTz7j+vJV5QntIObE=;
        b=eEVgrirOY8VXPk5hmz+nhNHdbCjQQrVq6I7eR0Q5d1wmV4I+quhMuyRiqYPUAeHJXG
         XpyolaYOurK2JV54RpS0b2VGj2sGVkrA0IQHdIxK0olAy0lX0XN8oLvITthAzwTdyuqO
         5R8IYDzGfE/4Ql1E3Mms15X85onK22Hi6BRK/KI1J9hmFvl77xQVCFc2KFLKs1bczzGD
         yLvNv1jUZ3qt12q7gkkog3cT5/Vq4z2kyczOAjVFuwcoG1IyzW655JLiKdtnIB0o7hbR
         HwQhzPBFddPlP8lFd5k4Vh/cAH8e8fGFiph14z/W9SbNqsXyfERnIMwI/fI1ISzFg+Nc
         aLwg==
X-Gm-Message-State: ACgBeo0Ga1g1h3TLALUJJKpw9EL9rlBVVh31mN6NakyuZDdvsRifZoYD
        HvaH7vhB88z83KDFtfIOtUrkrziN+pAzYEUzekj/XFjoJhI=
X-Google-Smtp-Source: AA6agR43+zQXbyALqGJ21buqeHmjKqrLr6l/7xJZ3v2b7XWr6N/+et5ywnsHQTHosHsAaHDGBcCllGTWFsCkAt0m1QI=
X-Received: by 2002:a17:90b:1189:b0:1f5:1311:cd89 with SMTP id
 gk9-20020a17090b118900b001f51311cd89mr28976132pjb.181.1661182942742; Mon, 22
 Aug 2022 08:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220816083854.1491886-1-raychi@google.com> <20220816083854.1491886-3-raychi@google.com>
 <Yvtb93dhvhTS5xYB@kroah.com>
In-Reply-To: <Yvtb93dhvhTS5xYB@kroah.com>
From:   Ray Chi <raychi@google.com>
Date:   Mon, 22 Aug 2022 23:42:11 +0800
Message-ID: <CAPBYUsA0LAYUBtXRuGwo=neLjWyojRUU91vnRE=k6rcimgSVbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: xhci: add check_init_status hook support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        Badhri Jagan Sridharan <badhri@google.com>,
        Albert Wang <albertccwang@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 4:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 16, 2022 at 04:38:54PM +0800, Ray Chi wrote:
> > In general, xHCI didn't do anything for port initialization. However,
> > there are some requirement or limitation on various platforms, so
> > vendors need to do some error handlings if the device connected to a
> > broken USB accessory.
> >
> > This patch also add the hook to xhci_driver_overrides so that vendors
> > can add their specific protection easily if needed.
> >
> > Signed-off-by: Ray Chi <raychi@google.com>
> > ---
> >  drivers/usb/host/xhci.c | 17 +++++++++++++++++
> >  drivers/usb/host/xhci.h |  1 +
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 65858f607437..f237af9d6e2e 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -4358,6 +4358,20 @@ static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
> >       return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
> >  }
> >
> > +/*
> > + * The function could get the status of port initialization.
> > + */
> > +static int xhci_check_init_status(struct usb_hcd *hcd, struct usb_device *udev, int r)
> > +{
> > +     /*
> > +      * In general, this function is not necessory. Some platforms may
> > +      * need doing error handling when the port initialization takes a
> > +      * long time to do. The device can use the override callback to
> > +      * do specific handlings.
> > +      */
> > +     return 0;
> > +}
>
> For obvious technical and legal reasons, we are not allowed to add
> "hooks" to the kernel where there are no in-kernel users.  Nor would you
> want us to do so.
>

Agree on this. I am trying another way to achieve the same goal.

> So I really do not understand this patch series at all.
>
> What driver wants to do odd things here?  What needs to happen that the
> in-tree drivers are not doing properly?  Why not get the needed fixes in
> the in-kernel drivers instead of trying to add random hooks that some
> out-of-tree code would use instead.
>
> confused,
>
> greg k-h

I will prepare a new commit to do it.

Thanks,
Ray
