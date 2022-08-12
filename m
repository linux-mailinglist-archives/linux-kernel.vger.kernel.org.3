Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC75909F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiHLBkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiHLBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:40:16 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F534B86
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:40:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-328303afa6eso189289187b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JGcWtnBYwiKJJQbwdikg0mmAy+U2P39G1mlmCK+xmWE=;
        b=FbhFvlnCB3Ej+bTsD0lexYxFgEpA8Glgkkqeqt8LUobGOsB2SxYSskPgBa1XCNegn8
         FoAMgayssuo63dg1XbqOYFRILKtwUsTNfm/5e/wNJOcqjKUGEZNs6zc5l8CJmprBePj1
         keUlDXOM30vOI3YIlpFQIcaJ3UmBD2qPRJxzzMKx3Q27NsddM983p1RGOaKYuZ3Z4p6a
         K4yVya6rPBTkPXpJY0rVoSYed8LZx1XfpDv3dz4L9bi2DIr8uH7yjZw8LFCw40KNs4Np
         WyinuhKb1pmDHKaBpchLoXPsOml6Qbih4PB61RdKE8jpKishfB3BEiYmL30KSAmWJcL8
         0eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JGcWtnBYwiKJJQbwdikg0mmAy+U2P39G1mlmCK+xmWE=;
        b=77c1ht0sMeaAcMAGa8T7cQM+4sVvh2hZ52h8MRCaie9wcJlmssCIUiPaFrslvWjsjX
         hGET0wfxlQnEhnb7O76rV7cYQsMKex4Pe90cDlO34JKfk8/PdCb80F8qrEKaquaMlDGE
         yYCwf+ELs9Useibi4lG9glNt3VHoEZ95tRhPpmRVhpYCwSskdkbR27ypU5u8FYc/mlhE
         yRhwqUUlW9LgE527C7N03vXg+ZEPYrJkwS1Vp1q1SNqNHK7MjWBbs0fStLSzeYwTs5RB
         0evRxtrNa5LHB7wpL9rJPObk1bw+D2xnDtIx7tqUYI5acL4b4lj5BBgOgDFA+8b6MQ8t
         hjKw==
X-Gm-Message-State: ACgBeo178WTuSLXp5k3wZz31WZdkzCmy3DKNC1leqUtP3nGFie+73aFv
        uMza6sjQPwVBv00I2B2AEjunOxXqgb/2jj9OyU3Ztw==
X-Google-Smtp-Source: AA6agR443AOUNCl2c/F7oYs9zw8lTqzWAk2IorGJ2qeKmdGX76eCje0RoddablorVZh/zyBvINOjRBJ4ZAYQXSa1OxY=
X-Received: by 2002:a81:998c:0:b0:326:5dab:df3f with SMTP id
 q134-20020a81998c000000b003265dabdf3fmr1994375ywg.126.1660268413610; Thu, 11
 Aug 2022 18:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220811190747.797081-1-isaacmanjarres@google.com> <baa22854-1286-5f63-c537-a6d3d5c12f76@roeck-us.net>
In-Reply-To: <baa22854-1286-5f63-c537-a6d3d5c12f76@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 11 Aug 2022 18:39:37 -0700
Message-ID: <CAGETcx-kktM4g8EELrLK867_rjBr929CzH-KsuQ66uqyiZmL_w@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Don't probe devices after
 bus_type.match() probe deferral
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 11, 2022 at 5:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/11/22 12:07, Isaac J. Manjarres wrote:
> > Both __device_attach_driver() and __driver_attach() check the return
> > code of the bus_type.match() function to see if the device needs to be
> > added to the deferred probe list. After adding the device to the list,
> > the logic attempts to bind the device to the driver anyway, as if the
> > device had matched with the driver, which is not correct.
> >
> > If __device_attach_driver() detects that the device in question is not
> > ready to match with a driver on the bus, then it doesn't make sense for
> > the device to attempt to bind with the current driver or continue
> > attempting to match with any of the other drivers on the bus. So, update
> > the logic in __device_attach_driver() to reflect this.
> >
> > If __driver_attach() detects that a driver tried to match with a device
> > that is not ready to match yet, then the driver should not attempt to bind
> > with the device. However, the driver can still attempt to match and bind
> > with other devices on the bus, as drivers can be bound to multiple
> > devices. So, update the logic in __driver_attach() to reflect this.
> >
> > Fixes: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from bus_type.match()")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> > ---
> >   drivers/base/dd.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> >
> > Guenter,
> >
> > Thanks for testing this patch out. Can you please add your "Tested-by"?
> >
> > --Isaac
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 70f79fc71539..90b31fb141a5 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -881,6 +881,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
> >               dev_dbg(dev, "Device match requests probe deferral\n");
> >               dev->can_match = true;
> >               driver_deferred_probe_add(dev);
> > +             /*
> > +              * Device can't match with a driver right now, so don't attempt
> > +              * to match or bind with other drivers on the bus.
> > +              */
> > +             return ret;
> >       } else if (ret < 0) {
> >               dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> >               return ret;
> > @@ -1120,6 +1125,11 @@ static int __driver_attach(struct device *dev, void *data)
> >               dev_dbg(dev, "Device match requests probe deferral\n");
> >               dev->can_match = true;
> >               driver_deferred_probe_add(dev);
> > +             /*
> > +              * Driver could not match with device, but may match with
> > +              * another device on the bus.
> > +              */
> > +             return 0;
> >       } else if (ret < 0) {
> >               dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> >               return ret;
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
