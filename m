Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9D571D64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiGLOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiGLOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:54:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63B3192D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+k83zGSxic1pbQTEJQS/iJCti7MTxdVcT9sj/XVqF9o=; b=AYur2/Yrsq3i8wnAiMQB5+HeGR
        Cw1t1umk+nFN6rzDv9R8Kx4j4+IbnkrgsEYyIxGKCrGXH6RGeySCrD/75ebbwoNRX6FXZg7zYOoQc
        pJBZfDHzeAgsQRlmUhdHkHxwaGQOmL2mvL1ysNWIPqYKl9LMq/2DvVjIMG7cj9aEcdqyWr12Nrl8K
        feqbLA6Rp/mCUDdslVe8t1ZDq6J4/VzufUvgGfcElp1Rxm7X5tHtU5VVjuExRYm15zBZ9jGtrDFgo
        W1AFvEjia6lwr0qz3ZrxQbsxetPO8Sk9Ib085EHPXQO8BCZbu3E8uJcFxAn+16vN9oGyKsgSFcG7g
        EtYvT1Xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBHH1-00715O-MX; Tue, 12 Jul 2022 14:54:03 +0000
Date:   Tue, 12 Jul 2022 15:54:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Message-ID: <Ys2LCwQZUuOwiiX6@casper.infradead.org>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 02:24:55PM +0000, Liam Howlett wrote:
> When building with C=1, the maple tree had some rcu type mismatch &
> locking mismatches in the destroy functions.  There were cosmetic only
> since this happens after the nodes are removed from the tree.

... in the current use-case.  It's a legitimate use of the API to do:

	ma_init();
	ma_store();
	ma_destroy();
	ma_store();

Can you add a new test that does that?

> @@ -5524,13 +5526,17 @@ static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
>  
>  		type = mte_node_type(mas.node);
>  		slots = ma_slots(mte_to_node(mas.node), type);
> -		if ((offset < mt_slots[type]) && mte_node_type(slots[offset]) &&
> -		    mte_to_node(slots[offset])) {
> -			struct maple_enode *parent = mas.node;
> +		if (offset >= mt_slots[type])
> +			goto next;
>  
> -			mas.node = mas_slot_locked(&mas, slots, offset);
> +		tmp = mas_slot_locked(&mas, slots, offset);
> +		if (mte_node_type(tmp) && mte_to_node(tmp)) {
> +

Unnecessary blank line?

> +			parent = mas.node;
> +			mas.node = tmp;
>  			slots = mas_destroy_descend(&mas, parent, offset);
>  		}
> +next:
>  		node = mas_mn(&mas);
>  	} while (start != mas.node);
>  
> -- 
> 2.35.1
> 
