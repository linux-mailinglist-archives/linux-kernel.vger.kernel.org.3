Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF80516F21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384778AbiEBL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiEBL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:58:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314CC1A054
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:54:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so19293080wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wnboMuk98NbOCluwVedMtYJYD9IwCf//+J2qQMcG5uA=;
        b=cxrZzZXq7X0MO2kCIsNdZQ/xGFTH3T/SpPQ2T4gRiUnBO7HQISRErPKAM70lzZNNIO
         xI3QdPD15aA8Ylh6h9zHlRJhCjbsJ8laJUqVsBmJgIuyJeQC2lHABcMuExKjcCqTpSlZ
         bKKG6iNnHeL/ee0AHYGhxup0O+CQw0c712SWqxOKqqA1cxMyl0/ZgIIsx62WX9JhDTgI
         OE9yndC1qLjMl33Erh6hQM1S+kk8Dp781QAkg7FoGAA9zNzb/R7WZzKDma4pEm+RELxi
         dItoWO7dRIwMjbBcdmVJc49MJf6eoDL325KN+VnrFWPzpZhT0D6Y9wULFX2GzXoFgpNv
         sQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wnboMuk98NbOCluwVedMtYJYD9IwCf//+J2qQMcG5uA=;
        b=ch/DtyQGumQaXE0HvMHK+ZEZ1FhSXyABGl/64N2GTtCNni9FjjuNtVXashUNZafv18
         kimbJDWekvu36HSGzfAHCRceNLRbIVcGxbHfDi6DMOU7eEhbyIjsJ6+yVBYC0qRr4mE1
         lqDXIiP+7SpXxIReDxT2A3bQRPL83Pml+cMPffoSgwqHJJhPxU4gErKsc3WN6WCtUIzn
         rOiD2cP/DwaXnP5HYydi+BJtlMdZBg4URFy1oMye6KqeQ2uzUlSSWzVI/P3TAK67KHIW
         xnXL5b9CaDDXDpQXe7wpw3HlZJ22BP7tJdb1M/9Z/7SG8GS05UyvPCJydtptMI1Q+L/2
         tFJw==
X-Gm-Message-State: AOAM533PpfLlYXTjP3olm2cTgyFR8NMg3dDhsTmhtKerth0vrPH4f1TK
        /hXQGC4gP+ve+JcWEx+bjqR7Ww==
X-Google-Smtp-Source: ABdhPJzbCQV9n5mAsaBDnp4iw4I7bOM4gnJ5QgpkiQuUST+ZT91rGnm4dyOzj6hTrz+p1b/TjR+Mmg==
X-Received: by 2002:adf:b613:0:b0:20a:c7db:3ce4 with SMTP id f19-20020adfb613000000b0020ac7db3ce4mr9303420wre.70.1651492495623;
        Mon, 02 May 2022 04:54:55 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:bdb8:d8d3:6904:292f])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b00394365abb2bsm3174924wms.42.2022.05.02.04.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 04:54:55 -0700 (PDT)
Date:   Mon, 2 May 2022 13:54:49 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] x86/cpu: Elide KCSAN for cpu_has() and friends
Message-ID: <Ym/GiZUb6Vqg+hy/@elver.google.com>
References: <20220502110741.951055904@infradead.org>
 <20220502111216.290518605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502111216.290518605@infradead.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 01:07PM +0200, Peter Zijlstra wrote:
> vmlinux.o: warning: objtool: enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x28: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Marco Elver <elver@google.com>

And should fix the same issue for other sanitizers that get instrumented
test_bit() via asm-generic/bitops/instrumented-*.h, not just KCSAN.

> ---
>  arch/x86/include/asm/cpufeature.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -51,7 +51,7 @@ extern const char * const x86_power_flag
>  extern const char * const x86_bug_flags[NBUGINTS*32];
>  
>  #define test_cpu_cap(c, bit)						\
> -	 test_bit(bit, (unsigned long *)((c)->x86_capability))
> +	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
>  
>  /*
>   * There are 32 bits/features in each mask word.  The high bits
> 
> 
