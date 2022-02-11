Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2A74B2A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351551AbiBKQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:32:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348529AbiBKQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:32:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95EA9CC9;
        Fri, 11 Feb 2022 08:32:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D01B106F;
        Fri, 11 Feb 2022 08:32:28 -0800 (PST)
Received: from [10.57.14.209] (unknown [10.57.14.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9C0A3F70D;
        Fri, 11 Feb 2022 08:32:24 -0800 (PST)
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
To:     Ali Saidi <alisaidi@amazon.com>, leo.yan@linaro.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
 <20220128210245.4628-1-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <7eca7a1d-a5a2-2aab-b3cf-5d83cb8ccf4f@arm.com>
Date:   Fri, 11 Feb 2022 16:31:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220128210245.4628-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On 28/01/2022 21:02, Ali Saidi wrote:
> Hi German,
>
> On 28/01/2022 19:20, German Gomez wrote:
>> Hi Ali,
>>
>> [...]
>>>  };
>>>  
>>>  enum arm_spe_op_type {
>>>  	ARM_SPE_LD		= 1 << 0,
>>>  	ARM_SPE_ST		= 1 << 1,
>>> +	ARM_SPE_LDST_EXCL	= 1 << 2,
>>> +	ARM_SPE_LDST_ATOMIC	= 1 << 3,
>>> +	ARM_SPE_LDST_ACQREL	= 1 << 4,

Wondering if we can store this in perf_sample->flags. The values are
defined in "util/event.h" (PERF_IP_*). Maybe we can extend it to allow
doing "sample->flags = PERF_LDST_FLAG_LD | PERF_LDST_FLAG_ATOMIC" and
such.

@Leo do you think that could work?

>>> +	ARM_SPE_BR		= 1 << 5,
>>> +	ARM_SPE_BR_COND		= 1 << 6,
>>> +	ARM_SPE_BR_IND		= 1 << 7,

Seems like we can store BR_COND in the existing "branch-miss" event
(--itrace=b) with:

  sample->flags = PERF_IP_FLAG_BRANCH;
  sample->flags |= PERF_IP_FLAG_CONDITIONAL;
and/or
  sample->flags |= PERF_IP_FLAG_INDIRECT;

PERF_IP_FLAG_INDIRECT doesn't exist yet but we can probably add it.
