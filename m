Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC16A5AA908
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiIBHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiIBHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:43:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2EA833B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OTkZ6uS66u1w+Hbm6TtejxpZoX4M4S5NPkBcQcAWCKc=; b=PnZijlpR1pOR1iufsipFUsPYmX
        wbuCNPHruLPvnd9YD9OGZaAbljCpwQ375yyM4LxLPNodHP7yyl8nCBECEYTFiQVqc4YVxSJ/V2dlh
        O/8jbSYyMnq7pIMy+I3eQIfZaErVmTLPipUltIDJnf+p51iDa+Z64wSxdGbbuLpDZVmryFk/FF5GN
        cP5Tu6T2zNfa688WKGMlX+v33GIJwYaMwjVzwszIeAy17yanlRL0xUsMQD41ZBgPm/IX3evr0bd8h
        t52Sf3vBachUsH2aTamhLXAmPGIVVmxbsmm6eJm2OoDfb4u1z/Ab3fdh7EznyK7iKAahKesRs1Ztw
        16OOfd2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU1KH-008c53-Ly; Fri, 02 Sep 2022 07:42:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BFA230010B;
        Fri,  2 Sep 2022 09:42:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 793AE2B89F172; Fri,  2 Sep 2022 09:42:51 +0200 (CEST)
Date:   Fri, 2 Sep 2022 09:42:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
Message-ID: <YxGz+3TT/J7u6H81@hirez.programming.kicks-ass.net>
References: <20220901173516.702122-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:34:48AM -0700, Suren Baghdasaryan wrote:
> This is a proof of concept for per-vma locks idea that was discussed
> during SPF [1] discussion at LSF/MM this year [2], which concluded with
> suggestion that “a reader/writer semaphore could be put into the VMA
> itself; that would have the effect of using the VMA as a sort of range
> lock. There would still be contention at the VMA level, but it would be an
> improvement.” This patchset implements this suggested approach.

The whole reason I started the SPF thing waay back when was because one
of the primary reporters at the time had very large VMAs and a per-vma
lock wouldn't actually help anything at all.

IIRC it was either scientific code initializing a huge matrix or a
database with a giant table; I'm sure the archives have better memory
than me.

