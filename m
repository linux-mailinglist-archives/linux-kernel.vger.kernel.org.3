Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9170F4E452F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiCVRdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiCVRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:33:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631A26AF8;
        Tue, 22 Mar 2022 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NFkGwkkhrXKsXoNixvjMqhth6GVq1xT6H5Lol9T+VgU=; b=IR9zRK//WRfac+j77k3QtuHdQX
        EIPyO0vIrQX4N5JoOX9kGpQFG9RNjID2VdiaJliR/IGjMTEEXCTL30GPpejZTR270Z7oeHcsCiVVt
        /9C+hoeDPFXYIRlEJEwhsAhCIj9hxyvU94pGeVq64F9cqA55TCgSdBm4D4knqSshcqYAsnFkb3yxS
        0/r6qwEn4PjLuocTXtfxJtopFGCyUOY6OXVc9+p+zbPSLWSmAy1e61+FInhcqDvWE5Fkjvms/ljDn
        1X+P73+wiHNENBM4w7eOfb9hlOPp16sU8GW5hnxE37yy0VN0cJaxVUPYMlZUSoKOvnFBBtLul+3Pf
        GCgTlcCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWiMC-00BkCB-9u; Tue, 22 Mar 2022 17:31:44 +0000
Date:   Tue, 22 Mar 2022 10:31:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>,
        Vimal Agrawal <avimalin@gmail.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, keescook@chromium.org,
        ndesaulniers@google.com, rdunlap@infradead.org, void@manifault.com
Subject: Re: [PATCH 1/1 module-next] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Message-ID: <YjoIAF/FoFDFMiOi@bombadil.infradead.org>
References: <CGME20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933@epcas5p2.samsung.com>
 <20220316043540.677128-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316043540.677128-1-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:05:40AM +0530, Maninder Singh wrote:
> print module information when KALLSYMS is disabled.
> 
> No change for %pB, as it needs to know symbol name to adjust address
> value which can't be done without KALLSYMS.
> 
> (A) original output with KALLSYMS:
> [8.842129] ps function_1 [crash]
> [8.842735] pS function_1+0x4/0x2c [crash]
> [8.842890] pSb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> [8.843175] pB function_1+0x4/0x2c [crash]
> [8.843362] pBb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> 
> (B) original output without KALLSYMS:
> [12.487424] ps 0xffff800000eb008c
> [12.487598] pS 0xffff800000eb008c
> [12.487723] pSb 0xffff800000eb008c
> [12.487850] pB 0xffff800000eb008c
> [12.487967] pBb 0xffff800000eb008c
> 
> (C) With patched kernel
> with KALLYSMS:
> [41.974576] ps function_1 [crash]
> [41.975173] pS function_1+0x4/0x2c [crash]
> [41.975386] pSb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> [41.975879] pB function_1+0x4/0x2c [crash]
> [41.976076] pBb function_1+0x4/0x2c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> 
> without KALLSYMS:
> [9.624152] ps 0xffff800001bd008c [crash]	// similar to original, no changes
> [9.624548] pS 0x(____ptrval____)+0x8c [crash]   // base address hashed and offset is without hash
> [9.624847] pSb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> [9.625388] pB 0x(____ptrval____)+0x8c [crash]
> [9.625594] pBb 0x(____ptrval____)+0x8c [crash a8b20caaec9635b316cf4812f6b55598fe2b7cee]
> 
> with disable hashing:
> [8.563916] ps 0xffff800000f2008c [crash]
> [8.564574] pS 0xffff800000f20000+0x8c [crash]
> [8.564749] pSb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
> [8.565008] pB 0xffff800000f20000+0x8c [crash]
> [8.565154] pBb 0xffff800000f20000+0x8c [crash 3423a8993a7033fb79e5add14bf9d8d6b56330ca]
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

I've pushed a lot of queued code into modules-testing (not modules-next
yet) [0] please base your changes on that in a new iteration as that is what
things look like now.

Vimal might be interested in your work too and you might be interested
in his patch too [1].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-testing
[1] https://lkml.kernel.org/r/CALkUMdRO+JAF_Dw3Q-mHOxvt7uM6gVDNGAA3OMeCUpnSvi7_Pg@mail.gmail.com

  Luis
