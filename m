Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3150A63A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351677AbiDUQyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbiDUQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:54:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901354888F;
        Thu, 21 Apr 2022 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nokgEa2HolX7WWxhI5hndPhelPjuw7thbF93zCKCMdA=; b=qftrAhVi/nehnq1OBPEsVl1VoT
        HD14CRCXX+aMfyYuu0gzFJmTCKNTZy6Y5PmnJbUThuPkFtXuSxZTtGDL1vREsxCg9j8BQov9pgZJ6
        rLYWE2V+gwqxfgDFIoG5VuaV4If9GFtG3XRtt1anmmzdAs6B9Wbi+feA5fMXQcqnCdZE5zUz3Ul/V
        sGsz94fgP7HgwHZl88jRBU/4RYh5w74uje5/W/LPyz878lUGPiEmwoEROzUxNycuAspjMXEv3zo3P
        weJCn6DDBdemFYJs/A0PslHL/eVJkSM3oxuYJV7sptzZYtgeoUS1JwGWd+6/pDBgvG4ydMEYVJrmj
        xKBhgacw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nha1m-00EK0q-NS; Thu, 21 Apr 2022 16:51:34 +0000
Date:   Thu, 21 Apr 2022 09:51:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        v.narang@samsung.com, swboyd@chromium.org, ojeda@kernel.or,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, onkarnath.1@samsung.com
Subject: Re: [PATCH modules-next 1/1] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Message-ID: <YmGLliGQBDzMBRP0@bombadil.infradead.org>
References: <CGME20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680@epcas5p4.samsung.com>
 <20220421041542.9195-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421041542.9195-1-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:45:42AM +0530, Maninder Singh wrote:
> print module information when KALLSYMS is disabled.
> 
> init_build_id() function is moved to module/main.c as it can be
> independent of kallsyms.
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
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>

Thanks! Queued onto modules-testing. If there are no complaints from the
build I'll move this to modules-next.

  Luis
