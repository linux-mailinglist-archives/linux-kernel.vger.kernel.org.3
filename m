Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C750DCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiDYJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241690AbiDYJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:38:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C830286C5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1UonpqwZd65WYiivXlpqOQWraGSiDc4ju5TfZF1NiKM=; b=StZ2TBUVc6H9eA7HI3hQ9Cthtx
        +OxPMS9JwhhSd0BB6R3IQjTc/fjdujxpv4Q2tMmONJc+Ekw7S0fvhZEEwGxxZquchFZ4a+52zDPiv
        JtRr5kQ/ZrcS9P02mHVdlmV22J4A4C8xdeUdx5lzSqa6TUmHuK8oPgr+GSVCYVLBNg0VsuBEK3whr
        LwhhCg9p95Cb+3AZz7JAds0nfKveJr2JmTyJtAopxHBXd2L1hVZ8glzwWql/q5Nd8HwuMUZdqiAr7
        7XLiAHBWCHdjTEdz0e2f3Lj1eG9RwPUSvtqAODBqFvKXGwCf2eYHSDsvMjieeXyKkHq1NVc+Ox9uD
        tvNGc+Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niv5q-008Via-MR; Mon, 25 Apr 2022 09:33:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF687980BF1; Mon, 25 Apr 2022 11:33:17 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:33:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] smp: replace smp_call_function_single() with
 smp_call()
Message-ID: <20220425093317.GF2731@worktop.programming.kicks-ass.net>
References: <20220422200040.93813-1-dqiao@redhat.com>
 <20220422200040.93813-5-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-5-dqiao@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:00:33PM -0400, Donghai Qiao wrote:
> Eliminated the percpu global csd_data and temporarily hook up
> to smp_call().
> 
> There is no obvious reason or evidence that the differentiation

Using the on-stack csd seems like an obvious benefit to me. Stack is
often cache-hot, while the percpu stuff is likely a cache-miss. Worse,
the call_function_data as used by the mask functions is likely a double
miss due to the O(n^2) nature of the thing.

