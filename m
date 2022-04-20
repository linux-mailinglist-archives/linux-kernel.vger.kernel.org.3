Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8834C508C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380311AbiDTPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380211AbiDTPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:52:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED43F40935;
        Wed, 20 Apr 2022 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650469770; x=1682005770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/aT/uybwZGUBqHJAa/El+PMS98PqvKBE4Ru4gZtuJEU=;
  b=GExNJ8skvIFFdUNpazFAI3vU28MWNL9PCFq3pTMqD5SRILw27b1FZZfx
   SvEM2A15n6PJP6u9t9lU5bDVaKSDEyVh17XxlStEF29IH9ZdtXGvZXxgA
   VAYx6PMEJwjrffiUyzuEJ5Wj3jnswTkTG7kvUow9e+SA+9UebvYKt2I+9
   VUxrDfhA7PwdvSgUyWJMG8j/0zJV20WSxonPhtwY7ykculDfBxlUgysZy
   Vrqmcs6DQakZ+VoDKz3waogA17dJSktaFV06JHiCPXUU22RmwxJwp/iSi
   A3jvdOqBc7PXIkUEtxUcKDzJqA+Pop9Nkmdg1mbgJOULl9YALpZVLjZDJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263524837"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="263524837"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:27:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="647705664"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:27:54 -0700
Date:   Wed, 20 Apr 2022 08:27:53 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YmAmebezoc8m6n2E@agluck-desk3.sc.intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-4-tony.luck@intel.com>
 <Yl7npfrVTPFEIivC@kroah.com>
 <CAPcyv4jzscs3Dg4QN0+XHRYdekBeqy1=dRX-mWCj1OXo8jS2vQ@mail.gmail.com>
 <Yl+66oyQhI0AkEDC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+66oyQhI0AkEDC@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:48:58AM +0200, Greg KH wrote:
> Don't write code today for stuff you do not have right now, you all know
> that.  We can always revisit it in the future.

Direction check on the virtual device option. Is this what
you are asking for in "core.c"?

The second test type is happening internally right away ... so I
put in some example code of how it can be added. Upstream submission
will just have the one test that exists today.

Static definition of:

 static struct ifs_data ifs_data[IFS_NUMTESTS];

keeps the code simpler (no need to have code to
cleanup if dynamic allocation of this small structure
fails). But if you feel strongly that all static allocation
is bad, then I can kzallloc() per enumerated test type.

With this change it is no longer a platform driver. So maybe
doesn't belong in drivers/platform/x86/intel/ifs/*

Any thoughts on where I should move it to?

-Tony

---- core.c ---

// SPDX-License-Identifier: GPL-2.0-only
/* Copyright(c) 2022 Intel Corporation. */

#include <linux/module.h>
#include <linux/device.h>
#include <linux/kdev_t.h>
#include <linux/semaphore.h>

#include <asm/cpu_device_id.h>

#include "ifs.h"

enum test_types {
	IFS_SAF,
	IFS_ANOTHER,
	IFS_NUMTESTS
};

static struct class *ifs_class;
static struct ifs_data ifs_data[IFS_NUMTESTS];

#define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
#define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)

#define X86_MATCH(model)				\
	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)

static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
	X86_MATCH(SAPPHIRERAPIDS_X),
	{}
};
MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);

static int ifs_device_unregister(struct device *dev, void *data)
{
	device_unregister(dev);

	return 0;
}

static int __init ifs_init(void)
{
	const struct x86_cpu_id *m;
	u64 ia32_core_caps;
	struct device *dev;
	int ndevices = 0;
	int ret = 0;

	m = x86_match_cpu(ifs_cpu_ids);
	if (!m)
		return -ENODEV;

	if (rdmsrl_safe(MSR_IA32_CORE_CAPS, &ia32_core_caps))
		return -ENODEV;

	ifs_class = class_create(THIS_MODULE, "intel_ifs");
	if (IS_ERR(ifs_class))
		return PTR_ERR(ifs_class);

	ret = ifs_setup_wq();
	if (ret)
		goto class_cleanup;

	if (ia32_core_caps & MSR_IA32_CORE_CAPS_INTEGRITY) {
		dev = device_create_with_groups(ifs_class, NULL, MKDEV(0, 0), &ifs_data[IFS_SAF],
					        plat_ifs_groups, "ifs%d", IFS_SAF);
		if (dev) {
			ndevices++;

			down(&ifs_sem);
			ifs_data[IFS_SAF].loaded = !ifs_load_firmware(dev);
			up(&ifs_sem);
		}
	}

	if (1) { // placeholder to test 2nd test
		dev = device_create_with_groups(ifs_class, NULL, MKDEV(0, 0), &ifs_data[IFS_ANOTHER],
					        plat_ifs_groups, "ifs%d", IFS_ANOTHER);
		if (dev)
			ndevices++;
	}

	if (ndevices)
		goto done;

	ret = -ENODEV;

	class_for_each_device(ifs_class, NULL, NULL, ifs_device_unregister);

class_cleanup:
	class_destroy(ifs_class);
done:
	return ret;
}

static void __exit ifs_exit(void)
{
	class_for_each_device(ifs_class, NULL, NULL, ifs_device_unregister);
	class_destroy(ifs_class);
	ifs_destroy_wq();
}

module_init(ifs_init);
module_exit(ifs_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Intel In Field Scan (IFS) driver");
