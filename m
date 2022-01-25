Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D249B164
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiAYKLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:11:13 -0500
Received: from foss.arm.com ([217.140.110.172]:59968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238734AbiAYKCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:02:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65ADF1FB;
        Tue, 25 Jan 2022 02:02:34 -0800 (PST)
Received: from [10.57.86.86] (unknown [10.57.86.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ACE63F7D8;
        Tue, 25 Jan 2022 02:02:32 -0800 (PST)
Message-ID: <8a348786-d028-a991-178f-60b17d3d6554@arm.com>
Date:   Tue, 25 Jan 2022 10:02:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH V3 0/7] coresight: trbe: Workaround Cortex-A510 erratas
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641872346-3270-1-git-send-email-anshuman.khandual@arm.com>
 <ec21e5da-7b2a-e99f-b24f-89b459e2d5cb@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ec21e5da-7b2a-e99f-b24f-89b459e2d5cb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 03:21, Anshuman Khandual wrote:
> 
> 
> On 1/11/22 9:08 AM, Anshuman Khandual wrote:
>> 	This series adds three different workarounds in the TRBE driver for
>> Cortex-A510 specific erratas. But first, this adds Cortex-A510 specific cpu
>> part number definition in the platform. This series applies on 5.16.
>>
>> Relevant errata documents can be found here.
>>
>> https://developer.arm.com/documentation/SDEN2397239/900
>> https://developer.arm.com/documentation/SDEN2397589/900
>>
>> Changes in V3:
>>
>> - Moved the comment inside trbe_needs_drain_after_disable()
>> - Moved the comment inside trbe_needs_ctxt_sync_after_enable()
>>
>> Changes in V2:
>>
>> https://lore.kernel.org/all/1641517808-5735-1-git-send-email-anshuman.khandual@arm.com/
>>
>> Accommodated most review comments from the previous version.
>>
>> - Split all patches into CPU errata definition, detection and TRBE workarounds
>> - s/TRBE_WORKAROUND_SYSREG_WRITE_FAILURE/TRBE_NEEDS_DRAIN_AFTER_DISABLE
>> - s/TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE/TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE
>> - s/trbe_may_fail_sysreg_write()/trbe_needs_drain_after_disable()
>> - s/trbe_may_corrupt_with_enable()/trbe_needs_ctxt_sync_after_enable()
>> - Updated Kconfig help message for config ARM64_ERRATUM_1902691
>> - Updated error message for trbe_is_broken() detection
>> - Added new trblimitr parameter to set_trbe_enabled(), improving performance
>> - Added COMPILE_TEST dependency in the errata, until TRBE part is available
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/lkml/1641359159-22726-1-git-send-email-anshuman.khandual@arm.com/
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Anshuman Khandual (7):
>>    arm64: Add Cortex-A510 CPU part definition
>>    arm64: errata: Add detection for TRBE ignored system register writes
>>    arm64: errata: Add detection for TRBE invalid prohibited states
>>    arm64: errata: Add detection for TRBE trace data corruption
>>    coresight: trbe: Work around the ignored system register writes
>>    coresight: trbe: Work around the invalid prohibited states
>>    coresight: trbe: Work around the trace data corruption
> 
> Hello Catalin/Mathieu,
> 
> I am wondering how this series is going to be merged i.e via arm64 or coresight
> tree ? Also will this require rebasing (and resend) against v5.17-rc1 release.
> Please do suggest. Thank you.

I would recommend rebasing on rc1.

Thanks
Suzuki
