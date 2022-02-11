Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B374B2386
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbiBKKl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:41:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiBKKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:41:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5540D48
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A31B82956
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD83AC340F0;
        Fri, 11 Feb 2022 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644576112;
        bh=pA9CzJ8siuC1/m8BcVTbkdCFB9w8GLlHir7PDat5MMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6REYmn9p5d0Dktie5hyYrl81Dpvwawd+5wIRfLWRjn0ELZGEkuSyVC6bleX7E76i
         9ADm3vADYXEl2vBayvLwzfqdLyMjNq0qWJMtiqCHSQ9eEKad+gy5nSMPDcCJ8etrk7
         4QBh++afQ6nsD/s5IV8fRLPOxDQOACZHtceEijDNXCe8IBrAiVs+luIk8f8A9gt1qj
         rlSA7wUt1YEXEy/bTwvE+YDVVJy0e6f411N8hd5kctvQcNH+paLyMVR3SfXWK60QW3
         e2vocYyaWOwf7p5OOir4f3iFpOHCl4e46tt4IZLjT5hV+rwj5FF+W/N0usy9g59f3M
         MbVWUxHw3Qsfg==
Date:   Fri, 11 Feb 2022 12:41:42 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 47/49] nodemask: add num_node_state_eq()
Message-ID: <YgY9Zl3HryDSSBI9@kernel.org>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-48-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-48-yury.norov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:31PM -0800, Yury Norov wrote:
> Page allocator uses num_node_state() to compare number of nodes with a
> given number. The underlying code calls bitmap_weight(), and we can do
> it more efficiently with num_node_state_eq because conditional nodes_weight
> may stop traversing the nodemask earlier, as soon as condition is (or is
> not) met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/nodemask.h | 5 +++++
>  mm/page_alloc.c          | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 197598e075e9..c5014dbf3cce 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -466,6 +466,11 @@ static inline int num_node_state(enum node_states state)
>  	return nodes_weight(node_states[state]);
>  }
>  
> +static inline int num_node_state_eq(enum node_states state, int num)
> +{
> +	return nodes_weight_eq(node_states[state], num);
> +}
> +
>  #define for_each_node_state(__node, __state) \
>  	for_each_node_mask((__node), node_states[__state])
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cface1d38093..897e64b66ca4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8434,7 +8434,7 @@ void __init page_alloc_init(void)
>  	int ret;
>  
>  #ifdef CONFIG_NUMA
> -	if (num_node_state(N_MEMORY) == 1)
> +	if (num_node_state_eq(N_MEMORY, 1))
>  		hashdist = 0;
>  #endif
>  
> -- 
> 2.32.0
> 
> 

-- 
Sincerely yours,
Mike.
