Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03A57A071
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiGSOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbiGSOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:05:11 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D005E82C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:19:38 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1oDn8O-0006Nm-UH; Tue, 19 Jul 2022 15:19:32 +0200
Message-ID: <9011132e-d78b-8bec-10cb-2b3d77a4e1fc@maciej.szmigiero.name>
Date:   Tue, 19 Jul 2022 15:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        hjl.tools@gmail.com, andrew.cooper3@citrix.com,
        mark.rutland@arm.com, will@kernel.org, ndesaulniers@google.com,
        x86@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
References: <20211204134338.760603010@infradead.org>
 <20211204134908.140103474@infradead.org>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Missing SLS int3 in JMP_NOSPEC? (Was: [PATCH v2 6/6] x86: Add
 straight-line-speculation mitigation)
In-Reply-To: <20211204134908.140103474@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.12.2021 14:43, Peter Zijlstra wrote:
> Make use of an upcomming GCC feature to mitigate
> straight-line-speculation for x86:
> 
>    https://gcc.gnu.org/g:53a643f8568067d7700a9f2facc8ba39974973d3
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
>    https://bugs.llvm.org/show_bug.cgi?id=52323
> 
> It's built tested on x86_64-allyesconfig using GCC-12 and GCC-11.
> 
> Maintenace overhead of this should be fairly low due to objtool
> validation.
> 
> Size overhead of all these additional int3 instructions comes to:
> 
>     text	   data	    bss	    dec	    hex	filename
> 22267751	6933356	2011368	31212475	1dc43bb	defconfig-build/vmlinux
> 22804126	6933356	1470696	31208178	1dc32f2	defconfig-build/vmlinux.sls
> 
> Or roughly 2.4% additional text.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
(..)
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -34,7 +34,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\re
>   
>   	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
>   		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
> -		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
> +		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_AMD
>   
>   .endm
>   

Looking at this __x86_indirect_thunk_* change makes me wonder why there is
no similar int3 SLS protection in the X86_FEATURE_RETPOLINE_LFENCE case of
JMP_NOSPEC in arch/x86/include/asm/nospec-branch.h:
> .macro JMP_NOSPEC reg:req
> #ifdef CONFIG_RETPOLINE
> 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
> 		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
> 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
> #else

JMP_NOSPEC users seem to have no explicit trailing int3 instructions
either.

Or am I missing something here?

Thanks,
Maciej
