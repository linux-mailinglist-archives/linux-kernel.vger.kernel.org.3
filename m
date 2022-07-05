Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABE5676C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGESpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGESpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:45:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228213F01
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657046711; x=1688582711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uMgPnPBiPWV6CTt7xGqFUzk0sXG5sTlNYiVhBS09tdY=;
  b=akzVuzJWyCdWPkIUIHjc5xeofJjl6jTfCIpqMh5aljqnm0+z2eeI+O2+
   2IJOiQqJhOYUmGRaOqD8OlvNzXxSfTw/eKJ3nQ99FZC2E7gauM+te5kgZ
   Q321qPyo5pyEDm3S2u/z2eEBbTz/AXNeFWxmpiv49Kh5TFDn9VW2xdT+1
   p3GQA+PfY0lUlcdwWUWS2NFZqnJq3rhqLaDLWcC1woKmB4q/fpmnhz+0Q
   P73l9ouecopVqHtu95EKbiWkwybFaWqgdEBL7L0xD/d0oQ5OWiUk3LwJ/
   d4DMsh0VtqMmRHMaNa4FoPCKbue5eQlHumElS5MffMxJZ/p0BEv0BPmO6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="308988058"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="308988058"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="619966919"
Received: from yma15-mobl1.amr.corp.intel.com (HELO [10.209.0.58]) ([10.209.0.58])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:45:08 -0700
Message-ID: <0b5884b8-9240-63b2-ca4c-20c86fd2e8c1@linux.intel.com>
Date:   Tue, 5 Jul 2022 11:45:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
 <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
 <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
 <ca73d2bd-5d40-d385-aeb0-8c04811690ff@linux.intel.com>
 <331abea18e728061979301772a9d0d61543f59fb.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <331abea18e728061979301772a9d0d61543f59fb.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/5/22 5:07 AM, Kai Huang wrote:
> On Thu, 2022-06-30 at 16:50 -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi,
>>
>> On 6/27/22 10:24 AM, Dave Hansen wrote:
>>> On 6/27/22 07:50, Sathyanarayanan Kuppuswamy wrote:
>>
>>>>> Second, how can someone test this code?  It appears that they need to
>>>>> assemble a veritable Rube Goldberg machine.  The least we could do is
>>>>> have a selftest that just calls the ioctl() and makes sure that
>>>>> something halfway sane comes out of it.
>>>>
>>>> My initial submission included a test app. But I removed it later to
>>>> reduce the review load. I thought to submit the test app once feature
>>>> support patches are merged.
>>>>
>>>> https://lore.kernel.org/all/9247fade9db5ae6eb183b2f92fdedb898282376a.1648664666.git.sathyanarayanan.kuppuswamy@intel.com/
>>>>
>>>> If you prefer, I can add it back to the next submission with the latest changes.
>>>
>>> I doubt anyone will ever run a "test app".  Why not just make this a
>>> selftest?
>>
>> Fine with me. I can change it into selftest.
>>
>>>
>>>>>> In such
>>>>>> case, since REPORTDATA is a secret, using sysfs to share it is insecure
>>>>>> compared to sending it via IOCTL.
>>>>>
>>>>> Huh?  How is sysfs "insecure"?
>>>>
>>>> REPORTDATA (input) we pass to the Module call might come from attestation
>>>> service as a per session unique ID.  If it is shared via sysfs, there is
>>>> a possibility for untrusted software to read it and trigger some form of
>>>> reply attack. So in this context, sysfs is insecure compared to IOCTL
>>>> approach. You can find the related discussion in,
>>>>
>>>> https://lore.kernel.org/lkml/b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com/
>>>
>>> I still don't get it.
>>>
>>> How is a 400 sysfs file "insecure"?  This sounds "if the filesystem
>>> permissions are broken" paranoia.  In other words, you're protecting
>>> against a malicious root user.
>>
>> AFAIK, root is not the only user of the attestation interface. General users can
>> also use it (For example, in a use case like pytorch, attestation may be requested
>> by server before passing the training data). So if the permission is not "root
>> only", then other users or application in TD can access the sysfs file to read
>> its contents. 
>>
>> Also, the security concern mentioned is just an additional point. Following are
>> the main reasons for choosing IOCTL over sysfs.
>>
>> 1. Sysfs is generally used for config purposes. Not for request/response kind of
>>    use case (Attestation falls under this category).
>> 2. If we only use sysfs model for GetReport, the design might look like below: 
>>
>>     /sys/kernel/../report/input
>>     /sys/kernel/../report/subtype
>>     /sys/kernel/../report/input_len
>>     /sys/kernel/../report/output
>>     /sys/kernel/../report/output_len
>>     /sys/kernel/../report/status
>>     /sys/kernel/../report/trigger
> 
> I don't think you need all those if using /sysfs approach.  You only need
> 'reportdata' and 'tdreport' to start with (see below my old reply).  
> 
> 	echo <REPORTDATA> > /sys/kernel/coco/tdx/attest/reportdata
> 	cat /sys/kernel/coco/tdx/attest/tdreport
> 
> 	Each "echo <REPORTDATA>" to '/sys/.../reportdata' triggers the driver
> 	to call TDCALL to get the TDREPORT, which is available at 
> 	'/sys/.../tdreport'.
> 
> You can add more (such as subtype) in the future if needed (and I doubt it will
> ever happen) but this doesn't break any existing ABI.  'output/output_len' also
> not needed, kernel can return the report with right size.

