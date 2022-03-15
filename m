Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61C4DA19A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbiCORy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiCORyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:54:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6DB366AF;
        Tue, 15 Mar 2022 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=52rHBF+vZNkINQkzy+dQdKO7m6EguFtfzcKt22qdjiM=; b=HPlL8HyK99RwRZsRjeZp9Cpjg4
        kISmRHdkZ49afWq1i4XuJmFWaG55ZUixdCnFq6GiXS3Dum+u2pUiRYSDCexImxtj91un1A+z2DhRz
        SANGmL9f1drkYJPxYA91MhQPebwpPhLoAef9WkkDOltg6gHJGUYOa4AEOAT1jtzA9XMPmfpBqwL3n
        QBYuLtvZB6p+f82lu7MzZl8+16TmJDfHVaGFcQNnoVDv8EkpwMf3hmBKmbiRlm5Sxb7zs2BQo25BX
        yOWqlIAWFs9fFXCIDsQFWb3L1HtUu2oBjf7uo2sbIDyxI+55Jvy6Jf3O2e6TthmbW0UR2Fwi8dVQH
        /CZcrmAA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUBLk-00A6wK-1k; Tue, 15 Mar 2022 17:52:48 +0000
Date:   Tue, 15 Mar 2022 10:52:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com
Subject: Re: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <YjDScHjMUbqYV4s4@bombadil.infradead.org>
References: <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcas5p2.samsung.com>
 <20220315155100.516107-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315155100.516107-1-maninder1.s@samsung.com>
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

On Tue, Mar 15, 2022 at 09:21:00PM +0530, Maninder Singh wrote:
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
> ---
> commit id 'kallsyms: print module name in %ps/S case when KALLSYMS is disabled'
> 	needs to be removed from mm(linux-next) tree, current change is
> 	with ignorance of this commit. I was not sure how to send patch, with 2 patches
> 	consisting reversal commit also, or current approach is correct.
> 
> v1->v2: hash base address of module, change *fmt to fmt[0] and removed
>         copy paste.
> v2->v3: fixed review comments from Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
>  include/linux/kallsyms.h |  2 +
>  include/linux/module.h   | 20 ++++++++++
>  kernel/kallsyms.c        | 27 +++++++------
>  kernel/module.c          |  4 +-
>  lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------

Hey Maninder, thanks for your patch!

Since this touches kernel/module.c and include/linux/module.h I'd prefer
this go through modules-next [0], and as you will see that's a different
world right now. I also have a set of at least 2 other patch sets to
merge there before yours.

Also, what is on modules-next is not intended to go to Linus for the
next merge window as the changes there got merged only late, and I want
at least 2 months of testing on linux-newt before any pull requiest is
sent to Linus.

Can you rebase to modules-next? I can evaluate the patches then for
integration there once the other stuff gets merged into that tree too.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
