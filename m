Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7D50F346
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiDZIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbiDZIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:03:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07415A06
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:00:37 -0700 (PDT)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KnZ4S0gwTzGpS7;
        Tue, 26 Apr 2022 15:58:00 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 16:00:35 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 16:00:35 +0800
Subject: Re: [PATCH] tracing: Reset the function filter after completing
 trampoline/graph selftest
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <jolsa@redhat.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220418073958.104029-1-lihuafei1@huawei.com>
 <20220425185859.29e8f9d8@gandalf.local.home>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <ee4bc477-0131-367b-9a1f-c2cb5af5c316@huawei.com>
Date:   Tue, 26 Apr 2022 16:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220425185859.29e8f9d8@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 2022/4/26 6:58, Steven Rostedt wrote:
> On Mon, 18 Apr 2022 15:39:58 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
>
>> The direct trampoline and graph coexistence test sets global_ops to
>> trace only 'trace_selftest_dynamic_test_func', but does not reset it
>> after the test is completed, resulting in the function filter being set
>> already after the system starts. Although it can be reset through the
>> tracefs interface, it is more or less confusing to the user, and we
>> should reset it to trace all functions after the trampoline/graph test
>> completes.
>>
>> Fixes: 130c08065848 ("tracing: Add trampoline/graph selftest")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>   kernel/trace/trace_selftest.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
>> index abcadbe933bb..e89f72571f8e 100644
>> --- a/kernel/trace/trace_selftest.c
>> +++ b/kernel/trace/trace_selftest.c
>> @@ -866,12 +866,12 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>>   	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
>>   				     (unsigned long) trace_direct_tramp);
>>   	if (ret)
>> -		goto out;
>> +		goto reset_filter;
>>   
>>   	ret = register_ftrace_graph(&fgraph_ops);
>>   	if (ret) {
>>   		warn_failed_init_tracer(trace, ret);
>> -		goto out;
>> +		goto reset_filter;
>>   	}
>>   
>>   	DYN_FTRACE_TEST_NAME();
>> @@ -887,14 +887,18 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>>   	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
>>   				       (unsigned long) trace_direct_tramp);
>>   	if (ret)
>> -		goto out;
>> +		goto reset_filter;
>>   
>>   	tracing_start();
>>   
>>   	if (!ret && !count) {
>>   		ret = -1;
>> -		goto out;
>> +		goto reset_filter;
> No need for all the 'goto reset_filter', if this function fails, then the
> tracer is disabled, and there's no reason to clear the filter. In fact, it
Thank you for the review. I see that we will disable function_graph tracer:

      /* Stop it if we failed */
      if (ret)
            ftrace_graph_stop();

But there is no function tracer disabled. Am I missing something that 
would disable the function tracer?


> may cause a crash (because something bad happened).

Yes, so should we kill ftrace when the function_graph test fails?

Thanks,
Huafei

>
> -- Steve
>
>
>>   	}
>> +
>> +reset_filter:
>> +	/* Enable tracing on all functions again */
>> +	ftrace_set_global_filter(NULL, 0, 1);
>>   #endif
>>   
>>   	/* Don't test dynamic tracing, the function tracer already did */
> .
