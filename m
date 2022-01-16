Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ADD48FD12
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiAPMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:54:47 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:58076 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiAPMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:54:46 -0500
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 953UnSJrpEuQ2953UnkOUl; Sun, 16 Jan 2022 13:54:45 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 16 Jan 2022 13:54:45 +0100
X-ME-IP: 90.126.236.122
Message-ID: <47530ced-e200-3754-3aaa-65d2698624d6@wanadoo.fr>
Date:   Sun, 16 Jan 2022 13:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] lib/string_helpers: Use the given gfp flag when
 allocating memory
Content-Language: fr
To:     Andy Shevchenko <andy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <30a0c2011f8034378639883339fa7d7c55e034a5.1642337349.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <30a0c2011f8034378639883339fa7d7c55e034a5.1642337349.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/01/2022 à 13:49, Christophe JAILLET a écrit :
> kstrdup_quotable_cmdline() is given a gfp flag that is passed and used for
> memory allocation in kstrdup_quotable() just a few lines below.
> 
> It looks reasonable to use this gfp value for the buffer allocated and
> freed in kstrdup_quotable_cmdline() as well.
> 
> Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> According to what I've found in 5.16, all callers use GFP_KERNEL, so this
> patch should be a no-op.
> But who knows how it will be used in the future. Better safe than sorry.
> ---
>   lib/string_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 90f9f1b7afec..7aceeb40dfd7 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -624,7 +624,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
>   	char *buffer, *quoted;
>   	int i, res;
>   
> -	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	buffer = kmalloc(PAGE_SIZE, gfp);
>   	if (!buffer)
>   		return NULL;
>   
> 

I have sent a V2. I missed the same issue in kstrdup_quotable_file().

CJ
