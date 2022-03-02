Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143A34CAFB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbiCBUaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiCBUa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:30:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696D4CA70C;
        Wed,  2 Mar 2022 12:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646252985; x=1677788985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sDxMd+01s5O5G8NWb6aH17UKo9j/qfU5AprOjkIrVzQ=;
  b=ZQan8mUyTgCJ3I5sLvBsco/jUqTCkgmqylhdM3f8MPeGw66lFdOPtbJJ
   Da+bLWh4IRFFzanb0birS07FRtCMgMri/iC13D7wxhlIruFmvNqe8jPK+
   OFubx9fMj9XO34/IYDWsTf28dqa8fZ7ZAbDPZ4DnYHWO+IDx4S3n9oW19
   8dzVm4AnRFmuDFbZjnsGUPn9JgaS8ojp9fj39NuCyPW9Y7wWZdjKwFizW
   mIdinuKznCfCU5SbQgqxctmsBj21iVyceGrEZkkEzZe9ztpIaf1U6GO+S
   yaVMWj7dMsh2kK/5X7W/rccInITAdnIFvF+Z1Y6pEf1//5Joxfk2OjDR+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278175803"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="278175803"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 12:29:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="630534019"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 12:29:44 -0800
Date:   Wed, 2 Mar 2022 12:29:43 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Message-ID: <Yh/Tt50Y8ubGNwS6@agluck-desk3.sc.intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <1b793ead-a47c-4719-b7b5-cba7d49633f2@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b793ead-a47c-4719-b7b5-cba7d49633f2@www.fastmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:59:59AM -0800, Andy Lutomirski wrote:
> > /sys/devices/system/cpu/ifs/reload
> >   Writing "1" to this file will reload the tests from
> >   /lib/firmware/intel/ifs/{ff-mm-ss}.scan
> 
> IMO this interface is wrong.  /lib/firmware is for firmware (or
> ucode, etc) files that should be provided by a distribution and loaded,
> as needed, by a driver so the hardware can function.  This is not at
> all what IFS does. For IFS, an administrator wants to run a specific
> test, and the test blob is part of the instruction to run the test.
> The distribution should not be involved, and this should work even on
> systems where /lib/firmware is immutable.

"so the hardware can function"

Data center customers want to know which aging systems in their
data centers are not functioning correctly. So this is not just
a random test that people might run when they suspect they have
a problem. It is expected that every core will run this test
periodically (period dependent on paranoia level of the system
owner ... maybe daily ... perhaps even more often).

This is so that the data centre can function.

> 
> So either the blob should be written to a file in sysfs or it should
> be supplied by write or ioctl to a device node.

I don't see the drive to create a new mechanism for the kernel
to load from a file when the firmware loader already exists.

If the problem is just immuatbility of /lib ... then make
an immutable symlink from /lib/firmware/intel/ifs to some
other place in the file system (which is what some OS
vendors already do for microcode).

-Tony
