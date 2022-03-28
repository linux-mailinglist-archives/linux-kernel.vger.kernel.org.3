Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F54E9256
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiC1KM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiC1KMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:12:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88F452E12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:10:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 841381F37E;
        Mon, 28 Mar 2022 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648462243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEUjP7knGa/NIjIdm17InHHeis0a7CbD1Zy0ms8KFt4=;
        b=VGijNzoIi8tSLKplwWXwpv83yPzhlX4c6/0YnH7iiqrDPb9dOGGWen4T78zMRbWgbCvhnE
        15/NrhAfM3yDAGnOGM7aOzv51N1/AZ7/xUlAvga01H6F49oZnTEKg9AQ+k/NSoP3cW6Ost
        +i7rgMR2GV9JiRZjR+rBuIBUpxSjf4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648462243;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEUjP7knGa/NIjIdm17InHHeis0a7CbD1Zy0ms8KFt4=;
        b=b23bF/+1Gspjhj8aQE39s29aPL3wPkpcD12HSrGVystQMZa029E8E04iQl8AxUdqH3wrhX
        jKpFwpW0W6D584Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E80413215;
        Mon, 28 Mar 2022 10:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MN8rEqOJQWLlPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 28 Mar 2022 10:10:43 +0000
Message-ID: <0b22192a-b5e5-93a3-6ed7-7670ff15844d@suse.cz>
Date:   Mon, 28 Mar 2022 12:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm, kasan: fix __GFP_BITS_SHIFT definition breaking
 LOCKDEP
Content-Language: en-US
To:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <462ff52742a1fcc95a69778685737f723ee4dfb3.1648400273.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <462ff52742a1fcc95a69778685737f723ee4dfb3.1648400273.git.andreyknvl@google.com>
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

On 3/27/22 19:00, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> KASAN changes that added new GFP flags mistakenly updated __GFP_BITS_SHIFT
> as the total number of GFP bits instead of as a shift used to define
> __GFP_BITS_MASK.
> 
> This broke LOCKDEP, as __GFP_BITS_MASK now gets the 25th bit enabled
> instead of the 28th for __GFP_NOLOCKDEP.
> 
> Update __GFP_BITS_SHIFT to always count KASAN GFP bits.
> 
> In the future, we could handle all combinations of KASAN and LOCKDEP to
> occupy as few bits as possible. For now, we have enough GFP bits to be
> inefficient in this quick fix.
> 
> Fixes: 9353ffa6e9e9 ("kasan, page_alloc: allow skipping memory init for HW_TAGS")
> Fixes: 53ae233c30a6 ("kasan, page_alloc: allow skipping unpoisoning for HW_TAGS")
> Fixes: f49d9c5bb15c ("kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/gfp.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 0fa17fb85de5..761f8f1885c7 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -264,9 +264,7 @@ struct vm_area_struct;
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>  
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (24 +						\
> -			  3 * IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
> -			  IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
>  
>  /**

