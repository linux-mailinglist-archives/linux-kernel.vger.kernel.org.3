Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2E4E5194
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbiCWLuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCWLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:50:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A620198
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:48:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFF561F37F;
        Wed, 23 Mar 2022 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648036110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PjZDyXTMEaHn2duElkoOX449JsJoEUnBONEtu7w2ec=;
        b=due7XOdwWAhr4mm91mYQhKVwvAMCG2rQKP2uXlTwqfKfl4ku+qD1DsAib8OrR55mnx+ZY7
        Jd4TR5wNe0iP0z6c+r4kPl5VbHs3RK71Gjl+6/w5lbIkRVhKJ/AZt60wCgLTT9sahzgQWX
        GTUbNeoRADoV9ynIrIuZQdLONgSHCkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648036110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PjZDyXTMEaHn2duElkoOX449JsJoEUnBONEtu7w2ec=;
        b=DNkYmWTOmcSlx4Nc5GwO5uYnK/Ad6vKfQeZQf9Z1wFc36uOnRNLB6P/+2yJ0a4xmliCUxM
        dS8jETBVmqgPScBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38B4413A78;
        Wed, 23 Mar 2022 11:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CqUDDA4JO2IdcgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Mar 2022 11:48:30 +0000
Message-ID: <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz>
Date:   Wed, 23 Mar 2022 12:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 27/39] kasan, mm: only define ___GFP_SKIP_KASAN_POISON
 with HW_TAGS
Content-Language: en-US
To:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1643047180.git.andreyknvl@google.com>
 <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 19:05, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Only define the ___GFP_SKIP_KASAN_POISON flag when CONFIG_KASAN_HW_TAGS
> is enabled.
> 
> This patch it not useful by itself, but it prepares the code for
> additions of new KASAN-specific GFP patches.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> ---
> 
> Changes v3->v4:
> - This is a new patch.
> ---
>  include/linux/gfp.h            |  8 +++++++-
>  include/trace/events/mmflags.h | 12 +++++++++---
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 581a1f47b8a2..96f707931770 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -54,7 +54,11 @@ struct vm_area_struct;
>  #define ___GFP_THISNODE		0x200000u
>  #define ___GFP_ACCOUNT		0x400000u
>  #define ___GFP_ZEROTAGS		0x800000u
> +#ifdef CONFIG_KASAN_HW_TAGS
>  #define ___GFP_SKIP_KASAN_POISON	0x1000000u
> +#else
> +#define ___GFP_SKIP_KASAN_POISON	0
> +#endif
>  #ifdef CONFIG_LOCKDEP
>  #define ___GFP_NOLOCKDEP	0x2000000u
>  #else
> @@ -251,7 +255,9 @@ struct vm_area_struct;
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>  
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT (24 +					\
> +			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
> +			  IS_ENABLED(CONFIG_LOCKDEP))

This breaks __GFP_NOLOCKDEP, see:
https://lore.kernel.org/all/YjoJ4CzB3yfWSV1F@linutronix.de/

>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
>  
>  /**
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 116ed4d5d0f8..cb4520374e2c 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -49,12 +49,18 @@
>  	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
>  	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
>  	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
> -	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
> -	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"}\
> +	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}	\
> +
> +#ifdef CONFIG_KASAN_HW_TAGS
> +#define __def_gfpflag_names_kasan					      \
> +	, {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"}
> +#else
> +#define __def_gfpflag_names_kasan
> +#endif
>  
>  #define show_gfp_flags(flags)						\
>  	(flags) ? __print_flags(flags, "|",				\
> -	__def_gfpflag_names						\
> +	__def_gfpflag_names __def_gfpflag_names_kasan			\
>  	) : "none"
>  
>  #ifdef CONFIG_MMU

