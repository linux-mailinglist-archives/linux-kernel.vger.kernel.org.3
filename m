Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2554857DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbiAESEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242686AbiAESEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:04:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE45C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 724A1B81CE7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CFCC36AE0;
        Wed,  5 Jan 2022 18:04:00 +0000 (UTC)
Date:   Wed, 5 Jan 2022 18:03:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     will@kernel.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, david@redhat.com,
        quic_qiancai@quicinc.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gshan@redhat.com, justin.he@arm.com, nd@arm.com
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YdXdjcJ7jbnkFsqp@arm.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216082812.165387-1-jianyong.wu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:28:12PM +0800, Jianyong Wu wrote:
> The 'fixmap' is a global resource and is used recursively by
> create pud mapping(), leading to a potential race condition in the
> presence of a concurrent call to alloc_init_pud():
> 
> kernel_init thread                          virtio-mem workqueue thread
> ==================                          ===========================
> 
>   alloc_init_pud(...)                       alloc_init_pud(...)
>   pudp = pud_set_fixmap_offset(...)         pudp = pud_set_fixmap_offset(...)
>   READ_ONCE(*pudp)
>   pud_clear_fixmap(...)
>                                             READ_ONCE(*pudp) // CRASH!
> 
> As kernel may sleep during creating pud mapping, introduce a mutex lock to
> serialise use of the fixmap entries by alloc_init_pud().
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

I tried to queue this patch but with certain configurations it doesn't
boot under Qemu. Starting from defconfig, update .config with (I had
this in one of my build scripts):

$ ./scripts/config \
		-e DEBUG_KERNEL \
		-e DEBUG_PAGEALLOC \
		-e DEBUG_PAGEALLOC_ENABLE_DEFAULT \
		-e DEBUG_WX \
		-e DEBUG_SET_MODULE_RONX \
		-e DEBUG_ALIGN_RODATA \
		-e ARM64_PTDUMP_DEBUGFS \
		-e DEBUG_OBJECTS \
		-e DEBUG_OBJECTS_FREE \
		-e DEBUG_OBJECTS_TIMERS \
		-e DEBUG_KOBJECT_RELEASE \
		-e DEBUG_LOCKING_API_SELFTESTS \
		-e DEBUG_PREEMPT \
		-e DEBUG_TIMEKEEPING \
		-e DEBUG_VM \
		-e DEBUG_VM_VMACACHE \
		-e DEBUG_VM_RB \
		-e DEBUG_VM_PGFLAGS \
		-e DEBUG_VIRTUAL \
		-e DEBUG_LIST \
		-e DEBUG_PI_LIST \
		-e DEBUG_SG \
		-e PROVE_LOCKING \
		-e DEBUG_RT_MUTEXES \
		-e DEBUG_ATOMIC_SLEEP \
		-e ATOMIC64_SELFTEST

It stop after exiting the EFI boot services. I did not have time to
debug.

-- 
Catalin
