Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503C356C1F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiGHTWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbiGHTWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:22:06 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2C322B05
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:22:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g1so16488833qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=aaWVjRt+AHG/IqpoV2z89+r6hmRW47qVhgIz9FsXZ7c=;
        b=k9VsfveFb7Hk3oZ+o82stl/UVlsmmDsOXYXb42UNigw1uS2RkH68SjGXl8n23syowR
         GcB/XN9Ixggow5AW4y7TTGu5Q8uyREZoLwPF/2wbarWwktN+zwxMzKVfCvIJs9K2A2CG
         mnbmOrNEQKMgKSl3L7Xx6o0O9IkfEunmhxe3Suih4/F8Zpi68ZDoVI2tVY1kC6X8q98e
         qoTB6vrhud8YfNd6Yzz/xSrEUu6ACkYTvUe/VBBXYyfXdFTqaa6GdAqLKJLA4mT6GREI
         mOE1YYbCrxC2XNCiSXiM9jIEbryNbOyQ7mGWBj8T6BLE5moi9NELMtCY9d8E2maXHtBb
         CPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=aaWVjRt+AHG/IqpoV2z89+r6hmRW47qVhgIz9FsXZ7c=;
        b=h1k0oLoGORHYV+RaclCe5PwzyVEm9GlUToiWh6qDbJIdFbj8bEQVuU7nU0E3O34a41
         vl91gt5KD7vm7a53tvfF5xxU5CYeh1YTkrlHd17Tm6zbnn0rWL5Fp8J5MQ0a+AotH4Qu
         E0o44l4CBE07xPXbMIpWwUhtF+XqjEi9Nbqke8hwc06KCRKQ5lRJcDel8W4b0iX3R6wk
         Ay7XiIHbeUPg4x/ZKVwA+LcJooCwgvN9b4hWMi+XkrIJHmtNQrMMODc0AYX5QeDf7lj1
         8BOJXgiP0ZG4OM+/ibts9XRvucrAnniJ4vbgJhqiNswHlllmoFwH9Yd0YPI1/Ab405EM
         ZMsg==
X-Gm-Message-State: AJIora9puP1A03zEGm8uUe+1yIvHPK5ImFrVaV/PlJcsMDQwh9RCmqIi
        nfiXmb9ITxCRt7HRm0G/Rcej7R1oHQbypCYb
X-Google-Smtp-Source: AGRyM1sQ2zoJ2nAyLPmkHDps5EK2x4szWjST3pbfcrR2EkBU10uS4KBUmUQeTtCCBqgIIDB+00/yxA==
X-Received: by 2002:ae9:dc42:0:b0:6a6:7b4b:1636 with SMTP id q63-20020ae9dc42000000b006a67b4b1636mr3458985qkf.111.1657308123341;
        Fri, 08 Jul 2022 12:22:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v123-20020a379381000000b006a6c230f5e0sm27158280qkd.31.2022.07.08.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:22:02 -0700 (PDT)
Date:   Fri, 8 Jul 2022 12:21:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Nadav Amit <nadav.amit@gmail.com>
cc:     linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
In-Reply-To: <20220708003053.158480-1-namit@vmware.com>
Message-ID: <4eccbb3a-2b5a-039-e934-da451e469929@google.com>
References: <20220708003053.158480-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 7 Jul 2022, Nadav Amit wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
> possible") introduced an optimization of skipping the flush if the TLB
> generation that is flushed (as provided in flush_tlb_info) was already
> flushed.
> 
> However, arch_tlbbatch_flush() does not provide any generation in
> flush_tlb_info. As a result, try_to_unmap_one() would not perform any
> TLB flushes.
> 
> Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
> anyhow is an invalid generation value.
> 
> In addition, add the missing unlikely() and jump to get tracing right.
> 
> Fixes: aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when possible")
> Reported-by: Hugh Dickins <hughd@google.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>

Thanks a lot for your rapid response and thinking it through
(before I got around to any "nopcid" or "nopti" experiments).

I've been testing this one for a few hours now, and no problems seen.
I expect you'll be sending another version, maybe next week, meeting
Dave's concerns; but wanted to reassure that you have correctly
identified the issue and fixed it with this - thanks.

Hugh

> ---
>  arch/x86/mm/tlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index d9314cc8b81f..d81b4084bb8a 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -771,14 +771,14 @@ static void flush_tlb_func(void *info)
>  		return;
>  	}
>  
> -	if (f->new_tlb_gen <= local_tlb_gen) {
> +	if (unlikely(f->new_tlb_gen != 0 && f->new_tlb_gen <= local_tlb_gen)) {
>  		/*
>  		 * The TLB is already up to date in respect to f->new_tlb_gen.
>  		 * While the core might be still behind mm_tlb_gen, checking
>  		 * mm_tlb_gen unnecessarily would have negative caching effects
>  		 * so avoid it.
>  		 */
> -		return;
> +		goto done;
>  	}
>  
>  	/*
> -- 
> 2.25.1
