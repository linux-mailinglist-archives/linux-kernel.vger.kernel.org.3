Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B249D49E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiAZVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiAZVim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:38:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:38:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D8156191A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 21:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D55C340E3;
        Wed, 26 Jan 2022 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643233121;
        bh=0ecxNlw62WJvra/OF+IRNXwztuf5U1ZovPthVp24nSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AX1hK+TSKreuoWTxwy2SoEkBiJd1PLC9xxTxgcTgf8s5jCGEpFNcr/AthESmPOqt3
         WNHsU4mcilnm3W5VjoUTXmCCiwnafW065aC3ka4y8u/rWxkujFIqW4M4yx0mQCIyYu
         nt7wvOYqbtoyuovOa45rehHDPuqesR2T2Q3+uaVcksDoCTmWZnq7EiO9xIDfJdCDkt
         YNBtXE0R/DqQkw+zmQaTY1k1I0Dp4NGtDEzsWmpgNhSniynL47+GUm1T65fkvT3J3H
         i0kdyulnLLWgZ5PQTSIfhu365pTqyZbv71PureX78iRmo4pXP4fyUJsLQYQSJIhGm5
         JtahrOxRQ+kVA==
Date:   Wed, 26 Jan 2022 23:38:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: make 'highmem' symbol ro_after_init
Message-ID: <YfG/Wi5OBHeDRPdg@kernel.org>
References: <20220124170555.1054480-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124170555.1054480-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:05:55PM +0100, Ard Biesheuvel wrote:
> The 'highmem' variable is only set at boot, so we can make it
> ro_after_init and prevent it from being corrupted inadvertently, or from
> ending up in a contended cacheline.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..50e82cb94ccc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -106,7 +106,7 @@ EXPORT_SYMBOL(mem_map);
>   * highstart_pfn must be the same; there must be no gap between ZONE_NORMAL
>   * and ZONE_HIGHMEM.
>   */
> -void *high_memory;
> +void *high_memory __ro_after_init;
>  EXPORT_SYMBOL(high_memory);
>  
>  /*
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
