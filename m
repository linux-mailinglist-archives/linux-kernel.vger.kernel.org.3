Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954D2516D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384140AbiEBJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384175AbiEBJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:19:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5C2FFC5
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qWaU7fU32JneqOsjE48g+9bculTaZxyLrP8LghP2GLg=; b=J45XSfSH8Zo5/WwDN4b77MrBfb
        Y3jRSKVhuYX8C3gnmzjZwXOsxDy6qK6L/6I1R3G5KbT9HDP1EfQ24R7Ry58gC3TAKTf4AYa2fWaea
        j80osFx0OTQMe58F8jEWuugpUs86oCK3xnp67aZ1oWCMPTayU+FADbudMdM3CdFTTlQlCbrLjZfdr
        wg6IOTHrksYf2irkoVijD2t3vs9oy7K9EW0kcwMfiRZRKQHPK+24hJWjy5fe2VeTOF5DMKbWv59zK
        wZ7WOWxLKyUMXNoJazZcm3FQuhFu5UpD0FtUCN9H34FDzd0qAH/otD6eKsPN96C/cgZ1BjYTaalh2
        Dm50GDyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlS9F-00Egx6-48; Mon, 02 May 2022 09:15:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC44698035B; Mon,  2 May 2022 11:15:14 +0200 (CEST)
Date:   Mon, 2 May 2022 11:15:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [tip:master 18/29] fs/ntfs3/ntfs3.prelink.o: warning: objtool:
 ni_read_frame() falls through to next function ni_readpage_cmpr.cold()
Message-ID: <20220502091514.GB479834@worktop.programming.kicks-ass.net>
References: <202205021021.6sless1W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205021021.6sless1W-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 10:34:28AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> head:   aea1ae1ab93e60b266453b008238fbc5f0c65865
> commit: ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3 [18/29] Merge objtool/core into tip/master
> config: x86_64-randconfig-c001-20220502 (https://download.01.org/0day-ci/archive/20220502/202205021021.6sless1W-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip master
>         git checkout ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/ntfs3/ntfs3.prelink.o: warning: objtool: ni_read_frame() falls through to next function ni_readpage_cmpr.cold()

That is in fact:

000000000000124a <ni_read_frame.cold>:
    124a:       44 89 e0                mov    %r12d,%eax
    124d:       0f b6 55 98             movzbl -0x68(%rbp),%edx
    1251:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1254: R_X86_64_32S      .data+0x1380
    1258:       48 89 c6                mov    %rax,%rsi
    125b:       e8 00 00 00 00          call   1260 <ni_read_frame.cold+0x16>   125c: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
    1260:       48 8d 7d cc             lea    -0x34(%rbp),%rdi
    1264:       e8 00 00 00 00          call   1269 <ni_read_frame.cold+0x1f>   1265: R_X86_64_PLT32    __tsan_read4-0x4
    1269:       8b 45 cc                mov    -0x34(%rbp),%eax
    126c:       e9 00 00 00 00          jmp    1271 <ni_read_frame.cold+0x27>   126d: R_X86_64_PC32     .text+0x19109
    1271:       48 8b 75 a0             mov    -0x60(%rbp),%rsi
    1275:       48 63 d0                movslq %eax,%rdx
    1278:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        127b: R_X86_64_32S      .data+0x13a0
    127f:       89 45 88                mov    %eax,-0x78(%rbp)
    1282:       e8 00 00 00 00          call   1287 <ni_read_frame.cold+0x3d>   1283: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
    1287:       8b 45 88                mov    -0x78(%rbp),%eax
    128a:       e9 00 00 00 00          jmp    128f <ni_read_frame.cold+0x45>   128b: R_X86_64_PC32     .text+0x19098
    128f:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1292: R_X86_64_32S      .data+0x11f0
    1296:       e8 00 00 00 00          call   129b <ni_readpage_cmpr.cold>     1297: R_X86_64_PLT32    __ubsan_handle_builtin_unreachable-0x4

000000000000129b <ni_readpage_cmpr.cold>:


The below seems to fix.


---
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2063f9fea1a2..d5189f5ec69e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -185,6 +185,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"stop_this_cpu",
 		"__invalid_creds",
                "cpu_startup_entry",
+	       "__ubsan_handle_builtin_unreachable",
 	};

 	if (!func)

