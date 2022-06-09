Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B9544A53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiFILhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiFILhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:37:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67C26394;
        Thu,  9 Jun 2022 04:36:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7534712FC;
        Thu,  9 Jun 2022 04:36:59 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF1433F73B;
        Thu,  9 Jun 2022 04:36:55 -0700 (PDT)
Message-ID: <a0b03913-6412-0e2a-d9c5-431c52ff624f@arm.com>
Date:   Thu, 9 Jun 2022 12:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V5] arm64: perf: Make exporting of pmu events configurable
Content-Language: en-GB
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>,
        Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
 <20220609100247.GA2187@willie-the-truck>
 <4f5dbc00-e25b-f6ff-8585-31fc50f48a21@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4f5dbc00-e25b-f6ff-8585-31fc50f48a21@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-09 11:35, Srinivasarao Pathipati wrote:
> On our Qualcomm platforms, The X bit is getting set by firmware at early 
> bootup for Qualcomm use cases
> and non-secure world is resetting it, that causing issue.

I think you're going to have to clarify what exactly this "issue" is if 
we're ever going to make sense of it...

I can't imagine that export from a disabled PMU would matter much, so my 
best guess is that EL2 firmware has reserved some counters via 
MDCR_EL2.HPMN which it's using to monitor the Non-Secure boot; if that 
also depends on PMCR.X remaining set, then as far as I can see it's 
really the firmware's own stupid fault for not using MDCR_EL2.TPMCR to 
prevent Linux from messing with its configuration. Or maybe something in 
the Secure world is trying to use the PMU independently and it's an EL3 
bug where PMCR_EL0 isn't being context-switched properly?

Robin.

> On 6/9/2022 3:32 PM, Will Deacon wrote:
>> On Mon, May 23, 2022 at 05:19:34PM +0530, Srinivasarao Pathipati wrote:
>>> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
>>> Make is configurable using sysctls to enable/disable at runtime.
>>> It can also be enabled at early bootup with kernel arguments.
>>>
>>> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
>>> ---
>>> Changes since V4:
>>>     - Registering sysctls dynamically for only arm64 as suggested by 
>>> Will
>>>     - Not removed the code to configure with kernel parameters
>>>       as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
>>>       is not working at early bootup. pmu_reset() getting called before
>>>       sysctl's kernel parameter is set.
>> Why do you need this during early bootup? Perf won't program any events
>> until much later and if somebody else is configuring the PMU before
>> entering Linux then they can also set that X bit in the PMCR.
>>
>> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
