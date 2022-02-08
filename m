Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1562C4AD7A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356171AbiBHLfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiBHLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:15:44 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E654C03FEC0;
        Tue,  8 Feb 2022 03:15:43 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id bs32so13406196qkb.1;
        Tue, 08 Feb 2022 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5ATNDVY5BBfcfxijhXC/1iC+qNbs6QVAVyFAJglrIA=;
        b=Ch1X4rYMr6HA1Ert5gDxuP0Z4IHG5DzbbwXXVp6sgfJ/CbGFZ34axFqel/jGAus/dC
         1JMkI3rMljd8A3TjT9YDbKHImN6wrC30A6uMP635b2hz9jqCbJeODuA2HtYBPpqQaq34
         g5feFwoun/O0JX5iG88O36A8iojpT6tu43L8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5ATNDVY5BBfcfxijhXC/1iC+qNbs6QVAVyFAJglrIA=;
        b=Pvr8wofz+VWjdIkZF1JAUhXjrJYVkWgw/M1wS4qopKv53eXQaLo+rM/ZThsUFwjw3S
         W7XyDJbAOk3BVQrND3JDO1R91ZWDuHwYwHMM+ad7JMTFmYKIYsosMKHpvCP+k5PZAhQ7
         mRCKC0eC5a8xziITNXg/l5PJinxZ2F1XjZh8P3bWdo3gSQmjjU0ikSaYtuGGzkKtuLoR
         WIuOU/NOdniKxga4Csu01Js0Jq9WxdkpOm3Ryl9SBdGTf7uTlKnCkN+1iy+Eb5UdruQs
         /GdP58n+K8nmqbYzEPjoy2nneKC2aKgIQla9AtqgYujWVuQATFjsftRMd2XVzF70Dteh
         Qfxw==
X-Gm-Message-State: AOAM531uvOv6acVFtXvPrHh3E+DgMajIhGKnbXfPVehtWDHMFOryzBT3
        Eh0IyACJx7WEDWLEw+e0X2toHOCN2gYshlWFb0Y=
X-Google-Smtp-Source: ABdhPJwVhiQ9NYAesN9fwHxFsiR0uMR/oXmTftb8+ojrbzE9gOYzak69ZOdtSmXgJGRvv+Z7ZVyIh3pVPztPCn+MRgY=
X-Received: by 2002:a05:620a:44c7:: with SMTP id y7mr2284975qkp.347.1644318942239;
 Tue, 08 Feb 2022 03:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20220202144838.163875-1-iwona.winiarska@intel.com>
 <20220202144838.163875-8-iwona.winiarska@intel.com> <YgJPFlr18AmWiTRY@kroah.com>
In-Reply-To: <YgJPFlr18AmWiTRY@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Feb 2022 11:15:30 +0000
Message-ID: <CACPK8Xc0Mo-eAH3bv1uAWxAsPFkLk0gZr9Sx0T0An68Lt2+c+Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/13] peci: Add sysfs interface for PECI bus
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 at 11:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 02, 2022 at 03:48:32PM +0100, Iwona Winiarska wrote:
> > PECI devices may not be discoverable at the time when PECI controller is
> > being added (e.g. BMC can boot up when the Host system is still in S5).
> > Since we currently don't have the capabilities to figure out the Host
> > system state inside the PECI subsystem itself, we have to rely on
> > userspace to do it for us.
> >
> > In the future, PECI subsystem may be expanded with mechanisms that allow
> > us to avoid depending on userspace interaction (e.g. CPU presence could
> > be detected using GPIO, and the information on whether it's discoverable
> > could be obtained over IPMI).
> > Unfortunately, those methods may ultimately not be available (support
> > will vary from platform to platform), which means that we still need
> > platform independent method triggered by userspace.
> >
> > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-peci | 16 +++++
> >  drivers/peci/Makefile                    |  2 +-
> >  drivers/peci/core.c                      |  3 +-
> >  drivers/peci/device.c                    |  1 +
> >  drivers/peci/internal.h                  |  5 ++
> >  drivers/peci/sysfs.c                     | 82 ++++++++++++++++++++++++
> >  6 files changed, 107 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
> >  create mode 100644 drivers/peci/sysfs.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-peci b/Documentation/ABI/testing/sysfs-bus-peci
> > new file mode 100644
> > index 000000000000..56c2b2216bbd
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-peci
> > @@ -0,0 +1,16 @@
> > +What:                /sys/bus/peci/rescan
> > +Date:                July 2021
> > +KernelVersion:       5.15
>
> 5.15 was a long time ago :(
>
>
> Other than this nit, these all look semi-sane to me.  What tree are you
> wanting these to go through, mine?  If so, can you fix this up (both
> places in this file) and resend?

Yes, I recommend Iwona send these through your tree.

Thanks for taking another look over them. Thanks to Iwona and Intel
for doing this work.

Cheers,

Joel
