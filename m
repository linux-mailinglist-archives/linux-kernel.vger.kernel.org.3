Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0251354DE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359714AbiFPKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiFPKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:01:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808B5C872
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CgVWCHgWJJT3XNAbwXXT31wUhHpLBydJuqr4cEkRcRg=; b=svndT7e0vHjSg2FVR5ABLL492R
        IBtvGgXVEG5zhGj5aNFh88vSwSzeRBdB1MBdUnYvsy9jCMe2cA+Wt0G4hjDRsv7wJbDrxi6i7BIDU
        7R1xPG91BSSXR6pN3fWYbtYx8ONsk5qrJgZBqZUqfCP1UHoZ2miHsNV1Gac7VMH747b5J1vn/1ijN
        VyRNaMy9QDV+NANfFtZ+IfN5dRQ+wvP3CezJog+UrECePy2EoNzEmF68hlLHwODy9dd5ylyEQF9pY
        2y98Qiax+HEcswDRZS2wlgcugb3gUJ3VVKg+ORcJKrjVJWkGX9gSOmvCVWRkOvyHlcaH++RCuqJsc
        4W4FsX0A==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1mJ9-001r0b-S3; Thu, 16 Jun 2022 10:00:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BE763006C2;
        Thu, 16 Jun 2022 12:00:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2E97201A4015; Thu, 16 Jun 2022 12:00:57 +0200 (CEST)
Date:   Thu, 16 Jun 2022 12:00:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 OPTIONAL 8/8] x86/mm: Extend LAM to support to LAM_U48
Message-ID: <Yqr/WdgRb1IEDMVk@hirez.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610143527.22974-9-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 05:35:27PM +0300, Kirill A. Shutemov wrote:
> LAM_U48 allows to encode 15 bits of tags into address.
> 
> LAM_U48 steals bits above 47-bit for tags and makes it impossible for
> userspace to use full address space on 5-level paging machine.
> 
> Make these features mutually exclusive: whichever gets enabled first
> blocks the other one.

This patch is broken in that it doesn't fix untag_pointer()

*If* you really want to continue down this road; you'll need something
like:

#define untagged_addr(mm, addr)        ({                              \
       u64 __addr = (__force u64)(addr);                               \
       s64 sign = (s64)__addr >> 63;                                   \
       __addr ^= sign;                                                 \
       __addr &= (mm)->context.untag_mask[sign & 1];                   \
       __addr ^= sign;                                                 \
       (__force __typeof__(addr))__addr;                               \
})

Which uses a different mask for kernel and user pointers.

Anyway, without this U48 patch on, the mask could be a constant, no need
to keep this variable, we can unconditionally unmask U57.

Let me go reply to that other mail too.
