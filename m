Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D1535EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbiE0Kqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344688AbiE0Kqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:46:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E4140E2;
        Fri, 27 May 2022 03:46:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m20so7894959ejj.10;
        Fri, 27 May 2022 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VEAekRrz/FSY4pk4QnV3m6H5QVjhz8BFDYr0EcpVw1E=;
        b=nXTl96gpCDbYy3bbmZHUFxanwBKanpTD5T3ye91nNt0S5DzRS50X+C3V5calou/Tbd
         W3tp+Pa5ui5nyk/J9IilzxqUhKzX+QyGcukjZk0ELfa/RtKrZMaq9i+yE1j0RcYeHGEH
         V+4RtLXDWPxnAymJMfcVpu0JZEZoxenwNXkmgyYKMQXGnN1Ls7NkOSx9TgW4IEazH0HS
         TOy4lNsQjFRd71dz5D/Ux8BGGU+UgNurAc7P2zcBMC8bJFwbS5pJWekOq461oc+DsRDd
         eh87WbfBiCTIu2NxwA+S3LoC7J0WxrnESI1Jt77XHjKjToAke3bka2tT28oXpFfiDYxk
         GFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VEAekRrz/FSY4pk4QnV3m6H5QVjhz8BFDYr0EcpVw1E=;
        b=LO/1f7GqF0w+xraxHPRErJiYfcdeZvbNzV9YGGojCAY5Bupb1bp0W3LZctCENfsFtR
         /WAKDzDKat2OkwGPW6D9fTl8fLj4Etmld6CZcJPticTjrF4H+haFomQ5h2e2HbYEdbs9
         rJXKpbLU4YBYdRz+DOOZSbUePDCap7/oqhjphJIaE5H/vNGTmKGyWs34XdICGbJfAF2E
         FnHaX6s/oiFnVrTvwhnGudEJM0wErbTqenz+2gjOQJe2b/lD6oLvnqlQCGKjtFr1Yece
         d/2nPYfV3C7ZHShCeCpBEDW/M2LNQKNi0ij4kNVyvIb3aU7A7WLEEfAmvHnsZOmvVZPm
         eUGQ==
X-Gm-Message-State: AOAM530kWFv/pmgO/9MV407r0PZ0iD3pk3N1Wphwja2DI6Sdq8+O0cTf
        4C7lKcUVxCvRV2qALA5lixmZBgoYiWo=
X-Google-Smtp-Source: ABdhPJyWn7wVchQLELsEVq6TA/gUzEaBn19VUAXtFTYBInhQr0sSQqMx29HcpQwhBHqmmOM8Z+iT0g==
X-Received: by 2002:a17:907:7baa:b0:6fe:b3dc:2378 with SMTP id ne42-20020a1709077baa00b006feb3dc2378mr30766036ejc.266.1653648395645;
        Fri, 27 May 2022 03:46:35 -0700 (PDT)
Received: from gmail.com (563BA16F.dsl.pool.telekom.hu. [86.59.161.111])
        by smtp.gmail.com with ESMTPSA id i20-20020a17090639d400b006fec1a73e48sm1320742eje.64.2022.05.27.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:46:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 27 May 2022 12:46:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Richard Henderson <rth@twiddle.net>,
        David Hildenbrand <david@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michal Simek <monstr@monstr.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-riscv@lists.infradead.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-m68k@lists.linux-m68k.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        sparclinux@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-xtensa@linux-xtensa.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-sh@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Helge Deller <deller@gmx.de>, Vineet Gupta <vgupta@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-um@lists.infradead.org, linux-alpha@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-ia64@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dinh Nguyen <dinguyen@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Hugh Dickins <hughd@google.com>, Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-parisc@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpCsBwFArieTpvg2@gmail.com>
References: <20220524234531.1949-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Xu <peterx@redhat.com> wrote:

> This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> program sequentially dirtying 400MB shmem file being mmap()ed and these are
> the time it needs:
>
>   Before: 650.980 ms (+-1.94%)
>   After:  569.396 ms (+-1.38%)

Nice!

>  arch/x86/mm/fault.c           |  4 ++++

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Minor comment typo:

> +		/*
> +		 * We should do the same as VM_FAULT_RETRY, but let's not
> +		 * return -EBUSY since that's not reflecting the reality on
> +		 * what has happened - we've just fully completed a page
> +		 * fault, with the mmap lock released.  Use -EAGAIN to show
> +		 * that we want to take the mmap lock _again_.
> +		 */

s/reflecting the reality on what has happened
 /reflecting the reality of what has happened

>  	ret = handle_mm_fault(vma, address, fault_flags, NULL);
> +
> +	if (ret & VM_FAULT_COMPLETED) {
> +		/*
> +		 * NOTE: it's a pity that we need to retake the lock here
> +		 * to pair with the unlock() in the callers. Ideally we
> +		 * could tell the callers so they do not need to unlock.
> +		 */
> +		mmap_read_lock(mm);
> +		*unlocked = true;
> +		return 0;

Indeed that's a pity - I guess more performance could be gained here, 
especially in highly parallel threaded workloads?

Thanks,

	Ingo
