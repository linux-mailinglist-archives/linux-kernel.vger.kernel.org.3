Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7265E51039C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353025AbiDZQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiDZQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A2BE2C;
        Tue, 26 Apr 2022 09:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA6C60ADA;
        Tue, 26 Apr 2022 16:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA9FC385AA;
        Tue, 26 Apr 2022 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650991009;
        bh=9UBlXEL+5EXdMywZqCfNDnB8y2GkRUxHNwf+32JANRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDsksfjnlTd1PwBoyZCNHLOrR5M2shxvAywQ6MsmCSbgi/4tuCzy4/PY6ZUgpGL6s
         WV8b21lEWkARxPfmRX9nTZ6zZyKvmE0ZGxj40sche74Hw8EXNZXKw2ayKfrmEVZUbo
         LpQdEHw9m/KJ3l4WVmHd/Hov+YrJKU/cIveZlPLE=
Date:   Tue, 26 Apr 2022 18:36:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v4 04/10] platform/x86/intel/ifs: Read IFS firmware image
Message-ID: <YmgfnhhCQHWPHxAw@kroah.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
 <20220422200219.2843823-1-tony.luck@intel.com>
 <20220422200219.2843823-5-tony.luck@intel.com>
 <YmfNVG0qLahv7TzL@kroah.com>
 <YmgZ9d54sjKllh6U@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmgZ9d54sjKllh6U@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:12:37AM -0700, Luck, Tony wrote:
> On Tue, Apr 26, 2022 at 12:45:40PM +0200, Greg KH wrote:
> > On Fri, Apr 22, 2022 at 01:02:13PM -0700, Tony Luck wrote:
> > >  drivers/platform/x86/intel/ifs/Makefile |  2 +-
> > >  drivers/platform/x86/intel/ifs/core.c   | 36 ++++++++++++++++++++++++-
> > >  drivers/platform/x86/intel/ifs/ifs.h    | 25 +++++++++++++++++
> > >  drivers/platform/x86/intel/ifs/load.c   | 28 +++++++++++++++++++
> 
> You haven't commented on the source tree location. With the change
> to use misc_register() this isn't a "platform" device anymore.
> 
> Should I move to "drivers/misc/"? Or is there some better spot that
> preseves the detail that this is an x86/intel driver in the path?

There's misc_register() users all over the tree, no need for it to be in
drivers/misc/ at all, especially if this really is a platform device as
this one is.  It's fine here.

> > > +static struct ifs_device ifs_devices[] = {
> > > +	[IFS_SAF] = {
> > > +		.data = {
> > > +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> > > +		},
> > > +		.misc = {
> > > +			.name = "intel_ifs_0",
> > > +			.nodename = "intel_ifs/0",
> > > +			.minor = MISC_DYNAMIC_MINOR,
> > > +		},
> > > +	},
> > > +};
> > > +
> > > +#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
> > 
> > Cute way to do this, but I don't see you ever have any more devices
> > added to this list in this series.  Did I miss them?
> 
> That's in part 11/10 ... I have hardware, so I'm pretty sure that this
> is a real thing. Just not ready to post until Intel announces the
> details of the new test type.

Let's not over-engineer for anything we can not review today please.

> > If not, why all the overhead and complexity involved here for just a
> > single misc device?
> 
> It didn't seem like a lot of complexity here. It makes the changes to
> this file to add an extra test trivial (just a new name in the "enum"
> and a new initializer in ifs_devices[]).
> 
> Obviously some more code in load.c and runtest.c to handle the new
> test type.
> 
> If it really is too much now, I can rip it out from this submission
> and add it back when the second test is ready for public view.

Please do, thanks.

greg k-h
