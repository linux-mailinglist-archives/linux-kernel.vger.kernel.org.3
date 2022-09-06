Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E395ADE0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbiIFDcE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Sep 2022 23:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiIFDba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:31:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF36D57B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 20:30:40 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-ZNshubgrNpWgD0cjxuFveQ-1; Tue, 06 Sep 2022 04:30:34 +0100
X-MC-Unique: ZNshubgrNpWgD0cjxuFveQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 6 Sep
 2022 04:30:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 6 Sep 2022 04:30:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tiezhu Yang' <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] perf bench syscall: Add close syscall benchmark
Thread-Topic: [PATCH 2/3] perf bench syscall: Add close syscall benchmark
Thread-Index: AQHYwZ3Hi0lkR53PnkGoJIdk12O6V63Rua3A
Date:   Tue, 6 Sep 2022 03:30:33 +0000
Message-ID: <3d1e08929fb74938998bd9aa2e370424@AcuMS.aculab.com>
References: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
 <1662433577-23266-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1662433577-23266-3-git-send-email-yangtiezhu@loongson.cn>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang
> Sent: 06 September 2022 04:06
> 
> This commit adds a simple close syscall benchmark, more syscall
> benchmarks can be added in the future.
> 
...
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/perf/bench/bench.h   |  1 +
>  tools/perf/bench/syscall.c | 11 +++++++++++
>  tools/perf/builtin-bench.c |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 6cefb43..916cd47 100644
...
> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> index 746fd71..058394b 100644
> --- a/tools/perf/bench/syscall.c
> +++ b/tools/perf/bench/syscall.c
> @@ -46,6 +46,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
>  		case __NR_getppid:
>  			getppid();
>  			break;
> +		case __NR_close:
> +			close(dup(0));

Not really a close() test.
The dup(0) call will be significant and may take longer.

I'm also not sure that using the syscall number for the
test number is entirely sensible.

One thing I have measured in the past is the time taken
to read in an iov[] array.
This can be measured quite nicely using writev() on /dev/null.
(No copies ever happen and iov_iter() is never used.)
But you need to test a few different iov lengths.

I'm also not 100% sure how accurate/repeatable/sensible it
is to use the 'wall clock time' for 1000000 iterations.
A lot of modern cpu will dynamically change the clock speed
underneath you and other system code (like ethernet receive)
can badly perturb the results.

What you really want to use is a TSC - but they are now
useless for counting cycles.
The x86 performance counters to have a cycle counter.
I've used that to measure single calls of both library
functions and system calls.
Just 10 iterations give a 'cold cache' value and some
very consistent counts (remove real outliers).
Indeed the fastest value is really the right one.

For functions like the IP checksum you can even
show that the code is executing in the expected number
of clock cycles (usually limited by memory reads).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

