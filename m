Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3904C49BA79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349448AbiAYRgw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 12:36:52 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:45015 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351433AbiAYRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:35:34 -0500
Received: by mail-yb1-f178.google.com with SMTP id r65so60244704ybc.11;
        Tue, 25 Jan 2022 09:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ikPquhjsfRMVv47QVMlRm0HBAR3in6p60nhuEa0N4a8=;
        b=HYzFpyV5XQp2Hg/gDOBuMpV3YuUxQjacP9fVpj9qJjsFE/pNiFI8r9sV4KUqNg/QiU
         XPIKJwKBHDUWDz8Ge9UTterIcG6Nhwb/spoUSR2f43owtZ2hndCOcu1yK3dIeOEj6LXA
         7s9osdW4KaNW39U4XZcxNKVhCcprHSrubo+1qFSbAZqELAkLFgpQlIwaxO5eD2LVwL4q
         dOIqZLxVH9nmvpRjj9frQGi8f2/nDvq7AkbROUHbfmlkaleaVH39BAMUw8fsKGkfXZkO
         wcPIp2w4APcfvklwNr9JIm8jUqYKdtj3WqC7uczGpNzvRv7j/2aKLNLjEIKWX5hVOOj2
         /g0Q==
X-Gm-Message-State: AOAM530FLhw0qC4KUXhywJDgmv2/M4l/fZaII6X0PGHNqk2zpxc6sU+i
        sc9ZS/odeQlGoOEAHK8FbkUTTnZMh4f1a2yShoz90WYK
X-Google-Smtp-Source: ABdhPJzBZwoaHgdiozvV59S3tZsGA0B+fRzmVS1HUkPFzreaDACHAcmZrXojlbU3Xrd6yAzLsL2ay1u84Mo6lC5ioRU=
X-Received: by 2002:a25:3793:: with SMTP id e141mr30656856yba.624.1643132130665;
 Tue, 25 Jan 2022 09:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20220119104751.1764414-1-amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220119104751.1764414-1-amadeuszx.slawinski@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 18:35:19 +0100
Message-ID: <CAJZ5v0gov=Tra2Z7H99CSnMt7Vf4LKEH3rGzVUjXiiBrusYdGQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove register_nosave_region_late()
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:48 AM Amadeusz Sławiński
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> It is an unused wrapper forcing kmalloc allocation for registering
> nosave regions. Also, rename __register_nosave_region() to
> register_nosave_region() now that there is no need for disambiguation.
>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  include/linux/suspend.h | 11 +----------
>  kernel/power/snapshot.c | 21 +++++++--------------
>  2 files changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 5785d909c321..3e8ecdebe601 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -430,15 +430,7 @@ struct platform_hibernation_ops {
>
>  #ifdef CONFIG_HIBERNATION
>  /* kernel/power/snapshot.c */
> -extern void __register_nosave_region(unsigned long b, unsigned long e, int km);
> -static inline void __init register_nosave_region(unsigned long b, unsigned long e)
> -{
> -       __register_nosave_region(b, e, 0);
> -}
> -static inline void __init register_nosave_region_late(unsigned long b, unsigned long e)
> -{
> -       __register_nosave_region(b, e, 1);
> -}
> +extern void register_nosave_region(unsigned long b, unsigned long e);
>  extern int swsusp_page_is_forbidden(struct page *);
>  extern void swsusp_set_page_free(struct page *);
>  extern void swsusp_unset_page_free(struct page *);
> @@ -458,7 +450,6 @@ int pfn_is_nosave(unsigned long pfn);
>  int hibernate_quiet_exec(int (*func)(void *data), void *data);
>  #else /* CONFIG_HIBERNATION */
>  static inline void register_nosave_region(unsigned long b, unsigned long e) {}
> -static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
>  static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
>  static inline void swsusp_set_page_free(struct page *p) {}
>  static inline void swsusp_unset_page_free(struct page *p) {}
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index f7a986078213..330d49937692 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -978,8 +978,7 @@ static void memory_bm_recycle(struct memory_bitmap *bm)
>   * Register a range of page frames the contents of which should not be saved
>   * during hibernation (to be used in the early initialization code).
>   */
> -void __init __register_nosave_region(unsigned long start_pfn,
> -                                    unsigned long end_pfn, int use_kmalloc)
> +void __init register_nosave_region(unsigned long start_pfn, unsigned long end_pfn)
>  {
>         struct nosave_region *region;
>
> @@ -995,18 +994,12 @@ void __init __register_nosave_region(unsigned long start_pfn,
>                         goto Report;
>                 }
>         }
> -       if (use_kmalloc) {
> -               /* During init, this shouldn't fail */
> -               region = kmalloc(sizeof(struct nosave_region), GFP_KERNEL);
> -               BUG_ON(!region);
> -       } else {
> -               /* This allocation cannot fail */
> -               region = memblock_alloc(sizeof(struct nosave_region),
> -                                       SMP_CACHE_BYTES);
> -               if (!region)
> -                       panic("%s: Failed to allocate %zu bytes\n", __func__,
> -                             sizeof(struct nosave_region));
> -       }
> +       /* This allocation cannot fail */
> +       region = memblock_alloc(sizeof(struct nosave_region),
> +                               SMP_CACHE_BYTES);
> +       if (!region)
> +               panic("%s: Failed to allocate %zu bytes\n", __func__,
> +                     sizeof(struct nosave_region));
>         region->start_pfn = start_pfn;
>         region->end_pfn = end_pfn;
>         list_add_tail(&region->list, &nosave_regions);
> --

Applied as 5.18 material, thanks!
