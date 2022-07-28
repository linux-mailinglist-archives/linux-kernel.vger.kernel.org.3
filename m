Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA7583F62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiG1M7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiG1M7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EDF48C80;
        Thu, 28 Jul 2022 05:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7403961CF6;
        Thu, 28 Jul 2022 12:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7786AC433D6;
        Thu, 28 Jul 2022 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659013170;
        bh=vgIa+V7WvBgBXcKVZ3AUAM80Vp/ZB7jscd8oWBAMeN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09j5v6BJG/+PU9ZL7/QmhKypyv6Io2hsGY+WhojCxqidkRlgrsyw0F/tbW1cDE63c
         ML/5Ll8eMgaqNvLNGpKRt6MWKYBPicA4nlCa9iiyxddsdRvCkW+1dyuOQp3tDrsmbd
         jLjtyL+4x4i6fKvetm0nmpD9Xo6/Z6zsRoA+jP4Q=
Date:   Thu, 28 Jul 2022 14:59:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Message-ID: <YuKIL4QkC25h6RF8@kroah.com>
References: <20220710160011.995800-1-jithu.joseph@intel.com>
 <YssFjbveghDLNn4N@kroah.com>
 <55368a65-c536-93c7-c501-9f6086e308d2@redhat.com>
 <YuJ8Ah37WAHGTJlV@kroah.com>
 <39b47ca8-1d25-0e60-d326-ad627541fe36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b47ca8-1d25-0e60-d326-ad627541fe36@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 02:52:06PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 7/28/22 14:07, Greg KH wrote:
> > On Thu, Jul 28, 2022 at 01:57:25PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 7/10/22 18:59, Greg KH wrote:
> >>> On Sun, Jul 10, 2022 at 09:00:11AM -0700, Jithu Joseph wrote:
> >>>> Existing implementation limits IFS images to be loaded only from
> >>>> a default file-name /lib/firmware/intel/ifs/ff-mm-ss.scan.
> >>>
> >>> That was by design, why is this suddenly not acceptable?
> >>>
> >>>> But there are situations where there may be multiple scan files
> >>>> that can be run on a particular system stored in /lib/firmware/intel/ifs
> >>>
> >>> Again, this was by design.
> >>>
> >>>> E.g.
> >>>> 1. Because test contents are larger than the memory reserved for IFS by BIOS
> >>>
> >>> What does the BIOS have to do with this?
> >>>
> >>>> 2. To provide increased test coverage
> >>>
> >>> Test coverage of what?
> >>>
> >>>> 3. Custom test files to debug certain specific issues in the field
> >>>
> >>> Why can't you rename the existing file?
> >>>
> >>>> Renaming each of these to ff-mm-ss.scan and then loading might be
> >>>> possible in some environments. But on systems where /lib is read-only
> >>>> this is not a practical solution.
> >>>
> >>> What system puts /lib/ as read-only that you want to have loading
> >>> hardware firmware?  That kind of defeats the security implications of
> >>> having a read-only /lib/, right?
> >>>
> >>>> Modify the semantics of the driver file
> >>>> /sys/devices/virtual/misc/intel_ifs_0/reload such that,
> >>>> it interprets the input as the filename to be loaded.
> >>>
> >>> So you are now going to allow any file to be read from the system, in an
> >>> unknown filesystem namespace, by this driver?
> >>
> >> @Intel folks to me this is the big blocker which needs to be solved before
> >> we can move forward with figuring out how to allow loading multiple
> >> different sets of test patterns through IFS.
> >>
> >> Which in turn is required to remove the broken marking...
> >>
> >> How about echoing a suffix to be appended to the default filename to
> >> the reload attribute? This suffix would then need to be sanity checked
> >> to only contain [a-z][0-9] (we don't want '/' but it seems better to
> >> limit this further) to avoid directory traversal attacks. 
> >>
> >> (and echoing an empty suffix can be used to force reloading the
> >> default test-patterns after a linux-firmware pkg upgrade)
> >>
> >> This way we avoid the allowing user to load an arbitrary file issue.
> >>
> >> Greg, would using a suffix appended to the default filename be
> >> acceptable to you as a solution to solving the load arbitrary
> >> file issue?
> > 
> > Not really, a suffix doesn't protect much at all.
> 
> ?
> 
> Currently the driver will always load:
> 
> /lib/firmware/intel/ifs/%02x-%02x-%02x.scan
> 
> with the "%02x" bits being fixed parts of the CPU model.
> 
> My suggestion is to make it:
> 
> /lib/firmware/intel/ifs/%02x-%02x-%02x%s.scan

Ah, sorry, I skimmed that, you are right, that would be fine.  But still
odd to ever be needed in a real system.

> > This really feels like a "test the product in the factory" type of
> > option that someone seems to want to do without just renaming the
> > firmware file.  Why this is unique from all other firmware file loading
> > in the kernel needs to really be explained here in order to even
> > consider justifying this type of change.
> 
> First of all I really wish some of the Intel folks would elaborate
> more on why multiple test-pattern files are necessary. Ping
> anyone@intel, you have all been very quiet in this thread which
> is not helpful (not helpful at all really).
> 
> Speculating myself as far as I understand IFS is not for factory
> tests but for testing in the fields since big cloud vendors have
> found that sometimes there are hard to catch CPU defects which
> they only find out by running statistics which show that certain
> tasks only crash when run on machine a, socket b, core c.

Who knows, Intel doesn't say so we can't really guess :(

greg k-h
