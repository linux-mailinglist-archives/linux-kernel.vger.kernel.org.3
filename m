Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B044DD4E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiCRGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiCRGsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 492ED196089
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647586056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I3lYvZeJcpFfGGlJYFnn0VDJIi283PypPxo2EohREtU=;
        b=E7vHFeEFosdJ3cEWlgaMewZkbFxA8CoCY52OuTCPfJ8/Xudxp8AHoVRo7ZamSfllZvRXuN
        oEcEzj8uSytSWpYPaOrr5l0YkJJLb2MqZS9tmYu0WMi7O/hZwJ54yQPMJySf7tGQF+kSxG
        Cjdsqzn4H1pIlSXu0uL6C1pb5OxMzrY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-ZMU0HdSXOEyAdzVkb_-0-g-1; Fri, 18 Mar 2022 02:47:35 -0400
X-MC-Unique: ZMU0HdSXOEyAdzVkb_-0-g-1
Received: by mail-lj1-f200.google.com with SMTP id v2-20020a2e9f42000000b00247e9c3f0e1so3099593ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3lYvZeJcpFfGGlJYFnn0VDJIi283PypPxo2EohREtU=;
        b=bh962bZiO45pVzQ9m0YyOAl/NeRT4wHMfTfXC9pNf5TO9W9oVxFFYmYwLuxeth6vIP
         ioJe4j64nNRphoEZMZBzAhxGC1FdEhdLZbwPh16I5nyzwgF2pqQrMhX8FD96Xc3cZY96
         Sf02DUhywShS1LZqLVQvC0a7PP5N4uAp8ylHyf9r93LSiJo9dFnecE5Lg99NEUd86atr
         i0mB6nEffwlVk3t7Mwy0950FHAh2npaTf0vWcBmIaBarMlYES4SeLDzvybdkr7rlyQDV
         kVvNhFJtYkgr6zDvut0E7Oq2rsmtqEDxPFlB1bL6QNE0QHdTVgJ4zncI2/WkPYZqb7Z8
         Ygmg==
X-Gm-Message-State: AOAM530pbw5RdZsLAoJYHGaSOdorVP7UGcrhhnDL/qPXTV2wL7fGiemV
        m5/PyiFFyjjEOyB+fjdWukQ3RDLuJSWkSlSj1tqXQCHjeMNi2lN0w3VasPX5+cURKTpWAcx2vWm
        cajMhI/h7wy8TRHJ4+bqerX39TkFWLs0f2kjYM0n1
X-Received: by 2002:a05:651c:1542:b0:246:36c:8d1f with SMTP id y2-20020a05651c154200b00246036c8d1fmr5344718ljp.311.1647586053354;
        Thu, 17 Mar 2022 23:47:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0I/xHSd8pqwSVkxR1iXkhf+tY1ZEwHylqHNX4opihknbprFolc447b2KSlP6xQEh9ImWdTxXmczEnwgkljXo=
X-Received: by 2002:a05:651c:1542:b0:246:36c:8d1f with SMTP id
 y2-20020a05651c154200b00246036c8d1fmr5344701ljp.311.1647586053120; Thu, 17
 Mar 2022 23:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220317075713.10633-1-hpa@redhat.com> <YjLxFuRXKzg3m9HH@paasikivi.fi.intel.com>
 <CAEth8oHqSS7EsPofmERRB=pmtS8YPP+MeM6fMG6tJT2z_qChxA@mail.gmail.com> <YjL6/wOVjSvZjSZ5@paasikivi.fi.intel.com>
In-Reply-To: <YjL6/wOVjSvZjSZ5@paasikivi.fi.intel.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Fri, 18 Mar 2022 14:47:22 +0800
Message-ID: <CAEth8oES8abPO4p7eFv43PwDXuxeOmg1661YtVvykBPrkagzKg@mail.gmail.com>
Subject: Re: [PATCH v4] staging: media: ipu3: Fix AF x_start position when
 rightmost stripe is used
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans De Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Mar 17, 2022 at 5:10 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Thu, Mar 17, 2022 at 04:53:07PM +0800, Kate Hsuan wrote:
> > Hi Sakari,
> >
> > On Thu, Mar 17, 2022 at 4:28 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > On Thu, Mar 17, 2022 at 03:57:13PM +0800, Kate Hsuan wrote:
> > > > For the AF configuration, if the rightmost stripe is used, the AF scene
> > > > will be at the incorrect location of the sensor.
> > > >
> > > > The AF coordinate may be set to the right part of the sensor. This
> > > > configuration would lead to x_start being greater than the
> > > > down_scaled_stripes offset and the leftmost stripe would be disabled
> > > > and only the rightmost stripe is used to control the AF coordinate. If
> > > > the x_start doesn't perform any adjustments, the AF coordinate will be
> > > > at the wrong place of the sensor since down_scaled_stripes offset
> > > > would be the new zero of the coordinate system.
> > > >
> > > > In this patch, if only the rightmost stripe is used, x_start should
> > > > minus down_scaled_stripes offset to maintain its correctness of AF
> > > > scene coordinate.
> > > >
> > > > Changes in v2:
> > > > 1. Remove the setting of the first stripe.
> > > >
> > > > Changes in v4:
> > > > 1. x_start is estimated based on the method for both stripes are enabled.
> > > > 2. x_end is estimated based on the width.
> > >
> > > Please put the changelog before '---' line. I've removed it from the commit
> > > message this time.
>
> I meant to say after. Then it won't be part of the commit message.

Thank you. I understand :)

>
> > >
> > > --
> > > Sakari Ailus
> > >
> >
> > Okay, I got it.
> >
> > Thank you.
> >
> > --
> > BR,
> > Kate
> >
>
> --
> Sakari Ailus
>


-- 
BR,
Kate

