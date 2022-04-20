Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53473508ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381307AbiDTRtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376783AbiDTRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:49:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48045AF1;
        Wed, 20 Apr 2022 10:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04ADAB8214A;
        Wed, 20 Apr 2022 17:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEEAC385A1;
        Wed, 20 Apr 2022 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650476774;
        bh=VNWQKUjihxzvmT8J4QtdlcfL7MhOpTqjqSEun+dcpcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8miy1+NmdxTFhZuBJnaYdoE+NSYNjqDMI3zX0zsk0wjqo0BW5z6RGodhEcKM4U+V
         ImjdvMq1y312c/o25yTqFZO4qkQkXnaq1hilcNz/SCTIsIYmXF8cQA3NF7KjGYfy4R
         mfNBf3s8bSYBvMSJefatHzOU36Gc8zbJa9fE4OpA=
Date:   Wed, 20 Apr 2022 19:46:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
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
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 03/11] platform/x86/intel/ifs: Create device for Intel
 IFS (In Field Scan)
Message-ID: <YmBG44t4dYsUl4Aa@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-4-tony.luck@intel.com>
 <Yl7npfrVTPFEIivC@kroah.com>
 <CAPcyv4jzscs3Dg4QN0+XHRYdekBeqy1=dRX-mWCj1OXo8jS2vQ@mail.gmail.com>
 <Yl+66oyQhI0AkEDC@kroah.com>
 <YmAmebezoc8m6n2E@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmAmebezoc8m6n2E@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:27:53AM -0700, Luck, Tony wrote:
> On Wed, Apr 20, 2022 at 09:48:58AM +0200, Greg KH wrote:
> > Don't write code today for stuff you do not have right now, you all know
> > that.  We can always revisit it in the future.
> 
> Direction check on the virtual device option. Is this what
> you are asking for in "core.c"?
> 
> The second test type is happening internally right away ... so I
> put in some example code of how it can be added. Upstream submission
> will just have the one test that exists today.
> 
> Static definition of:
> 
>  static struct ifs_data ifs_data[IFS_NUMTESTS];
> 
> keeps the code simpler (no need to have code to
> cleanup if dynamic allocation of this small structure
> fails). But if you feel strongly that all static allocation
> is bad, then I can kzallloc() per enumerated test type.
> 
> With this change it is no longer a platform driver. So maybe
> doesn't belong in drivers/platform/x86/intel/ifs/*
> 
> Any thoughts on where I should move it to?
> 
> -Tony
> 
> ---- core.c ---
> 
> // SPDX-License-Identifier: GPL-2.0-only
> /* Copyright(c) 2022 Intel Corporation. */
> 
> #include <linux/module.h>
> #include <linux/device.h>
> #include <linux/kdev_t.h>
> #include <linux/semaphore.h>
> 
> #include <asm/cpu_device_id.h>
> 
> #include "ifs.h"
> 
> enum test_types {
> 	IFS_SAF,
> 	IFS_ANOTHER,
> 	IFS_NUMTESTS
> };
> 
> static struct class *ifs_class;
> static struct ifs_data ifs_data[IFS_NUMTESTS];
> 
> #define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
> #define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
> 
> #define X86_MATCH(model)				\
> 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
> 		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
> 
> static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> 	X86_MATCH(SAPPHIRERAPIDS_X),
> 	{}
> };
> MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
> 
> static int ifs_device_unregister(struct device *dev, void *data)
> {
> 	device_unregister(dev);
> 
> 	return 0;
> }
> 
> static int __init ifs_init(void)
> {
> 	const struct x86_cpu_id *m;
> 	u64 ia32_core_caps;
> 	struct device *dev;
> 	int ndevices = 0;
> 	int ret = 0;
> 
> 	m = x86_match_cpu(ifs_cpu_ids);
> 	if (!m)
> 		return -ENODEV;
> 
> 	if (rdmsrl_safe(MSR_IA32_CORE_CAPS, &ia32_core_caps))
> 		return -ENODEV;
> 
> 	ifs_class = class_create(THIS_MODULE, "intel_ifs");

Why do you need a class?  Why not just use a misc device?  Saves you
loads of boilerplate code that is sometimes tricky to get correct.

thanks,

greg k-h
