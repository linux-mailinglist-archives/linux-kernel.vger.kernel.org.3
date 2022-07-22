Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1257E8C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiGVVTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVVTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:19:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B5681496
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658524739; x=1690060739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JNEVeaQpNIkYZAQkbOrI2gpmynzCWz40l3qhi8iEsRE=;
  b=UbMRaaza35Bw5ubQVD7drpUvNxYYG8JUOolBnBM4Z5CO1XRCavYB2Ny8
   355+RDvU02vtpruOJuiPTi/9GfNGjRfGEqq3C6YfGa9KfQLX8PyYNIEJ3
   77LkSDXh+tjlI4F1gXUtUJpWvjc6Nx9wWoEV+8NbkS1l6oUQyOgcETutd
   4HwQTe8BFYnb2UNVe9z7i5USuen2C30NXCCWWEs53MQ1J0Kt2YWXvlA9H
   UzUvVybtNkVWMYn6nPFDovDk31qU/Jr5yFJ2hUMULzcadyHzxNozS1Gie
   mSyUkzgVQ1y8lhuvuVWAXs1l2a/G/GoJVaEuUgK1J4GyFaoWURvguQtgh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267802562"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="267802562"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 14:18:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="574311344"
Received: from atsunori-mobl1.amr.corp.intel.com (HELO [10.251.22.108]) ([10.251.22.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 14:18:58 -0700
Message-ID: <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
Date:   Fri, 22 Jul 2022 14:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org,
        "Nakajima, Jun" <jun.nakajima@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
 <20220722190524.GA3299911@ls.amr.corp.intel.com>
 <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jun

On 7/22/22 12:13 PM, Dave Hansen wrote:
> On 7/22/22 12:05, Isaku Yamahata wrote:
>>> So, the quote portion of this is basically a bidirectional blob sender.
>>>  It's to send a blob between guest userspace to host userspace.
>>>
>>> Do we *REALLY* need specific driver functionality for this?  For
>>> instance, is there no existing virtio device that can send blobs back
>>> and forth?
>> It's virtio-vsock.  If virtio-vsock is available, the communication works.
>> However, some users would like to disable virtio-vsock on their environment for
>> some reasons.  Even virtio at all.  Especially for confidential computing use
>> case.  It's their choice.  It can't be assumed that virtio is available.
>>
>> The goal is VMM-agnostic (but TDX-specific) interface for that.
> 
> You're basically saying that every confidential computing technology
> should have its own host user <-> guest kernel <-> guest user ABI.
> That's insanity.  If we do this, we need *one* interface that says "talk
> to the hypervisor" that's common for all hypervisors and hardware
> vendors, or at least more than *one*.
> 
> We don't need a way to talk to hypervisors for Intel systems and another
> for AMD and yet another on whatever.

For cases where your platform does not want to support or enable the generic
interface (like vsock), isn't it better to have a fallback approach? I am not
saying we should have such an ABI for all cases. But attestation is a must-have
feature for the TDX guest, and we want to support it in all TD guest platforms.
I think the GHCI ABI is added to meet this requirement.

Jun/Isaku, if you are aware of the exact requirement for this hypercall, please
share it. Also let us know your comments on this topic.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
