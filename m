Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46FF567943
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiGEVWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGEVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:22:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855C14037
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657056119; x=1688592119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8prCsjjwtcxisgqVbfhhyvLNe8GZByTgB0MPi1kR0SQ=;
  b=LPMg/c2VxmNRk76vFLSs5cHR0gTgnIzyjLeJRrQusryTTPooHsRWQQE3
   4uUuehHNsMyMojqIQauSZmRK1eeuBAdKo96cF3j91tZXpxJNOersNnU31
   Wk426Tdc1K66Yqk7OiskEyzJUSiMGDpKkbrH6PwmmPixWF8qHc1ghaLsZ
   nws5WFfY6w3fs3gAfon2cUmN83ulDIFrnVK+B/f/C9EHX+6xvasSZA9n7
   Wm7sQYLp8pksCV9myaIKsSfNI7qM0M8bi9P+WYNJs3pWHrgnxhphE5fZc
   GKAIPk90m4VPz7+WrNJHiIAkgE/1LfMG+NIUI8k71iX6EbmjLAuKrHBw5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266540723"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="266540723"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:21:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="620014817"
Received: from yma15-mobl1.amr.corp.intel.com (HELO [10.209.0.58]) ([10.209.0.58])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:21:55 -0700
Message-ID: <74383158-460e-0cd1-94bc-faca5b8175ea@linux.intel.com>
Date:   Tue, 5 Jul 2022 14:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@intel.com>,
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
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <8b6f3f9f-71c8-2b6f-20a3-5e9c259a1b9a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 11:52 AM, Dave Hansen wrote:
> On 7/5/22 11:45, Sathyanarayanan Kuppuswamy wrote:
>> Yes, there are many ways to design this. But I still think IOCTL is a better fit
>> for the request/response kind of use case.
> 
> Are there any other similar ABIs in the kernel?  What kind of mechanism
> do they use?

AMD also plans to add attestation support. It also uses IOCTL approach.

https://patchwork.kernel.org/project/linux-mm/patch/20220307213356.2797205-44-brijesh.singh@amd.com/

SGX is a related feature. It also uses IOCTL approach for enclave provisioning.

arch/x86/kernel/cpu/sgx/ioctl.c

Other examples (not very related) are,

drivers/platform/chrome/cros_ec_chardev.c - It is an embedded controller driver which
has IOCTL support to read memory region from the device.
drivers/s390/crypto/pkey_api.c - It has IOCTL interfaces to read/write/generate crypto
keys.
drivers/crypto/ccp/sev-dev.c - sev_ioctl() has some IOCTL to set/get keys.
drivers/platform/x86/intel_scu_ipcutil.c - Uses IOCTL to read contents of registers.




-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
