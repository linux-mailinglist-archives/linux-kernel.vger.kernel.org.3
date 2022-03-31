Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245D14EDBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiCaOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiCaOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:39:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 793A4209A54
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:37:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DCFC13D5;
        Thu, 31 Mar 2022 07:37:53 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E2313F73B;
        Thu, 31 Mar 2022 07:37:51 -0700 (PDT)
Message-ID: <e93a7d66-7e43-d2c7-ad85-fb24d50effc5@arm.com>
Date:   Thu, 31 Mar 2022 16:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arch/arm64: Fix topology initialization for core
 scheduling
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220330155611.30216-1-pauld@redhat.com>
 <66f29bee-e26c-b40e-c3af-79d5297565d8@arm.com>
 <20220331132103.GB17613@pauld.bos.csb>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220331132103.GB17613@pauld.bos.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 15:21, Phil Auld wrote:
> On Thu, Mar 31, 2022 at 11:04:31AM +0200 Dietmar Eggemann wrote:
>> On 30/03/2022 17:56, Phil Auld wrote:

[...]

>> Ah, the reason is that smt_mask is not correctly setup, so we bail on
>> `cpumask_weight(smt_mask) == 1` for !leaders in:
>>
>> notify_cpu_starting()
>>   cpuhp_invoke_callback_range()
>>     sched_cpu_starting()
>>       sched_core_cpu_starting()
>>
>> which leads to rq->core not being correctly set for !leader-rq's.
>>
> 
> Exactly, sorry I was not clearer.  smt_mask must be setup correctly 
> by the time sched_core_cpu_starting() is called. (Maybe I should crib
> some of the above lines into the commit message?)

Yeah, maybe, it wouldn't hurt I guess. IMHO mentioning stress-ng's prctl
needs PR_SCHED_CORE support could also be handy since today's stress-ng
packages don't seem to have this yet.
