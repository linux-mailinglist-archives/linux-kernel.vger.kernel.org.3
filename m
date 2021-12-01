Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F5D464D15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbhLALi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243572AbhLALiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:38:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED8C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 03:35:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a18so51589404wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7oFCw3r7bT3X7Dv+eyjA/okr2FmaHILwO7XorQYmoTs=;
        b=BlKjYbOMUR/aTDj+Ec2chakLzgzNY5VOrahaRQVT/BVafy9OG3EI8f8Rk7Wtn/mPtJ
         S/ZKgHGjhmylvV+Opha093vWnbSBwnOC8zXm56O8WpqHJFkaBJN8+J/NTqlnF9596O5n
         IONkG7mF6uVqCaXGTmIK8FrXIv0FWYuzqfzztnjzRoGC8WfDK0VnbwiQqcYQlI7ZNj3G
         ozRLtxrDIeYJHR0zwiYdDMTbPIKerPqfRzEnRTu3OlzRDTrtsi5JYJryWjf/Uo6jUYZo
         pSHa2xcSofEVwYJ8m0Mnjf/XHDblzkSMFUZh1UzN5o7SrUXZ7mKaEtgNHEe47zPhaowZ
         y8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7oFCw3r7bT3X7Dv+eyjA/okr2FmaHILwO7XorQYmoTs=;
        b=7zGpcRYjnnj/wj/0LYQOISDWjBcsBODw8lffyKjvnXzW7W0yrqG9hjdNNyMWO4arbA
         MKgBLEvK9OeKxi7eDj57ejbcJMNpSrRPCMRVb9/EP8C2rxdFelfib7OPDXTMf7ZfVIcO
         7NV6mmqKyMf1pkUvOlukjaXmprO76tL9YEsvqS9pXR/WrG5pyc2RRHjxlelUiIHAXoNT
         K1Go2gnI1+AKVUiBO58Xa+M4A9dq5xRz6IIS7MxhqGzZvxVmvf7/leef/E3PDn/TYBxf
         m/PbxTB6YSpjcVTtOanBPqc5+2opL6pptJ6O/tVEOZMOldDEMTkBTDpHnZc8XORr4Vk2
         /HZQ==
X-Gm-Message-State: AOAM532Av/f3F7bxAEefDbsTXt40xuZgYNaa5KxEN7ZosFTQp0Ag7wD0
        VdYXpLFiCgTNGOPSWOtrxGsIuA==
X-Google-Smtp-Source: ABdhPJwyr4p/7w9/0D8u9fu/l1X87xRMhQAf8kDNHVmbpnIb9ZmIPngnhesriY/M7C9uy4UG3lqkzw==
X-Received: by 2002:a5d:54cf:: with SMTP id x15mr6333226wrv.30.1638358528549;
        Wed, 01 Dec 2021 03:35:28 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:95ad:1401:cf07:6d1a])
        by smtp.gmail.com with ESMTPSA id u15sm638839wmq.13.2021.12.01.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 03:35:28 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:35:22 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 29/31] kasan, arm64: allow KASAN_VMALLOC with HW_TAGS
Message-ID: <Yadd+oOVYSOPoWMS@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <8afdf7eb0bae77d2e94210d689d524580cf5ed9a.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afdf7eb0bae77d2e94210d689d524580cf5ed9a.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> vmalloc tagging support for HW_TAGS KASAN is now complete.
> 
> Allow enabling CONFIG_KASAN_VMALLOC.

This actually doesn't "allow" enabling it, it unconditionally enables it
and a user can't disable CONFIG_KASAN_VMALLOC.

I found some background in acc3042d62cb9 why arm64 wants this.

> Also adjust CONFIG_KASAN_VMALLOC description:
> 
> - Mention HW_TAGS support.
> - Remove unneeded internal details: they have no place in Kconfig
>   description and are already explained in the documentation.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/Kconfig |  3 +--
>  lib/Kconfig.kasan  | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c05d7a06276f..5981e5460c51 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -205,8 +205,7 @@ config ARM64
>  	select IOMMU_DMA if IOMMU_SUPPORT
>  	select IRQ_DOMAIN
>  	select IRQ_FORCED_THREADING
> -	select KASAN_VMALLOC if KASAN_GENERIC
> -	select KASAN_VMALLOC if KASAN_SW_TAGS
> +	select KASAN_VMALLOC

This produces the following warning when making an arm64 defconfig:

 | WARNING: unmet direct dependencies detected for KASAN_VMALLOC
 |   Depends on [n]: KASAN [=n] && HAVE_ARCH_KASAN_VMALLOC [=y]
 |   Selected by [y]:
 |   - ARM64 [=y]
 | 
 | WARNING: unmet direct dependencies detected for KASAN_VMALLOC
 |   Depends on [n]: KASAN [=n] && HAVE_ARCH_KASAN_VMALLOC [=y]
 |   Selected by [y]:
 |   - ARM64 [=y]

To unconditionally select KASAN_VMALLOC, it should probably be

	select KASAN_VMALLOC if KASAN
