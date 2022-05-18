Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9119F52BC31
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiERNsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiERNsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:48:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8852B1C12DD;
        Wed, 18 May 2022 06:48:22 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3DkB0XFQz687Z6;
        Wed, 18 May 2022 21:44:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 15:48:20 +0200
Received: from [10.47.24.102] (10.47.24.102) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 14:48:18 +0100
Message-ID: <cf7d8003-9700-880f-0e46-ff40e6348bb1@huawei.com>
Date:   Wed, 18 May 2022 14:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     Robin Murphy <robin.murphy@arm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com>
 <28509191-3a45-de6d-f5bc-a8e7331c0a9e@huawei.com>
 <5773b630-8159-1eba-481a-1bf3c406c055@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <5773b630-8159-1eba-481a-1bf3c406c055@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.102]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 13:32, Robin Murphy wrote:
>> If we were to add to arm32/arm then the common event numbers and maybe 
>> other JSONs in future would need to be duplicated.
>>
>> Would there be any reason to add to arm32/arm apart to from being 
>> strictly proper? Maybe if lots of other 32b support for other vendors 
>> came along then it could make sense (to separate them out).
> 
> That's the heart of the question, really. At best it seems unnecessarily 
> confusing as-is. 

I think it comes down to the first core supported was TX2 and the build 
system relies on the target arch to decide which arch from 
pmu-events/arch to compile.

> AFAICS either the naming isn't functional, wherein it 
> would potentially make the most sense to rename the whole thing 
> "pmu-events/arch/arm" if it's merely for categorising Arm architectures 
> in general, or it is actually tied to the host triplet, in which case 
> the above patches are most likely useless.

Today ARCH=arm has no pmu-events support. I think that it should be easy 
to add plumbing for that. It becomes more tricky with supporting a 
single "arm" folder.

But then do people really care enough about pmu-events for these 32b 
cores? Until now, it seems not.

> 
> I'd agree that there doesn't seem much point in trying to separate 
> things along relatively arbitrary lines if it *isn't* functionally 
> necessary - the PMUv2 common events look to be a straightforward subset 
> of the PMUv3 ones, but then there's Cortex-A32 anyway, plus most of the 
> already-supported CPUs could equally run an AArch32 perf tool as well.

Sure, we should have these 32b cores supported for ARCH=arm if they are 
supported for ARCH=arm64. But then does it even make sense to have A7 
support in arch/arm64?

Thanks,
John
