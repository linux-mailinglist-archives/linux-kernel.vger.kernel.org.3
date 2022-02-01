Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9D4A5FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiBAP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:26:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45186 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiBAP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:26:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE78561697
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C32BC340EB;
        Tue,  1 Feb 2022 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643729197;
        bh=D+RrHXUNVvIfZXzq/hDFYNc82WJYpI5xTqKhv7Ezh54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ne613kzsv+qtB9aIL4yFk9meuhxVcaPqpGRMdgsZI+Kn/RWnKft7Ts1Uqq1FdcF7n
         vpuhBMoaQ7WxjmG7FZ+vhCtJ3AljpEJLiH31ixR+nM+n94JYowaawJ/5e0c2kvy0PH
         CUyAG4JHxeHviwMiRoiV/zVCwHeo15D394w4wPCMs51JO6/BXjpfS+wkgH1fW7pUlv
         tXmT9S6YOorBCNVYL+/lVQ+7YaVyxbsIAkXU56OG3W5fhYiwXw0Er2sNS0Eh0oLmZ3
         /kU+7YkNtSK9fc/tPMzTvRhAK8lj3W27N8jcqdkmC3HLEhJhtalqLAMJHYKmgvl417
         hkgC3IrF9CpXw==
Date:   Tue, 1 Feb 2022 17:26:29 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] memblock: Remove unused io.h include
Message-ID: <YflRJZV94Mx6lKAG@kernel.org>
References: <20220131121723.72395-1-karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131121723.72395-1-karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karolina,

On Mon, Jan 31, 2022 at 01:17:23PM +0100, Karolina Drobnik wrote:
> Memblock does not use anything from io.h, remove the include.

As Matthew pointed out [1], many architectures put their definition of
virt_to_phys() in asm/io.h, e.g. 

arch/powerpc/include/asm/io.h:#define virt_to_phys virt_to_phys
arch/sh/include/asm/io.h:#define virt_to_phys(address)  ((unsigned long)(address))
arch/x86/include/asm/io.h:#define virt_to_phys virt_to_phys

which means memblock needs this header for declaration of virt_to_phys().

Although it is included indirectly, let's keep it for now.

[1] https://lore.kernel.org/all/YfbQlMyohx31FhSW@casper.infradead.org/
 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  mm/memblock.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 1018e50566f3..4ee190b3f026 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -18,7 +18,6 @@
>  #include <linux/memblock.h>
>  
>  #include <asm/sections.h>
> -#include <linux/io.h>
>  
>  #include "internal.h"
>  
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
