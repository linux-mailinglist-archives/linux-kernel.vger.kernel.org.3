Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6320B51EF46
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiEHTIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358074AbiEHSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:20:58 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08001B1F1
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:17:05 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id y21so13940558edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=loFIheiMu2Crc+DoRZaJl6AeMAJVov39dGaYt5KOZD4=;
        b=bNUGz6xjgxV/ELTDUeksWxGurjA/48dJb6jRSoyvxCOquvvufBTmzycqYK8D+A0anY
         Oty4HydLxW9D4TA+5TCBLQW3xhp0IyBWct94Xb32+RZf8adGfZKMs1remDqSeAkjf4c0
         Sj95+HvkslDIIVXblE4qkSk7Eyjino6+2XC/AHvgMIGxuNkFGJj+v5wMQG6Kk7ypsmIB
         Nv4ViSd++ttOTwPgoet4jPY/afvtEGxog41XbH6AKatTgdfAZkGSMfrzSTS9xnpacEiC
         IyLI5nb9u+4IqUO/c3Eb16UJS31g6dP1Hdtkuwvntu3QubLqXZXtFPqeWHSrFS4K/AdW
         /big==
X-Gm-Message-State: AOAM533QOAHbVWc3ICSg4V4UzrmXyEAAucpD/vnk3F4NqCsawQBR26aL
        mebVVy78GALhXLcbWu5sY50=
X-Google-Smtp-Source: ABdhPJxCax2ujg6yC/0BtAh7dxpYxYj313fZjEN1v5f+vWY76URaZLSGwan6iSjmfMZX4xI9ypE65g==
X-Received: by 2002:a05:6402:268f:b0:427:d90e:86a1 with SMTP id w15-20020a056402268f00b00427d90e86a1mr13768964edd.143.1652033824560;
        Sun, 08 May 2022 11:17:04 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.128.205])
        by smtp.gmail.com with ESMTPSA id zd20-20020a17090698d400b006f3ef214e31sm4270009ejb.151.2022.05.08.11.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 11:17:03 -0700 (PDT)
Message-ID: <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
Date:   Sun, 8 May 2022 21:17:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-4-mark.rutland@arm.com>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <20220427173128.2603085-4-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2022 20:31, Mark Rutland wrote:
> In __stackleak_erase() we check that the `erase_low` value derived from
> `current->lowest_stack` is above the lowest legitimate stack pointer
> value, but this is already enforced by stackleak_track_stack() when
> recording the lowest stack value.
> 
> Remove the redundant check.
> 
> There should be no functional change as a result of this patch.

Mark, I can't agree here. I think this check is important.
The performance profit from dropping it is less than the confidence decrease :)

With this check, if the 'lowest_stack' value is corrupted, stackleak doesn't 
overwrite some wrong kernel memory, but simply clears the whole thread stack, 
which is safe behavior.

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   kernel/stackleak.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index 753eab797a04d..f7a0f8cf73c37 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -78,10 +78,6 @@ static __always_inline void __stackleak_erase(void)
>   	unsigned int poison_count = 0;
>   	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
>   
> -	/* Check that 'lowest_stack' value is sane */
> -	if (unlikely(kstack_ptr - boundary >= THREAD_SIZE))
> -		kstack_ptr = boundary;
> -
>   	/* Search for the poison value in the kernel stack */
>   	while (kstack_ptr > boundary && poison_count <= depth) {
>   		if (*(unsigned long *)kstack_ptr == STACKLEAK_POISON)

