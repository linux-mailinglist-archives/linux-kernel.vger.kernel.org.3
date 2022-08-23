Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BB259EC02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiHWTPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiHWTPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:15:30 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5E78200
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:52:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g14so1408756qto.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aVY44zUJCCDQ7+jE7lahWZfCJK6yRD2rgu0a7TJeScs=;
        b=QPGtAhAC9IPHz4YOehFybYLcoAHltpwZeYqPHM0Aef8Vz+ZD765VxYLhu6SP3ggXE+
         sgo+WBPoZVhj0Xuo4AvreWK6N77yPPSw2kS68dqP1X+JgbttRrQ7XcTBVuZ29H2ajhqb
         uZ7q4rSRSjBMa+uuLEWw224WUWt1jLNhjcC4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aVY44zUJCCDQ7+jE7lahWZfCJK6yRD2rgu0a7TJeScs=;
        b=VaAaD5bieWSdia42V4dehNHiCVXgu1PgnpBRwy3Yx1fBCkVCwAxfLvoZm3KZbqSNik
         IaZrJzCYAs5SCtSdF3EcKQpg7f4KrX+xGRlrj6NtNBpnHIYUk4M7JCOds83+5N50q4zu
         JbBYsxr0vuljZZ0cB4LIjudVgOkD+J6h6w4B+hSXCtSMvJ3dtRsOBOhIPY6Q9plyfl0Z
         jUkPtnnDHGyQQDCZBi6Bq0wXXMSeQrzkesv82OiReY23KIR4oEPWgnsUqaru7f2r9Il/
         aFuQYKhIqMnodzx6AUuRgc2KxSDy/vVkbeBmHzfyYNaD73MnL1352ZbbtGB0yRqrY4rf
         8l0Q==
X-Gm-Message-State: ACgBeo1ojiW4N09ZzhU8G/ODJKl6BlvAZ2v1WOKJUQSvyHrQtGlJrBjZ
        MPYzli9satTG47MECmjS/YPyEjRz/LVnFkVfk8mBUQ==
X-Google-Smtp-Source: AA6agR5k2ANBaD6tQI8kPLr5fMj3MFS9ARNHhCcTviM5G2mWb7zBc16KvcPvRdNRxlf/qtdj8rA/YTXLchgXYZpx/Cw=
X-Received: by 2002:a05:622a:15d6:b0:344:6a92:d8ca with SMTP id
 d22-20020a05622a15d600b003446a92d8camr20589533qty.540.1661277171274; Tue, 23
 Aug 2022 10:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-4-pmalani@chromium.org> <YwRa/QxA/RRtxU3P@google.com> <YwSNCFt48Q9Eo02I@kuha.fi.intel.com>
In-Reply-To: <YwSNCFt48Q9Eo02I@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 23 Aug 2022 10:52:39 -0700
Message-ID: <CACeCKae8YYQUk0dKKbuq-S-3D4=rPFHyjwgK7b55q_T=u9QjLw@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Stash port driver info
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reviews folks.

On Tue, Aug 23, 2022 at 1:17 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Aug 23, 2022 at 04:43:41AM +0000, Tzung-Bi Shih wrote:
> > On Fri, Aug 19, 2022 at 07:08:04PM +0000, Prashant Malani wrote:
> > > Stash port number and a pointer to the driver-specific struct in the
> > > local Type-C port struct.
> > >
> > > These can be useful to the port driver to figure out how to communicate
> > > with the ChromeOS EC when an altmode driver related callback is invoked
> > > from the Type-C class code.
> >
> > The patch looks good to me.  But I would suggest to send it in later series
> > that uses the driver-specific struct (e.g. in altmode driver related callbacks)
> > to make the usage clear.
>
> I agree.

Ok. I will resend this along with the alt mode series.

BR,

-Prashant
