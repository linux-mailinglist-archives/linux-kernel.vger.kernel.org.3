Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77C3590BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiHLGKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiHLGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:10:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D3A4B2F;
        Thu, 11 Aug 2022 23:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F721B81A6B;
        Fri, 12 Aug 2022 06:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFACC433C1;
        Fri, 12 Aug 2022 06:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660284598;
        bh=8sV3XZOg58DpG6LIkEH130HfyjeZTPgBQd2AwBSjxwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcfHnH9qRK3vponWPY9s9bHFoHxiz60ojylon1FIGI5uXm6pBZPPhra71d3Zxr72F
         vHEDalz9cXMB8o2HAtw/pRHp1H4E5OHxWflCpAxV9sgrtC4NoT2eWyW6C+3ufmKQkJ
         /bptqaQHLnlP9R49xdU2ygOrndH1soH/TsSVBtg4=
Date:   Fri, 12 Aug 2022 08:09:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com, Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] sysfs: Add attribute info for
 /sys/devices/.../coredump_disabled
Message-ID: <YvXusxxBZ+cHvzqz@kroah.com>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
 <bfc5f964d8dadd6378f2da5b3b6ef4bc9fb847c2.camel@sipsolutions.net>
 <YvPbGms7bzFuWTJg@kroah.com>
 <CAGPPCLAV=mnMcteCnqFT5zdbWdZuFQRv6-oxC3qAnLh8_8H61Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGPPCLAV=mnMcteCnqFT5zdbWdZuFQRv6-oxC3qAnLh8_8H61Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 04:21:54PM -0700, Manish Mandlik wrote:
> On Wed, Aug 10, 2022 at 9:21 AM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Aug 10, 2022 at 06:03:37PM +0200, Johannes Berg wrote:
> > > On Wed, 2022-08-10 at 09:00 -0700, Manish Mandlik wrote:
> > > > This patch adds the specification for
> > /sys/devices/.../coredump_disabled
> > > > attribute which allows the userspace to enable/disable devcoredump for
> > a
> > > > particular device and drivers can use it to enable/disable
> > functionality
> > > > accordingly. It is available when the CONFIG_DEV_COREDUMP is enabled
> > and
> > > > driver has implemented the .coredump() callback.
> > > >
> > >
> > > It would be nice to say _why_? What problem does this solve? You could
> > > just create the dump and discard it, instead, for example?
> >
> > Agreed, I do not understand the need for this at all.
> >
> 
> The existing /sys/class/devcoredump/disabled (devcd) switch has two
> limitations - it disables dev_coredump for everyone who's using it;

Which is good and is the design of the thing.

> and
> drivers don't have visibility if devcd is disabled or not, so, the
> dev_coredump API simply lets drivers collect the coredump from a device but
> then later discards it if devcd is disabled.

Why would a driver care?

> Now that there are more subsystems using the base dev_coredump API, having
> a granular control will make it easier to selectively disable dev_coredump
> only for a particular device. For ChromeOS, this is useful to allow drivers
> to develop coredump functionality and deploy it without affecting other
> drivers with stable devcoredump implementations (example, we've had some
> devcoredumps that take 12s to run and we only want to enable it on test
> builds because it has lots of PII). The drivers can use this flag to
> refrain from collecting or triggering coredump when undesirable.

This feels odd.  You have various out-of-tree drivers that take too long
when they crash to make a dump and it causes some unknown issue
elsewhere?

I don't really understand, sorry.

If you need something for development of a system, that's one thing, but
this feels like you are adding fine-grained tweaks that no one in a real
system would ever use.

What is broken with the current system of "on/off" that does not work
for you now?  Why would a normal user only want to turn this on for one
driver and not another?

thanks,

greg k-h
