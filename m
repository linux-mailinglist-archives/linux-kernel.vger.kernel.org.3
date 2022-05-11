Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416F522D27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiEKHXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiEKHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:23:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421515E760
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mX/LPDRiM2kjAACGQpTgwsVpipKtiyAP/j4T+KMpNkM=; b=H2/3L8F7yOeN39Y9I52eNdrzPI
        6WJJqorodqUEV1tadzEdsg+pmg6ApMstzoETm5LYfYIBf3jRFe8ZM1oLQaOn9g5/nU+BYx+jZmCtV
        ApK+n2Bs6quvnCfX3491X21sptzS+5fRS7wH70EJWI3PM9Vr6l8PHIFBC41q+6VGbMKkzmqzVSSIh
        TJCgpvJIGzzZw7tB91z4c6ujByRcMa6t3HzePMVu95nTb6jdQkB5t2CSmI6cNNONuOmEEWC8gbhen
        5hWhj7bZa6MMBdMpkYJ0YtnTQ/ORRuQeE0mXNJ7dfgu9vJCcxc+9kX7K9Le2UDRskwC0u73X4T4p2
        WSpasbIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noggg-005EEx-Kt; Wed, 11 May 2022 07:23:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 445C3980E3A; Wed, 11 May 2022 09:23:10 +0200 (CEST)
Date:   Wed, 11 May 2022 09:23:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 07/10] x86/mm: Handle tagged memory accesses from kernel
 threads
Message-ID: <20220511072310.GU76023@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511022751.65540-9-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:27:48AM +0300, Kirill A. Shutemov wrote:
> When a kernel thread performs memory access on behalf of a process (like
> in async I/O, io_uring, etc.) it has to respect tagging setup of the
> process as user addresses can include tags.
> 
> Normally, LAM setup is per-thread and recorded in thread features, but
> for this use case kernel also tracks LAM setup per-mm. mm->context.lam
> would record LAM that allows the most tag bits among the threads of
> the mm.

Then why does it *ever* make sense to track it per thread? It's not like
it makes heaps of sense to allow one thread in a process to use LAM but
not the others.
