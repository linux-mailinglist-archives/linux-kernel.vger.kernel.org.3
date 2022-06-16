Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2862054D710
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354405AbiFPBbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350881AbiFPBbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:31:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFF5713F;
        Wed, 15 Jun 2022 18:31:50 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNl1T5L7WzSh0h;
        Thu, 16 Jun 2022 09:28:29 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 09:31:48 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 09:31:47 +0800
Subject: Re: [RFC 06/13] perf kwork: Implement perf kwork report
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
 <20220613094605.208401-7-yangjihong1@huawei.com>
 <CAM9d7ci9R4=LuyDJAHSqtxc3nOZG+N8e7_WKJUKtL5j3xXqqtA@mail.gmail.com>
 <2953080a-a1bd-0a1c-8466-96c4b58de2e6@huawei.com>
 <CAM9d7ci2XGE6jTnN1UrM=v4E55KswwQHUxmgCL71LgaCn+cFVQ@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <36cb15b2-a8e0-1beb-3462-16a79d41c40d@huawei.com>
Date:   Thu, 16 Jun 2022 09:31:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7ci2XGE6jTnN1UrM=v4E55KswwQHUxmgCL71LgaCn+cFVQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/6/16 6:01, Namhyung Kim wrote:
> On Tue, Jun 14, 2022 at 8:12 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Hello,
>>
>> On 2022/6/15 5:49, Namhyung Kim wrote:
>>> On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>>>
>>>> Implements framework of perf kwork report, which is used to report time
>>>> properties such as run time and frequency:
>>>>
>>>> test case:
>>>>
>>>>     Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
>>>>    ---------------------------------------------------------------------------------------------------------------------------
>>>>    ---------------------------------------------------------------------------------------------------------------------------
>>>>
>>>> Since there are no report supported events, the output is empty.
>>>>
>>>> Briefly describe the data structure:
>>>> 1. "class" indicates event type. For example, irq and softiq correspond
>>>> to different types.
>>>> 2. "cluster" refers to a specific event corresponding to a type. For
>>>> example, RCU and TIMER in softirq correspond to different clusters,
>>>> which contains three types of events: raise, entry, and exit.
>>>
>>> I'm not good at naming but how about calling it "work" instead?
>>> It's all about kernel works anyway..
>>>
>> How about calling it "work_atoms" ?
>> Otherwise, "work" feels a little similar to kwork_class in the first step.
> 
> Didn't you already have "atom"?  I think we can have a hierarchy like
> class (IRQ) - work (eth0) - atom.
OK, I'll modify it in next version according to this hierarchy.

Thanks,
Jihong
.
