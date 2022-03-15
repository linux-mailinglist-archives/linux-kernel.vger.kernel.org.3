Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C818E4D9560
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiCOHgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiCOHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7384B1C0;
        Tue, 15 Mar 2022 00:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2852613DC;
        Tue, 15 Mar 2022 07:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BA6C340E8;
        Tue, 15 Mar 2022 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647329693;
        bh=9t5nbjS6o46IYV0HqycSY7vUg/zpQpjyLn2xTnP5TPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/OKLCXN+zqRQwxpMuvhRoVL7KZucbSVV/Qg665/NCRsHNj7b/kZNMB1x/9ARSknA
         hS7mtBLvMgnVqF1frARHwFl5GT7PUmPkkgIjWBW9HMcoa3rJLRFvOdSBD02WE32FJV
         d+fkNpzTwsZUws600ExqZVL7xWS7HUpDjs2znJn0=
Date:   Tue, 15 Mar 2022 08:34:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, andriy.shevchenko@linux.intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Message-ID: <YjBBmEjbIaqTbVt+@kroah.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com>
 <Yh5+om/Nr06V0+Qj@kroah.com>
 <Yi/Lb5laEki0JHft@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi/Lb5laEki0JHft@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 04:10:39PM -0700, Luck, Tony wrote:
> On Tue, Mar 01, 2022 at 09:14:26PM +0100, Greg KH wrote:
> > On Tue, Mar 01, 2022 at 09:10:20PM +0100, Greg KH wrote:
> > > On Tue, Mar 01, 2022 at 11:54:47AM -0800, Jithu Joseph wrote:
> > > > Note to Maintainers:
> > > > Requesting x86 Maintainers to take a look at patch01 as it
> > > > touches arch/x86 portion of the kernel. Also would like to guide them
> > > > to patch07 which sets up hotplug notifiers and creates kthreads.
> > > > 
> > > > Patch 2/10 - Adds Documentation. Requesting Documentation maintainer to review it.
> > > > 
> > > > Requesting Greg KH to review the sysfs changes added by patch08.
> > > 
> > > "RFC" means you are not comfortable submitting the changes yet, so you
> > > don't need my review at this point in time.  Become confident in your
> > > changes before asking for others to review the code please.
> > 
> > Hint, it needs work, sysfs_emit() for one thing, lack of reference
> > counting on your cpu objects is another...
> 
> Greg,
> 
> Thanks for the comments. They triggered a bunch of internal
> re-thinking of the interface.  One idea that has some traction
> (Credit/Blame: Dan Williams) is to:

First off, I did not pay attention to this thread at all, given that the
very basics of this patch series had such obvious problems.  I only saw
the contents, not the context in which you wanted to make these changes.

So I have no real thoughts as to what your design should be, as I have
no idea what it is you even want to accomplish at all.

That being said, I do have one comment:

> 1) Don't put anything in /sys/devices/system/cpu/*
> 2) Driver creates some info/control files in its own
>    corner of /sys/devices/.../ifs
> 3) No per-cpu files ... run a test with:
>    # echo ${cpu} > /sys/devices/.../ifs/run_test
> 4) No test result files.
>    When tests complete they report using uevents
> 
> Using uevent to report means that we can easily have
> mutiple parts to the result (pass/fail/incomplete status, as well
> as diagnostic details about the reason for the failure,
> or why the test was not completed).
> 
> This seems a novel use of uevent ... is it OK, or is is abuse?

Don't create "novel" uses of uevents.  They are there to express a
change in state of a device so that userspace can then go and do
something with that information.  If that pattern fits here, wonderful.

I doubt you can report "test results" via a uevent in a way that the
current uevent states and messages would properly convey, but hey, maybe
I'm wrong.

good luck!

greg k-h
