Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367B4A9CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbiBDQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244738AbiBDQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:19:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23863C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 08:19:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q132so5410041pgq.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3kaFhkHfeyp7+DAWdTbgQvWXyZk2TOSGCxZo84uhFc=;
        b=Z/bFLoHuYGxnC+L5jEiRsk+VQU8yJzsbr34AKd38IlxXWkd/jE3s4EOd+VWd8knBOw
         2+ViH28gT13phy3ki8Fa8AJl5WjkFfaJ7zvjDGYl4lpT+R4T9OQvybjsPtoVB3KrLc77
         nY/ca4LHHHTLgrlIbMP/SWImqrZn0B4zJyLCZnDzPn544U+GzNotMxSlQ5sE+X8Psbji
         MGak58PqZZWtNve9hLCTQz0vX4axIr7JAxmTa0NqsKUkdObA3k7wYSB3l0fISc1wDQ+U
         JYByaRxiLhhq/dW9fWImDyNCznByxm3eGN+9iHGWAsMVtFFqa/x6sZvgM2anE1sxlAFi
         EVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3kaFhkHfeyp7+DAWdTbgQvWXyZk2TOSGCxZo84uhFc=;
        b=uNZWoOs/wD1V25ND//SBHmKsGQmvv3jUUG2hk3TGzY42MoyeniMp+wHo3YKW2HDkPo
         GvloROXFcczzBp/iH93cS9E6dXvrXnRaL4R/OODk3u8zCOZDSs6bRExI0OrfNxkKnfmL
         4E1iwUdduVuVLcpwJCtSaash0XN3rrlMdA6njmv8umuUBIXEgrJ7Aeq8Zu3VzCZzR8c2
         JhvMxNgKWn+c1y9ZHVXpyh5Isg0n2+0U+FZx4f36UGF8V41SJvqajaEVnNNuloLuFKYd
         0A5/CWXd+SDP75KpUIZZmTW6BMZJerL9MWB4/dvljV9nkhLlmtNbmcRUeWPaF1izkWXh
         fF9A==
X-Gm-Message-State: AOAM5318YOGqRR6YoDcHoyApglc8v+MIBdXJBUQRw2X8eAPUcF7ClUDN
        exKKsBVw4pIRHqBsTyqzMiSreIjR1w6dxuHv62hwHA==
X-Google-Smtp-Source: ABdhPJzQCBGQTeYrKjE55d10B9f40V82cSAN5INhpiCLIZLqfpVPGn1ysSyJGY9CcVppX1VGIFulhIhreY4ItWcfC4A=
X-Received: by 2002:a63:4717:: with SMTP id u23mr2958870pga.74.1643991594594;
 Fri, 04 Feb 2022 08:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-34-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-34-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 08:19:43 -0800
Message-ID: <CAPcyv4gWcs5u1vRMjzQwJque98u_6MPTWKOFb6XS273egyiXHA@mail.gmail.com>
Subject: Re: [PATCH V8 33/44] memremap_pages: Introduce pgmap_protection_available()
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Users will need to specify that they want their dev_pagemap pages
> protected by specifying a flag in (struct dev_pagemap)->flags.  However,
> it is more efficient to know if that protection is available prior to
> requesting it and failing the mapping.
>
> Define pgmap_protection_available() for users to check if protection is
> available to be used.  The name of pgmap_protection_available() was
> specifically chosen to isolate the implementation of the protection from
> higher level users.  However, the current implementation simply calls
> pks_available() to determine if it can support protection.
>
> It was considered to have users specify the flag and check if the
> dev_pagemap object returned was protected or not.  But this was
> considered less efficient than a direct check beforehand.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Split this out to it's own patch.
>         s/pgmap_protection_enabled/pgmap_protection_available
> ---
>  include/linux/mm.h | 13 +++++++++++++
>  mm/memremap.c      | 11 +++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e1a84b1e6787..2ae99bee6e82 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1143,6 +1143,19 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>                 page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
>  }
>
> +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> +
> +bool pgmap_protection_available(void);
> +
> +#else
> +
> +static inline bool pgmap_protection_available(void)
> +{
> +       return false;
> +}
> +
> +#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
> +
>  /* 127: arbitrary random number, small enough to assemble well */
>  #define folio_ref_zero_or_close_to_overflow(folio) \
>         ((unsigned int) folio_ref_count(folio) + 127u <= 127u)
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 6aa5f0c2d11f..c13b3b8a0048 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -6,6 +6,7 @@
>  #include <linux/memory_hotplug.h>
>  #include <linux/mm.h>
>  #include <linux/pfn_t.h>
> +#include <linux/pkeys.h>
>  #include <linux/swap.h>
>  #include <linux/mmzone.h>
>  #include <linux/swapops.h>
> @@ -63,6 +64,16 @@ static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
>  }
>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
>
> +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> +
> +bool pgmap_protection_available(void)
> +{
> +       return pks_available();
> +}
> +EXPORT_SYMBOL_GPL(pgmap_protection_available);

Any reason this was chosen to be an out-of-line function? Doesn't this
defeat the performance advantages of static_cpu_has()?

> +
> +#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
> +
>  static void pgmap_array_delete(struct range *range)
>  {
>         xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
> --
> 2.31.1
>
