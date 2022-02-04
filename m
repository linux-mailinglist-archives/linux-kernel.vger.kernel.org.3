Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AE74AA192
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiBDVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiBDVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:07:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53FC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:07:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d5so6694647pjk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laVS1zO2EThVkNeZ4rz7U7ORBArTWOIiwe6cc14IlZw=;
        b=fKASpfRnI5mOlBRA8i9Z4b37bEGo3GHzIXQ6+R/5YPGFwxi6eWPd5w9PmG8GKtXryd
         UXOzWsTM8GDlIPgSGk8wW1zyLOEq11WULbps+HAhMpVfo5xuZCOj3I8ZvfEU8QbdIBHs
         402dYrnejDaiOt0gzcaxu+fdwi1bBaiF2UfHyieDWcubeYyYK11ZOOZIU1CtX7KZhX7i
         HblOt2AT4nxKQlg+ITyqcXwGfa15DcGPJkD11mC5CsWToFLbOce2FI0agPRkoHj34kI2
         3TS+Krycwx8s2GmXx3v3kLv195RHxhDhZeMGqKL4l4n9ZG2bchMwadyoAViGbntxY1nZ
         nKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laVS1zO2EThVkNeZ4rz7U7ORBArTWOIiwe6cc14IlZw=;
        b=dLB+TTiy3GHi7K+upgLBjtYb2eAHscyLJnQxQKCNaNyVa5v4eK4Xkej5k7OeqwLmKO
         kEoSoLgH+z5QN8vXUpafQUgVUGUvuXRWXAl6ofvXTw9fRShP2v+dXsGJvQJX/KJIsLCC
         bLWxWxfxzuHOuEtF/cAXmDgDtrtLdNBpnjXSzt+CSlEDRt93h322jbn7ygdG1wl9V2Pz
         B6lCEN/ITzKGEvx0GrTeisgvYoVTUfgy869T48rbGMODWTVg2yVV76v37WUn6sGrGCRy
         cbmscekTKXrjsd34+vPza8VisWOQG1tet0QPyoRAPGltDV2qAhP35/8Vop4g4AvWUgA6
         gNFQ==
X-Gm-Message-State: AOAM533YoNTU53SEQjIZBzxBrOKTBSiF9LKpV0PbGfzhKu1bYLLXa3r6
        30OjZ2lU5vxThtT8YxG69sv9xubw/N8bKCUBndYfgQ==
X-Google-Smtp-Source: ABdhPJxJ7yL6bK33jfQroJ/V+5BLwfa/2b63FNbd1U8VLiR0wVhkpjM2FX30R/e9iXk8dfloz5ZuP9iOb6I02k0ukzM=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr4924993plr.132.1644008841760;
 Fri, 04 Feb 2022 13:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-42-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-42-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 13:07:10 -0800
Message-ID: <CAPcyv4h1Q6H6_VApe3eFhEwe0McqbrFGRmy9rzFSPP0ATsTeTw@mail.gmail.com>
Subject: Re: [PATCH V8 41/44] kmap: Ensure kmap works for devmap pages
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Users of devmap pages should not have to know that the pages they are
> operating on are special.

How about get straight to the point without any ambiguous references:

Today, kmap_{local_page,atomic} handles granting access to HIGHMEM
pages without the caller needing to know if the page is HIGHMEM, or
not. Use that existing infrastructure to grant access to PKS/PGMAP
access protected pages.

> Co-opt the kmap_{local_page,atomic}() to mediate access to PKS protected
> pages via the devmap facility.  kmap_{local_page,atomic}() are both
> thread local mappings so they work well with the thread specific
> protections available.
>
> kmap(), on the other hand, allows for global mappings to be established,
> Which is incompatible with the underlying PKS facility.

Why is kmap incompatible with PKS? I know why, but this is a claim
without evidence. If you documented that in a previous patch, there's
no harm and copying and pasting into this one. A future git log user
will thank you for not making them go to lore to try to find the one
patch with the  details.  Extra credit for creating a PKS theory of
operation document with this detail, unless I missed that?

> For this reason
> kmap() is not supported.  Rather than leave the kmap mappings to fault
> at random times when users may access them,

Is that a problem? This instrumentation is also insufficient for
legitimate usages of page_address(). Might as well rely on the kernel
developer community being able to debug PKS WARN() splats back to the
source because that will need to be done regardless, given kmap() is
not the only source of false positive access violations.

> call
> pgmap_protection_flag_invalid() to show kmap() users the call stack of
> where mapping was created.  This allows better debugging.
>
> This behavior is safe because neither of the 2 current DAX-capable
> filesystems (ext4 and xfs) perform such global mappings.  And known
> device drivers that would handle devmap pages are not using kmap().  Any
> future filesystems that gain DAX support, or device drivers wanting to
> support devmap protected pages will need to use kmap_local_page().
>
> Direct-map exposure is already mitigated by default on HIGHMEM systems
> because by definition HIGHMEM systems do not have large capacities of
> memory in the direct map.  And using kmap in those systems actually
> creates a separate mapping.  Therefore, to reduce complexity HIGHMEM
> systems are not supported.

It was only at the end of this paragraph did I understand why I was
reading this paragraph. The change in topic was buried. I.e.

---

Note: HIGHMEM support is mutually exclusive with PGMAP protection. The
rationale is mainly to reduce complexity, but also because direct-map
exposure is already mitigated by default on HIGHMEM systems  because
by definition HIGHMEM systems do not have large capacities of memory
in the direct map...

---

That note and related change should probably go in the same patch that
introduces CONFIG_DEVMAP_ACCESS_PROTECTION in the first place. It's an
unrelated change to instrumenting kmap() to fail early, which again I
don't think is strictly necessary.

>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Reword commit message
> ---
>  include/linux/highmem-internal.h | 5 +++++
>  mm/Kconfig                       | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 0a0b2b09b1b8..1a006558734c 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -159,6 +159,7 @@ static inline struct page *kmap_to_page(void *addr)
>  static inline void *kmap(struct page *page)
>  {
>         might_sleep();
> +       pgmap_protection_flag_invalid(page);
>         return page_address(page);
>  }
>
> @@ -174,6 +175,7 @@ static inline void kunmap(struct page *page)
>
>  static inline void *kmap_local_page(struct page *page)
>  {
> +       pgmap_mk_readwrite(page);
>         return page_address(page);
>  }
>
> @@ -197,6 +199,7 @@ static inline void __kunmap_local(void *addr)
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>         kunmap_flush_on_unmap(addr);
>  #endif
> +       pgmap_mk_noaccess(kmap_to_page(addr));
>  }
>
>  static inline void *kmap_atomic(struct page *page)
> @@ -206,6 +209,7 @@ static inline void *kmap_atomic(struct page *page)
>         else
>                 preempt_disable();
>         pagefault_disable();
> +       pgmap_mk_readwrite(page);
>         return page_address(page);
>  }
>
> @@ -224,6 +228,7 @@ static inline void __kunmap_atomic(void *addr)
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>         kunmap_flush_on_unmap(addr);
>  #endif
> +       pgmap_mk_noaccess(kmap_to_page(addr));
>         pagefault_enable();
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 migrate_enable();
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 67e0264acf7d..d537679448ae 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -779,6 +779,7 @@ config ZONE_DEVICE
>  config DEVMAP_ACCESS_PROTECTION
>         bool "Access protection for memremap_pages()"
>         depends on NVDIMM_PFN
> +       depends on !HIGHMEM
>         depends on ARCH_HAS_SUPERVISOR_PKEYS
>         select ARCH_ENABLE_SUPERVISOR_PKEYS
>         default y
> --
> 2.31.1
>
