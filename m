Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543E34F82D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiDGP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiDGP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:26:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A91B21B2FD;
        Thu,  7 Apr 2022 08:24:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B208112FC;
        Thu,  7 Apr 2022 08:24:46 -0700 (PDT)
Received: from [10.1.26.146] (e127744.cambridge.arm.com [10.1.26.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E6743F73B;
        Thu,  7 Apr 2022 08:24:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
To:     Ali Saidi <alisaidi@amazon.com>, Leo Yan <leo.yan@linaro.org>
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, james.clark@arm.com,
        john.garry@huawei.com, jolsa@kernel.org, kjain@linux.ibm.com,
        lihuafei1@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
References: <20220328130547.GA360814@leoy-ThinkPad-X240s>
 <20220329143214.12707-1-alisaidi@amazon.com>
 <4710b4b2-5dcd-00a4-3976-1bd5340f401d@arm.com>
 <20220331124425.GB1704284@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <da902ef2-df87-ed71-275b-f7b41d1afc9a@arm.com>
Date:   Thu, 7 Apr 2022 16:24:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220331124425.GB1704284@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/03/2022 13:44, Leo Yan wrote:
> [...]
>>> I'd like to do this in a separate patch, but I have one other proposal. The
>>> Neoverse cores L2 is strictly inclusive of the L1, so even if it's in the L1,
>>> it's also in the L2. Given that the Graviton systems and afaik the Ampere
>>> systems don't have any cache between the L2 and the SLC, thus anything from
>>> PEER_CORE, LCL_CLSTR, or PEER_CLSTR would hit in the L2, perhaps we
>>> should just set L2 for these cases? German, are you good with this for now? 
>> Sorry for the delay. I'd like to also check this with someone. I'll try
>> to get back asap. In the meantime, if this approach is also OK with Leo,
>> I think it would be fine by me.

Sorry for the delay. Yeah setting it to L2 indeed looks reasonable for
now. Somebody brought up the case of running SPE in a heterogeneous 
system, but also we think might be beyond the scope of this change.

One very minor nit though. Would you be ok with renaming LCL to LOCAL 
and CLSTR to CLUSTER? I sometimes mistead the former as "LLC".

> Thanks for the checking internally.  Let me just bring up my another
> thinking (sorry that my suggestion is float): another choice is we set
> ANY_CACHE as cache level if we are not certain the cache level, and
> extend snoop field to indicate the snooping logics, like:
>
>   PERF_MEM_SNOOP_PEER_CORE
>   PERF_MEM_SNOOP_LCL_CLSTR
>   PERF_MEM_SNOOP_PEER_CLSTR
>
> Seems to me, we doing this is not only for cache level, it's more
> important for users to know the variant cost for involving different
> snooping logics.
>
> Thanks,
> Leo

I see there's been some more messages I need to catch up with. Is the 
intention to extend the PERF_MEM_* flags for this cset, or will it be
left for a later change?

In any case, I'd be keen to take another look at it and try to bring
some more eyes into this.

Thanks,
German
