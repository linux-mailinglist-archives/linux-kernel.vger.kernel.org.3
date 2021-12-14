Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453AB474361
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhLNNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLNNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:25:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:25:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B428614EC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08494C34606;
        Tue, 14 Dec 2021 13:25:22 +0000 (UTC)
Date:   Tue, 14 Dec 2021 13:25:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v3 23/38] kasan, arm64: reset pointer tags of vmapped
 stacks
Message-ID: <YbibPyHQXjU2A/jg@arm.com>
References: <cover.1639432170.git.andreyknvl@google.com>
 <bc9f6cb3df24eb076a6d99f91f97820718f3e29e.1639432170.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9f6cb3df24eb076a6d99f91f97820718f3e29e.1639432170.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:54:19PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Once tag-based KASAN modes start tagging vmalloc() allocations,
> kernel stacks start getting tagged if CONFIG_VMAP_STACK is enabled.
> 
> Reset the tag of kernel stack pointers after allocation in
> arch_alloc_vmap_stack().
> 
> For SW_TAGS KASAN, when CONFIG_KASAN_STACK is enabled, the
> instrumentation can't handle the SP register being tagged.
> 
> For HW_TAGS KASAN, there's no instrumentation-related issues. However,
> the impact of having a tagged SP register needs to be properly evaluated,
> so keep it non-tagged for now.
> 
> Note, that the memory for the stack allocation still gets tagged to
> catch vmalloc-into-stack out-of-bounds accesses.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
