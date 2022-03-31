Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346B04EE3EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiCaWVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbiCaWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:21:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B90165B92
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:19:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x34so890750ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YSaHDkAvmBJB04tvcs27QeW1C0jDbJIkGoAvurrnuc=;
        b=nCY9+A+xIgpdMJrfOfBZNGi1zfqiizPKHr3g/tNExvO4VcIhxbM2ireHIlaXx36mm8
         bxcf6o2TzDBMY3/54yxpT9nxtwzQAdFZcA+jNmPplf7/M8jZ+S/TGLkH8jRWmyKv7QaP
         cXkhU2XD6Lx+dJvlzQiP6Ab0JSoba0fd3BCj44DmYqAsBYj9zb/Dq8WuLCLbL4jYtW49
         QcBF7dUdpk1GFY81pxJ2WUvRde8YAk6U3eLEPw0EEPh0AtLiHYJhZK1MNBKph+Zay0mY
         BoHXJM/LyRRiGODJcPJTOgFdubmldc/XMoegCopV0eFKihx361+rHTHxhf5hg5sIy7Lv
         7P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YSaHDkAvmBJB04tvcs27QeW1C0jDbJIkGoAvurrnuc=;
        b=LoryLiyLX2GNOG5Q2Cy/mZNksrTPUzxI/onstGVAb+Ri/Aoo91pS+cKnH3MFxD92ZV
         LE8+lnU8o9GcH0OEEm3fYD/1pQjbWtvc3QS328LMCztCSwh9AwhKdJQ/xG9G41JEpwPl
         q5tZjSTBpoamZ62sDfFqRek1bYP/paD1DWr1k1IfTBI1uCP9FMub6SeAWFfD7gpGbTU2
         dSb2iFK+pBlctKy/M6e82rsFM00hjrGPjaKLJY2x4qX8nEfROtgmHUCEVLXFxboWymPV
         zrm9whfmCct3nUHitHibli364h7s2eokXnSF7Rx0emjZddcTv2XlcubHpT6PD9J9Engl
         5yXA==
X-Gm-Message-State: AOAM531tS37eBS4zuOVphgafOldp+v7cwcUJPgLaIs2zx5nYgw3p62oV
        bFUAz937uk5iGJNX9hadoSPDVZyLG2foGJu6lig=
X-Google-Smtp-Source: ABdhPJwOlN/TMZokvtXmBgj3LHrCm7GzgTImbUlYjv4oimgBCWAxzpsDGXcnHKZKYtR6ARTw2a8SoAfc9hUWMI396+k=
X-Received: by 2002:a05:6402:60e:b0:419:d2e:bcea with SMTP id
 n14-20020a056402060e00b004190d2ebceamr18717054edv.326.1648765188589; Thu, 31
 Mar 2022 15:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220331065640.5777-1-songmuchun@bytedance.com>
In-Reply-To: <20220331065640.5777-1-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 1 Apr 2022 11:19:36 +1300
Message-ID: <CAGsJ_4yV89RndtL--9mC++-bTRTo6YVAygQyr40oETirAhKeHQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: hugetlb_vmemmap: introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 7:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page is implemented on x86_64, however, the infrastructure of
> this feature is already there, we could easily enable it for other
> architectures.  Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP for other
> architectures to be easily enabled.  Just select this config if they
> want to enable this feature.
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Review-by: Barry Song <baohua@kernel.org>

> ---
>  arch/x86/Kconfig |  1 +
>  fs/Kconfig       | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..e69d42528542 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -119,6 +119,7 @@ config X86
>         select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>         select ARCH_WANTS_NO_INSTR
>         select ARCH_WANT_HUGE_PMD_SHARE
> +       select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP      if X86_64
>         select ARCH_WANT_LD_ORPHAN_WARN
>         select ARCH_WANTS_THP_SWAP              if X86_64
>         select ARCH_HAS_PARANOID_L1D_FLUSH
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 6c7dc1387beb..f6db2af33738 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,9 +245,17 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>         def_bool HUGETLBFS
>
> +#
> +# Select this config option from the architecture Kconfig, if it is preferred
> +# to enable the feature of minimizing overhead of struct page associated with
> +# each HugeTLB page.
> +#
> +config ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
> +       bool
> +
>  config HUGETLB_PAGE_FREE_VMEMMAP
>         def_bool HUGETLB_PAGE
> -       depends on X86_64
> +       depends on ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
>         depends on SPARSEMEM_VMEMMAP
>
>  config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
> --
> 2.11.0
>
