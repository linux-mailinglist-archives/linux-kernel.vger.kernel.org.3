Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C64ED9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbiCaMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiCaMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:40:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 042AD117CBA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:39:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B975123A;
        Thu, 31 Mar 2022 05:39:11 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BA223F718;
        Thu, 31 Mar 2022 05:39:08 -0700 (PDT)
Date:   Thu, 31 Mar 2022 13:39:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
Message-ID: <YkWg5dCulxknhyZn@FVFF77S0Q05N>
References: <cover.1648049113.git.andreyknvl@google.com>
 <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:54:08AM +0100, Mark Rutland wrote:
> On Wed, Mar 23, 2022 at 04:32:51PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> > 
> > kasan, arm64, scs, stacktrace: collect stack traces from Shadow Call Stack
> > 
> > Currently, KASAN always uses the normal stack trace collection routines,
> > which rely on the unwinder, when saving alloc and free stack traces.
> > 
> > Instead of invoking the unwinder, collect the stack trace by copying
> > frames from the Shadow Call Stack whenever it is enabled. This reduces
> > boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.
> 
> That is an impressive number. TBH, I'm shocked that this has *that* much of an
> improvement, and I suspect this means we're doing something unnecssarily
> expensive in the regular unwinder.

I've had a quick look into this, to see what we could do to improve the regular
unwinder, but I can't reproduce that 30% number.

In local testing the worst can I could get to was 6-13% (with both the
stacktrace *and* stackdepot logic hacked out entirely).

I'm testing with clang 13.0.0 from the llvm.org binary releases, with defconfig
+ SHADOW_CALL_STACK + KASAN_<option>, using a very recent snapshot of mainline
(commit d888c83fcec75194a8a48ccd283953bdba7b2550). I'm booting a
KVM-accelerated QEMU VM on ThunderX2 with "init=/sbin/reboot -- -f" in the
kernel bootargs, timing the whole run from the outside with "perf stat --null".

The 6% figure is if I count boot as a whole including VM startup and teardown
(i.e. an under-estimate of the proportion), the 13% figure is if I subtract a
baseline timing from a run without KASAN (i.e. an over-estimate of the
proportion).

Could you let me know how you're measuring this, and which platform+config
you're using?

I'll have a play with some configs in case there's a pathological
configuration, but if you could let me know how/what you're testing that'd be a
great help.

Thanks,
Mark.
