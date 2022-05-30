Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC8A537B29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiE3NO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiE3NOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:14:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B630F64
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:14:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k19so6416934wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqpmVnuueZQIlhBb560o3jiUPdmh9qmgxvpm22XE9vM=;
        b=GMTaxPbUqiwzHpHfkliB8mj7se8B6PzPUTvAMZdLtcGnLWiiJbXMYAVwKmUrThTfZd
         7hpNWNuyx0Ttnh2y3LKFdDvfWpKFiqUCnrk6IUapEtaRWb/kC8+cTgtp/bHjXF56N8Ij
         74JeOKQ3YgehnwAPeJZvInf3ouOgmEKhCOv+TfIyP/Xe7V2kP6spGrUS4bXo7XRk9+Yw
         6BILXAK8D59e4fUgAov4u4KE8zIVtncceXzpGjilkZp6k2wy8EHUyyaYDD5lN+jxfJ3m
         ttobB+h0Kc4w+gan1Lv/Cp0Tji0MRHuVELPOyi2rGyjY4y3uAPeqXQuKmSw8BMfWtwfw
         0j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqpmVnuueZQIlhBb560o3jiUPdmh9qmgxvpm22XE9vM=;
        b=X5BxZs2mEuAIG628YrAWx5F89CCeApm1nulRvDPnXtuMmhFMsBWdX2pU+xBdk0z2dd
         FrWKgkXQg6tjmdQQapMJE4HWisAcIqkbXk7biK2BFV6GTItoGQR3ar5G+8zgGHNYKI7G
         MtQBLZbjvuFyLY20M5GNodox1/sLOGYGZPW4tJaheZl37QLLQcrKf6jODJ+xosnN0RyO
         hhJ+bTBJ9/LokmfYXPl/JawSJzOPdRIk+9S4vY4/Qc+FmYmk3q+KKSNhhEYD3AiKygnm
         hU61BA00hqLTcZ8MF8DJEdpQ5fDduuTu1+c+nxHLmyf7/LOpbNk+K5ZSzOUQrfDOezlE
         lJOQ==
X-Gm-Message-State: AOAM530m5N2pQoTxOlYfhhTD1dVTosUSXdTukWo0GXa6NVx5Z0/NqArP
        u6pIdI/PnXMVsJC6thA0dl959Q==
X-Google-Smtp-Source: ABdhPJxQXzAcuUBoixPcrN69srTJpY3wO9TCvwr9ZTgR2YeGk8NcoeWXn8GRB7VV4Gy1c9ONfKzyHA==
X-Received: by 2002:a5d:6dc3:0:b0:210:89d:30bc with SMTP id d3-20020a5d6dc3000000b00210089d30bcmr17971785wrz.272.1653916491972;
        Mon, 30 May 2022 06:14:51 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:c918:d0ea:5b07:e1c3])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003974860e15esm11712274wms.40.2022.05.30.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:14:51 -0700 (PDT)
Date:   Mon, 30 May 2022 15:14:44 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        mark.rutland@arm.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 4/7] x86/cpu: Elide KCSAN for cpu_has() and friends
Message-ID: <YpTDRFGcEGIO0h06@elver.google.com>
References: <20220526105252.440440893@infradead.org>
 <20220526105957.944756116@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526105957.944756116@infradead.org>
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

On Thu, May 26, 2022 at 12:52PM +0200, Peter Zijlstra wrote:
> As x86 uses the <asm-generic/bitops/instrumented-*.h> headers, the
> regular forms of all bitops are instrumented with explicit calls to
> KASAN and KCSAN checks. As these are explicit calls, these are not
> suppressed by the noinstr function attribute.
> 
> This can result in calls to those check functions in noinstr code, which
> objtool warns about:
> 
> vmlinux.o: warning: objtool: enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x28: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> 
> Prevent this by using the arch_*() bitops, which are the underlying
> bitops without explciit instrumentation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20220502111216.290518605@infradead.org

Acked-by: Marco Elver <elver@google.com>

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
