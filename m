Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6E4F8E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiDHD5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiDHD5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:57:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BDD555C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649390098; x=1680926098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cgaS9ZvpFeSv+RbYtEAFTm8IymBUs7K6+jgyHaDx9hI=;
  b=ILQhtt8bF3nCaGH5vZZNZn8foMTqra8dnZQy3SI4X39ddEflQzFENPfK
   Mxp3d2JOyr+O9LlEgbO020LPBalMp1+rhPmsA7RsKFojpKP/vKTqatRth
   sr2Dar9o6bOdWmpEEzebMZJC/RfSt5s0hpxO1mErJwKqT3zAvXc3YxWZ9
   wKTiTkMqwTJWsQpl3IRkZC7ePG29YQg1t8MKdrHdWHjUifZkHn17lRbcU
   Ppd0iu6jk8P1xMP190sHLxQp0eN2LlVckL3J/5Rfxs77ehpNmShWZxBEi
   ka0Y220cuZBKgCdv0IdOCCmxSUT2XPmhkquDPl9K+WndHFCsACFl61K9c
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241435240"
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="241435240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 20:54:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="571337373"
Received: from vjcarmax-mobl.amr.corp.intel.com (HELO [10.252.140.177]) ([10.252.140.177])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 20:54:57 -0700
Message-ID: <8d6789ba-85d3-3482-4bbb-3693073bea06@linux.intel.com>
Date:   Thu, 7 Apr 2022 20:54:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] x86/apic: Do apic driver probe for "nosmp" use case
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220406185430.552016-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87mtgxzuzz.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <87mtgxzuzz.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/22 3:50 PM, Thomas Gleixner wrote:
> On Wed, Apr 06 2022 at 18:54, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index b70344bf6600..79b8b521981c 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -1419,22 +1419,22 @@ void __init apic_intr_mode_init(void)
>>   		return;
>>   	case APIC_VIRTUAL_WIRE:
>>   		pr_info("APIC: Switch to virtual wire mode setup\n");
>> -		default_setup_apic_routing();
>>   		break;
>>   	case APIC_VIRTUAL_WIRE_NO_CONFIG:
>>   		pr_info("APIC: Switch to virtual wire mode setup with no configuration\n");
>>   		upmode = true;
>> -		default_setup_apic_routing();
>>   		break;
>>   	case APIC_SYMMETRIC_IO:
>>   		pr_info("APIC: Switch to symmetric I/O mode setup\n");
>> -		default_setup_apic_routing();
>>   		break;
>>   	case APIC_SYMMETRIC_IO_NO_ROUTING:
>>   		pr_info("APIC: Switch to symmetric I/O mode setup in no SMP routine\n");
>> +		upmode = true;
> 
> Why? The changelog tells nothing about this change.
> 
> And it's not correct because the APIC configuration is there, otherwise
> __apic_intr_mode_select() would have returned APIC_VIRTUAL_WIRE_NO_CONFIG.

Makes sense. I initially thought since APIC_SYMMETRIC_IO_NO_ROUTING is
only used in non-smp case (setup_max_cpus == 0), we can force
uniprocessor mode. But checking again, my assumption is incorrect. It
will only be used in non MADT/MP case. I will remove the upmode change 
in next version.

> 
> Thanks,
> 
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
