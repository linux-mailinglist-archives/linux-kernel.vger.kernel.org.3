Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5B4AD7A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359680AbiBHLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357032AbiBHL2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:28:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CEC03FEF3;
        Tue,  8 Feb 2022 03:28:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD374B81A4A;
        Tue,  8 Feb 2022 11:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2927C004E1;
        Tue,  8 Feb 2022 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644319711;
        bh=S/OkajaK//lhGgvpH8Fw06Nx4ATm9sAyJIS5raQ2bvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0ybZeeHBJKmL5e5GBklD/SFNg2ORM9tj6Uo94eWeAyDaZznYCaSGBMNaoKafm9Rx
         o26RX7aXd2Niprs6HcmE6Xc+k1+wpuIvcCGKjthZfKnrVjNwbyTlR6uWsSW7lg2Sgn
         rVoqZL/xTG2Nwq7Q4um8qFYpeVKRyLKz3iFMsY8o=
Date:   Tue, 8 Feb 2022 12:28:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
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
Subject: Re: [PATCH v7 07/13] peci: Add sysfs interface for PECI bus
Message-ID: <YgJT3bd8Uj8omVYz@kroah.com>
References: <20220202144838.163875-1-iwona.winiarska@intel.com>
 <20220202144838.163875-8-iwona.winiarska@intel.com>
 <YgJPFlr18AmWiTRY@kroah.com>
 <CACPK8Xc0Mo-eAH3bv1uAWxAsPFkLk0gZr9Sx0T0An68Lt2+c+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xc0Mo-eAH3bv1uAWxAsPFkLk0gZr9Sx0T0An68Lt2+c+Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:15:30AM +0000, Joel Stanley wrote:
> On Tue, 8 Feb 2022 at 11:08, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Feb 02, 2022 at 03:48:32PM +0100, Iwona Winiarska wrote:
> > > PECI devices may not be discoverable at the time when PECI controller is
> > > being added (e.g. BMC can boot up when the Host system is still in S5).
> > > Since we currently don't have the capabilities to figure out the Host
> > > system state inside the PECI subsystem itself, we have to rely on
> > > userspace to do it for us.
> > >
> > > In the future, PECI subsystem may be expanded with mechanisms that allow
> > > us to avoid depending on userspace interaction (e.g. CPU presence could
> > > be detected using GPIO, and the information on whether it's discoverable
> > > could be obtained over IPMI).
> > > Unfortunately, those methods may ultimately not be available (support
> > > will vary from platform to platform), which means that we still need
> > > platform independent method triggered by userspace.
> > >
> > > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-peci | 16 +++++
> > >  drivers/peci/Makefile                    |  2 +-
> > >  drivers/peci/core.c                      |  3 +-
> > >  drivers/peci/device.c                    |  1 +
> > >  drivers/peci/internal.h                  |  5 ++
> > >  drivers/peci/sysfs.c                     | 82 ++++++++++++++++++++++++
> > >  6 files changed, 107 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
> > >  create mode 100644 drivers/peci/sysfs.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-peci b/Documentation/ABI/testing/sysfs-bus-peci
> > > new file mode 100644
> > > index 000000000000..56c2b2216bbd
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-peci
> > > @@ -0,0 +1,16 @@
> > > +What:                /sys/bus/peci/rescan
> > > +Date:                July 2021
> > > +KernelVersion:       5.15
> >
> > 5.15 was a long time ago :(
> >
> >
> > Other than this nit, these all look semi-sane to me.  What tree are you
> > wanting these to go through, mine?  If so, can you fix this up (both
> > places in this file) and resend?
> 
> Yes, I recommend Iwona send these through your tree.
> 
> Thanks for taking another look over them. Thanks to Iwona and Intel
> for doing this work.

Can you provide an ack or reviewed-by for them when they are reposted so
I know this?

thanks,

greg k-h
