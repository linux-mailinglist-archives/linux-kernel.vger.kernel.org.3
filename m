Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762C85636AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGAPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiGAPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA662340FB;
        Fri,  1 Jul 2022 08:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5831D623C3;
        Fri,  1 Jul 2022 15:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C0FC3411E;
        Fri,  1 Jul 2022 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656688205;
        bh=VE3xxCP6qqMSL2Ge+UO5AZuDtQGRgxKsVxk0c6Av2T0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQP7Pi54fa7ZlG5vmHtJ7YP4w9Zl7R6UolfS21FRKD0FrxXep/C+ymxdztrJJKQq2
         Wnodsl9qNX5zewz9cNtwNOLWVDVASDmiGvE46ybj8XTIPHyQTJSz3YtmnljPecHY5s
         1GvGFt5pr/4NNT3r+1F7nyVFeksLwpSuAslTrl6SWAMnt0hGgaMPONb7h6hPoCKx5A
         4450/CLeN5jlE9mXZ8+IMhcTxGVrkoA+GIlMje27H0Rn2WLZAl5pd1b9luG7HHO+d0
         3TZ4IuvszhIWicsFMOYL/oVLkXIHovhGbH8HGVL0xoK1uVGbpW2c6ViGW3a1QYSPJS
         ts0LGRh5LZigA==
Date:   Fri, 1 Jul 2022 08:10:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, michael@walle.cc, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        guillaume.tucker@collabora.com, pmladek@suse.com
Subject: Re: [PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Message-ID: <Yr8OSxotW2VEUyKQ@dev-arch.thelio-3990X>
References: <20220701145047.2206900-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701145047.2206900-1-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 12:50:47AM +1000, Imran Khan wrote:
> Kick fsnotify only if an event is not already scheduled for target
> kernfs node. commit b8f35fa1188b ("kernfs: Change kernfs_notify_list to
> llist.") changed kernfs_notify_list to a llist.
> Prior to this list was a singly linked list, protected by
> kernfs_notify_lock. Whenever a kernfs_node was added to the list
> its ->attr.notify_next was set to head of the list and upon removal
> ->attr.notify_next was reset to NULL. Addition to kernfs_notify_list
> would only happen if kernfs_node was not already in the list i.e.
> if ->attr.notify_next was NULL. commit b8f35fa1188b ("kernfs: Change
> kernfs_notify_list to llist.") removed this checking and this was wrong
> as it resulted in multiple additions for same kernfs_node.
> 
> So far this bug only got reflected with some console related setting.
> Nathan found this issue when console was specified both in DT and in
> kernel command line and Marek found this issue when earlycon was enabled.
> 
> This patch avoids adding an already added kernfs_node into notify list.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

This should also include:

Reported-by: Michael Walle <michael@walle.cc>

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: b8f35fa1188b ("kernfs: Change kernfs_notify_list to llist.")
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

For the ARCH=um case that I noticed:

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  fs/kernfs/file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index bb933221b4bae..e8ec054e11c63 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -917,6 +917,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	if (free == NULL)
>  		return;
>  
> +	free->next = NULL;
>  	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
>  	kn = attribute_to_node(attr, struct kernfs_node, attr);
>  	root = kernfs_root(kn);
> @@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
>  	rcu_read_unlock();
>  
>  	/* schedule work to kick fsnotify */
> -	kernfs_get(kn);
> -	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> -	schedule_work(&kernfs_notify_work);
> +	if (kn->attr.notify_next.next != NULL) {
> +		kernfs_get(kn);
> +		llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> +		schedule_work(&kernfs_notify_work);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(kernfs_notify);
>  
> 
> base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf
> -- 
> 2.30.2
> 
