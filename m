Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6EA556FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377175AbiFWBCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiFWBCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:02:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606C427C3;
        Wed, 22 Jun 2022 18:02:48 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LT25907pCzkWZJ;
        Thu, 23 Jun 2022 09:01:33 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:02:46 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:02:45 +0800
Subject: Re: [RFC 00/13] perf: Add perf kwork
To:     "Paul A. Clarke" <pc@us.ibm.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
 <YrMuQXIn9DdhZl2w@li-be644d4c-2c59-11b2-a85c-bc3dba3ed00b.ibm.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <3cccc03a-c2bc-91d9-60b9-daf180c6b108@huawei.com>
Date:   Thu, 23 Jun 2022 09:02:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YrMuQXIn9DdhZl2w@li-be644d4c-2c59-11b2-a85c-bc3dba3ed00b.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/6/22 22:59, Paul A. Clarke wrote:
> On Mon, Jun 13, 2022 at 05:45:52PM +0800, Yang Jihong wrote:
>> Sometimes, we need to analyze time properties of kernel work such as irq,
>> softirq, and workqueue, such as delay and running time of specific interrupts.
>> Currently, these events have kernel tracepoints, but perf tool does not
>> directly analyze the delay of these events
>>
>> The perf-kwork tool is used to trace time properties of kernel work
>> (such as irq, softirq, and workqueue), including runtime, latency,
>> and timehist, using the infrastructure in the perf tools to allow
>> tracing extra targets
>>
>> test case:
>>
>>    # perf kwork report
>>
>>      Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
>>     ---------------------------------------------------------------------------------------------------------------------------
>>      (s)RCU:9                  | 0007 |      3.488 ms |      1258 |      0.145 ms |    3398384.220013 s |    3398384.220157 s |
>>      (s)NET_RX:3               | 0003 |      1.866 ms |       156 |      0.042 ms |    3398385.629764 s |    3398385.629806 s |
>>      (s)TIMER:1                | 0000 |      1.799 ms |       117 |      0.055 ms |    3398385.568033 s |    3398385.568088 s |
>>      (w)0xffff9c66e563ee98     | 0006 |      1.561 ms |         5 |      0.351 ms |    3398384.060021 s |    3398384.060371 s |
> 
> What units are used for "Frequency"? It would be helpful to include somewhere.
This refers to the number of event in the trace period.

Thanks，
Jihong
> 
> PC
> .
> 
