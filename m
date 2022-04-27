Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64473510E27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356834AbiD0Bmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356817AbiD0Bmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:42:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A851301A4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:39:30 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kp1ZC3vGGzGpVS;
        Wed, 27 Apr 2022 09:36:51 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 09:39:27 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 09:39:27 +0800
Subject: Re: [PATCH] tracing: Reset the function filter after completing
 trampoline/graph selftest
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <jolsa@redhat.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220418073958.104029-1-lihuafei1@huawei.com>
 <20220425185859.29e8f9d8@gandalf.local.home>
 <ee4bc477-0131-367b-9a1f-c2cb5af5c316@huawei.com>
 <20220426113114.2005b94f@gandalf.local.home>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <407b6387-c4a1-830d-00d1-21cbac133843@huawei.com>
Date:   Wed, 27 Apr 2022 09:39:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220426113114.2005b94f@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


On 2022/4/26 23:31, Steven Rostedt wrote:
> On Tue, 26 Apr 2022 16:00:35 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
>
>>> No need for all the 'goto reset_filter', if this function fails, then the
>>> tracer is disabled, and there's no reason to clear the filter. In fact, it
>> Thank you for the review. I see that we will disable function_graph tracer:
>>
>>        /* Stop it if we failed */
>>        if (ret)
>>              ftrace_graph_stop();
>>
>> But there is no function tracer disabled. Am I missing something that
>> would disable the function tracer?
> No, but if we are triggering these, then something really bad has happened,
> and function tracer is possibly corrupted too, or should not be trusted.
>
>>
>>> may cause a crash (because something bad happened).
>> Yes, so should we kill ftrace when the function_graph test fails?
> No, but the system should be fixed. These should never trigger on any
> production system, because it means something really bad is happening and
> we do not know what.
>
> Not resetting the filters may even be useful in debugging it. So that's
> another reason to not do so.


That makes sense.  I will remove all "goto reset_filter" from the error 
path and only reset the filter when the test passes.


Thanks,

Huafei


>
> -- Steve
> .
