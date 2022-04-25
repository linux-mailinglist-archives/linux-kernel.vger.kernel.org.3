Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F750DCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiDYJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbiDYJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:39:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998751A810
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E1kcROZ+fCs3z4dQX4IyDMh/u9LZXEPrs8/KgbHFo1k=; b=I4iXNAzxc2pkqfSueczc5kQAxt
        7tT6vweOtBeczZ2JjiJby6NBn70jtX8/cUgXrzp6XUfv8pSfd9WbXavBfTtbTcWH3ql6PBp8vXrSR
        1LeqpGjoMQ/2It7JpcJxtD6VcudT9NJNRXzs1iLdgJVBqPevz0tvyFzRQ8kizoGaYQAOQ1Pphz++D
        n+Srjzi5ehNkGfdhh61oGBtwAUkZTstzmv7yOBa4vxGLw7i84Ec5RqxRXpQDuex+J1UejZXZjJc+t
        tQrTBLjh7kH2xul0QatkWTMLVp+r8/RxLBrafijEstHDo+7hYjxnEAdmaKnEuuYFH9u22THaNnNM3
        MP3IlvHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niv7f-008aC8-As; Mon, 25 Apr 2022 09:35:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A331980BF1; Mon, 25 Apr 2022 11:35:09 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:35:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] smp: replace smp_call_function_single_async()
 with  smp_call_private()
Message-ID: <20220425093509.GG2731@worktop.programming.kicks-ass.net>
References: <20220422200040.93813-1-dqiao@redhat.com>
 <20220422200040.93813-6-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-6-dqiao@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:00:34PM -0400, Donghai Qiao wrote:
> Replaced smp_call_function_single_async() with smp_call_private()
> and also extended smp_call_private() to support one CPU synchronous
> call with preallocated csd structures.
> 
> Ideally, the new interface smp_call() should be able to do what
> smp_call_function_single_async() does. Because the csd is provided
> and maintained by the callers, it exposes the risk of corrupting
> the call_single_queue[cpu] linked list if the clents menipulate
> their csd inappropriately. On the other hand, there should have no
> noticeable performance advantage to provide preallocated csd for
> cross call kernel consumers. Thus, in the long run, the consumers
> should change to not use this type of preallocated csd.

You're completely missing the point of this interface. *please* look at
it more carefully.
