Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516794C70CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiB1PgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiB1PgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:36:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8943269CD1;
        Mon, 28 Feb 2022 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GNPd2mBhTgr/5Zdb0t0XFMB2uX9xNt+6bXBEBE0PVvc=; b=5CuTzGzBCJfw5uqXXDfM577KCE
        nH/HWTEjZNDCGG2goDLArSLnuJswpiT0GVi9HiV7zGyKUYv4+GXWbL6h7vGyCsRJZ3fQUs3MO4XDE
        z2zjrlhrfVdxuSlV8W7gBfilrj/+3A412Qps3U2OCTnkf+UdHE5N+qIGhJ9XIdFRJ8fmkzMkhoYbt
        spf6tjl2zmXFK5X3O0pP7kAmBfPRKKzvrWDAX32uIia4YZ4XhyZ33c36Jje9GMd1xGMQFbDdDDW5M
        T788IZBcY9QXyFF3L4HLDFYXRY6UT5thMGKVICtpzaej9pwe090e0gfV7I7v7CKHZbpnE1ldrjDYp
        nbYi1APQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOi3g-00DAcP-06; Mon, 28 Feb 2022 15:35:32 +0000
Date:   Mon, 28 Feb 2022 07:35:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.or,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com
Subject: Re: [PATCH 1/1] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <YhzrwwqGTFKVCiFy@bombadil.infradead.org>
References: <CGME20220228053457epcas5p1dac3fced39d1594f8fdfc5e64e23ac73@epcas5p1.samsung.com>
 <20220228053447.1584704-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228053447.1584704-1-maninder1.s@samsung.com>
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

On Mon, Feb 28, 2022 at 11:04:47AM +0530, Maninder Singh wrote:
> with commit '82b37e632513 ("kallsyms: print module name in %ps/S
> case when KALLSYMS is disabled"), module name printing was enhanced.
> 
> As per suggestion from Petr Mladek <pmladek@suse.com>, covering
> other flavours also to print build id also.
> 
> for %pB no change as it needs to know symbol name to adjust address
> value which can't be done without KALLSYMS.
> 
> original output with KALLSYMS:
> [8.842129] ps function_1 [crash]
> [8.842735] pS function_1+0x4/0x2c [crash]
> [8.842890] pSb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> [8.843175] pB function_1+0x4/0x2c [crash]
> [8.843362] pBb function_1+0x4/0x2c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> 
> original output without KALLSYMS:
> [12.487424] ps 0xffff800000eb008c
> [12.487598] pS 0xffff800000eb008c
> [12.487723] pSb 0xffff800000eb008c
> [12.487850] pB 0xffff800000eb008c
> [12.487967] pBb 0xffff800000eb008c
> 
> With patched kernel without KALLSYMS:
> [9.205207] ps 0xffff800000eb008c [crash]
> [9.205564] pS 0xffff800000eb0000+0x8c [crash]
> [9.205757] pSb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> [9.206066] pB 0xffff800000eb0000+0x8c [crash]
> [9.206257] pBb 0xffff800000eb0000+0x8c [crash b367e79021b9f3b0172f9a36d4261c1f528ca1b3]
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
> earlier discussion: https://lkml.org/lkml/2022/2/10/185
> 
>  include/linux/kallsyms.h | 27 --------------
>  kernel/module.c          |  4 +--

See Aaron's work which you'll need to base your work on:

https://lkml.kernel.org/r/20220222141303.1392190-1-atomlin@redhat.com

Soon Aaron will post a v9.

  Luis
