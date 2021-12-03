Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65846467D94
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbhLCS6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:58:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53098 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhLCS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:58:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BD5362CAA;
        Fri,  3 Dec 2021 18:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC384C53FCE;
        Fri,  3 Dec 2021 18:54:41 +0000 (UTC)
Date:   Fri, 3 Dec 2021 18:54:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     dennis@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
        gregkh@linuxfoundation.org, cl@linux.com, will@kernel.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 1/4] mm: percpu: Generalize percpu related config
Message-ID: <Yapn7veWrVvWpskW@arm.com>
References: <20211121093557.139034-1-wangkefeng.wang@huawei.com>
 <20211121093557.139034-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121093557.139034-2-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 05:35:54PM +0800, Kefeng Wang wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..4ff73299f8a9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1135,6 +1135,10 @@ config NUMA
>  	select GENERIC_ARCH_NUMA
>  	select ACPI_NUMA if ACPI
>  	select OF_NUMA
> +	select HAVE_SETUP_PER_CPU_AREA
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	select USE_PERCPU_NUMA_NODE_ID
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>  
> @@ -1151,22 +1155,6 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> -config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> -	depends on NUMA
> -
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_PAGE_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SPARSEMEM_ENABLE

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
