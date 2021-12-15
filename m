Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A247554F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhLOJi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:38:59 -0500
Received: from foss.arm.com ([217.140.110.172]:46588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhLOJi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:38:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7976D;
        Wed, 15 Dec 2021 01:38:57 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6903F5A1;
        Wed, 15 Dec 2021 01:38:56 -0800 (PST)
Date:   Wed, 15 Dec 2021 09:38:53 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v4] arm64: Enable KCSAN
Message-ID: <Ybm3rfq+9bNEX1Rt@FVFF77S0Q05N>
References: <20211211131734.126874-1-wangkefeng.wang@huawei.com>
 <YbjhUaEP4Sqk7qRP@FVFF77S0Q05N>
 <CANpmjNP_M2R9XD8GnCJVTmN17GPOR_5Y3jX8r5AAKcaDRUWJ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP_M2R9XD8GnCJVTmN17GPOR_5Y3jX8r5AAKcaDRUWJ4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 08:11:24PM +0100, Marco Elver wrote:
> On Tue, 14 Dec 2021 at 19:24, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> >   Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> >   Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks for taking a look and testing! Thought I'd update you re status
> of some of the reports below. :-)

Thanks for the pointers below! I'll fold those into a test branch, so that I
can soak this under Syzkaller over the holiday break.

I've given precise refernces below in case I've misunderstood or missed
something.

> > * BUG: KCSAN: data-race in mutex_spin_on_owner+0xcc/0x150
> > * BUG: KCSAN: data-race in rwsem_spin_on_owner+0xa8/0x13c
> 
> These are going away, fixes are already in -tip/-next.

Cool! I assume that means commits:

* c0bed69daf4b6780 ("locking: Make owner_on_cpu() into <linux/sched.h>")
  from https://lore.kernel.org/r/20211203075935.136808-2-wangkefeng.wang@huawei.com

* 4cf75fd4a2545ca4 ("locking: Mark racy reads of owner->on_cpu")
  from https://lore.kernel.org/r/20211203075935.136808-3-wangkefeng.wang@huawei.com

... in the tip locking/core branch (the head commit of which is currently
5fb6e8cf53b005d2 ("locking/atomic: atomic64: Remove unusable atomic ops")).

> > * UBSAN: object-size-mismatch in net/unix/af_unix.c:977:14
> 
> The UBSAN object-size-mismatch warnings are going away, as
> fsanitize=object-size is broken/incomplete as it turns out --
> UBSAN_OBJECT_SIZE will be removed from 5.17:
> https://bugzilla.kernel.org/show_bug.cgi?id=214861#c4

I see the relevant patch is:

* "[PATCH] ubsan: Remove CONFIG_UBSAN_OBJECT_SIZE"
  from https://lore.kernel.org/all/20211203235346.110809-1-keescook@chromium.org/

... and from looking at next-20211214 that's been picked up by Andrew Morton.

Thanks,
Mark.
