Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86E549DED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiFMTn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348594AbiFMTn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE144475D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD7F561224
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DB5C34114;
        Mon, 13 Jun 2022 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655144046;
        bh=l1GarhKWVezQ3DxuFDO/C4uU/4XVyFAxJs/gK7NOHnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YwjfxlaKZqxX4hU11mhZuFFt9qElvR/AUmKnHMZjTQTeD/IQK7zpIpGKgm41urQYO
         hk11kgTfNttJQZu+e/Dg4GVF2oEPEG0Wru2VqNSn1Ac9afc1DbkLHPNecq0w6rtb9J
         l8n55tpzhMkgQEvmDVKw/+ee8quX0uP3uo+Q4DJE=
Date:   Mon, 13 Jun 2022 11:14:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     alexs@kernel.org, sjhuang@iluvatar.ai, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/genalloc: Set chunk size to real size which
 gen_pool managed.
Message-Id: <20220613111404.5253fe6ac69f5fd145dd437c@linux-foundation.org>
In-Reply-To: <20220612105937.30862-1-wuchi.zero@gmail.com>
References: <20220612105937.30862-1-wuchi.zero@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2022 18:59:37 +0800 wuchi <wuchi.zero@gmail.com> wrote:

> The demand size (chunk->avail > size > round_down(chunk->avail)) will
> lead to meaningless algo calls in gen_pool_alloc_algo_owner without the
> patch, alse move the follow code:
> 	size = nbits << order
> out of read-side critical section.
> 

Nobody has seriously worked on this code in a long time :(

Please expand more on the flaw.  What are "algo calls"?  Why are they
meaningless, etc?  What are the runtime effects of this error?

> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -193,6 +193,7 @@ int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt, phys_addr_t ph
>  	if (unlikely(chunk == NULL))
>  		return -ENOMEM;
>  
> +	size = nbits << pool->min_alloc_order;

If we're going to do this then gen_pool_add_owner() no longer needs its
`size' argument.


