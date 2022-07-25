Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EBB58070F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiGYWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGYWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:06:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A1BC9F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658786797; x=1690322797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mtQex+tF3nqMKIaJPEdmeV6cujGPvYgLpkJZmv0xAV4=;
  b=GOHiAlfEwhDyJumtJbdMVvr2FRXnNOiH/8jK3K9WJLCmvmitAMXjtOyz
   nUFvATI1FL9MicBntAVnyiDz6sD5nWbKyC+TaBSzBqIhlTVRbZlmNLHlX
   qxRSqS0mBStgu7Mgoy/875Jq970VgcqnNG9W2lS4y3XFgwXZyGbep0o8O
   6gIxH6QUI/H5GIfIjk8caQOZl6Aam5NzEbZgkruQxNEYNHI4pmysefYOJ
   1Hz0sI9gEbtBhSHMctp9Du7nm3ecClCscypIWBh0PhqiOOrKv8aQyBwp0
   HIicK+MbXfBCOGcMO7v2bjNtGCJVIs34uX10RsPdRSaTZ9OTJymh3Tdfl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274671141"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274671141"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 15:06:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575231955"
Received: from mgarner-mobl.amr.corp.intel.com (HELO [10.209.39.177]) ([10.209.39.177])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 15:06:35 -0700
Message-ID: <56e1c722-1378-c59c-73f9-de79b7afce60@linux.intel.com>
Date:   Mon, 25 Jul 2022 15:06:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
 <20220722190524.GA3299911@ls.amr.corp.intel.com>
 <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
 <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
 <4B48A192-8305-4E94-AA0C-10FCE23F424D@intel.com>
 <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
 <1A54F61B-DAD8-45E1-BBB4-42338D9B0917@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1A54F61B-DAD8-45E1-BBB4-42338D9B0917@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 7/25/22 2:56 PM, Nakajima, Jun wrote:
> 
>> On Jul 25, 2022, at 1:23 PM, Hansen, Dave <dave.hansen@intel.com> wrote:
>>
>> On 7/25/22 13:19, Nakajima, Jun wrote:
>>> 3. Need to be available in minimal/early runtime environments,
>>> including pre-boot, e.g. guest BIOS, no user-space yet.
>>
>> Jun, are we talking about the same thing here?  This patch is for a
>> guest userspace -> guest kernel ABI.  This facility is *FOR* userspace.
>> It can't possibly be used before userspace is running.
>>
>> I'm horribly confused.
> 
> I responded to one of Sathya’s questions, especially why we have the GetQuote in GHCI. 
> And the hypervisor needs to implement that anyway because it doesn’t matter (or doesn’t know) whether the TD guest is running in BIOS, the kernel, or userspace. Of course, the facility in this patch is for userspace, but we don’t want to suggest to implement two different GetQuote code paths for guests, depending on the guest state, e.g. in the OS (kernel or userspace) or guest BIOS.

Ok. Since both host and QE need to support GetQuote hypercall to
handle attestation request from the BIOS, QE/host may want to use
the same communication model for requests from the guest user space
as well.

> 
> --- 
> Jun
> 
> 
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
