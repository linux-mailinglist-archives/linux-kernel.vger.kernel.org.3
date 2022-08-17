Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC905597399
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiHQQFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiHQQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:05:15 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B8DFDA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:04:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-33387bf0c4aso138215267b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i6paBFGBWzxKX2pJffOjWDghTkcVcT2QwPiGdTfZzZw=;
        b=pFju4+cgecb+7nzXxtJfDFJTBEmSFx1WBUSqHs+X+u0mvTvjh2PtlDwGgfcJNQdgdY
         BfCM/+2xseoWg9tqub1kfPnDpYXixSzX3QiFNW0xz3sa+0G4g2yfqNMqiXPGYVIOTCRw
         UNGnug1QrOs5ryom3oYOP8Bp+EmkDArR+4p1FsyTS6EJFZ/IJ4KOl1GUlyxEETEM/AVy
         d0fmtfxFoALcbSj8HwgBmJxJOcEBokjqGn2YJnbpIDao8WDG8BfpRLYCFnCPa7AkRZEn
         kXDVZt+KNhylvc48myX/S2nySbTfJjp09PjDPn7DP1NQcrmqTi6KpdYtir/12VMgaf3P
         kiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i6paBFGBWzxKX2pJffOjWDghTkcVcT2QwPiGdTfZzZw=;
        b=SNej+5VvWEq5yAtUABCLlyfltGPRw4wX5e1rWqaYH9eoEV+PKIYaVRVyz8wkBOtwpT
         3KU5SfzqMFCwbg28gHwOVYBLFob1bgUwfR7Pp/oK+iOkTuq8qsLsgtmnbKwAV8QhxweR
         1joXuUCcznCIDw9ncGDug6KssYp6ePoBKDdJ9HXivNNxOI3eJAhxlgna6hj47bWA9v7r
         iCsjeK5YYrq1EOjw6yr739x0RWVUow4PqWhaDBkdfsERzK1tnoqfwTrLRdBuGSDVXRsN
         Ue6172glCgxx8q8wXEECU3S4+fZJ5Vka5qi8TlFaaeytBbohWGs3V5/3ipGeZEBqvlMD
         B0yg==
X-Gm-Message-State: ACgBeo1MfMsLdmd9Uy8+KQVa377K+eihIzV4WqHkzbmT1tOYyZhaU/hg
        j9S6+Zm+ZCHrmrvrHnfs7rX5kouSsf1DV0qb4nl0Tw==
X-Google-Smtp-Source: AA6agR5ln2ugwHVp4qeFJqZ931PAFnuNukW+KaAmhkMXTkwVzW1CvdUV2yYR8fYD2+p0D7KwXRp96xM0A+iq4P2HGKQ=
X-Received: by 2002:a81:6f43:0:b0:335:9e7e:ad25 with SMTP id
 k64-20020a816f43000000b003359e7ead25mr1912112ywc.518.1660752294638; Wed, 17
 Aug 2022 09:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220803122655.100254-1-nipun.gupta@amd.com> <20220817150542.483291-1-nipun.gupta@amd.com>
 <20220817150542.483291-7-nipun.gupta@amd.com> <Yv0JsOJBfVW1lAOy@kroah.com>
In-Reply-To: <Yv0JsOJBfVW1lAOy@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 17 Aug 2022 09:04:18 -0700
Message-ID: <CAGETcx_CXE6PPOrbJ9uxYPdNn2TPDUtxxTxXGu+A1OJOH0p5Tw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] driver core: add compatible string in sysfs
 for platform devices
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nipun Gupta <nipun.gupta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        cohuck@redhat.com, puneet.gupta@amd.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        Michael.Srba@seznam.cz, mani@kernel.org, yishaih@nvidia.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kvm@vger.kernel.org, okaya@kernel.org,
        harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
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

On Wed, Aug 17, 2022 at 8:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 17, 2022 at 08:35:42PM +0530, Nipun Gupta wrote:
> > This change adds compatible string for the platform based
> > devices.
>
> What exactly is a "compatible string"?

Didn't read the rest of the patches in the series yet, but Nack to
this. This info is already available under:

<device folder>/of_node/compatible for any device in any (or at least
most) bus that was created from an of_node.

Unless compatible is now also in ACPI. In which case, it's probably be
better to have an of_node like symlink.


-Saravana

>
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-platform |  8 +++++++
> >  drivers/base/platform.c                      | 23 ++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
> > index c4dfe7355c2d..d95ff83d768c 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-platform
> > +++ b/Documentation/ABI/testing/sysfs-bus-platform
> > @@ -54,3 +54,11 @@ Description:
> >               Other platform devices use, instead:
> >
> >                       - platform:`driver name`
> > +
> > +What:                /sys/bus/platform/devices/.../compatible
> > +Date:                August 2022
> > +Contact:     Nipun Gupta <nipun.gupta@amd.com>
> > +Description:
> > +             compatible string associated with the device. This is
> > +             a read only and is visible if the device have "compatible"
> > +             property associated with it.
>
> Where is it defined what a compatible property is?
>
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 51bb2289865c..94c33efaa9b8 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1289,10 +1289,25 @@ static ssize_t driver_override_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RW(driver_override);
> >
> > +static ssize_t compatible_show(struct device *dev, struct device_attribute *attr,
> > +                           char *buf)
> > +{
> > +     const char *compat;
> > +     int ret;
> > +
> > +     ret = device_property_read_string(dev, "compatible", &compat);
> > +     if (ret != 0)
> > +             return 0;
>
> Shouldn't you return an error here?
>
> thanks,
>
> greg k-h
