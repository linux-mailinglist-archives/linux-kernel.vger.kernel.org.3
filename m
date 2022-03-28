Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0484E9CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiC1RFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244065AbiC1RFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:05:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CEF1CB0C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:03:23 -0700 (PDT)
Date:   Mon, 28 Mar 2022 19:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648487002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srXDUoBEUUPdcjFobaF0lZd9YYmN1yFN4+ozvIVJW9Q=;
        b=Pmt3+lGNfGL4U0YTB/9h9aYv99clc3rYiHA7ZabaYMzkuWJKFFx3ylcw6dOEPiGFOCtrQi
        DlXL9WUM7LwG44LngFDeryV4XVBXS0+x9yMQ2pvQ9uusbYiNSS1r7XIgVuGrQDFiCkFl1y
        ZyvbbX9LHUpei8qjczmufT2LlIRQIJ3kpLIWzzhYG1yj8myub0e0aFNA9GLQuE6r1AR0yb
        2V84DiMctksoJZCOf9dA7QXm5UHA9b30EGe8vrh0UTYQI2zmD1oJoUKVo2phd99PYCdmNi
        ghYt2ElrRwAWIaTpqd1iqfAWYizmIiVIqjVaug/+wOC40Yr8r6kJ8xfZSFRq/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648487002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srXDUoBEUUPdcjFobaF0lZd9YYmN1yFN4+ozvIVJW9Q=;
        b=SJa/ZKaR8ZxqMtI21QJW2n2ad3znC9T4KW9AInZr/BVGtIWn58oR30ZuTRv8gjHUeFt/aI
        +vFojVL6CUdQSODA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] mm, kasan: fix __GFP_BITS_SHIFT definition breaking
 LOCKDEP
Message-ID: <YkHqWKRRtnQuAVa/@linutronix.de>
References: <462ff52742a1fcc95a69778685737f723ee4dfb3.1648400273.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <462ff52742a1fcc95a69778685737f723ee4dfb3.1648400273.git.andreyknvl@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-27 19:00:23 [+0200], andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> KASAN changes that added new GFP flags mistakenly updated __GFP_BITS_SHIFT
> as the total number of GFP bits instead of as a shift used to define
> __GFP_BITS_MASK.
> 
> This broke LOCKDEP, as __GFP_BITS_MASK now gets the 25th bit enabled
> instead of the 28th for __GFP_NOLOCKDEP.
> 
> Update __GFP_BITS_SHIFT to always count KASAN GFP bits.
> 
> In the future, we could handle all combinations of KASAN and LOCKDEP to
> occupy as few bits as possible. For now, we have enough GFP bits to be
> inefficient in this quick fix.
> 
> Fixes: 9353ffa6e9e9 ("kasan, page_alloc: allow skipping memory init for HW_TAGS")
> Fixes: 53ae233c30a6 ("kasan, page_alloc: allow skipping unpoisoning for HW_TAGS")
> Fixes: f49d9c5bb15c ("kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
