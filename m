Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1F59C04E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiHVNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiHVNO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:14:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8F275CD;
        Mon, 22 Aug 2022 06:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7E1CB81216;
        Mon, 22 Aug 2022 13:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C943C433B5;
        Mon, 22 Aug 2022 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661174062;
        bh=SEh3mF7ErUNfvVH/oVHuD4yxNekDIazJvrYvjkTf/wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdNZ0LYu5Rx+ziVjZkM4Hi/80XTmYVjC+0m651EfSjVbUv8Xg64kNcTIwfGaLhdbZ
         ZExpIhp4TlYJdPB8G0BWjFChLLjxRjG6kTcLb1EayDD7ye12REKi3JIiC5+szvM+Ea
         e5ltKuMpuiie5AFJ0f+V4+FpeNTsbrVmQ785pkpjSTEwmD3hu4vHeLyfXTUA9FghdQ
         1sCG200GTk65GrZRuKErqQyD3dBF9bM0oL0/tveElV/6A9y38s1Ex4RCtQpEQEQLuB
         mxeO5D01NKWCStn2JV2q5Gyw1zh3Q3+nUCdM8dtHhq3aptev7zYxf+hXa4KhqNDvqU
         FgUXzMlIeZv6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE2F0404A1; Mon, 22 Aug 2022 10:14:19 -0300 (-03)
Date:   Mon, 22 Aug 2022 10:14:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, bp@suse.de,
        ndesaulniers@google.com, nathan@kernel.org,
        alexandre.belloni@bootlin.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix compile error for x86
Message-ID: <YwOBKwPmW/FX6hSS@kernel.org>
References: <20220822092557.210209-1-yangjihong1@huawei.com>
 <YwNcgdk/p18Cr+uv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwNcgdk/p18Cr+uv@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 22, 2022 at 12:37:53PM +0200, Ingo Molnar escreveu:
> 
> * Yang Jihong <yangjihong1@huawei.com> wrote:
> 
> > Commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO") eradicates
> > CC_HAS_ASM_GOTO, perf on x86 call asm_volatile_goto when compiling __GEN_RMWcc.
> > However, asm_volatile_goto is not declared, which causes compilation error:
> > 
> > In file included from /home/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h:7,
> >                  from /home/linux/tools/include/asm/atomic.h:6,
> >                  from /home/linux/tools/include/linux/atomic.h:5,
> >                  from /home/linux/tools/include/linux/refcount.h:41,
> >                  from /home/linux/tools/lib/perf/include/internal/cpumap.h:5,
> >                  from /home/linux/tools/perf/util/cpumap.h:7,
> >                  from /home/linux/tools/perf/util/env.h:7,
> >                  from /home/linux/tools/perf/util/header.h:12,
> >                  from pmu-events/pmu-events.c:9:
> > /home/linux/tools/include/asm/../../arch/x86/include/asm/atomic.h: In function ‘atomic_dec_and_test’:
> > /home/linux/tools/include/asm/../../arch/x86/include/asm/rmwcc.h:7:2: error: implicit declaration of function ‘asm_volatile_goto’ [-Werror=implicit-function-declaration]
> >   asm_volatile_goto (fullop "; j" cc " %l[cc_label]"  \
> >   ^~~~~~~~~~~~~~~~~
> > 
> > Solution:
> > Define asm_volatile_goto in compiler_types.h if not declared.
> > 
> > Currently, only x86 architecture uses asm_volatile_goto.
> > Theoretically, this patch affects only the x86 architecture.
> > 
> > Fixes: a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO")
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > ---
> >  tools/include/linux/compiler_types.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
> > index 24ae3054f304..1bdd834bdd57 100644
> > --- a/tools/include/linux/compiler_types.h
> > +++ b/tools/include/linux/compiler_types.h
> > @@ -36,4 +36,8 @@
> >  #include <linux/compiler-gcc.h>
> >  #endif
> >  
> > +#ifndef asm_volatile_goto
> > +#define asm_volatile_goto(x...) asm goto(x)
> > +#endif
> 
> Tested-by: Ingo Molnar <mingo@kernel.org>

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Linus, I'll prep a pull req later today or you can apply this so that we
can reduce the window where tools/perf/ isn't building.

- Arnaldo
