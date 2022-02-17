Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100F4BA14C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbiBQNc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbiBQNcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:32:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A11F3F36
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CZ8Mw6CSYsNw+QBWgSmOSeP2EMv4VEwmQANgBJD4siA=; b=vq9OWPBDhsEYSwxAwZq+df0bTz
        DcYCVy68zR0dOGH89lvvNA7BuaMu/iu9qOvr17tUKEJEFdjijP85e/rypQKgR/tXu2u770xuxXTHf
        xa7e9G+OkoD8Hxdk7lcx6CP1m23vRjtyY/JMppTO9XsdpTu6oKbWk0yzsrSKjOYintraFxySpzTpB
        zW+ody+buoavK4qgQP7LC2YM6xX5hkt+EPWj/zhKg0YZUvqNMF9VIJ2g53qz+ZeA4dsgFaN18usBC
        hLs5c7iTwK8WQqgbXZHdB7qSgu6CcJjts/zv/y/g40zBFWy3JDnXlUr9AhtjFM6i61JRiJVa57S15
        paFJZAEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKgtU-00FduW-8E; Thu, 17 Feb 2022 13:32:24 +0000
Date:   Thu, 17 Feb 2022 13:32:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifiers: use helper function
 mmu_notifier_synchronize()
Message-ID: <Yg5OaP+4hclrUcB9@casper.infradead.org>
References: <20220217110948.35477-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217110948.35477-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 07:09:48PM +0800, Miaohe Lin wrote:
> Use helper function mmu_notifier_synchronize() to ensure all mmu_notifiers
> are freed. Minor readability improvement.

Is it though?

> @@ -334,15 +334,15 @@ static void mn_hlist_release(struct mmu_notifier_subscriptions *subscriptions,
>  	srcu_read_unlock(&srcu, id);
>  
>  	/*
> -	 * synchronize_srcu here prevents mmu_notifier_release from returning to
> -	 * exit_mmap (which would proceed with freeing all pages in the mm)
> -	 * until the ->release method returns, if it was invoked by
> -	 * mmu_notifier_unregister.
> +	 * mmu_notifier_synchronize here prevents mmu_notifier_release from
> +	 * returning to exit_mmap (which would proceed with freeing all pages
> +	 * in the mm) until the ->release method returns, if it was invoked
> +	 * by mmu_notifier_unregister.
>  	 *
>  	 * The notifier_subscriptions can't go away from under us because
>  	 * one mm_count is held by exit_mmap.
>  	 */
> -	synchronize_srcu(&srcu);
> +	mmu_notifier_synchronize();

We just read_unlocked the &srcu.  Now I have to jump to the definition
of mmu_notifier_synchronize() to find out that it's now waiting for the
very same srcu.  I think this abstraction makes the code harder to read,
not easier.

>  }
>  
>  void __mmu_notifier_release(struct mm_struct *mm)
> @@ -851,7 +851,7 @@ void mmu_notifier_unregister(struct mmu_notifier *subscription,
>  	 * Wait for any running method to finish, of course including
>  	 * ->release if it was run by mmu_notifier_release instead of us.
>  	 */
> -	synchronize_srcu(&srcu);
> +	mmu_notifier_synchronize();

Same here.
