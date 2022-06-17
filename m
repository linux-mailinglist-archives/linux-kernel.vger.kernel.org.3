Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7254F065
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380022AbiFQFBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiFQFBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:01:34 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F27663CF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:01:32 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 246poVa8MZfs8246poo0ha; Fri, 17 Jun 2022 07:01:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 17 Jun 2022 07:01:30 +0200
X-ME-IP: 90.11.190.129
Message-ID: <0ca5ee14-a382-0935-66be-820975501f45@wanadoo.fr>
Date:   Fri, 17 Jun 2022 07:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] powerpc: powernv: Fix refcount leak bug in opal-powercap
Content-Language: en-GB
To:     Liang He <windhl@126.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     nick.child@ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20220617042038.4003704-1-windhl@126.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220617042038.4003704-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/06/2022 à 06:20, Liang He a écrit :
> In opal_powercap_init(), of_find_compatible_node() will return
> a node pointer with refcount incremented. We should use of_node_put()
> in fail path or when it is not used anymore.
> 
> Besides, for_each_child_of_node() will automatically *inc* and *dec*
> refcount during iteration. However, we should add the of_node_put()
> if there is a break.

Hi,

I'm not sure that your patch is right here. Because of this *inc* and 
*dec* things, do we still need to of_node_put(powercap) once we have 
entered for_each_child_of_node?

I think that this reference will be released on the first iteration of 
the loop.


Maybe of_node_put(powercap) should be duplicated everywhere it is 
relevant and removed from the error handling path?
Or an additional reference should be taken before the loop?
Or adding a new label with "powercap = NULL" and branching there when 
needed?

CJ

> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>   arch/powerpc/platforms/powernv/opal-powercap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
> index 64506b46e77b..b102477d3f95 100644
> --- a/arch/powerpc/platforms/powernv/opal-powercap.c
> +++ b/arch/powerpc/platforms/powernv/opal-powercap.c
> @@ -153,7 +153,7 @@ void __init opal_powercap_init(void)
>   	pcaps = kcalloc(of_get_child_count(powercap), sizeof(*pcaps),
>   			GFP_KERNEL);
>   	if (!pcaps)
> -		return;
> +		goto out_powercap;
>   
>   	powercap_kobj = kobject_create_and_add("powercap", opal_kobj);
>   	if (!powercap_kobj) {
> @@ -236,6 +236,9 @@ void __init opal_powercap_init(void)
>   		kfree(pcaps[i].pg.name);
>   	}
>   	kobject_put(powercap_kobj);
> +	of_node_put(node);
>   out_pcaps:
>   	kfree(pcaps);
> +out_powercap:
> +	of_node_put(powercap);
>   }

