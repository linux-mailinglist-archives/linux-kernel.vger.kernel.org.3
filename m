Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8662E5776C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiGQOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiGQOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:48:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF062E0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zg3lKm07i/XRUKG1J5yBXuQWVN/SwXdMkJ8fAyjZVmo=; b=iywJmjKFHgq/ARQuh+atQwVIvA
        FILkIUajNEfJ1DFe5/u66Z+kUlvfCYCh4t2aMqCWNHfWmd5kjMI68LD6/DKT1QFs5gYGNROYhHp7C
        vVulUjHl1Zzj0E3qB0iE980E96nM0AQFq/sgtrq9qPx1Qdz45IavU+8LnQGrJjZxewAut+mBm8gwT
        BChXAKgFkxSD2c2tj8/drGrftRAOQNxEQDgJl7VicsiStrcLHCxfe2kBmrZbUTXnK804qO7b1k2Ld
        u8jLuiPLe9cIs+B+kQTccWEIV+pgOevQf8KIg8G83n5EHRByb59aMgVdYc0biY1OJ/VgM88pxSUmI
        B7jsnvrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oD5Yp-00BtUa-Oc; Sun, 17 Jul 2022 14:47:55 +0000
Date:   Sun, 17 Jul 2022 15:47:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Li Hongyu <lihongyu1999@bupt.edu.cn>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] maple: change the pointer name from maple_enode to
 maple_enode_p
Message-ID: <YtQhGyEw5Tn2eNPh@casper.infradead.org>
References: <20220717120652.GA9281@38c3a67cb865>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717120652.GA9281@38c3a67cb865>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 09:12:42PM +0900, Li Hongyu wrote:
> The current name of the pointer to struct maple_enode is also
> maple_enode. This is correct from the grammar point but can be
> comfusing. Besides it seems in Linux it prefers typedef struct foo
> *foo_p;, e.g. typedef struct cpumask *cpumask_var_t; and typedef
> struct cgraph_node *cgraph_node_ptr;. I use re to search in the
> Linux project and cannot find another example in typedef struct
> foo *foo; style.
> 
> This also results in a bug in the bindings of the
> rust-for-linux subsystem, which can be seen in this github issue.
> 
> https://github.com/Rust-for-Linux/linux/issues/795
> 
> The struct pointer maple_enode and maple_pnode are not used. It is
> safe to change it to a new name.
> 
> Signed-off-by: Li Hongyu <lihongyu1999@bupt.edu.cn>
> ---
>  include/linux/maple_tree.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 2c9dede989c7..4886e019a2b5 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -72,8 +72,8 @@
>   *   0x010 : 32 bit values, type in 0-2, slot in 3-6
>   *   0x110 : 64 bit values, type in 0-2, slot in 3-6
>   */
> -typedef struct maple_enode *maple_enode; /* encoded node */
> -typedef struct maple_pnode *maple_pnode; /* parent node */
> +typedef struct maple_enode *maple_enode_p; /* encoded node */
> +typedef struct maple_pnode *maple_pnode_p; /* parent node */

If this is the only change needed, then clearly they're not being used,
so just delete them?
