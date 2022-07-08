Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7AD56B478
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbiGHI2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbiGHI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:28:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FE776944;
        Fri,  8 Jul 2022 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tZqJpdO9mWHvfo40+BrDE5gDm81r18HOvRnoVU7AxhE=; b=ZHBJrcAlGSicxPGyzNcW6jjtGb
        UihST65d0mhDIdXVy0vepaPfEU9cNn/CFvfQGNX/RDjPqvOu4DHTs6S0vu3+A5MfGVsn/y2NDvEYv
        DDOUgjjBFYeOBD/eZJwwIK2Pj6gqFKCFji11hDIa0aCrimiINryZhcgH46cAfv5x+IF84mN2GUJ8k
        6BafMRo7BbcbjNfnU6+Lwuwj5PPzPc2GgVu4ZZhiTGNeJgZSqAtsnnxuUN48Xghc8HJD/3dboufjP
        gQGwvh5cisG4Su887/XYtsk98bTLhuOfST78VXT2XAUG21ZnhtVUKJovFXgZgc70Cnct0+Kktnpye
        xxXSiyaQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9jLE-001efP-Gb; Fri, 08 Jul 2022 08:28:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2800300222;
        Fri,  8 Jul 2022 10:27:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD0B5200E5E5E; Fri,  8 Jul 2022 10:27:58 +0200 (CEST)
Date:   Fri, 8 Jul 2022 10:27:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "guojian@oppo.com" <guojian@oppo.com>,
        "huzhanyuan@oppo.com" <huzhanyuan@oppo.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "v-songbaohua@oppo.com" <v-songbaohua@oppo.com>,
        "will@kernel.org" <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "zhangshiming@oppo.com" <zhangshiming@oppo.com>
Subject: Re: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to
 defer TLB flush
Message-ID: <YsfqjsntneiX0xYE@hirez.programming.kicks-ass.net>
References: <67943544-6DAA-4C8A-A04D-029D2D36C318@vmware.com>
 <20220708065957.3859-1-21cnbao@gmail.com>
 <EE0C38ED-A213-4F5C-9F87-FD90E5035C21@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EE0C38ED-A213-4F5C-9F87-FD90E5035C21@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 08:08:45AM +0000, Nadav Amit wrote:

> Is it really only x86 that has mm_cpumask()?

Unlikely, everybody who needs to IPI (eg. doesn't have broadcast
invalidate) has benefit to track this mask more accurately.

The below greps for clearing CPUs in the mask and ought to be a fair
indicator:

$ git grep -l "cpumask_clear_cpu.*mm_cpumask" arch/
arch/arm/include/asm/mmu_context.h
arch/loongarch/include/asm/mmu_context.h
arch/loongarch/mm/tlb.c
arch/mips/include/asm/mmu_context.h
arch/openrisc/mm/tlb.c
arch/powerpc/include/asm/book3s/64/mmu.h
arch/powerpc/mm/book3s64/radix_tlb.c
arch/riscv/mm/context.c
arch/s390/kernel/smp.c
arch/um/include/asm/mmu_context.h
arch/x86/mm/tlb.c
