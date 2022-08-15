Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075EA59302C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiHONoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbiHONn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:43:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211C22538
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xAbhSHTyhYfiOMcbvhSTpSJFMq8Zh5CE32rvygg3JG4=; b=dOmUTCATwFfwZ/P231/IatKal/
        SS/oZPAPoavCRrL7O5HF4WQ46rSOIUNj9sjJgpKFBqdoYEJmWJaZg6SCMMoGuDI8Tt2lqdy/vjbHk
        A+ic52BCuNY6d6dyXC6zApCV6SrlG/z5TjZrb/vsPX5vvJBsWF7R2kHLAApzeYQ5JMEh0/VEeVsWG
        l2QLFg/qo6ZhDJoil82rOTfAqamRDDveMzGOkycNeueaKC6OxY/IomVq8Nh1MYRnFpVJKq8Zk4jxh
        YxB5K7PvzqbNEnrKxKSW1S+aExelMltKz4PM4SPGbrkxGnkIhQJ4+1a3x2HSHjyQODEacbTLimtL3
        rs8ry4xA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNaNj-005l96-SN; Mon, 15 Aug 2022 13:43:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1600F980153; Mon, 15 Aug 2022 15:43:51 +0200 (CEST)
Date:   Mon, 15 Aug 2022 15:43:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 00/11] Linear Address Masking enabling
Message-ID: <YvpNlqnxRkeZ/Tfi@worktop.programming.kicks-ass.net>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 07:17:52AM +0300, Kirill A. Shutemov wrote:

> Kirill A. Shutemov (7):
>   x86/mm: Fix CR3_ADDR_MASK
>   x86: CPUID and CR3/CR4 flags for Linear Address Masking
>   mm: Pass down mm_struct to untagged_addr()
>   x86/mm: Handle LAM on context switch
>   x86/uaccess: Provide untagged_addr() and remove tags before address
>     check
>   x86/mm: Provide arch_prctl() interface for LAM
>   x86: Expose untagging mask in /proc/$PID/arch_status

Over-all these are not terrible.. I've replied with a few nits; with
those fixed:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
