Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3A574B91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbiGNLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGNLKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:10:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16432DF2F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:10:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149E2139F;
        Thu, 14 Jul 2022 04:10:49 -0700 (PDT)
Received: from [10.57.43.87] (unknown [10.57.43.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E723F792;
        Thu, 14 Jul 2022 04:10:47 -0700 (PDT)
Message-ID: <f12d0412-93b0-8c6b-f269-39435725cc6b@arm.com>
Date:   Thu, 14 Jul 2022 12:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     german.gomez@arm.com, james.clark@arm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220714061302.2715102-1-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220714061302.2715102-1-anshuman.khandual@arm.com>
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

On 14/07/2022 07:13, Anshuman Khandual wrote:
> The arm_spe_pmu driver will enable SYS_PMSCR_EL1.CX in order to add CONTEXT
> packets into the traces, if the owner of the perf event runs with required
> capabilities i.e CAP_PERFMON or CAP_SYS_ADMIN via perfmon_capable() helper.
> 
> The value of this bit is computed in the arm_spe_event_to_pmscr() function
> but the check for capabilities happens in the pmu event init callback i.e
> arm_spe_pmu_event_init(). This suggests that the value of the CX bit should
> remain consistent for the duration of the perf session.
> 
> However, the function arm_spe_event_to_pmscr() may be called later during
> the event start callback i.e arm_spe_pmu_start() when the "current" process
> is not the owner of the perf session, hence the CX bit setting is currently
> not consistent.
> 
> One way to fix this, is by caching the required value of the CX bit during
> the initialization of the PMU event, so that it remains consistent for the
> duration of the session. It uses currently unused 'event->hw.flags' element
> to cache perfmon_capable() value, which can be referred during event start
> callback to compute SYS_PMSCR_EL1.CX. This ensures consistent availability
> of context packets in the trace as per event owner capabilities.
> 
> Drop BIT(SYS_PMSCR_EL1_CX_SHIFT) check in arm_spe_pmu_event_init(), because
> now CX bit cannot be set in arm_spe_event_to_pmscr() with perfmon_capable()
> disabled.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: cea7d0d4a59b ("drivers/perf: Open access for CAP_PERFMON privileged process")

TBH, this is not sufficient. The above commit simply replaced the 
capable() check with perfmon_capable() wrapper. The "incorrect check
in the wrong task context" existed since :

d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical 
Profiling Extension").

So I would recommend using that for the Fixes tag. And any stable
backports without perfmon_capable() could fallback to using capable()
check, like we do in this patch, from the event_init.

Otherwise,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

