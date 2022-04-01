Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC14EEDE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346081AbiDANO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244872AbiDANOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:14:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5A1D66DE;
        Fri,  1 Apr 2022 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=TpRKn7SJqJk10dOIDt+TAhE5hOf2Y79WpsicE+YX85k=; b=PHtC2Xm86gFfykvKt6TEThyM7M
        Of9YUNDCIcLsjkG/E3JJi26aThQnEy3e2XeE1Ze1NDD5eVAK8t/lmr3JbkTS7ejKWUGrlDekcrscT
        zxNnM8A4j6wafn7bBTbzDasdq+0Sq4n/LSwOc/lZeB7aWqsRa0wT/baok6J9nRtoIb0zWmgcosrXz
        0LTQtqFKW1oAW4ApN1crtiuseHp/po4kZye4sHM7kI/8lkPQIVBQIwJjQMmnSp6vyDzkJ0IlanT2K
        36IncTVI3qDFnRSjgm3ye3+xOylL8xomBBjF1Zc6VoOC16bhLYh90wsVZoJyyhqXM/kNI7Oz3IOBl
        OIZYMNwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naH4g-003DMW-V2; Fri, 01 Apr 2022 13:12:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77FFD30027B;
        Fri,  1 Apr 2022 15:12:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C6182008B7BF; Fri,  1 Apr 2022 15:12:22 +0200 (CEST)
Date:   Fri, 1 Apr 2022 15:12:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] x86/mm/pgtable: Fix Wstringop-overflow warnings
Message-ID: <Ykb6Nv80LJomLDsO@hirez.programming.kicks-ass.net>
References: <20220401005834.GA182932@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220401005834.GA182932@embeddedor>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:58:34PM -0500, Gustavo A. R. Silva wrote:
> Fix the following -Wstringop-overflow warnings when building with GCC-11:
> 
> .arch/x86/mm/pgtable.c: In function ‘pgd_alloc’:
> arch/x86/mm/pgtable.c:437:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   437 |         if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:437:13: note: referencing argument 2 of type ‘pmd_t **’
> arch/x86/mm/pgtable.c:225:12: note: in a call to function ‘preallocate_pmds.constprop’
>   225 | static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>       |            ^~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:440:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   440 |         if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:440:13: note: referencing argument 2 of type ‘pmd_t **’
> arch/x86/mm/pgtable.c:225:12: note: in a call to function ‘preallocate_pmds.constprop’
>   225 | static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>       |            ^~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:462:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   462 |         free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:462:9: note: referencing argument 2 of type ‘pmd_t **’
> arch/x86/mm/pgtable.c:213:13: note: in a call to function ‘free_pmds.constprop’
>   213 | static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>       |             ^~~~~~~~~
> arch/x86/mm/pgtable.c:455:9: warning: ‘pgd_prepopulate_user_pmd’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   455 |         pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:455:9: note: referencing argument 3 of type ‘pmd_t **’
> arch/x86/mm/pgtable.c:320:13: note: in a call to function ‘pgd_prepopulate_user_pmd’
>   320 | static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:464:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   464 |         free_pmds(mm, pmds, PREALLOCATED_PMDS);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/pgtable.c:464:9: note: referencing argument 2 of type ‘pmd_t **’
> arch/x86/mm/pgtable.c:213:13: note: in a call to function ‘free_pmds.constprop’
>   213 | static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>       |             ^~~~~~~~~
> 
> by using pointer notation instead of array notation as a workaround for
> the above GCC warnings.

'Workaround' implies the warning is on crack...

> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.

which puts to question this endeavour, why are you wanting to have this
if its crap?

