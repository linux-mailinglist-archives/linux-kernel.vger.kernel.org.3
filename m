Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB15A3086
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbiHZUhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiHZUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:37:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB6C1234
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dBudLsH8xKTaAURk3Fnio7O0UMH3BKVFIFOUfO3Eq7Y=; b=MedR6XE++H2z6aSZ2c6myhh1q1
        BmW4oPms3YE3BcWMRLXPWHLhWhW2P7qOd7rsaFi+D3kF9B2dmazaQFzTmohifJ3bic0N1Js1KqpDY
        74pXuBp6Al0JoTQPYccEcBzjVfyrRdDClRGGe5x2E6RfnLBsIAPlP976ZifCMUISJ0w2Qwvz7mqGA
        RqrUxBkqvIw7cwZmKGHxiX3M+3cGt0ZhbazIAeo72dEGs0zUyRWi+TQe6Y6Aq9C4SOZtwZccpno2I
        GUaPEnCzROTviY1/Wx2+h0RCQMv1pQEO0EYiIEl8h6MA8zFrbEv9m9Z1LE3x5OEHjZumA+9UKx6wh
        wDHMJbLw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRg4Z-00Bwdg-81; Fri, 26 Aug 2022 20:36:59 +0000
Message-ID: <63b95279-8013-078d-b84b-716b3dbfbac4@infradead.org>
Date:   Fri, 26 Aug 2022 13:36:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/2] um: Cleanup compiler warning in arch/x86/um/tls_32.c
Content-Language: en-US
To:     Lukas Straub <lukasstraub2@web.de>,
        linux-um <linux-um@lists.infradead.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220826152931.5835fdf8@gecko>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220826152931.5835fdf8@gecko>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/22 08:29, Lukas Straub wrote:
> arch.tls_array is statically allocated so checking for NULL doesn't
> make sense. This causes the compiler warning below.
> 
> Remove the checks to silence these warnings.
> 
> ../arch/x86/um/tls_32.c: In function 'get_free_idx':
> ../arch/x86/um/tls_32.c:68:13: warning: the comparison will always evaluate as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
>    68 |         if (!t->arch.tls_array)
>       |             ^
> In file included from ../arch/x86/um/asm/processor.h:10,
>                  from ../include/linux/rcupdate.h:30,
>                  from ../include/linux/rculist.h:11,
>                  from ../include/linux/pid.h:5,
>                  from ../include/linux/sched.h:14,
>                  from ../arch/x86/um/tls_32.c:7:
> ../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
>    22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
>       |                               ^~~~~~~~~
> ../arch/x86/um/tls_32.c: In function 'get_tls_entry':
> ../arch/x86/um/tls_32.c:243:13: warning: the comparison will always evaluate as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
>   243 |         if (!t->arch.tls_array)
>       |             ^
> ../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
>    22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
>       |                               ^~~~~~~~~
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/um/tls_32.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
> index ac8eee093f9c..66162eafd8e8 100644
> --- a/arch/x86/um/tls_32.c
> +++ b/arch/x86/um/tls_32.c
> @@ -65,9 +65,6 @@ static int get_free_idx(struct task_struct* task)
>  	struct thread_struct *t = &task->thread;
>  	int idx;
>  
> -	if (!t->arch.tls_array)
> -		return GDT_ENTRY_TLS_MIN;
> -
>  	for (idx = 0; idx < GDT_ENTRY_TLS_ENTRIES; idx++)
>  		if (!t->arch.tls_array[idx].present)
>  			return idx + GDT_ENTRY_TLS_MIN;
> @@ -240,9 +237,6 @@ static int get_tls_entry(struct task_struct *task, struct user_desc *info,
>  {
>  	struct thread_struct *t = &task->thread;
>  
> -	if (!t->arch.tls_array)
> -		goto clear;
> -
>  	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
>  		return -EINVAL;
>  

-- 
~Randy
