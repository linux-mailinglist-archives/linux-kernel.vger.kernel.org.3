Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF94F6062
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiDFNvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiDFNvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:51:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B35F9ADD;
        Wed,  6 Apr 2022 04:28:58 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KYMfk02mrz688JV;
        Wed,  6 Apr 2022 19:26:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 13:28:56 +0200
Received: from [10.47.80.129] (10.47.80.129) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 12:28:56 +0100
Message-ID: <2139adb2-17be-761f-3c8d-e006fc2c4384@huawei.com>
Date:   Wed, 6 Apr 2022 12:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: perf tool: About "perf arm64: Inject missing frames when using
 'perf record --call-graph=fp'"
To:     James Clark <james.clark@arm.com>, <alexandre.truong@arm.com>
CC:     <linux-perf-users@vger.kernel.org>,
        "jolsa@kernel.org >> Jiri Olsa" <jolsa@kernel.org>,
        <german.gomez@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <5f1d8b3f-0afa-2724-4ff1-f061939c68c5@huawei.com>
 <2dc4266f-02b1-0937-a884-dfa037cc7ffd@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <2dc4266f-02b1-0937-a884-dfa037cc7ffd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.129]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 10:08, James Clark wrote:
> 
> 
> On 05/04/2022 15:04, John Garry wrote:
>> Hi Alexandre,
>>
>> I notice that with commit b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf record --call-graph=fp'") that I get messages spewing the console when running perf record+report, as below:
>>
>> john@ubuntu:~/linux$sudo tools/perf/perf record -ag fio null12.fio
>> john@ubuntu:~/linux$sudo tools/perf/perf report > report
>> unwind: can't read reg 29
>> unwind: can't read reg 29
>> unwind: can't read reg 29
>> unwind: can't read reg 29
>> ...
>>
>> Do you know the possible cause? I haven't checked...
> 
> Hi John,
> 
> I'm going to look into this today.

Great

  I expect the cause is because we only record
>> the link register for this change and then do a best effort unwind to see if
> we can get the return address just from that. So I don't think this is a major issue,
> probably the outcome will be that I mask any of these errors just for this call
> to libunwind that we added. The other main call to libunwind should still print
> these errors.
> 
> One thing that is interesting is why we didn't see this when we were testing
> the patch before, and we've also found it a little bit difficult to reproduce here.
> So there might be more to it than just masking the error, but I'm not sure yet.
> 
> Either way, I don't expect that any unwinding is broken, just that it's
> printing an annoying message.

Yeah, the actual ouput looks ok at a glance. I really didn't check much.

Thanks,
John

