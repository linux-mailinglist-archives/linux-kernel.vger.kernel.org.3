Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100645176CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386959AbiEBSv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349799AbiEBSvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07FA2BE05
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651517275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o31KDKAjASCg4O6xIHCxaz/umy+aWKrPUxdDjD2fwoI=;
        b=OoSAHJ+UstuAtQFpGzBZjzbwZpFAC62V1x9nwTXZ9lIJiZOfUBJWzrAyp0nWnzV5Myi0t8
        wUk1elo4GPkcvGHHz1w9qllBjzDPtnBReVY9bAy/K43KfSCNItFn/hXcCt/+KXP4l8fQN8
        LdJJ2UsU9mRye5CFOqyXiTptlpPPwMY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-2nisNgt9MziPI563ZzJVNQ-1; Mon, 02 May 2022 14:47:51 -0400
X-MC-Unique: 2nisNgt9MziPI563ZzJVNQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-e1fa5c533eso5054590fac.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o31KDKAjASCg4O6xIHCxaz/umy+aWKrPUxdDjD2fwoI=;
        b=la1+RIuAd1AaFROAK3UJCKfdoaRAinsOdABOpg8m9tfti5H4Ez3ZRJLeN2Rye8p4dJ
         stCczsV16dU8ONCe4OrkGt/Nyd741fllpMdtaMbIKMIMTU37pGf1V3nlyQvjYjna6N35
         tH+Q5GHJ1RgmdPmG35xcrDFRlJkSd3nBduGCqkJr9y7D9kgKe/9DJ24sE2h0nwK3rqAk
         YPrp9xGKCBXY5jZtIxNu3Pq/7zrAznL/K1ozwpqbOSULbOjTLhxS4y3gdhmFrpwgHgGS
         tuMpRXya59aZKlI7rteqW/D5m71HRqwzpXrKa1f7OI7QNtItdEdzQtZR3zpAJWH0z0M8
         9Qqg==
X-Gm-Message-State: AOAM5331M1yRXo86jhCx2erScP28b7L8uIYWq7kQYmT4f9sOBh5URBUj
        BgoIChMV7qmVjajNm9pZxkUCir2OcAjwCaBqTr3MOSKy5s4pPX3l4HFBo+fPtesBdl0hhD93yBr
        9flB6nn03rM8Tg47gKqMEQXSG
X-Received: by 2002:a05:6870:819e:b0:e9:8de4:5ff9 with SMTP id k30-20020a056870819e00b000e98de45ff9mr266061oae.70.1651517271069;
        Mon, 02 May 2022 11:47:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1uGJ2E9K/79jmhcECha9MBujuJqI4NSml86exkjHlO+7PauvXrhkdt5CgbRxUlFD0It9H9A==
X-Received: by 2002:a05:6870:819e:b0:e9:8de4:5ff9 with SMTP id k30-20020a056870819e00b000e98de45ff9mr266055oae.70.1651517270805;
        Mon, 02 May 2022 11:47:50 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id z21-20020a056870e15500b000e686d1389dsm6135246oaa.55.2022.05.02.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:47:50 -0700 (PDT)
Date:   Mon, 2 May 2022 11:47:47 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] x86/cpu: Elide KCSAN for cpu_has() and friends
Message-ID: <20220502184747.cr5ssem3g4mel4qq@treble>
References: <20220502110741.951055904@infradead.org>
 <20220502111216.290518605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220502111216.290518605@infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 01:07:43PM +0200, Peter Zijlstra wrote:
> vmlinux.o: warning: objtool: enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x28: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

An explanation about *why* this fixes it would help, as I have no idea
from looking at the patch.

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

-- 
Josh

