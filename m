Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D4508F05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381394AbiDTSHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiDTSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF73FDA2;
        Wed, 20 Apr 2022 11:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E917F61B36;
        Wed, 20 Apr 2022 18:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA00BC385A0;
        Wed, 20 Apr 2022 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650477864;
        bh=rkAmbVI6aHnLXharGX4h9tblF253CQDYQ3OhidgsHkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05jYBkVDueTF2VelhpNsYB28ihKfDRvOrm/1nvns/1+/N0ROYrXYFjursm2ehTv7w
         zqMcuUeaYN7gtkX5Flg3vktCKGYFQmoaLn+erpBZWBNFCSOdIk9/7HFuvkVCtiIHnO
         48QaSdVwlj6luZWHK7YG3LnPsuAHFZigbXrVN9U4=
Date:   Wed, 20 Apr 2022 20:04:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 03/11] platform/x86/intel/ifs: Create device for Intel
 IFS (In Field Scan)
Message-ID: <YmBLJf8JQkfSQGvA@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-4-tony.luck@intel.com>
 <Yl7npfrVTPFEIivC@kroah.com>
 <CAPcyv4jzscs3Dg4QN0+XHRYdekBeqy1=dRX-mWCj1OXo8jS2vQ@mail.gmail.com>
 <Yl+66oyQhI0AkEDC@kroah.com>
 <YmAmebezoc8m6n2E@agluck-desk3.sc.intel.com>
 <YmBG44t4dYsUl4Aa@kroah.com>
 <578be5d8874f4942a58adf5f64c4e817@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578be5d8874f4942a58adf5f64c4e817@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 05:57:04PM +0000, Luck, Tony wrote:
> >> 	ifs_class = class_create(THIS_MODULE, "intel_ifs");
> >
> > Why do you need a class?  Why not just use a misc device?  Saves you
> > loads of boilerplate code that is sometimes tricky to get correct.
> 
> It didn't feel like a "ton" of boiler plate. Just class_create()/class_destroy()
> for the class itself. And
> 
> 	class_for_each_device(ifs_class, NULL, NULL, ifs_device_unregister);
> 
> to clean up devices on exit (or error cleanup in init()).
> 
> 
> I thought I needed a class to make a directory for my per-test directories to live in:
> 
> $ ls -l /sys/devices/virtual/intel_ifs
> total 0
> drwxr-xr-x 3 root root 0 Apr 20 13:36 ifs0
> drwxr-xr-x 3 root root 0 Apr 20 13:36 ifs1
> 
> Can I do that with a misc device?
> 
> Or is it ok for them all to sit at the top level of /sys/devices/virtual?

How many do you have?

And why is a directory needed for just one tiny driver type?

thanks,

greg k-h
