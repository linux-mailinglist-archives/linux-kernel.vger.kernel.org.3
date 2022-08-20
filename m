Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9D59B087
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiHTVAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 17:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E83123C
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 13:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FE8160C11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 20:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83510C433D6;
        Sat, 20 Aug 2022 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661029196;
        bh=4kMwix/69G0yBDqqAuHOdMHB6BeNOUzbJJVBoUshEGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dax9WBA4KxTo8O+AzNPL8dtJUe842xz2gni616L+RuzIX5davGJLQkR0b5mCPsRAQ
         gScqAN8NMjFrqV7jCJAEvkQh1z/CSy30FHrdRnsy9wh0xYTH3KQEJveO9h+4JdW0ua
         aINb5hwWT4nXDRvfAJsR3j9WQPqJTjgl9EwO/5Dw=
Date:   Sat, 20 Aug 2022 13:59:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix pgdat->kswap accessed concurrently
Message-Id: <20220820135955.1520aa480fe04ab31d4fce1f@linux-foundation.org>
In-Reply-To: <1E87F09C-4904-49E2-B45C-C408DD5F6F62@linux.dev>
References: <20220820032506.126860-1-wangkefeng.wang@huawei.com>
        <1E87F09C-4904-49E2-B45C-C408DD5F6F62@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 15:33:04 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> 
> 
> > +	if (IS_ERR(t)) {
> > 		/* failure at boot is fatal */
> > 		BUG_ON(system_state < SYSTEM_RUNNING);
> > 		pr_err("Failed to start kswapd on node %d\n", nid);
> > -		pgdat->kswapd = NULL;
> > +		WRITE_ONCE(pgdat->kswapd, NULL);
> > +	} else {
> > +		WRITE_ONCE(pgdat->kswapd, t);
> > 	}
> > }
> 
> IIUC, the race is like the followings:
> 
> CPU 0:					CPU 1:
> 
> kswapd_run()
> 	pgdat->kswapd = kthread_run()
> 	if (IS_ERR(pgdat->kswapd))
> 					kswapd_is_running
> 						// load pgdat->kswapd and it is NOT NULL.
> 		pgdat->kswapd = NULL
> 						task_is_running(pgdat->kswapd); // NULL pointer dereference
> 

But don't we still have a bug?  Sure, kswapd_is_running() will no
longer deref a null pointer.  But it now runs kswapd_is_running()
against a task which has exited - a use-after-free?
