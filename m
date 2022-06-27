Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7B55DC82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiF0RZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiF0RZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:25:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AC1274E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656350724; x=1687886724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zoq5pElgt9tcAAKjHN3saguGM3oIB3eDYDn4Qas4q/g=;
  b=h9aLHP+3/MNmLYeZ6OVGqTH67V4vaZH32/X5Vu3Eqh0T92vzudacgirJ
   qQkqSeClGkdqSfYbY5f8Ajz1XzBcEgi+WhL1/GoQ1adXo1vjVL3UDxeDf
   +iMZHq36R8dovKp+8i7Mj0X/I21L0zruvQuK8OHvUUUrAKIPwG6yZLu0k
   8DSPAUTS3VcobwVuXbmygTS08peLkFwe61ele+CyD9+q7Oy8Z+6E25wvq
   JT2zvF/3b9y26JfqUlvmqq7QjhONIbtcG0wXi87dPFRo6J7YDgP3xjBiK
   vFHUS3Ja/IeW2j3mx2dXUGtPboPsmTNK8+BrhngPMWeoI/Re4uZcn7UZa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280274957"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="280274957"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:25:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="732405754"
Received: from jsagoe-mobl1.amr.corp.intel.com (HELO [10.209.12.66]) ([10.209.12.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:25:22 -0700
Message-ID: <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
Date:   Mon, 27 Jun 2022 10:24:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
 <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 07:50, Sathyanarayanan Kuppuswamy wrote:
>> On high-level comment: this whole series is quite agnostic about what is
>> actually attested.  On some level, I guess it doesn't matter.  But, it
>> makes me a bit uneasy.  There needs to be at least *some* kind of claim
>> about that somewhere, preferably a sentence in the cover letter and
>> sentence or two here.
> 
> We are attesting that the given TD Guest is secure and trustworthy, and
> the remote server requesting attestation can safely transfer the secrets.

What is *actually* attested?

> Are you looking for something like the above?

No, I'd like some actual facts, please.  I want key examples of things
visible to an end user that might change that might determine if a guest
is "secure and trustworthy".

Does a kernel command-line parameter change attestation?  How about the
disk image?  The kernel image?  initrd?  Memory *size*?  Devices?

Compare this mechanism to something that exists outside the TDX world.

>> Second, how can someone test this code?  It appears that they need to
>> assemble a veritable Rube Goldberg machine.  The least we could do is
>> have a selftest that just calls the ioctl() and makes sure that
>> something halfway sane comes out of it.
> 
> My initial submission included a test app. But I removed it later to
> reduce the review load. I thought to submit the test app once feature
> support patches are merged.
> 
> https://lore.kernel.org/all/9247fade9db5ae6eb183b2f92fdedb898282376a.1648664666.git.sathyanarayanan.kuppuswamy@intel.com/
> 
> If you prefer, I can add it back to the next submission with the latest changes.

I doubt anyone will ever run a "test app".  Why not just make this a
selftest?

>>> In such
>>> case, since REPORTDATA is a secret, using sysfs to share it is insecure
>>> compared to sending it via IOCTL.
>>
>> Huh?  How is sysfs "insecure"?
> 
> REPORTDATA (input) we pass to the Module call might come from attestation
> service as a per session unique ID.  If it is shared via sysfs, there is
> a possibility for untrusted software to read it and trigger some form of
> reply attack. So in this context, sysfs is insecure compared to IOCTL
> approach. You can find the related discussion in,
> 
> https://lore.kernel.org/lkml/b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com/

I still don't get it.

How is a 400 sysfs file "insecure"?  This sounds "if the filesystem
permissions are broken" paranoia.  In other words, you're protecting
against a malicious root user.

In other words, I don't think the ABI here has been well thought out.

Also, this is basically a:

	Inputs:

		* nonce
		* report type

	Outputs:

		* report

I have to wonder how hard it would be to have this be:

	fd = open("/dev/foo");
	ioctl(fd, REPORT, type, flags??);
	write(fd, &inputs, inputs_len);
	read(fd,  &output, outputs_len);



>>> +	/*
>>> +	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
>>> +	 *
>>> +	 * Get the TDREPORT using REPORTDATA as input. Refer to
>>> +	 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
>>> +	 * Specification for detailed information.
>>> +	 */
>>> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
>>> +				virt_to_phys(reportdata), 0, 0, NULL);
>>
>> One of those 0's is a "Report sub type".  Those bits in the module call
>> are presumably because it won't *always* be zero.  But, if there's ever
>> a new report type, we'll need another user/kernel ABI.  That doesn't
>> seem great.
>>
>> The TDX module spec doesn't even give a name to "sub report type 0".
>> That is not super helpful for deciding what it *means*.
>>
>> Right now, the entire ABI is basically:
>>
>> 	ret = ioctl(TDX_GET_REPORT, &buffer);
>>
>> That _implies_ a ton of stuff:
>>
>> 	1. report sub type 0
>> 	2. a specific input length REPORTDATA
>> 	3. a specific output length
>>
>> I don't want to over-engineer this thing, but it would make a lot of
>> sense to me to feed the ioctl() with something like this:
>>
>> struct tdx_report
>> {
>> 	u8 report_sub_type;
>> 	u64 report_input_data;
>> 	u64 report_input_data_len;
>>
>> 	u64 report_output_data;
>> 	u64 report_output_data_len;
>> }
>>
>> That makes *everything* explicit.  It makes it utterly clear what goes
>> where, *AND* it makes userspace declare it.
> 
> Ok. Parameter to handle subtype makes sense. But regarding the input and
> output length, currently there is no indication in specification that it
> will change and there is no way to pass it in the module call. So do you
> still prefer to add parameters for it?

It seems like a more flexible ABI to me.  What you have here seems to be
a *PURE* passthrough of the module ABI.

>> But, you have:
>>
>>> +/**
>>> + * struct tdx_report_req: Get TDREPORT using REPORTDATA as input.
>>> + *
>>> + * @reportdata : User-defined 64-Byte REPORTDATA to be included into
>>> + *		 TDREPORT. Typically it can be some nonce provided by
>>> + *		 attestation service, so the generated TDREPORT can be
>>> + *		 uniquely verified.
>>> + * @tdreport   : TDREPORT output from TDCALL[TDG.MR.REPORT] of size
>>> + *		 TDX_REPORT_LEN.
>>> + *
>>> + * Used in TDX_CMD_GET_REPORT IOCTL request.
>>> + */
>>> +struct tdx_report_req {
>>> +	union {
>>> +		__u8 reportdata[TDX_REPORTDATA_LEN];
>>> +		__u8 tdreport[TDX_REPORT_LEN];
>>> +	};
>>> +};
>>> +
>>
>> and a bunch of code copying in and out of this structure:
>>
>>> +static long tdx_get_report(void __user *argp)
>>> +{
>>> +	void *reportdata = NULL, *tdreport = NULL;
>> ...
>>> +	/* Copy REPORTDATA from the user buffer */
>>> +	if (copy_from_user(reportdata, argp, TDX_REPORTDATA_LEN)) {
>>> +		ret = -EFAULT;
>>> +		goto out;
>>> +	}
>>
>> But none of that code even bothers to *use* the structure!
> 
> I have created that struct mainly to document the ABI details for the
> userspace clarity (like input and output). Since the length of the input
> and output is defined as macro, it worked fine for driver implementation.
> I am fine with modifying the code to use it. Please let me know if you
> prefer it.

Let's say I'm reviewing kernel code.  I want to know what the ABI of
'reportdata' is.  How do I find it?

Now, imagine that the code is:


	struct tdx_report_req __user *user_rd = argp;
	struct tdx_report_req *kern_rd;
	...

	if (copy_from_user(&kern_rd->reportdata,
			   &user_rd->reportdata,
			   sizeof(kern_rd->reportdata)) {


This tells me a *LOT*.  It says that the user and kernel buffers are the
same ABI, and I'm also much more that the copy matches the data
structure sizes.

We don't put structures in kernel headers just for our health.  We put
them so the kernel can use them.

>> What's with the union?  Are you really just trying to save 64 bytes of
>> space?  Is that worth it?
> 
> Makes sense. I will change it to separate variables.
> 
>> How many of these "drivers" are we going to need which are thinly veiled
>> ioctl()s that are only TDX module call wrappers?

This is actually a really big question.  This code is obviously just
trying to do one thing very narrowly and not thinking about the future
at all.  Can we please consider what the future will be like and try to
*architect* this instead of having the kernel just play a glorified game
of telephone?

