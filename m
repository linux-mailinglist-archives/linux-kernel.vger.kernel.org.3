Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A675584541
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiG1Ryv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1Ryr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:54:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29E74CE9;
        Thu, 28 Jul 2022 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659030886; x=1690566886;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=JsCihHwGNelzEytHVWS5kY7iC8ruf5PuejZHsP3vb04=;
  b=SGFIZ99v3nOJJ0VR8q9S0V/b05U3LmsdqYSjId3gW0ajM3WiLwXW2DbR
   ssDXaDiPRI73C3MpBDMY/3HyGURWPNPmDd1vJ18G2GTohEMpaOmXlvRIv
   fl3AT9a45pwiXdINpRNRgCcb/6GzXqwg3uI8Q5+uBE/NxG9613B23zP9/
   268KKo2nwdZAwsKzUJBXhzXyKQNq+Hw6zIvO90K+7hePgcaWda7M5Nrlp
   mfZu1kjE/7UUdJsB5iRK6m6VkQc1c9wNl+MRoCggLpsPSsPYNOcNO8o63
   kDFF96IRs9hZitMvw3ei7KCFOXQOJD1Ri18KwDso53mRX4xiVTNE4SW+N
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="268342962"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="268342962"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 10:54:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="576577269"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.212.82.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 28 Jul 2022 10:54:44 -0700
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
 <op.1pwcs8btwjvjmi@hhuan26-mobl1.mshome.net>
 <4c614defad8e9ce2bccce8a062600212e4978113.camel@intel.com>
 <op.1pw6lhz8wjvjmi@hhuan26-mobl1.mshome.net>
 <c99078bf036b5bb175dd4c173790a90b77c6ef72.camel@intel.com>
Date:   Thu, 28 Jul 2022 12:54:40 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1p02pepwwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <c99078bf036b5bb175dd4c173790a90b77c6ef72.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 16:21:53 -0500, Kai Huang <kai.huang@intel.com> wrote:

> On Tue, 2022-07-26 at 10:28 -0500, Haitao Huang wrote:
>> On Tue, 26 Jul 2022 05:47:14 -0500, Kai Huang <kai.huang@intel.com>  
>> wrote:
>>
>> > On Tue, 2022-07-26 at 00:10 -0500, Haitao Huang wrote:
>> > > On Mon, 25 Jul 2022 05:36:17 -0500, Kai Huang <kai.huang@intel.com>
>> > > wrote:
>> > >
>> > > > On Fri, 2022-07-22 at 08:21 -0700, Dave Hansen wrote:
>> > > > > On 7/22/22 06:26, Kai Huang wrote:
>> > > > > > Did a quick look at the spec.  It appears ENCLU[EDECCSSA]  
>> should
>> > > be
>> > > > > used
>> > > > > > together with AEX-notify.  So besides advertising the new
>> > > > > > SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we  
>> should
>> > > > > also
>> > > > > > advertise the ENCLU[EDECCSSA] support in guest's CPUID, like  
>> below
>> > > > > (untested)?
>> > > > >
>> > > > > Sounds like a great follow-on patch!  It doesn't seem truly
>> > > functionally
>> > > > > required from the spec:
>> > > > >
>> > > > > > EDECCSSA is a new Intel SGX user leaf function
>> > > > > > (ENCLU[EDECCSSA]) that can facilitate AEX notification  
>> handling...
>> > > > >
>> > > > > If that's wrong or imprecise, I'd love to hear more about it and
>> > > also
>> > > > > about how the spec will be updated.
>> > > > >
>> > > >
>> > > > They are enumerated separately, but looks in practice the notify
>> > > handler
>> > > > will
>> > > > use it to switch back to the correct/targeted CSSA to continue to  
>> run
>> > > > normally
>> > > > after handling the exit notify.  This is my understanding of the
>> > > > "facilitate"
>> > > > mean in the spec.
>> > > >
>> > > > Btw, in real hardware I think the two should come together,  
>> meaning no
>> > > > real
>> > > > hardware will only support one.
>> > > >
>> > > > Haitao, could you give us more information?
>> > > >
>> > > You are right. They are enumerated separately and HW should come  
>> with
>> > > both
>> > > or neither.
>> > > My understanding it is also possible for enclaves choose not to  
>> receive
>> > > AEX notify
>> > > but still use EDECCSSA.
>> > >
>> >
>> > What is the use case of using EDECCSSA w/o using AEX notify?
>> > If I understand correctly EDECCSSA effectively switches to another
>> > thread (using
>> > the previous SSA, which is the context of another TCS thread if I
>> > understand
>> > correctly).  Won't this cause problem?
>>
>> No. Decrementing CSSA is equivalent to popping stack frames, not  
>> switching
>> threads.
>> In some cases such as so-called "first stage" exception handling, one
>> could pop CSSA back to the previous after resetting CPU context and  
>> stack
>> frame appropriate to the "second stage" or "real" exception handling
>> routine, then jump to the handler directly. This could improve exception
>> handling performance by saving an EEXIT/ERESUME trip.
>>
>>
>
> Looking at the AEX-notify spec again, EDECCSSA does below:
>
> (* At this point, the instruction is guaranteed to complete *)
> CR_TCS_PA.CSSA := CR_TCS_PA.CSSA - 1;
> CR_GPR_PA := Physical_Address(DS:TMP_GPR);
>
> It doens't reset the RIP to CR_GPA_PA.RIP so looks yes you are right.   
> It only
> "popping the stack frame" but doesn't switch thread.
>
> But the pseudo code of EDECCSSA only updates the CR_TCS_PA and CR_GPR_PA
> registers (forget about XSAVE not), but doesn't manually updating the  
> actual CPU
> registers such as GPRs.  Are the actual CPU registers updated  
> automatically when
> CR_xx are updated?
>
No, the enclave code is supposed to do that. Here is are a few more  
details on the flow I mentioned.

On any AEX event, CPU saves states including GPR/XSave into SSA[0]. When  
AEX-notify is turned off, for enclaves to handle exceptions occurred  
inside enclave, user space must do EENTER with the same TCS on which the  
exception occurred. EENTER would give a clean slate of GPR and SSA[1]  
becomes active for next AEX. It's enclave's responsibility to save  
GPR/XSave states in SSA[0] to some place (e.g., stack), then EDECCSSA,   
then jump to the "second stage" handler. (Note now SSA[0] is reactivated  
and ready if another AEX occurs). The second stage handler then fixes the  
situation that caused the original AEX, restore CPU context from the saved  
SSA[0] states, jump back to original place where exception happened.
