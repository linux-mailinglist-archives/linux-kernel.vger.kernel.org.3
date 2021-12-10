Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1EE47080C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbhLJSHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbhLJSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:07:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA6C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4AEB8294F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF83C00446;
        Fri, 10 Dec 2021 18:04:06 +0000 (UTC)
Date:   Fri, 10 Dec 2021 18:04:03 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 32/34] arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
Message-ID: <YbOWk2ywaZpgpmeW@arm.com>
References: <cover.1638825394.git.andreyknvl@google.com>
 <4f56dd2bfaf945032a226f90141bb4f8e73959b7.1638825394.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f56dd2bfaf945032a226f90141bb4f8e73959b7.1638825394.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:44:09PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Generic KASAN already selects KASAN_VMALLOC to allow VMAP_STACK to be
> selected unconditionally, see commit acc3042d62cb9 ("arm64: Kconfig:
> select KASAN_VMALLOC if KANSAN_GENERIC is enabled").
> 
> The same change is needed for SW_TAGS KASAN.
> 
> HW_TAGS KASAN does not require enabling KASAN_VMALLOC for VMAP_STACK,
> they already work together as is. Still, selecting KASAN_VMALLOC still
> makes sense to make vmalloc() always protected. In case any bugs in
> KASAN's vmalloc() support are discovered, the command line kasan.vmalloc
> flag can be used to disable vmalloc() checking.
> 
> This patch selects KASAN_VMALLOC for all KASAN modes for arm64.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I also had a look at the rest of the patches and they look fine to me
(even the init_tags comment, feel free to ignore it). I'll poke Vincenzo
next week to look at the patches with his co-developed-by tag.

-- 
Catalin
