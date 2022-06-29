Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1181E5606B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiF2QuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiF2QuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:50:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF03F6E;
        Wed, 29 Jun 2022 09:50:20 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY6pP23BRz6H6m6;
        Thu, 30 Jun 2022 00:47:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 18:50:18 +0200
Received: from [10.195.244.164] (10.195.244.164) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 17:50:16 +0100
Message-ID: <03cab2a6-0217-d688-8c86-5fd58e847dde@huawei.com>
Date:   Wed, 29 Jun 2022 17:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        "Felix Fietkau" <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20220627025744.106527-1-irogers@google.com>
 <6f9649d7-8129-57cf-8ab5-03abacd9cb6e@huawei.com>
 <CAP-5=fVxc7H75mb=j23gTD-eMYD3vru5U9QFGQDmODb57aykPA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fVxc7H75mb=j23gTD-eMYD3vru5U9QFGQDmODb57aykPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.164]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 17:47, Ian Rogers wrote:
> On Mon, Jun 27, 2022 at 10:27 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 27/06/2022 03:57, Ian Rogers wrote:
>>> A challenge with this code is in avoiding regressions. For this reason
>>> the jevents.py produces identical output to jevents.c, validated with a
>>> test script and build target.
>>>
>>> v6. Adds Tested-by from Zhengjun Xing<zhengjun.xing@linux.intel.com>
>>>       and Thomas Richter<tmricht@linux.ibm.com>. Fixes issues spotted
>>>       by Jiri Olsa<jolsa@kernel.org>, jsmn.c wasn't deleted and the
>>>       empty pmu-events.c didn't pass the pmu-events test. It also adds a
>>>       missing mkdir which is necessary before creating pmu-events.c and
>>>       tweaks the quiet display code in the empty case to display a gen.
>>> v5. Adds a 2>/dev/null as suggested by David Laight
>>
>>
>> Hmmm... shouldn't this be v7? Anyway what I got with message-id
>> 20220627025744.106527-1-irogers@google.com now seems to build and the
>> output looks ok.
>>
>> Thanks,
>> John
> 
> Thanks John, I think I've confused myself by working on greater than 1
> machine wrt version numbers. I can re-send as v7, would it be okay to
> put on a Tested-by: John Garry <john.garry@huawei.com> ?
> 
Sure,

Tested-by: John Garry <john.garry@huawei.com>
> .

