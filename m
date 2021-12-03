Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2702467788
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380864AbhLCMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380791AbhLCMl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:41:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DFC061759
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 04:38:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so2222410wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 04:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhF4DJloD8iRgaeJPijyIb6Lv1uWFcqJB9vbZ2tw7/U=;
        b=Y5fbPakt6NI1S/kY3sqHoChvm/iLe/qHIHAmQYufgFDRp+QJIkkqwxpcPf8cfQJlQ2
         iw253ZPMA7SoFhHxb6gzUzhlmbt8xhjZdiMXxbQ1BHS0p7GKYLPaDiGlkdK5/OSqBYJE
         nOJK24RFSM+wRmcOlDbtYcfe6pIYdDGkxZjwTjpumNiVgJdgXBh/GvUutL5E0xKMbKae
         KRRVqgEUDkWCRf+7K5mOwxdFbExZtKL7aMDADh0ZXauUdMM3GBcF1JBMb0Hz+gV5hq6E
         3G+DwUvOQygOTpAEGOzKF71XncFVfk+E8U3iI00P3WFhI+deVu1Pojn3gRnMfclUpqen
         U4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhF4DJloD8iRgaeJPijyIb6Lv1uWFcqJB9vbZ2tw7/U=;
        b=lylU/9C+zy7/lY7rSKiR3YDJKxyf4lDM4T0nJGF0yy29kXJDvrJ7TM3Wyz7FG8Aoj8
         H6kCa6G7xt/fUfbn7r42/sWa/Rd2bNk4M4426fjoTsdSv5CttCBxH9isoky9tBiHgSAy
         zTteI0ivVHC+xy3e6Xb0aYhsuyldZrhTnqARX/EO3eZ9U/z9pq8FknCrikOWn6Ax6ROB
         9xBq+Vjz8hYEAXU7K6D+qCw/F3d3xnE05PVesYP+2sTSy1zrSuCZwatF5qtM/qhjAxxZ
         SSKvvydqL4XpbjiDtxtJ0Og7Tk1La9XrOBB5IpyjNGV5UW0FQcnNOnsyoisRmHcD1csQ
         CTpg==
X-Gm-Message-State: AOAM531bV+WtZybNQ6o4uoF0Z+BvKlHDvJdSUhrAfjJU9QwIJATJa/OE
        nc4ThHTsNQaDhmCfcCTaHNUwmg==
X-Google-Smtp-Source: ABdhPJwQBodRT/70beD57Bl0QbM1bN/4aJG4705TNjYW9cEDSDNkfOqHhpxJMeTqa4eESd3rLp0nSw==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr828526wmj.119.1638535082851;
        Fri, 03 Dec 2021 04:38:02 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:cb5f:d3e:205e:c7c4])
        by smtp.gmail.com with ESMTPSA id q26sm2513762wrc.39.2021.12.03.04.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 04:38:02 -0800 (PST)
Date:   Fri, 3 Dec 2021 13:37:56 +0100
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
Subject: Re: [PATCH 23/31] kasan, arm64: allow KASAN_VMALLOC with SW_TAGS
Message-ID: <YaoPpPAKi0/OZB2f@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <f90dfb0c02598aab3ad1b5b6ea4a4104b14e099d.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f90dfb0c02598aab3ad1b5b6ea4a4104b14e099d.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> vmalloc support for SW_TAGS KASAN is now complete.
> 
> Allow enabling CONFIG_KASAN_VMALLOC.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

This change is small enough that I would have expected the
lib/Kconfig.kasan change to appear in "kasan, vmalloc: add vmalloc
support to SW_TAGS" because that sounds like it would fully unlock
core KASAN support.

However, the arm64 change could be in its own patch, since there may be
conflicts with arm64 tree or during backports, and only dropping that
may be ok.

I've been backporting too many patches lately, that I feel that would
help.

> ---
>  arch/arm64/Kconfig | 1 +
>  lib/Kconfig.kasan  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..c05d7a06276f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -206,6 +206,7 @@ config ARM64
>  	select IRQ_DOMAIN
>  	select IRQ_FORCED_THREADING
>  	select KASAN_VMALLOC if KASAN_GENERIC
> +	select KASAN_VMALLOC if KASAN_SW_TAGS
>  	select MODULES_USE_ELF_RELA
>  	select NEED_DMA_MAP_STATE
>  	select NEED_SG_DMA_LENGTH
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cdc842d090db..3f144a87f8a3 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -179,7 +179,7 @@ config KASAN_TAGS_IDENTIFY
>  
>  config KASAN_VMALLOC
>  	bool "Back mappings in vmalloc space with real shadow memory"
> -	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
> +	depends on (KASAN_GENERIC || KASAN_SW_TAGS) && HAVE_ARCH_KASAN_VMALLOC
>  	help
>  	  By default, the shadow region for vmalloc space is the read-only
>  	  zero page. This means that KASAN cannot detect errors involving
> -- 
> 2.25.1
> 
