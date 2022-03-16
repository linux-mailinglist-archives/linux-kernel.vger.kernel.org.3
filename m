Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B224DBB55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351264AbiCPXtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiCPXs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:48:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F971ADB7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647474464; x=1679010464;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=a22VnsJwbTMqoeBLYxaiCYSdCmcibqRCMdIjApoGDCs=;
  b=i1TotBV4i/p0lW37OMSaOAVIJPMfcIRAC9ax1x7ZJVKK2EuoAdwDs31e
   dRwE6Un7oBEmCpt7GBm0rPIS6OVwMPRxesn9E/3cd+4MAMLf5Q6FnjGE7
   FoUaRsAPRlZM1iCjxrWnUOZ1hVTVV8P2yIJc9Ledamkm6QwyhV2P/DUYd
   vGKZCmonfN4yrESN1qhsLmxjdI7KZPT8/ilAW/yoxfHIiD8XyvKRy1eHB
   kT1HBjerXe6tdFn2+xHrh89EG0KCoYgFm752hqDE1HZSNRS/GfwNIDBOD
   An3s78iEptvTreHaxXJ8wdy4R5Z4LR6zTmNbLS1wp2DIBa2KD3Z9lEdWg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256468914"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256468914"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:47:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="513225743"
Received: from pwblakex-mobl1.amr.corp.intel.com (HELO [10.212.129.47]) ([10.212.129.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:47:33 -0700
Message-ID: <9f1aea6e-29ad-33e0-8ec8-c112956491b6@intel.com>
Date:   Wed, 16 Mar 2022 16:47:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-22-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv6 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
In-Reply-To: <20220316020856.24435-22-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 19:08, Kirill A. Shutemov wrote:
> +	 * The value of apic_id and wakeup_vector has to be set before updating
> +	 * the wakeup command. To let compiler preserve order of writes, use
> +	 * smp_store_release.
> +	 */

Yeah, but that's not what's written:

> +	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
> +	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> +	smp_store_release(&acpi_mp_wake_mailbox->command,
> +			  ACPI_MP_WAKE_COMMAND_WAKEUP);

That says that the write to ->apic_id has to happen before the write to
->wakeup_vector which has to happen before the write to ->command.  What
you have here *works*, but it doesn't match the comment.

If the problem were the compiler alone, I think three WRITE_ONCE()'s
would also suffice.  (Hint: WRITE_ONCE() is insufficient).

I _think_ this will do:

	acpi_mp_wake_mailbox->apic_id 	    = apicid;
	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
	smp_wmb();
	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_CO...);

But it's the end of the day and I'm sending this out under duress, so
please double-check my logic.

Also, in all practicality, the WRITE_ONCE() isn't going to do much.
->command is 2 bytes and even the stupidest compiler isn't going to
break that up.  The compiler also fundamentally understands the ordering
between this ->command write and the below:

	READ_ONCE(acpi_mp_wake_mailbox->command).

The READ_ONCE() will also ensure that *it* goes out to memory.  *But*,
the WRITE_ONCE() does make it very clear what is supposed to happen.
