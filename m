Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29E4A5994
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiBAKDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiBAKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:03:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC79C061714;
        Tue,  1 Feb 2022 02:03:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s5so52213096ejx.2;
        Tue, 01 Feb 2022 02:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mClIZuGiU90N8/wVEGuz0kPrT8HDVsO1SF0mMBp9TKA=;
        b=m8l3iizy6m+bL/jBYQ1WY3ATqWzlyg2KTCyNULM3eVNvkC5wqKTucOmaIxZWFKKHKC
         O4vEtqtNwuq399PL5WPFG5Z7vCu6zPPjoimtCnr8vb/5lojlVqjvZJwxMJzVd0Vk35+r
         ZVAR+4L1KqtGJhgkD+zr3U76KGUGG1P7/BPweFRor+Y6JBV2yCS0CX+UFmYJA0lC10As
         KSMXOwfQMpM5C1cOo7NxFB454lv8KZ0AWzZzM/pxNJiKv31JpTcyWfsVCUPzCl573dFS
         WOqZrDF8DuO60afmvVeUg1FCdgzqdmHYIJrUyRb6laaV9nlyKLCU0X2qcosie45x9Rgc
         yezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mClIZuGiU90N8/wVEGuz0kPrT8HDVsO1SF0mMBp9TKA=;
        b=AjJnTwOTz4vQWsalBUistg/e6KCqcUfSw6yBKo6WhEm4kjQkqSqmSfYN4bRDCIoUmJ
         nazF20oNS3SSaIGS6zyx00FESNliOYJiXb2yMkyDCIAy3GNDuHqm7i2qYM/h15YhvFq9
         NlFxQq6uEGixCPYsbXru822uL536p1G19p6X2sKqSb+/72o/SDIba0WLU+07dMW55gSP
         Dx4Vxvnu2Fk4Ps2vJT+shObijSRHz7a92x1T9G5qqq/YYnXYa3OqW1uQ5iCLVHzZADz6
         /CpJkCDPdrZiD+BpzcgoscbJsSKll6M7a8VrgssNyf07zzwW1p6H3BwNt+T7ecye0V2z
         luHg==
X-Gm-Message-State: AOAM530Yxswqg3PeicJhuNMg8ZwE75fDf/cd+2pDttVOqlXoGDSsWccA
        ax2IsivtFZ0XbBS6NubsjIb3QENKQWVEd2PGoKU=
X-Google-Smtp-Source: ABdhPJyfD5PfJ3o2DgbfikfmuisQ6IDuSCV1txCGADlAID79HMnZ8k2HT/445aAlBSn/3Hrxj9wDnw0NxNHNH60hLfE=
X-Received: by 2002:a17:907:1c1c:: with SMTP id nc28mr20280513ejc.651.1643709778741;
 Tue, 01 Feb 2022 02:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20220128151540.164759-1-david@redhat.com>
In-Reply-To: <20220128151540.164759-1-david@redhat.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 1 Feb 2022 13:02:45 +0300
Message-ID: <CADxRZqx_rAkwFVwSc1ohm-RqKD=-pcBsR+rBrRaw9KazQncANQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1] drivers/base/node: consolidate node device
 subsystem initialization in node_dev_init()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 2:11 PM David Hildenbrand <david@redhat.com> wrote:
>
> ... and call node_dev_init() after memory_dev_init() from driver_init(),
> so before any of the existing arch/subsys calls. All online nodes should
> be known at that point.
>
> This is in line with memory_dev_init(), which initializes the memory
> device subsystem and creates all memory block devices.
>
> Similar to memory_dev_init(), panic() if anything goes wrong, we don't
> want to continue with such basic initialization errors.
>
> The important part is that node_dev_init() gets called after
> memory_dev_init() and after cpu_dev_init(), but before any of the
> relevant archs call register_cpu() to register the new cpu device under
> the node device. The latter should be the case for the current users
> of topology_init().
>
> RFC because I tested only on x86-64 and s390x, I think I cross-compiled all
> applicable architectures except riscv and sparc.

Compiled and boot tested on sparc.

Tested-by: Anatoly Pugachev <matorola@gmail.com> (sparc64)
