Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4E355E1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiF0O4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiF0O4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:56:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE9B1704B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656341793; x=1687877793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bGHVaA7Y+W77422JzIddjRuPoKK0dOVQ9IvZwPkfw9k=;
  b=gJVfRCyu1pvsU7iG/kuUB0ZUnDpSVgnq+OJU2hfrO2FgPCynHI/BVFh5
   dLw9U6xW9Es7pjT5wMF3hn3QVyHpTkaO2Ikmlq6ofyRkKH7Zt+3vd/9um
   Uz96gj6P/fOSjQxx+BI5xGlp4Lm3kSFJ50JMzPjhn+Zc6eaLzTasGEet+
   LDhg7zw6k1z3ZriI0YptUIvTpFjPZq+66BnprcOBKitoitFXnly+QSK5g
   TiUs+pKdCLDTIHLFcBmDWlQm+bhBFtKCUiLRflvKaboi3ixlhaoL+nOQK
   rmdBhJcgq2204P4MJObgmguhZYzPZoTI7Qi4qXLDg0ppDIp5iEW5wMfiq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="279009416"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="279009416"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 07:56:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="679608765"
Received: from noraberg-mobl1.amr.corp.intel.com (HELO [10.209.14.29]) ([10.209.14.29])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 07:56:31 -0700
Message-ID: <bceec213-4756-474b-6b91-51266e86c25a@linux.intel.com>
Date:   Mon, 27 Jun 2022 07:56:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        "Yao, Jiewen" <jiewen.yao@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
 <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
 <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
 <MW4PR11MB5872E3B775A680678331D6358CB79@MW4PR11MB5872.namprd11.prod.outlook.com>
 <9c7d99469179340eeecabaf3e9c414fc98900626.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <9c7d99469179340eeecabaf3e9c414fc98900626.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/22 4:21 AM, Kai Huang wrote:
> On Sat, 2022-06-25 at 15:35 +1200, Yao, Jiewen wrote:
>> Thank you, Jun.
>>
>> Yes. I confirmed that we will include below change to GHCI.next spec.
>>
>> ================
>> 3.5 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
>>
>> From: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an interrupt at the requested-interrupt vector into the TD via the posted-interrupt descriptor. "
>>
>> To: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an interrupt at the requested-interrupt vector into the TD VCPU that executed TDG.VP.VMCALL <SetupEventNotifyInterrupt> via the posted-interrupt descriptor. "
>>
> 
> Hi Sathy,
> 
> With this change, I don't think we should use system vector anymore.  Instead,
> we just need one non-migratable IRQ which has a fixed vector on a fixed cpu.
> 

Yes. I will try your suggestion and make necessary changes in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
