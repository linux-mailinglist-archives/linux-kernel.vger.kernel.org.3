Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85074F1BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380960AbiDDVWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380392AbiDDT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:58:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9B2FE42;
        Mon,  4 Apr 2022 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649102196; x=1680638196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qVd2+lCgjElgVwX9Ld2sTZVzh1JVcgMBp6qK+c5LCoo=;
  b=cCdp8jrmCBythpZyyT6LT89aC5fwDremHSG/wm+26i64/4TyA8S+31Cg
   cQtlBlHddCIOlAbrBjUHGwwImYJmVAZOBJbavQWHIxpgKcsQIxaZvOjly
   kx/K7fHyHIVBXOsLm/n1l7fF7UeWC3kLn/+DKcKx/EWCrOrPB/IEFXDKf
   U6EK/YGD/0fatA4/Kkp0vj0w+SZ995FwAflTTZU0IWNi0XfEVPpAHIres
   yMDjhz7TvvK7YL4OeMGw36BXLPibzVsH4Bq3gvtjDsCp+GR1WpxTTwFtL
   vD4yrZAFAafHJIQYhvL5aTVH7Is9eiFlhLYJ3FBOkVZtBW6uUAuAUNx75
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="241183795"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="241183795"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 12:56:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="721773941"
Received: from skokoori-mobl1.amr.corp.intel.com (HELO [10.209.7.74]) ([10.209.7.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 12:56:35 -0700
Message-ID: <aece84e1-2c90-2c18-993a-96f8fed7bb46@linux.intel.com>
Date:   Mon, 4 Apr 2022 12:56:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/6] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
 <054b22e81e88379a5a8459c19e89a335531c1bdd.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
 <8308a830-3096-3f94-4f12-5fd2c290524e@redhat.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <8308a830-3096-3f94-4f12-5fd2c290524e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 4/4/22 3:07 AM, Hans de Goede wrote:
>> +static int __init tdx_attest_init(void)
>> +{
>> +	dma_addr_t handle;
>> +	long ret = 0;
>> +
>> +	mutex_lock(&attestation_lock);
>> +
>> +	ret = misc_register(&tdx_attest_device);
>> +	if (ret) {
>> +		pr_err("misc device registration failed\n");
>> +		mutex_unlock(&attestation_lock);
>> +		return ret;
>> +	}
> Why not do this as the last thing of the probe?

We need misc device reference in dma_alloc_coherent() and
dma_set_coherent_mask() calls. This is the reason for keeping
misc_register() at the beginining of the init function.

> 
> That will avoid the need to unregister this again in all
> the error-exit paths and also fixes a possible deadlock.
> 

Agree. But, unless we create another device locally, I don't
think we can avoid this. Do you prefer this approach?

> Right now you possibly have:
> 
> 1. probe() locks attestation_lock
> 2. probe() registers misc-device
> 3. userspace calls tdx_attest_ioctl
> 4. tdx_attest_ioctl blocks waiting for attestastion_lock
> 5. Something goes wrong in probe, probe calls
>     misc_deregister()
> 6. misc_deregister waits for the ioctl to finish
> 7. deadlock
> 
> I'm not sure about 6, but if 6 does not happen then
> instead we now have tdx_attest_ioctl running
> after the misc_deregister, with tdquote_data and
> tdreport_data as NULL, or pointing to free-ed memory
> leading to various crash scenarios.

Makes sense. But as I have mentioned above, we have reason
for keeping the misc_register() at the begining of the
init function.

One way to avoid this deadlock is to use global initalization
check.

--- a/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
+++ b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
@@ -48,6 +48,8 @@ static void *tdreport_data;
  /* DMA handle used to allocate and free tdquote DMA buffer */
  dma_addr_t tdquote_dma_handle;

+static bool device_initialized;
+
  static void attestation_callback_handler(void)
  {
         complete(&attestation_done);
@@ -60,6 +62,9 @@ static long tdx_attest_ioctl(struct file *file, 
unsigned int cmd,
         struct tdx_gen_quote tdquote_req;
         long ret = 0;

+       if (!device_initialized)
+               return -ENODEV;
+
         mutex_lock(&attestation_lock);

         switch (cmd) {
@@ -191,6 +196,8 @@ static int __init tdx_attest_init(void)

         mutex_unlock(&attestation_lock);

+       device_initialized = true;
+
         pr_debug("module initialization success\n");

         return 0;

Please let me know your comment on above solution.

> 
> TL;DR: you must always delay registering any
> interfaces for userspace until your code is
> ready to deal with userspace calls.
> 
> Regards,
> 
> Hans
> 
> p.s.
> 
> As I mentioned with v1:
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
