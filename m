Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3454023A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbiFGPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiFGPRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB8672220
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654615019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPvoewAmUOM0GLn7JQsKuSAR7CQKv1vKgGbkLLVS6jg=;
        b=QlbxphrbtzlCGtK5Y2JD9c7WElv5CR7zV/F7mG78UQ+KAN+2gj57dlYLiv3yLi+KA2TYLD
        7QYImDLq9pqu6G8y61eABgu4noy3QJ7dWbaQ99jcqKVJlkN3/u+f/8harCQfM8zs0jRSAR
        ly7Y8ras03GJshDqTWRprS8cT//5WNY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-BgQAczaQOZuU1-nqoiONbg-1; Tue, 07 Jun 2022 11:16:58 -0400
X-MC-Unique: BgQAczaQOZuU1-nqoiONbg-1
Received: by mail-wm1-f69.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so5907639wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IPvoewAmUOM0GLn7JQsKuSAR7CQKv1vKgGbkLLVS6jg=;
        b=WAHxVuTYKwwwmDPDfVKjTlX9WivT0VfW54pquEr27+yADx/F44IqykUzNu4v+vf1TT
         SVxanSCJ8aiVsH01woRGa64LpuuBD9KCGadDZ5Y1rHJquLOEFFwMTPiTsDsYmteCWegG
         +NZicWw5JyLcG1PiTVskRgcz0TI7JKNjjNdfxXurxteci1crmg3NP91OmbmD8Oeo08Nj
         1ZPQ0kZ4AQzM6QqqmD3Ej2J4J0Yq8Mzz3xLXCFkeduMaH1jY4TrrZkmVUn7zxA7SOoPC
         ydhe9duhj4szv6C65WbnNVTwGaHl9bkfsUxXZqkOrzqBIyDxUWSrg50PUAZTlArhBQ68
         1vKw==
X-Gm-Message-State: AOAM532igRO/Ez8LcdC1BRhPgK5Xpt+jyZ7SCEZ1xNfOQKg0nfd1s9KT
        GYX9W7ZM9beuJDB2lpTdwOvbZi9sZveg1XXVa8yc+v2fFf3M5gi2tDASVpPcjKE6Bymi/QRpw21
        kNpotiwbAKDOj3RUGiXqegFre
X-Received: by 2002:a5d:6d51:0:b0:20c:e06f:702b with SMTP id k17-20020a5d6d51000000b0020ce06f702bmr27998030wri.502.1654615016942;
        Tue, 07 Jun 2022 08:16:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzRTwcXwStOoEOzbRsPwFscUaJcLOH7Y5tg/YdtJcKJz/v164jPPJRs8i0pt2kMF/QUpvLIw==
X-Received: by 2002:a5d:6d51:0:b0:20c:e06f:702b with SMTP id k17-20020a5d6d51000000b0020ce06f702bmr27998007wri.502.1654615016658;
        Tue, 07 Jun 2022 08:16:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id w25-20020a7bc759000000b0039c5645c60fsm3924590wmk.3.2022.06.07.08.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 08:16:55 -0700 (PDT)
Message-ID: <2a34e60a-6ac3-0f83-51d5-80a4c6403504@redhat.com>
Date:   Tue, 7 Jun 2022 17:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86: drop bogus "cc" clobber from
 __try_cmpxchg_user_asm()
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
References: <485c0c0b-a3a7-0b7c-5264-7d00c01de032@suse.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <485c0c0b-a3a7-0b7c-5264-7d00c01de032@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 17:00, Jan Beulich wrote:
> As noted (and fixed) a couple of times in the past, "=@cc<cond>" outputs
> and clobbering of "cc" don't work well together. The compiler appears to
> mean to reject such, but doesn't - in its upstream form - quite manage
> to yet for "cc". Furthermore two similar macros don't clobber "cc", and
> clobbering "cc" is pointless in asm()-s for x86 anyway - the compiler
> always assumes status flags to be clobbered there.
> 
> Fixes: 989b5db215a2 ("x86/uaccess: Implement macros for CMPXCHG on user addresses")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
> The change I continue to carry locally actually allows specifying that
> "cc" is _not_ clobbered; it only happens to improve detection of bad
> situations like the one here.
> 
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -439,7 +439,7 @@ do {									\
>   		       [ptr] "+m" (*_ptr),				\
>   		       [old] "+a" (__old)				\
>   		     : [new] ltype (__new)				\
> -		     : "memory", "cc");					\
> +		     : "memory");					\
>   	if (unlikely(__err))						\
>   		goto label;						\
>   	if (unlikely(!success))						\
> 

Queued, thanks.

Paolo

