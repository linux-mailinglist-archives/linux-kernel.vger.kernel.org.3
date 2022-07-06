Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A760856954B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiGFW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiGFW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:27:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825B2B1B4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657146460; x=1688682460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RVLT8rJ9x5ZWWb04/HzX/gD4RqrjVQt6kKfYwghXiqs=;
  b=FjI7s9B7dtHaO23GCNJhMRFlu6lxitZ4ybhraff3bgfezLeMBR5Xf1YN
   VSq7QYocysGL3WGYVxh9zA/cq7x2xttfZOLb8vW7uWlUHv4VKz76tUZwp
   mdQN7m8SXCrnd95cc+u7h3o8msOcGfPJafL8pe5pRNvVp29E3baOMACbT
   8FQubxHATqKlUs8CDS0X2WPE2k0N8OdNAIwGhby0oIcqfczAfdSg7BxGs
   zV4BIcjgHJkSlNHjqfZbtFUJ/f14GCT6D87JGGtGJgYIRWHv0gDaLRzpa
   0P+2FhejOedgPt5ZuVFPc1xrjPUyq+OrC8UNAjGoHd0JT2dLN/IeasBQe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281430224"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="281430224"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 15:27:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="920351252"
Received: from leejust1-mobl.amr.corp.intel.com (HELO [10.212.160.225]) ([10.212.160.225])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 15:27:39 -0700
Message-ID: <e92c570e-29c0-e6d1-88e8-cb6344c01859@linux.intel.com>
Date:   Wed, 6 Jul 2022 15:27:39 -0700
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
 <0b5884b8-9240-63b2-ca4c-20c86fd2e8c1@linux.intel.com>
 <8b6f3f9f-71c8-2b6f-20a3-5e9c259a1b9a@intel.com>
 <74383158-460e-0cd1-94bc-faca5b8175ea@linux.intel.com>
 <932869b757b384426ada376cd9791697353c2247.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <932869b757b384426ada376cd9791697353c2247.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 3:31 PM, Kai Huang wrote:
> On Tue, 2022-07-05 at 14:21 -0700, Sathyanarayanan Kuppuswamy wrote:
>> SGX is a related feature. It also uses IOCTL approach for enclave provisioning.
>>
>> arch/x86/kernel/cpu/sgx/ioctl.c
> 
> SGX isn't a good example here.  The IOCTLs are used to create enclaves, but not
> for attestation.  SGX attestation relies on enclave itself to get/verify the
> report, etc, so has no interaction with the kernel.

If you are looking for an attestation specific example, you can only check the AMD
code.

https://patchwork.kernel.org/project/linux-mm/patch/20220307213356.2797205-44-brijesh.singh@amd.com/

Also, sev_get_attestation_report() in arch/x86/kvm/svm/sev.c also implements attestation
IOCTL specific to KVM.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
