Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E38517041
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380694AbiEBN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385265AbiEBN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:28:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C132526FA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:25:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t6so19596243wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1w5KNGZlTby5n3yh1tUKik48sS/s0HNFzIllnPu0NA=;
        b=GQ8+YWL1sW0nw7vaDKDF6NhZOlpCMGU0MMsBNkEwVTLijsOMokNkZov099GVZhTUqU
         YE2jAGOZbomNE1+VnaBWTj76IJdJPt2y/XrA7KRn+yPvmkd+BRoSgVYDt/wFMmy0dtvP
         QFfYH3Spg3Ex4R/583JetjV2L8jFMKHipyfqE8KGWUZ0CCTBUIT8h/NowrN5hJ2yV8RU
         hjvB2LWXHdn2rojyg9oWEGC193gJeruZkX8gq4lrhSUTb5AmKqwjS3FIeclE6B+wVHpQ
         PVO3KPD5hMFeG/cGfH5u8zjEC/Tuhep5qpbZqjw8DGxVPtchpcMYRuaknOJJ8ZMo4O/d
         90Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1w5KNGZlTby5n3yh1tUKik48sS/s0HNFzIllnPu0NA=;
        b=hxtbhFtKwymSBDd9SAJISmX9kKnXaMeXVL9g45sJ8RLXq3Wxaad678gidAQ1IjOQ8l
         646PqaId4bcBtz3tCPcCq6ArZJjvu85Vm7MfZqXbzzTT9G4oJ5bfWRWFLlgtmsNIWFPJ
         Hi6xNqUaVZvWKcinRmnT3CsyUv4wzagCoSojDfIKB9jhKzEmsjqEtJj4Fbm/v5Reb26c
         WEG5vu0bhHEovH+A5n8hBNGzHXagUqSCi1PcYZkc6jt8ym5EtFsd/0ZlW9BqzUGoyYc4
         dxVGpOdoSEiYN+75mZ04f9jQg4BFHeOVV9kR3/Ouq9/S9OZgmZ+luYyxu1lgHJjivb06
         t1Yw==
X-Gm-Message-State: AOAM530gQx8duvjE6p4L2fjKLmH7CCbaPb3Ms8eeRzV0S0lc5tYp7ktd
        89TWdAEJnSyMW0TX8gXkT5Fvvw==
X-Google-Smtp-Source: ABdhPJyORHPotq9IJJawWGEiaAYv0R0g0uWJi3J4vzrOnWTdnLOl46f4UN/qxb8PlywGiT63Q+AAcA==
X-Received: by 2002:a05:6000:3c9:b0:20c:4e4e:863f with SMTP id b9-20020a05600003c900b0020c4e4e863fmr9139762wrg.4.1651497920748;
        Mon, 02 May 2022 06:25:20 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:bdb8:d8d3:6904:292f])
        by smtp.gmail.com with ESMTPSA id o3-20020adfba03000000b0020c5253d90asm7351891wrg.86.2022.05.02.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:25:20 -0700 (PDT)
Date:   Mon, 2 May 2022 15:25:14 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/3] jump_label,noinstr: Avoid instrumentation for
 JUMP_LABEL=n builds
Message-ID: <Ym/buh8nDPFhohc2@elver.google.com>
References: <20220502110741.951055904@infradead.org>
 <20220502111216.350926848@infradead.org>
 <Ym/X/BuXCi8H0vud@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym/X/BuXCi8H0vud@hirez.programming.kicks-ass.net>
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

On Mon, May 02, 2022 at 03:09PM +0200, Peter Zijlstra wrote:
> 
> Subject: jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon May  2 12:30:20 CEST 2022
> 
> When building x86_64 with JUMP_LABEL=n it's possible for
> instrumentation to sneak into noinstr:
> 
> vmlinux.o: warning: objtool: exit_to_user_mode+0x14: call to static_key_count.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x2d: call to static_key_count.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/jump_label.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocke
>  #include <linux/atomic.h>
>  #include <linux/bug.h>
>  
> -static inline int static_key_count(struct static_key *key)
> +static __always_inline int static_key_count(struct static_key *key)
>  {
> -	return atomic_read(&key->enabled);
> +	return arch_atomic_read(&key->enabled.count);

Curious if this compiles - s/.count// ?

>  }
>  
>  static __always_inline void jump_label_init(void)
