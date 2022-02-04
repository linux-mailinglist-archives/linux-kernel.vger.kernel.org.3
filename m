Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1304D4A9FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiBDTSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiBDTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:18:38 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6A0C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:18:38 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v74so5920611pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJAEx8FGZd2Xu0zfDXDDitF3sMkZ8+OeDmkPgDQ5PK8=;
        b=siie8HfaVAMRprOeUrIUCwokKb96WLLMPRANFKHyvIYxx4NVbdce5VAGmHomLVZuZw
         P4RZ52v1ug35AveQQt4TnHQL1SW/2+TsQ3W7Hkq+7SYMgwvCSqRPAlZcB7Exqplb6+jR
         V2fay5T7mBpJjYEEOzT/mkGky5Z427lrko1qAtY2avb+xxE8MRDodAyk38nBBCu3dsqv
         Tak8E3Ubh6lJOLomlWSEmbLgl9ach14HgrnWX8jrZqmMkh2qAXHDN/L+aZUln6ExeaTk
         MWm4mWGCdXxkSYMLJe6A5WmKV1LM10zON5HBpGHxHFmhHETYci6Wb22dJIkBcGBiPFyV
         e3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJAEx8FGZd2Xu0zfDXDDitF3sMkZ8+OeDmkPgDQ5PK8=;
        b=slJ58LYRVSQyV/we62VaNeZDt1MBVPFwyXWdkA+9Oq0eLIqwMNucY3oTQawrZ96af/
         RqB614fBtz8mczyMXsH39Ep06CQSVmIw1COSiTLwMZEcBO25Ll5EfuMqsewOeucv76eL
         EHGgzjfga2NBewd3gQIf+sE05U7SQoINXOUsngB2ZeiWFj/7aVZ6WTElSQ+igGeJUjD1
         O1hHzyVwNLZ6IImpCxUmCajNfSmfI/wNMVlTsDrH8VrJ2kDLZjGX462AdV64/7LQ/Jje
         grGA8js3/dLDeXrHNr4nYgmkRlSnaXbpq/0v2Htp0G24Ptp1iBDbzR3ppPuzQjBJrO7R
         4+wQ==
X-Gm-Message-State: AOAM530DyDDhqErO6YlHlIxW06r9lvGOQZImkTvVcyzzffoUnyxo/in7
        8ZP9MzxM+fru7yJ/wwoXZXI9x6zRqVft8qian4sZKQ==
X-Google-Smtp-Source: ABdhPJw/zfIjc/QqS1mVL/bPDlqlsZMmIGTVPWJ8OiMwVQEjjacjzO7f8baDsD+McKVukjnWyy1qbIL3McBtyusfQ/Y=
X-Received: by 2002:a05:6a00:1508:: with SMTP id q8mr4529950pfu.3.1644002317646;
 Fri, 04 Feb 2022 11:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-41-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-41-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 11:18:26 -0800
Message-ID: <CAPcyv4jdxKC=6Wh+T37R_sBee0vE-yfRqdX8EbmvLiWTwYhwrw@mail.gmail.com>
Subject: Re: [PATCH V8 40/44] memremap_pages: Add pgmap_protection_flag_invalid()
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
> Some systems may be using pmem in ways that are known to be incompatible

"systems"? You mean kernel code paths? Is it really plural "ways" and
not just the kmap() problem?

> with the PKS implementation.  One such example is the use of kmap() to
> create 'global' mappings.

What are the other examples? I.e. besides bugs, what are the
legitimate ways for the kernel to access memory that are now invalid
in the presence of kmap() access protections. They should all be
listed here. Like the CONFIG_64BIT direct page_address() use problem.
Are there others?

> Rather than only reporting the invalid access on fault, provide a call
> to flag those uses immediately.  This allows for a much better splat for
> debugging to occur.

It does? The faulting RIP will be in the splat, that's not good enough?

It just seems like a lost cause to try to get all the potential paths
that get access protection wrong to spend the time instrumenting this
self-incriminating call. Just let the relaxed mode WARNs "name and
shame" those code paths.

>
> This is also nice because even if no invalid access' actually occurs,
> the invalid mapping can be fixed with kmap_local_page() rather than
> having to look for a different solution.
>
> Define pgmap_protection_flag_invalid() and have it follow the policy set
> by pks_fault_mode.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Split this from the fault mode patch
> ---
>  include/linux/mm.h | 23 +++++++++++++++++++++++
>  mm/memremap.c      |  9 +++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e900df563437..3c0aa686b5bd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1162,6 +1162,7 @@ static inline bool devmap_protected(struct page *page)
>         return false;
>  }
>
> +void __pgmap_protection_flag_invalid(struct dev_pagemap *pgmap);
>  void __pgmap_mk_readwrite(struct dev_pagemap *pgmap);
>  void __pgmap_mk_noaccess(struct dev_pagemap *pgmap);
>
> @@ -1178,6 +1179,27 @@ static inline bool pgmap_check_pgmap_prot(struct page *page)
>         return true;
>  }
>
> +/*
> + * pgmap_protection_flag_invalid - Check and flag an invalid use of a pgmap
> + *                                 protected page
> + *
> + * There are code paths which are known to not be compatible with pgmap
> + * protections.  pgmap_protection_flag_invalid() is provided as a 'relief
> + * valve' to be used in those functions which are known to be incompatible.
> + *
> + * Thus an invalid use case can be flaged with more precise data rather than
> + * just flagging a fault.  Like the fault handler code this abandons the use of
> + * the PKS key and optionally allows the calling code path to continue based on
> + * the configuration of the memremap.pks_fault_mode command line
> + * (and/or sysfs) option.
> + */
> +static inline void pgmap_protection_flag_invalid(struct page *page)
> +{
> +       if (!pgmap_check_pgmap_prot(page))
> +               return;
> +       __pgmap_protection_flag_invalid(page->pgmap);
> +}
> +
>  static inline void pgmap_mk_readwrite(struct page *page)
>  {
>         if (!pgmap_check_pgmap_prot(page))
> @@ -1200,6 +1222,7 @@ bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
>
>  static inline void __pgmap_mk_readwrite(struct dev_pagemap *pgmap) { }
>  static inline void __pgmap_mk_noaccess(struct dev_pagemap *pgmap) { }
> +static inline void pgmap_protection_flag_invalid(struct page *page) { }
>  static inline void pgmap_mk_readwrite(struct page *page) { }
>  static inline void pgmap_mk_noaccess(struct page *page) { }
>
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 783b1cd4bb42..fd4b9b83b770 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -150,6 +150,15 @@ static const struct kernel_param_ops param_ops_pks_fault_modes = {
>         __param_check(name, p, pks_fault_modes)
>  module_param(pks_fault_mode, pks_fault_modes, 0644);
>
> +void __pgmap_protection_flag_invalid(struct dev_pagemap *pgmap)
> +{
> +       if (pks_fault_mode == PKS_MODE_STRICT)
> +               return;
> +
> +       WARN_ONCE(1, "Invalid page map use");
> +}
> +EXPORT_SYMBOL_GPL(__pgmap_protection_flag_invalid);
> +
>  bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
>                               bool write)
>  {
> --
> 2.31.1
>
