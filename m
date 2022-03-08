Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8776D4D185B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiCHMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiCHMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:55:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A40473A5;
        Tue,  8 Mar 2022 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Lp9h5SvUj4oJnNVmwW10MNKyznLkyl6QZ7JvhC2KJM=; b=mHLjbhesuT1YGt2pdddZdDSQes
        +RIv3T+4cnxzoo/5L/ymQ6iM2w54DIgyKYXnhsAdLE/fjh4dC02OsoMysW6Ziol9z0tdodHLYMiZx
        e0EPSWv2qL3lKCH5ATDBWA38cJc0Pz96PZqhfW7QjwSrA3LmXb3xLN4416GZMNDmE9P2GPVZD4Lm/
        qx4zQTruexHwZIopHK+CB7c4n3BTMRs5fECGrQVr1VL7DUb2mScgQnU7A46X+U6uj7h/JTQblvzIm
        +r9J1xjscX7bCiLkbJtmBEFIHpVsS0GIGkOAMWBxuqGifCLUfpb9eQlFamyGe1O8hXF0d5dPwqhdI
        1fvTnaRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRZLg-00GAms-5s; Tue, 08 Mar 2022 12:53:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7C07300169;
        Tue,  8 Mar 2022 13:53:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCDA9203A88DC; Tue,  8 Mar 2022 13:53:54 +0100 (CET)
Date:   Tue, 8 Mar 2022 13:53:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
Message-ID: <YidR4iKM/GjWto4Y@hirez.programming.kicks-ass.net>
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com>
 <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com>
 <CABPqkBQTkfofi0-92iMRSfgZDHwCxpOD0GmhvAtOruhO=M1gKg@mail.gmail.com>
 <17f24adb-c1af-8c51-d5a9-63b45a7bdcbd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f24adb-c1af-8c51-d5a9-63b45a7bdcbd@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 02:42:10PM +0800, Wen Yang wrote:

> Perhaps the following code could ensure that the pmu counter value is
> stable:
> 
> 
>     /*
>      * Careful: an NMI might modify the previous event value.
>      *
>      * Our tactic to handle this is to first atomically read and
>      * exchange a new raw count - then add that new-prev delta
>      * count to the generic event atomically:
>      */
> again:
>     prev_raw_count = local64_read(&hwc->prev_count);
>     rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> 
>     if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
>                     new_raw_count) != prev_raw_count)
>         goto again;
> 
> 
> It might be better if we could reduce the calls to goto again.

This is completely unrelated. And that goto is rather unlikely, unless
you're doing some truely weird things.

That case happens when the PMI for a counter lands in the middle of a
read() for that counter. In that case both will try and fold the
hardware delta into the software counter. This conflict is fundamentally
unavoidable and needs to be dealt with. The above guarantees correctness
in this case.

It is however extremely unlikely and has *NOTHING* what so ever to do
with counter scheduling.
