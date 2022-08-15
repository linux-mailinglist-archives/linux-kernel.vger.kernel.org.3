Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1359279B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiHOBs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHOBs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC3B270F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF7260F9B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4447CC433C1;
        Mon, 15 Aug 2022 01:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660528104;
        bh=A6XaAMbAGTE966cBn4lJmzBhj49vrP/VSOAuGGrp73U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0KTormW1/IjvX+qnRSIi1SmbJpMmJDBhgwStTo7A91W3rCIUOl0GRoWm/cnOpSM+R
         EhpsR8m8CeY6LuwwDYuxbVMBnthxoNf+SIi7oGsycvonhKstzW1QrIXzeob/BtJJQt
         kBZgpZDeOEvtZGi/ZSCLaul+PvcPr6tvMBMxkvP4=
Date:   Sun, 14 Aug 2022 18:48:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] llist: Use try_cmpxchg in llist_add_batch and
 llist_del_first
Message-Id: <20220814184823.c6ca2c396db0d8817e518ef9@linux-foundation.org>
In-Reply-To: <20220712144917.4497-1-ubizjak@gmail.com>
References: <20220712144917.4497-1-ubizjak@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 12 Jul 2022 16:49:17 +0200 Uros Bizjak <ubizjak@gmail.com> wrote:

> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> llist_add_batch and llist_del_first. x86 CMPXCHG instruction returns
> success in ZF flag, so this change saves a compare after cmpxchg.
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails, enabling further code simplifications.
> 
> No functional change intended.

Well this is strange.  Your innocuous little patch:

> --- a/lib/llist.c
> +++ b/lib/llist.c
> @@ -30,7 +30,7 @@ bool llist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
>  
>  	do {
>  		new_last->next = first = READ_ONCE(head->first);
> -	} while (cmpxchg(&head->first, first, new_first) != first);
> +	} while (!try_cmpxchg(&head->first, &first, new_first));
>  
>  	return !first;
>  }
> @@ -52,18 +52,14 @@ EXPORT_SYMBOL_GPL(llist_add_batch);
>   */
>  struct llist_node *llist_del_first(struct llist_head *head)
>  {
> -	struct llist_node *entry, *old_entry, *next;
> +	struct llist_node *entry, *next;
>  
>  	entry = smp_load_acquire(&head->first);
> -	for (;;) {
> +	do {
>  		if (entry == NULL)
>  			return NULL;
> -		old_entry = entry;
>  		next = READ_ONCE(entry->next);
> -		entry = cmpxchg(&head->first, old_entry, next);
> -		if (entry == old_entry)
> -			break;
> -	}
> +	} while (!try_cmpxchg(&head->first, &entry, next));
>  
>  	return entry;
>  }

Does this:

x1:/usr/src/25> size lib/llist.o-before lib/llist.o-after  
   text	   data	    bss	    dec	    hex	filename
    541	     24	      0	    565	    235	lib/llist.o-before
    940	     24	      0	    964	    3c4	lib/llist.o-after

with x86_64 allmodconfig, gcc-11.1.0.

No change with allnoconfig, some bloat with defconfig.

I was too lazy to figure out why this happened, but it'd be great if
someone could investigate.  Something has gone wrong somewhere.

x1:/usr/src/25> scripts/bloat-o-meter lib/llist.o-before lib/llist.o-after 
add/remove: 0/0 grow/shrink: 2/0 up/down: 351/0 (351)
Function                                     old     new   delta
llist_add_batch                              106     286    +180
llist_del_first                              106     277    +171
Total: Before=310, After=661, chg +113.23%

in the two functions you touched.
