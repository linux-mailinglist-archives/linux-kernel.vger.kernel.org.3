Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82114B2BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352274AbiBKRor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:44:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbiBKRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:44:45 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBDD38D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:44:44 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IZyJniOQGeHnVIZyJnZhrl; Fri, 11 Feb 2022 18:44:42 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 11 Feb 2022 18:44:42 +0100
X-ME-IP: 90.126.236.122
Message-ID: <65ab6b3e-82b4-0a4e-bd6e-5869f735a8f7@wanadoo.fr>
Date:   Fri, 11 Feb 2022 18:44:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 46/49] mm/mempolicy: replace nodes_weight with
 nodes_weight_eq
Content-Language: en-GB
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-47-yury.norov@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220210224933.379149-47-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/02/2022 à 23:49, Yury Norov a écrit :
> do_migrate_pages() calls nodes_weight() to compare the weight
> of nodemask with a given number. We can do it more efficiently with
> nodes_weight_eq() because conditional nodes_weight() may stop
> traversing the nodemask earlier, as soon as condition is (or is not)
> met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>   mm/mempolicy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 7c852793d9e8..56efd00b1b6e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1154,7 +1154,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>   			 *          [0-7] - > [3,4,5] moves only 0,1,2,6,7.
>   			 */
>   
> -			if ((nodes_weight(*from) != nodes_weight(*to)) &&
> +			if (!nodes_weight_eq(*from, nodes_weight(*to)) &&
>   						(node_isset(s, *to)))

Hi,

I've not looked in details, but would it make sense to hoist the 
"(nodes_weight(*from) != nodes_weight(*to))" test out of the 
for_each_node_mask() to compute it only once?

'from' and 'to' look unmodified in the loop.

Just my 2c,
CJ

>   				continue;
>   

