Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ECB461F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379462AbhK2SyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379565AbhK2SwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:52:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE7C043CF0;
        Mon, 29 Nov 2021 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fGya+d7JQ+VE2Ixm7VmIitr62xoALtxhc2z8CJxZNJE=; b=Z5p2PXVAcRjmbrHa3NKplEsb+o
        o/aiFiuACfd7c8jVkKm1AZolMeL8KnZTRMbQhIwhcKbBXEq8nH5eM+uUPfojl9m/Y7z4HHK8WUeHK
        PFxamuEIk3xZp6FLb+6iYBXYxGlt69id6SdwXNRAYjlCWt3J6MDd7uyCs9w+H8slulKxwdiRrxFSe
        ObpIdHYxv4U+j69nj13JCATwsVMoR5PrgBXS/0M58AVetgT33mp5MYgEFPKtMZeLQfbxO1CmaSGaQ
        IpmEtUFm3nZbxEK3YWmYxmiq45Jm08HDUZKyl4w23292qiIdBJEWVPsqI67YcY2LIdU6p3rYrgmsx
        dEJCv0IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mriG5-0083LL-E4; Mon, 29 Nov 2021 15:07:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C03F9300235;
        Mon, 29 Nov 2021 16:07:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A72942B2FE9E1; Mon, 29 Nov 2021 16:07:57 +0100 (CET)
Date:   Mon, 29 Nov 2021 16:07:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YaTszYhYoprITiF1@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <YaFcyzq0WpnXu+2R@hirez.programming.kicks-ass.net>
 <87r1b2fldw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1b2fldw.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 02:16:43AM +0100, Thomas Gleixner wrote:

> So yes, this should work, but I hate the sticky nature of TIF_UMCG. I
> have no real good idea how to avoid that yet, but let me think about it
> some more.

Yeah, that, I couldn't come up with anything saner either.
