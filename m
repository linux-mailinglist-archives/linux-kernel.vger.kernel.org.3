Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9350F56A599
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiGGOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiGGOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:38:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D0C530F6F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:38:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F3021063;
        Thu,  7 Jul 2022 07:38:00 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75EC63F66F;
        Thu,  7 Jul 2022 07:37:58 -0700 (PDT)
Message-ID: <4b99cf3c-f40b-cba7-2fa2-b6b311859776@arm.com>
Date:   Thu, 7 Jul 2022 09:37:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/8] arm64: Create cache sysfs directory without ACPI PPTT
 for hardware prefetch control
Content-Language: en-US
To:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>,
        'Sudeep Holla' <sudeep.holla@arm.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
 <20220125071414.811344-6-tarumizu.kohei@fujitsu.com>
 <20220126103614.pcrcuc2kzklkq3xa@bogus>
 <OSBPR01MB2037E92722D372D48F54438E80269@OSBPR01MB2037.jpnprd01.prod.outlook.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <OSBPR01MB2037E92722D372D48F54438E80269@OSBPR01MB2037.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/22 05:56, tarumizu.kohei@fujitsu.com wrote:
>> I am assuming this is ACPI enabled system.
> 
> Yes, it is ACPI enabled system.
> 
>> This looks bit hacky in my opinion. Before I explore better way of adding it, I would
>> like to check if you have explored ways to add PPTT reading these registers from
>> UEFI/EDK2 as PPTT has other topology information which you will need anyways.
>> That would simplify handling of these cacheinfo sysfs in the kernel. Let me know
>> what are your thoughts ?
> 
> The latest firmware of ARM64 machine, FX700 with the A64FX processor
> does not support PPTT.
> I think adding PPTT is the best way to generate cacheinfo sysfs.
> However, it is difficult to modify the firmware to add PPTT, so
> it is not clear when it will be possible.
> Therefore, I would like to implement the function in the kernel on
> the condition that firmware does not support PPTT.

As a bit of a late comment here, I assume you tried injecting the PPTT 
via the initrd (directions in 
admin-guide/acpi/initrd_table_override.txt) then? That is one of the 
usual kernel workarounds for broken/missing ACPI tables.

As mentioned above, besides not providing appropriate topology 
information to userspace, not having the PPTT is also possibly causing 
suboptimal scheduling decisions in the kernel itself.

