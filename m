Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C39580AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 07:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbiGZFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 01:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiGZFKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 01:10:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60052641;
        Mon, 25 Jul 2022 22:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658812210; x=1690348210;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=MgnGplLF04cAZqyABU8ihZqNYjTRRmHtvqP6hGOqXdE=;
  b=JeRvu2T1Cx/uK7X3YkJtmLyF8WdQA1KQIaI71hhPKehpmpV1Fvgkx2W+
   MPWpz/CUxLfMjV7CAnfypwr/SfST4rPpUWPuQxJ9aqZ+bEOAgXAm955jO
   M9gOhTbSGp/la8mquaTzCesmgNAKXdCfGPe8jwMkWeu6Aq5SLZW1iiWJ8
   QJSQTVcPQLigsVqlc1O9jKp1xrKbwHWs0Ap6iSGCKZTvCVoFTTV8FNniq
   s9X4GGCX4t+igyyKxqPQWiKKMXuCHMiElCQsyvgdE/VWIqkuqzYCPOV+f
   1gbA9+AM5uuLUkhPSGPPRRoiSufnERxXR4pydrw5jERDv3quyZqHZZL/x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274728309"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274728309"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 22:10:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="726407284"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.209.167.179])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 25 Jul 2022 22:10:07 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Kai Huang" <kai.huang@intel.com>
Cc:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Sean Christopherson" <seanjc@google.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
 <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
 <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
 <06a9fef8579e880b9b031f03911739d4d902dbe0.camel@intel.com>
Date:   Tue, 26 Jul 2022 00:10:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1pwcs8btwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <06a9fef8579e880b9b031f03911739d4d902dbe0.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 05:36:17 -0500, Kai Huang <kai.huang@intel.com> wrote:

> On Fri, 2022-07-22 at 08:21 -0700, Dave Hansen wrote:
>> On 7/22/22 06:26, Kai Huang wrote:
>> > Did a quick look at the spec.  It appears ENCLU[EDECCSSA] should be  
>> used
>> > together with AEX-notify.  So besides advertising the new
>> > SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we should  
>> also
>> > advertise the ENCLU[EDECCSSA] support in guest's CPUID, like below  
>> (untested)?
>>
>> Sounds like a great follow-on patch!  It doesn't seem truly functionally
>> required from the spec:
>>
>> > EDECCSSA is a new Intel SGX user leaf function
>> > (ENCLU[EDECCSSA]) that can facilitate AEX notification handling...
>>
>> If that's wrong or imprecise, I'd love to hear more about it and also
>> about how the spec will be updated.
>>
>
> They are enumerated separately, but looks in practice the notify handler  
> will
> use it to switch back to the correct/targeted CSSA to continue to run  
> normally
> after handling the exit notify.  This is my understanding of the  
> "facilitate"
> mean in the spec.
>
> Btw, in real hardware I think the two should come together, meaning no  
> real
> hardware will only support one.
>
> Haitao, could you give us more information?
>
You are right. They are enumerated separately and HW should come with both  
or neither.
My understanding it is also possible for enclaves choose not to receive  
AEX notify
but still use EDECCSSA.

Thanks
Haitao