I have included *_len files for readability. You can get away with it. But I think
you still need a status file to understand whether TDCALL is successful or not.
Another way is, you can try to write -1 or something to tdreport file if failed. 

Yes, there are many ways to design this. But I still think IOCTL is a better fit
for the request/response kind of use case.

I will let the maintainer decide whether you want to take this route.

> 
> Btw, although the /sysfs may not be as secure as IOCTL -- as you mentioned
> above, other programs with the same permission can get the TD report by reading
> /sysfs and use it as a "reply attack" -- but I am not sure whether such
> "potential reply attack" is a true issue or not.  For instance, typically the
> attestation service should already have established a secure TLS connection with
> TD attestation agent before it provides the 'nonce' (reportdata), and the
> attestation should reject the TD report from other connection, etc.

As I have mentioned, security issue is just an additional point. If this is not
very valid or real, I can remove it.

> 
>>
>> We might need similar files for GetQuote use case as well. IMO, such a design is 
>> more complicated than using IOCTL.
> 
> Using /sysfs for TD report doesn't necessarily mean you must use /sysfs for
> Quote.  I don't think we should mixing them up.  For instance, even if we use
> /dev/xxx for getting TD report, we can use a separate device node for getting
> the Quote:
> 
> 	/dev/tdreport
> 	/dev/tdquote
> 
> I believe there should be pros/cons comparing to using single /dev/attest, but I
> haven't thought this very carefully.

Yes. There are pros and cons for different approaches. But I personally think
using one device and IOCTL ABI model is a simpler design for this use case. AMD also
uses a similar model for their attestation use case.

> 
> 
>>>
>>> In other words, I don't think the ABI here has been well thought out.
>>>
>>> Also, this is basically a:
>>>
>>> 	Inputs:
>>>
>>> 		* nonce
>>> 		* report type
>>>
>>> 	Outputs:
>>>
>>> 		* report
>>>
>>> I have to wonder how hard it would be to have this be:
>>>
>>> 	fd = open("/dev/foo");
>>> 	ioctl(fd, REPORT, type, flags??);
>>> 	write(fd, &inputs, inputs_len);
>>> 	read(fd,  &output, outputs_len);
> 
> It looks like the kernel and userspace still need data structures to agree on
> the input/output data format.  I guess with this approach, we can start with
> what we need now, and if we need more in the future, we define new data
> structures for input and output?
> 
>>>
>>
>> It is not hard to implement it this way. But I don't see it being
>> very different from just using IOCTL. config/{read/write} model is
>> usually preferred for applications in which you have a requirement to do
>> multiple read/writes after one time config (use cases like serial
>> port read, printer write or reading temperature, etc). But in our case
>> we will mostly use it once after every config. 
>>
>> Also, splitting input over IOCTL and write system call will require us
>> to add additional code to store the state.
>>
>> I have attempted a sample implementation (untested) for reference. But I
>> feel our current code is simpler. It handles allocation and input/output
>> validation in one place compared to spreading it across multiple handlers. 
>>
>> struct report_req {
>>         int subtype;
>>         void *reportdata;
>>         int reportdata_len;
>> };
>>
>> struct tdx_attest_req {
>>         unsigned int cmd;
>>         void *data;
>> };
> 
> Is it supposed to be used for Quote too?

Yes. It is to save the command request in kernel during IOCTL request.

> 
> I dislike the idea of mixing up getting TD report and getting Quote (make TD
> report and Quote both as a sub-commands, etc).
> 
> As we have adequately put, the new IOCTLs to support getting Quote isn't even
> mandatory -- we just need some communication channel between TD attestation
> agent and the QE, such as vsock.

Yes. There are other ways to get the Quote. But we have a requirement to support
TDVMCALL based method.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
