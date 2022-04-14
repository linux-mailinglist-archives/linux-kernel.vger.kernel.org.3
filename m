Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F455017BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiDNPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbiDNPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:38:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097842480;
        Thu, 14 Apr 2022 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZsRcyfHgsom67rurNKLx6V9HZjclTS2jkLPhlClFRLs=; b=udaIYXxYUP+g4H6OzdvOVK++G9
        qGQUmznF+HIBu36y0AXnja7i2BxxjdG/bdqJmsgmYEEkfUeYAUwEmKh55aPfmduuzbqX1GaRJ5dKI
        r1f+HvFYyEpze2tmnfBFJLjuW5ItjPjlPei9QzXLHWjmv1AI4QT6fWPFf7sCBbuZZXtfQJnpvdSD7
        D9+agEGq90Eo5AxANYUK1Je727HyMYrViIvTgnGJl33ruOCPffgCJjwFam1rvmDz/bbViZEXKmL5f
        aLjAPgNuSix4ustrHw5HJuzbgZn3uIrJ1TAPXRj6Jromg0Gw3jyVch4Pt0J7Yx9aXwax0as1EZXty
        00dEw7sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf1Ca-00FEFk-3H; Thu, 14 Apr 2022 15:16:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0403C3002DE;
        Thu, 14 Apr 2022 17:16:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D346920173681; Thu, 14 Apr 2022 17:16:05 +0200 (CEST)
Date:   Thu, 14 Apr 2022 17:16:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhipeng Xie <xiezhipeng1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
        fanwentao@huawei.com
Subject: Re: [PATCH v2] perf/core: Fix perf_mmap fail when
 CONFIG_PERF_USE_VMALLOC enabled
Message-ID: <Ylg6tU5d9JA/2anr@hirez.programming.kicks-ass.net>
References: <20220209145417.6495-1-xiezhipeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209145417.6495-1-xiezhipeng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 09:54:17AM -0500, Zhipeng Xie wrote:
> This problem can be reproduced with CONFIG_PERF_USE_VMALLOC enabled on both
> x86_64 and aarch64 arch when using sysdig -B(using ebpf)[1].
> sysdig -B works fine after rebuilding the kernel with CONFIG_PERF_USE_VMALLOC
> disabled.
> 
> I tracked it down to the if condition event->rb->nr_pages != nr_pages in
> perf_mmap is true when CONFIG_PERF_USE_VMALLOC is enabled where
> event->rb->nr_pages = 1 and nr_pages = 2048 resulting perf_mmap to return
> -EINVAL.This is because when CONFIG_PERF_USE_VMALLOC is enabled, rb->nr_pages
> is always equal to 1.
> 
> Arch with CONFIG_PERF_USE_VMALLOC enabled by default:
> 	arc/arm/csky/mips/sh/sparc/xtensa
> Arch with CONFIG_PERF_USE_VMALLOC disabled by default:
> 	x86_64/aarch64/...
> 
> Fix this problem by using data_page_nr.
> 
> [1] https://github.com/draios/sysdig
> 
> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>

Right; sorry for being tardy. Fix looks ok, but I tihnk it needs:

Fixes: 906010b2134e ("perf_event: Provide vmalloc() based mmap() backing")

Will go queue.

