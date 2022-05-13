Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14624526763
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382473AbiEMQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353194AbiEMQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:46:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2029517C0;
        Fri, 13 May 2022 09:46:49 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L0DxN2RFvz67Dl8;
        Sat, 14 May 2022 00:43:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 18:46:47 +0200
Received: from [10.47.25.226] (10.47.25.226) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 17:46:46 +0100
Message-ID: <0461c8ea-a872-2581-55ec-0e2ed4912b21@huawei.com>
Date:   Fri, 13 May 2022 17:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/7] perf test: Skip reason for suites with 1 test
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        "Sohaib Mohamed" <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20220513040519.1499333-1-irogers@google.com>
 <20220513040519.1499333-2-irogers@google.com>
 <6341384c-b3e6-fbe5-f29f-e0db114bd439@huawei.com>
 <CAP-5=fX+PfnyHRc=-sQMo1_mGLzCJ77pSfzXXHVUEOHtVFGwxA@mail.gmail.com>
 <b6e28614-e348-b490-bf33-af5810a60722@huawei.com>
 <CAP-5=fVA+x_sNuWCOMj9ASBpFanms8DkAvLkbs5URDvcBW1itg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fVA+x_sNuWCOMj9ASBpFanms8DkAvLkbs5URDvcBW1itg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.226]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 17:34, Ian Rogers wrote:
>>>> john@localhost:~/acme/tools/perf> sudo ./perf test 63
>>>> 63: Test libpfm4 support : Skip (not compiled in)
>>>>
>>>> Although it is odd to have a single sub-test, is there a reason for
>>>> which we don't print its name? We print the name when there are multiple
>>>> sub-tests.
>>> The reason was to replicate the existing "perf test" behavior before
>>> the kunit style transition. The main place we get tests with a single
>>> sub-test is from the DEFINE_SUITE macro:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/tests.h?h=perf/core#n67
>>> I agree it looks kind of weird and was inheriting the data structures
>>> from kunit and the format of the output from perf test.
>> Out of curiosity, which suite is this that you find only has a single
>> subtest? Does it possibly only have a single subtest as some others may
>> be compiled out?
> I was getting it when I added a skip message to the openat syscall
> tests in patch 3:
> https://lore.kernel.org/lkml/20220513040519.1499333-4-irogers@google.com/
> 
> I didn't see any changes with any existing tests.

I suppose it works when the suite has the same name as the subtest, so, 
FWIW:

Reviewed-by: John Garry <john.garry@huawei.com>
