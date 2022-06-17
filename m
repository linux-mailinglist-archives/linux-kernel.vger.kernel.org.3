Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E154F955
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382771AbiFQOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiFQOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:39:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689239684;
        Fri, 17 Jun 2022 07:39:33 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPhTm4850z6H6mV;
        Fri, 17 Jun 2022 22:37:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 17 Jun 2022 16:39:31 +0200
Received: from [10.126.175.22] (10.126.175.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 15:39:29 +0100
Message-ID: <cb61ea57-ea48-ccd7-fa3f-6e46f196de1e@huawei.com>
Date:   Fri, 17 Jun 2022 15:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/4] perf jevents: Add python converter script
To:     Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Felix Fietkau <nbd@nbd.name>,
        Qi Liu <liuqi115@huawei.com>, Like Xu <likexu@tencent.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        "Nick Forrington" <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "James Clark" <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20220616044806.47770-1-irogers@google.com>
 <20220616044806.47770-3-irogers@google.com>
 <7eb148e5-0763-1dbe-d1f5-80e5159be7c8@linux.intel.com>
 <CAP-5=fUy=_HFhhdghRJs-+G75ppsYCRg72SSnoeijvdqb8hyVQ@mail.gmail.com>
 <3108fd92-c05b-961f-2367-81925535bf4f@linux.intel.com>
 <CAP-5=fW10QAD1MZ_RhdCvOTwiWTcYoQps5hSGH4F2JsVYeAB5A@mail.gmail.com>
 <5e27d1e8-f329-7e11-2f5a-cc0d53ce1db3@linux.intel.com>
 <CAP-5=fUZbi2359+jgMx8MNjT0aEt1Ai0aBzA4kc+iKphpJWwCg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fUZbi2359+jgMx8MNjT0aEt1Ai0aBzA4kc+iKphpJWwCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.22]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 14:33, Ian Rogers wrote:
>> ...                       libzstd: [ on  ]
>> ...        disassembler-four-args: [ on  ]
>> ...         python-dev-is-python3: [ off ]
>>
> Agreed on cleaning up the python Makefile logic. I'd rather do it out
> of these patches.
IMHO I know it's painful to get right but we should have it shouted that 
python is not properly configured and jevents won't get compiled 
(properly) - the message "Python interpreter too old (older than 3.6) 
disabling jevent generation" is too quiet.

Thanks!
