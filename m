Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B69522C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbiEKGuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiEKGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:50:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8652438C8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wb2IprcNdbCRFCgYDckZft2aeKRMMRpizPTVHCdq9g0=; b=oWKuI4E3xRnBU4umLmcQ1pnmQf
        LBr3d8Mp4iRH4vwyhYDq2IOOss3+KBuyWkhsc7rtMVBjlMEqnAfNVgaq93uubMCwyzOd5FZbyTZzG
        sbegnrNLtPGySXv5K4yfgixrJYiH4vI0lM1+oPYgUAi4hyeRytVJI8ddGe8D3C6IISSm9YIkyvcoj
        TMz5R6HKyqiDeyzEQNaO7tjB3YUfosoj0dZ5GpW3kXYWZSJ+62ETrVWScB+OGgJlKwipYnvClE0ey
        JfUGQ66pzagM/JllXwO6R/4wQoO3PlL6s9wMWtRJ7pmJULeFiIhk6h+0k4tRn57uwDBOKyeuTYHYM
        urGdqZlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nogAM-005CRz-5i; Wed, 11 May 2022 06:49:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC5ED980E3A; Wed, 11 May 2022 08:49:43 +0200 (CEST)
Date:   Wed, 11 May 2022 08:49:43 +0200
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
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Message-ID: <20220511064943.GR76023@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:27:40AM +0300, Kirill A. Shutemov wrote:
> Hi all. Here's long overdue update on LAM enabling.
> 
> # Description #
> 
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
> 
> The patchset brings support for LAM for userspace addresses.
> 
> The most sensitive part of enabling is change in tlb.c, where CR3 flags
> get set. Please take a look that what I'm doing makes sense.
> 
> The feature competes for bits with 5-level paging: LAM_U48 makes it
> impossible to map anything about 47-bits. The patchset made these
> capability mutually exclusive: whatever used first wins. LAM_U57 can be
> combined with mappings above 47-bits.

So aren't we creating a problem with LAM_U48 where programs relying on
it are of limited sustainability?

Any such program simply *cannot* run on 5 level pagetables. Why do we
want to do this?
