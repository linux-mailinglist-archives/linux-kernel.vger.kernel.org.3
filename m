Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80451583E33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiG1MBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiG1MBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:01:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCEC1D6;
        Thu, 28 Jul 2022 05:01:16 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ltpzg6SlXzWfZT;
        Thu, 28 Jul 2022 19:57:19 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:08 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:07 +0800
Subject: Re: [RFC v3 06/17] perf kwork: Implement perf kwork report
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <pc@us.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220709015033.38326-1-yangjihong1@huawei.com>
 <20220709015033.38326-7-yangjihong1@huawei.com> <YuAnEBpYSf53PkXI@kernel.org>
 <b865f96a-856c-6a7d-a66a-c3343097ee5a@huawei.com>
 <YuFF83qDSyzBrhBm@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <e3be9062-ade9-56c7-71f3-a8cce1db0583@huawei.com>
Date:   Thu, 28 Jul 2022 20:01:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YuFF83qDSyzBrhBm@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo,

On 2022/7/27 22:04, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 27, 2022 at 08:39:33AM +0800, Yang Jihong escreveu:
>> Hello,
>>
>> On 2022/7/27 1:40, Arnaldo Carvalho de Melo wrote:
>>> Em Sat, Jul 09, 2022 at 09:50:22AM +0800, Yang Jihong escreveu:
>>>> +
>>>> +static void report_print_work(struct perf_kwork *kwork,
>>>> +			      struct kwork_work *work)
>>>> +{
>>>> +	int ret = 0;
>>>> +	char kwork_name[PRINT_KWORK_NAME_WIDTH];
>>>> +	char max_runtime_start[32], max_runtime_end[32];
>>>
>>> Committer notes:
>>>
>>> - Add some {} for multiline for/if blocks
>>>
>>> - Return the calculated number of printed bytes in report_print_work,
>>>     otherwise soem compilers will complain that variable isn't used, e.g.:
>>>
>>>      2    92.64 almalinux:9                   : FAIL clang version 13.0.1 (Red Hat 13.0.1-1.el9)
>>>       builtin-kwork.c:1061:6: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
>>>               int ret = 0;
>>>
>>>
>> OK, I'll fix it in next version.
> 
> your work with these fixups is already at acme/perf/core:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> 
> Please continue from there. Please let me know if I made some mistake.
> 
> Thanks for working on this!
>
Thanks to these fixups.
OK, I'll send fix patches according to review comments based on this branch.

Regards,
Jihong
