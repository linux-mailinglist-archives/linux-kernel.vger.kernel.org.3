Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5A52293D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiEKBz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiEKBz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00E18AABB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5313661AF8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DF5C385D4;
        Wed, 11 May 2022 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652234124;
        bh=RtSdZCnq9Vk4zc1XyJ8ZqHXdTm5EZ4CK1h6O7cMw0pI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J79FLtB90hPRhj8Cyxnz5KUi42r/kNxFA3LWVSJAnnlxqXpoUmGvDgWXk+sf9663p
         gacki1T30wP6yYsIoiz1GisRrMHjZKKFd7Y8FZf29HErhWaUq9kBMSh9AYY+lbXYL2
         Hht6B3dw/xl2srLlkSdSQLev8e9GAfHBVPItXmn0=
Date:   Tue, 10 May 2022 18:55:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     <rppt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <xuqiang36@huawei.com>
Subject: Re: [PATCH] memblock: config the number of init memblock regions
Message-Id: <20220510185523.3f7479b8ffc49a8a7c17d328@linux-foundation.org>
In-Reply-To: <20220511010530.60962-1-zhouguanghui1@huawei.com>
References: <20220511010530.60962-1-zhouguanghui1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 01:05:30 +0000 Zhou Guanghui <zhouguanghui1@huawei.com> wrote:

> During early boot, the number of memblocks may exceed 128(some memory
> areas are not reported to the kernel due to test failures. As a result,
> contiguous memory is divided into multiple parts for reporting). If
> the size of the init memblock regions is exceeded before the array size
> can be resized, the excess memory will be lost.
> 
> ...
>
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -89,6 +89,14 @@ config SPARSEMEM_VMEMMAP
>  	  pfn_to_page and page_to_pfn operations.  This is the most
>  	  efficient option when sufficient kernel resources are available.
>  
> +config MEMBLOCK_INIT_REGIONS
> +	int "Number of init memblock regions"
> +	range 128 1024
> +	default 128
> +	help
> +	  The number of init memblock regions which used to track "memory" and
> +	  "reserved" memblocks during early boot.
> +
>  config HAVE_MEMBLOCK_PHYS_MAP
>  	bool
>  
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e4f03a6e8e56..6893d26b750e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -22,7 +22,7 @@
>  
>  #include "internal.h"
>  
> -#define INIT_MEMBLOCK_REGIONS			128
> +#define INIT_MEMBLOCK_REGIONS			CONFIG_MEMBLOCK_INIT_REGIONS

Consistent naming would be nice - MEMBLOCK_INIT versus INIT_MEMBLOCK.

Can we simply increase INIT_MEMBLOCK_REGIONS to 1024 and avoid the
config option?  It appears that the overhead from this would be 60kB or
so.  Or zero if CONFIG_ARCH_KEEP_MEMBLOCK and CONFIG_MEMORY_HOTPLUG
are cooperating.
