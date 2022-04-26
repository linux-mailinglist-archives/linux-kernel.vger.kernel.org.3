Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD95102F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352762AbiDZQPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbiDZQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:15:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71584996AE;
        Tue, 26 Apr 2022 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650989559; x=1682525559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0RIR7mb999d1172gD+dJU/ULf/cy2ZbhtoDViRJG+bI=;
  b=akxPOGmwj8OoVXM6KLBkU7Yd1qEQIybwgbLqf+n+q0P9ii73iuBJi/RI
   IFYQA/8lM2o/MKVk/EC67g/Yh2TulTZFKH+XMdY0FOX6595t/ZaPp63rc
   V8DjW8Iq/BhmhtniqxEvV+LKiJoszwKNskGI3/JgugA2qliLcuCEtbU0U
   aC8oASDWhubjUFtme/IuM1JgDUYZtJrnwpKaxzPumG91n1aG0hrndIzCH
   ny2zeBwR8/HpquljsnlpjzpF6itkefcYFplO5tl3w6RkYJxbili4uQjCj
   wesIkF01qm0I2IFumxpUmHCR36s4d5b1qXJrB0AHOoQvofDPLHgcaWumz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245552675"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="245552675"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:12:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="617063201"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:12:38 -0700
Date:   Tue, 26 Apr 2022 09:12:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v4 04/10] platform/x86/intel/ifs: Read IFS firmware image
Message-ID: <YmgZ9d54sjKllh6U@agluck-desk3.sc.intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
 <20220422200219.2843823-1-tony.luck@intel.com>
 <20220422200219.2843823-5-tony.luck@intel.com>
 <YmfNVG0qLahv7TzL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmfNVG0qLahv7TzL@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:45:40PM +0200, Greg KH wrote:
> On Fri, Apr 22, 2022 at 01:02:13PM -0700, Tony Luck wrote:
> >  drivers/platform/x86/intel/ifs/Makefile |  2 +-
> >  drivers/platform/x86/intel/ifs/core.c   | 36 ++++++++++++++++++++++++-
> >  drivers/platform/x86/intel/ifs/ifs.h    | 25 +++++++++++++++++
> >  drivers/platform/x86/intel/ifs/load.c   | 28 +++++++++++++++++++

You haven't commented on the source tree location. With the change
to use misc_register() this isn't a "platform" device anymore.

Should I move to "drivers/misc/"? Or is there some better spot that
preseves the detail that this is an x86/intel driver in the path?

> > +static struct ifs_device ifs_devices[] = {
> > +	[IFS_SAF] = {
> > +		.data = {
> > +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> > +		},
> > +		.misc = {
> > +			.name = "intel_ifs_0",
> > +			.nodename = "intel_ifs/0",
> > +			.minor = MISC_DYNAMIC_MINOR,
> > +		},
> > +	},
> > +};
> > +
> > +#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
> 
> Cute way to do this, but I don't see you ever have any more devices
> added to this list in this series.  Did I miss them?

That's in part 11/10 ... I have hardware, so I'm pretty sure that this
is a real thing. Just not ready to post until Intel announces the
details of the new test type.

> If not, why all the overhead and complexity involved here for just a
> single misc device?

It didn't seem like a lot of complexity here. It makes the changes to
this file to add an extra test trivial (just a new name in the "enum"
and a new initializer in ifs_devices[]).

Obviously some more code in load.c and runtest.c to handle the new
test type.

If it really is too much now, I can rip it out from this submission
and add it back when the second test is ready for public view.

-Tony
