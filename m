Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C681D590B64
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 06:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiHLE6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 00:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiHLE6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 00:58:49 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D85979EE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:58:48 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id MMkwoiWPCbJVVMMkwoGkN2; Fri, 12 Aug 2022 06:58:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 12 Aug 2022 06:58:47 +0200
X-ME-IP: 90.11.190.129
Message-ID: <6754c5ec-7b89-0393-659b-5c0487a70138@wanadoo.fr>
Date:   Fri, 12 Aug 2022 06:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/mremap_pages: Save a few cycles in 'get_dev_pagemap()'
Content-Language: fr
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <b4a47154877853cc64be3a35dcfd594d40cc2bce.1635975283.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b4a47154877853cc64be3a35dcfd594d40cc2bce.1635975283.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/11/2021 à 22:35, Christophe JAILLET a écrit :
> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   mm/memremap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 84de22c14567..012e8d23d365 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -506,7 +506,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>   	/* fall back to slow path lookup */
>   	rcu_read_lock();
>   	pgmap = xa_load(&pgmap_array, PHYS_PFN(phys));
> -	if (pgmap && !percpu_ref_tryget_live(pgmap->ref))
> +	if (pgmap && !percpu_ref_tryget_live_rcu(pgmap->ref))
>   		pgmap = NULL;
>   	rcu_read_unlock();
>   

Hi,
gentle reminder.

Is this patch useful?
When I first posted it, percpu_ref_tryget_live_rcu() was really new.
Now it is part of linux since 5.16.

CJ
