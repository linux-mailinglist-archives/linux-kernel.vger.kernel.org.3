Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923B04F660C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiDFQqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbiDFQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:46:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E850E322815;
        Wed,  6 Apr 2022 08:00:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D26C712FC;
        Wed,  6 Apr 2022 08:00:19 -0700 (PDT)
Received: from [10.57.10.15] (unknown [10.57.10.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFE863F73B;
        Wed,  6 Apr 2022 08:00:18 -0700 (PDT)
Message-ID: <718ca801-b9db-ac33-d224-9c569aab7446@arm.com>
Date:   Wed, 6 Apr 2022 16:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: perf tool: About "perf arm64: Inject missing frames when using
 'perf record --call-graph=fp'"
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     John Garry <john.garry@huawei.com>, alexandre.truong@arm.com
Cc:     linux-perf-users@vger.kernel.org,
        "jolsa@kernel.org >> Jiri Olsa" <jolsa@kernel.org>,
        german.gomez@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <5f1d8b3f-0afa-2724-4ff1-f061939c68c5@huawei.com>
 <2dc4266f-02b1-0937-a884-dfa037cc7ffd@arm.com>
In-Reply-To: <2dc4266f-02b1-0937-a884-dfa037cc7ffd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
> I'm going to look into this today. I expect the cause is because we only record
> the link register for this change and then do a best effort unwind to see if
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
> 

In my case it was showing the error because I'd installed libc debug symbols which
explains why we might have missed it before. Also it's looking for the frame pointer
register which doesn't make sense to save because that would be used to look into
the stack which isn't recorded.

So for that reason I think suppressing the error is the best thing to do. I've sent
"[PATCH] perf: Don't show unwind error messages when augmenting frame pointer stack"

> James
> 
>>
>> Thanks,
>> john
