Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C255ADE89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiIFE1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiIFE1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:27:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12AC652FF3;
        Mon,  5 Sep 2022 21:27:11 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmsUzBZj_W0SAA--.61655S3;
        Tue, 06 Sep 2022 12:27:01 +0800 (CST)
Subject: Re: [PATCH 2/3] perf bench syscall: Add close syscall benchmark
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
 <1662433577-23266-3-git-send-email-yangtiezhu@loongson.cn>
 <3d1e08929fb74938998bd9aa2e370424@AcuMS.aculab.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <05688277-4fbb-f9d1-61c6-cb221cd47ffb@loongson.cn>
Date:   Tue, 6 Sep 2022 12:27:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3d1e08929fb74938998bd9aa2e370424@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxnmsUzBZj_W0SAA--.61655S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1Utw13Aw1UWr45uFyDJrb_yoW5Wry3pF
        W7Ga10kws5AFy0yw12qa1DXFW8K3Z7GFy5CrnIyr4DZrnxW3sIgrW2qFy5KFZrWr42kFWF
        vF4vvrWUWF4rZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5GzutUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2022 11:30 AM, David Laight wrote:
> From: Tiezhu Yang
>> Sent: 06 September 2022 04:06
>>
>> This commit adds a simple close syscall benchmark, more syscall
>> benchmarks can be added in the future.
>>
> ...
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  tools/perf/bench/bench.h   |  1 +
>>  tools/perf/bench/syscall.c | 11 +++++++++++
>>  tools/perf/builtin-bench.c |  1 +
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
>> index 6cefb43..916cd47 100644
> ...
>> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
>> index 746fd71..058394b 100644
>> --- a/tools/perf/bench/syscall.c
>> +++ b/tools/perf/bench/syscall.c
>> @@ -46,6 +46,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
>>  		case __NR_getppid:
>>  			getppid();
>>  			break;
>> +		case __NR_close:
>> +			close(dup(0));
>
> Not really a close() test.
> The dup(0) call will be significant and may take longer.
>
> I'm also not sure that using the syscall number for the
> test number is entirely sensible.
>
> One thing I have measured in the past is the time taken
> to read in an iov[] array.
> This can be measured quite nicely using writev() on /dev/null.
> (No copies ever happen and iov_iter() is never used.)
> But you need to test a few different iov lengths.
>
> I'm also not 100% sure how accurate/repeatable/sensible it
> is to use the 'wall clock time' for 1000000 iterations.
> A lot of modern cpu will dynamically change the clock speed
> underneath you and other system code (like ethernet receive)
> can badly perturb the results.
>
> What you really want to use is a TSC - but they are now
> useless for counting cycles.
> The x86 performance counters to have a cycle counter.
> I've used that to measure single calls of both library
> functions and system calls.
> Just 10 iterations give a 'cold cache' value and some
> very consistent counts (remove real outliers).
> Indeed the fastest value is really the right one.
>
> For functions like the IP checksum you can even
> show that the code is executing in the expected number
> of clock cycles (usually limited by memory reads).
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

Hi David,

Thanks for your reply.

There are some explanations in commit c2a08203052f ("perf bench:
Add basic syscall benchmark"), I presume the current benchmark
framework works well, if not, maybe we should modify the framework
first.

The initial aim of this patch series is to benchmark more syscalls,
some code is similar with the UnixBench syscall test [1].

[1] 
https://github.com/kdlucas/byte-unixbench/blob/master/UnixBench/src/syscall.c

Thanks,
Tiezhu

