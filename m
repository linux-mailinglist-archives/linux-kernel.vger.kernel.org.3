Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01FE4626F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhK2W7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:59:20 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:42758 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhK2W6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:58:32 -0500
Received: by mail-qt1-f179.google.com with SMTP id z9so18292676qtj.9;
        Mon, 29 Nov 2021 14:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pEDakQnvUPgfExSNtMrcASRup0dCzLPmxqHNnZuTaEw=;
        b=wECnoec7m6QRbIYqzsIi+BuTLLCPF9pwNMwZ88ZZP5gl2wMtEoli++uEitU4cHKUsk
         5dRDl0rdv3oZCHVDkF3OPeL6yY27nrHYOiSJmdN3+4mKOgirNbg1VfPY+Rxfb3HFKi2K
         lhL4JxSEHIdU+CnWxelZ9k9gvEi8nwj7xJviCHYlRMXWd20kuYWRu/qNzRTTEJN88Qzt
         nmwdTAvA9GA9Bwy6mxRuuDYb3hWvyvEKw1s6+gnfiifPXIw/9MIhjdwLehEaGaU4HLo5
         OYSrgo4exa9kWrFjiRZQnZIWbDh4gaZb5H1GlCGEW510Ag4Y/9Jd8WD1OvDDqihtizCF
         LO2w==
X-Gm-Message-State: AOAM531AgnlY052hjYIpmg4zLeBRpUu6UmIgJJyP3ImhDPsvR1Zs4mPo
        BJdR94hbCuCop34BJyXGGIU=
X-Google-Smtp-Source: ABdhPJwhddCBXLud6erDgcxLoWG12ankufJKN/6VQiDHvJFght0g5pwFKu7S2tQHfyQ8XLjcAQQPNA==
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr47933221qtw.72.1638226513800;
        Mon, 29 Nov 2021 14:55:13 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id d9sm9373180qkn.131.2021.11.29.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:55:13 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:55:11 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tj@kernel.org, gregkh@linuxfoundation.org,
        cl@linux.com, catalin.marinas@arm.com, will@kernel.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 0/4] mm: percpu: Cleanup percpu first chunk funciton
Message-ID: <YaVaTwjiZmWz8PKY@fedora>
References: <20211121093557.139034-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121093557.139034-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Nov 21, 2021 at 05:35:53PM +0800, Kefeng Wang wrote:
> When support page mapping percpu first chunk allocator on arm64, we
> found there are lots of duplicated codes in percpu embed/page first
> chunk allocator. This patchset is aimed to cleanup them and should
> no funciton change, only test on arm64.
> 
> Kefeng Wang (4):
>   mm: percpu: Generalize percpu related config
>   mm: percpu: Add pcpu_fc_cpu_to_node_fn_t typedef
>   mm: percpu: Add generic pcpu_fc_alloc/free funciton
>   mm: percpu: Add generic pcpu_populate_pte() function
> 
>  arch/arm64/Kconfig             |  20 +----
>  arch/ia64/Kconfig              |   9 +--
>  arch/mips/Kconfig              |  10 +--
>  arch/mips/mm/init.c            |  14 +---
>  arch/powerpc/Kconfig           |  17 +---
>  arch/powerpc/kernel/setup_64.c |  92 +--------------------
>  arch/riscv/Kconfig             |  10 +--
>  arch/sparc/Kconfig             |  12 +--
>  arch/sparc/kernel/smp_64.c     | 105 +-----------------------
>  arch/x86/Kconfig               |  17 +---
>  arch/x86/kernel/setup_percpu.c |  66 ++-------------
>  drivers/base/arch_numa.c       |  68 +---------------
>  include/linux/percpu.h         |  13 +--
>  mm/Kconfig                     |  12 +++
>  mm/percpu.c                    | 143 +++++++++++++++++++++++++--------
>  15 files changed, 165 insertions(+), 443 deletions(-)
> 
> -- 
> 2.26.2
> 

I've made a few comments. I think this will be a little bit of a
challenge to get through due to it touching so many architectures. For
ease, it probably makes sense to run it through mny tree, but we'll need
explicit acks as I mentioned.

I like getting rid of the pcpu_alloc_bootmem()/pcpu_free_bootmem()
functions. However, let's keep the implementation identical to x86.


I don't think we should get rid of the populate_pte_fn(). I'm not
comfortable changing x86's implementation. Simply offer a NULL, and if
NULL use the default.

Do you have a tree that intel pulls? I suggest cleaning up the patches
and pushing to a remote branch that they pick up. That would have caught
the mips typo. Send a PR creating a file in [1] for your branch, github
is fine. Basic validation needs to be done before I can pick this up
too on more than arm64.

[1] https://github.com/intel/lkp-tests/tree/master/repo/linux

Thanks,
Dennis
