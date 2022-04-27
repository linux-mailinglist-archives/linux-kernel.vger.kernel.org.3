Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D8511734
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiD0LxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiD0LxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:53:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDD781B2B05;
        Wed, 27 Apr 2022 04:49:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778F9ED1;
        Wed, 27 Apr 2022 04:49:51 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB443F774;
        Wed, 27 Apr 2022 04:49:49 -0700 (PDT)
Message-ID: <de9d0707-0a3b-7a3d-eb95-f8de10765130@arm.com>
Date:   Wed, 27 Apr 2022 12:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V1] arm64: perf: Change PMCR write to read-modify-write
Content-Language: en-GB
To:     "Srinivasarao Pathipati (Consultant)" <c_spathi@qti.qualcomm.com>,
        quic_spathi <quic_spathi@quicinc.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1651053105-11557-1-git-send-email-quic_spathi@quicinc.com>
 <99352dbe-c7dd-73da-3e48-807dcaea3e91@arm.com>
 <SA0PR02MB735545C7F1138C04A87A42D6D9FA9@SA0PR02MB7355.namprd02.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SA0PR02MB735545C7F1138C04A87A42D6D9FA9@SA0PR02MB7355.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-27 12:09, Srinivasarao Pathipati (Consultant) wrote:
>>
>> On 2022-04-27 10:51, Srinivasarao Pathipati wrote:
>>> Preserve the bitfields of PMCR_EL0 during PMU reset.
>>> Reset routine should set only PMCR.C, PMCR.P and PMCR.LC fields only
>>> to reset the counters. Other fields should not be changed
>>> as they could be set before PMU initialization and their value must
>>> be preserved even after reset.
>>
>> No. We also want to ensure PMCR.E and PMCR.D are set to 0, for example.
>> Given that nearly all the writeable fields in PMCR reset to an
>> architecturally UNKNOWN value, preserving that is clearly nonsense.
>> What's your *real* motivation here?
> 
> Thanks Robin for reviewing this patch.
> The X bit is set by firmware on Qualcomm chipsets
> same is getting cleared by kernel from armv8pmu_reset().
> We are trying to retain this bit with this patch.

OK, that's fair enough, but anything firmware may have done is not 
really relevant once Linux has taken over, since firmware is no longer 
in control of the PMU. As mentioned, at this point the driver doesn't 
know *why* any bits are set the way they are - maybe they were 
deliberately configured by platform firmware; maybe the hardware just 
randomly reset to that value; maybe another OS kexec'ed with the PMU 
still running and configured in who-knows-what state; we simply can't 
reason about it, so we have to configure the PMU into a known state for 
how we're going to use it.

> If it is wrong to retaining all bits? can we just retain X bit?

If it's useful for PMU events under Linux to be exported where 
applicable, then it seems reasonable for Linux to enable PMCR.X for 
itself. Certainly there doesn't seem to be any obvious reason *not* to, 
other than perhaps some small power cost, but I guess it could always be 
user-controlled if we wanted to be particularly cautious.

Thanks,
Robin.
