Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6624DAC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354407AbiCPIKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346256AbiCPIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:10:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDAC5E779;
        Wed, 16 Mar 2022 01:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ED88B81A1F;
        Wed, 16 Mar 2022 08:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8213CC340E9;
        Wed, 16 Mar 2022 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647418163;
        bh=9MeOuZ7Yb5TifZzFGIEaV3LSES97K18572IADr0rgLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ds4oKayjlDznyeIMcJbkfh4rTkv1b4It02XA8am1nY113Xy4U/FEyNmAreeBKRikd
         0YzEDewn6u91E4uZxR3Gj4Kcl2amkC0qh4XGWeEWrU+d7UpanofIwKmelRTgMWBcgu
         m0hpfVhCYrZpDtSU52Y4BbaI7lrs8Bl6n+ko7J9k=
Date:   Wed, 16 Mar 2022 09:09:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Message-ID: <YjGbL2HzksucTn0h@kroah.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com>
 <Yh5+om/Nr06V0+Qj@kroah.com>
 <Yi/Lb5laEki0JHft@agluck-desk3.sc.intel.com>
 <YjBBmEjbIaqTbVt+@kroah.com>
 <c4af81bd788e43dda915a1052af0be55@intel.com>
 <YjCwI4N00reBuIqA@kroah.com>
 <de895b9617aa412e95fdd14fcad285fa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de895b9617aa412e95fdd14fcad285fa@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:10:59PM +0000, Luck, Tony wrote:
> > Again, I have no idea what you are doing at all with this driver, nor
> > what you want to do with it.
> >
> > Start over please.
> 
> TL;DR is that silicon ages and some things break that don't have parity/ECC checks.
> So systems start behaving erratically. If you are lucky they crash. If you are less lucky
> they give incorrect results.
> 
> There's a paper (and even a movie 11 minutes) that describe the research by
> Google on this.
> https://sigops.org/s/conferences/hotos/2021/papers/hotos21-s01-hochschild.pdf  
> (https://www.youtube.com/watch?v=QMF3rqhjYuM)    

Both you and Dan are assuming that I actually care about this hardware
and driver enough to read a presentation or watch a video about it.
Sorry, but that's not happening :)

I'm saying these questions as you all need to be asking yourself that,
and figuring out what the proper api is.  That's not my job here.  I was
just pointing out the problems in your original submission that you all
should have caught before sending it out...

good luck!

greg k-h
