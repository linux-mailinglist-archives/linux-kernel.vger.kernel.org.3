Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C997578DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiGRWwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiGRWwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:52:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41A32ECC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658184723; x=1689720723;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Ppc0WMgEoRli+1vb5q9D23cP9I5d5tmVloP4wivrBe4=;
  b=DmO/zfMF0iThneRyonbqlGLny5S0PI6wU+BPYDGyDYmhgRj75nkERPZz
   iuhVSiV9/Tn3E5X2jiEjUN2Cx5BjBR+Wa49VBKZz8c5Ebzreg401VbIfS
   mKPRUHOpghW6BF/qQaOckyu+Gc0Y0WTyqBE1RSOa0AZXb0FXfuet88L6g
   aHHVEf4J7XnjaRHKFwSPF2Kxdkw6ZlfaLUeohisEuTNkCnnyLadeRZuMJ
   1GpvCVd+2Ga3jmDdO3AwlYgUciDS6ysYqknQFV1EGK9g2GbLFofy+8DSH
   fOunzdb21P7wY64s596IfzBbMKEBWPbph+5WQRK3k8zJkNJFc2PAl46nh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="348027355"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="348027355"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:52:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="624924161"
Received: from venigall-mobl2.amr.corp.intel.com (HELO [10.209.89.134]) ([10.209.89.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:52:02 -0700
Message-ID: <39dad538-3aed-3b46-3590-d496df5e2884@linux.intel.com>
Date:   Mon, 18 Jul 2022 15:52:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
 <0b5884b8-9240-63b2-ca4c-20c86fd2e8c1@linux.intel.com>
 <8b6f3f9f-71c8-2b6f-20a3-5e9c259a1b9a@intel.com>
 <74383158-460e-0cd1-94bc-faca5b8175ea@linux.intel.com>
 <932869b757b384426ada376cd9791697353c2247.camel@intel.com>
 <e92c570e-29c0-e6d1-88e8-cb6344c01859@linux.intel.com>
In-Reply-To: <e92c570e-29c0-e6d1-88e8-cb6344c01859@linux.intel.com>
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

Hi Dave,

On 7/6/22 3:27 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 7/5/22 3:31 PM, Kai Huang wrote:
>> On Tue, 2022-07-05 at 14:21 -0700, Sathyanarayanan Kuppuswamy wrote:
>>> SGX is a related feature. It also uses IOCTL approach for enclave provisioning.
>>>
>>> arch/x86/kernel/cpu/sgx/ioctl.c
>>
>> SGX isn't a good example here.  The IOCTLs are used to create enclaves, but not
>> for attestation.  SGX attestation relies on enclave itself to get/verify the
>> report, etc, so has no interaction with the kernel.
> 
> If you are looking for an attestation specific example, you can only check the AMD
> code.
> 
> https://patchwork.kernel.org/project/linux-mm/patch/20220307213356.2797205-44-brijesh.singh@amd.com/
> 
> Also, sev_get_attestation_report() in arch/x86/kvm/svm/sev.c also implements attestation
> IOCTL specific to KVM.
> 

As mentioned above, AMD also uses IOCTL model for attestation use case. So you agree
with us using similar approach here? Please let me know your comments.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
