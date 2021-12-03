Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5696D467579
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbhLCKtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:49:06 -0500
Received: from foss.arm.com ([217.140.110.172]:47180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhLCKtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:49:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99831595;
        Fri,  3 Dec 2021 02:45:41 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716C33F5A1;
        Fri,  3 Dec 2021 02:45:40 -0800 (PST)
Date:   Fri, 3 Dec 2021 10:41:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Subject: Re: [PATCH v3] arm64: Enable KCSAN
Message-ID: <Yan0PnVmRvGr/0p7@FVFF77S0Q05N>
References: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
 <CANpmjNO5DUk=biDkfP9iepKYBeROO8wL58n8HziOTXuRMOXpvQ@mail.gmail.com>
 <Yajb4w6R4nqPpELq@lakrids>
 <4cd6d815-aaf2-2d62-cff9-8fb4fae3781d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cd6d815-aaf2-2d62-cff9-8fb4fae3781d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 10:29:22AM +0800, Kefeng Wang wrote:
> 
> On 2021/12/2 22:44, Mark Rutland wrote:
> > On Thu, Dec 02, 2021 at 03:36:06PM +0100, Marco Elver wrote:
> > > On Thu, 2 Dec 2021 at 15:23, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > > > This patch enables KCSAN for arm64, with updates to build rules
> > > > to not use KCSAN for several incompatible compilation units.
> > > > 
> > > > Resent GCC version(at least GCC10) made outline-atomics as the
> > > s/Resent/Recent/
> > > 
> > > > default option(unlike Clang), which will cause linker errors
> > > > for kernel/kcsan/core.o. Disables the out-of-line atomics by
> > > > no-outline-atomics to fix the linker errors.
> > > > 
> > > > Meanwhile, as Mark said[1], there is a specific issue on arm64
> > > > about ARM64_BTI with Clang 11 if KCSAN enabled, which is fixed
> > > > by Clang 12, add CLANG_VERSION check. And also some latent issues
> > > > are need to be fixed which isn't just a KCSAN problem, we make
> > > > the KCSAN depends on EXPERT for now.
> > > > 
> > > > Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> > > > and all passed.
> > > > 
> > > > [1] https://lkml.org/lkml/2021/12/1/354
> > > Please use lore/kernel.org permalinks. For this one it'd be:
> > > https://lkml.kernel.org/r/YadiUPpJ0gADbiHQ@FVFF77S0Q05N
> > > 
> > > (But I think if this is the final version of the patch, hopefully a
> > > maintainer can amend the commit message.)
> > > 
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > Acked-by: Marco Elver <elver@google.com> # kernel/kcsan
> > > 
> > > is still valid, given nothing changed there. I leave the rest to Mark.
> > I want to do some compiler / config testing before I ack this (just to
> > make sure there isn't some latent issue I've forgotten about), but
> > otherwise I think this should be fine.
> > 
> > I'll try to have that done in the next few days.
> 
> I will wait for some time, thanks Marco/Mark.
> 
> > 
> > Any other review/testing would be appreciated!
> 
> As Nathan points, commit 8cdd23c23c3d ("arm64: Restrict ARM64_BTI_KERNEL
> 
> to clang 12.0.0 and newer"), so need to add Clang version check, which is v2
> does.
> 
> is there some other requirement that we need this check, what's your option,

I'm not immediately aware of another reason, so I'm fine with not checking that
for KCSAN -- If I discover another reason I will let you know.

Thanks,
Mark.
