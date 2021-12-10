Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF2F46FFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhLJLZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:25:53 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48976 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbhLJLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:25:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75F4ECE2AB7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C061C00446;
        Fri, 10 Dec 2021 11:22:12 +0000 (UTC)
Date:   Fri, 10 Dec 2021 11:22:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     will@kernel.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        david@redhat.com, gshan@redhat.com, justin.he@arm.com, nd@arm.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YbM4YTgXryp45ufk@arm.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210095432.51798-1-jianyong.wu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:54:32PM +0800, Jianyong Wu wrote:
> fixmap is a global resource and is used recursively in create pud mapping.
> It may lead to race condition when alloc_init_pud is called concurrently.
> 
> Fox example:
> alloc_init_pud is called when kernel_init. If memory hotplug
> thread, which will also call alloc_init_pud, happens during
> kernel_init, the race for fixmap occurs.
> 
> The race condition flow can be:
> 
> *************** begin **************
> 
> kerenl_init thread                          virtio-mem workqueue thread
> ==================                          ======== ==================
> alloc_init_pud(...)
>   pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
> ...                                         ...
>     READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
> ...                                         ...
>   pud_clear_fixmap() //fixmap break
>                                               READ_ONCE(*pudp) //CRASH!
> 
> **************** end ***************
> 
> Hence, a spin lock is introduced to protect the fixmap during create pdg
> mapping.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

It looks fine to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Do we need a cc stable? Fixmap was introduced in 4.6, so usually:

Fixes: f4710445458c ("arm64: mm: use fixmap when creating page tables")
Cc: <stable@vger.kernel.org> # 4.6.x

but I haven't checked when memory hotplug was added to be able to
trigger the race. It may not need to go back that far.

-- 
Catalin
