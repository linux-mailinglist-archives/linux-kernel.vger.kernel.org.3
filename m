Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1A5426DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiFHFsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiFHFqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EA0B3C0E8F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654658389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEPTWYbvI5NJZCPcqRYQAZ13jlNYaW+Mr8ondcYJw3w=;
        b=L7+nM3FgNjXRA2hZy5QSFDARVlzE3CnK6YO3qGG4zAm6gNnnypKpw93KQrz+vKEKoL3+IC
        BncGJWmnxjWIeL+rkJ6KRlTHN79uQ6wSwv6LgqYTyFZAUMflJJybGmW4pF3aqatKy052hm
        agcR4frqWgHReowJ/MxsVD3lFXg8qv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-4qN6XzvqNPqlEDBUIhTvug-1; Tue, 07 Jun 2022 23:19:45 -0400
X-MC-Unique: 4qN6XzvqNPqlEDBUIhTvug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96C9485A581;
        Wed,  8 Jun 2022 03:19:44 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFD30492CA4;
        Wed,  8 Jun 2022 03:19:43 +0000 (UTC)
Date:   Wed, 8 Jun 2022 11:19:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 3/5] mm/vmalloc: Initialize VA's list node after unlink
Message-ID: <YqAVS7rYAmOmlLYH@MiWiFi-R3L-srv>
References: <20220607093449.3100-1-urezki@gmail.com>
 <20220607093449.3100-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093449.3100-4-urezki@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/22 at 11:34am, Uladzislau Rezki (Sony) wrote:
> A vmap_area can travel between different places. For example
> attached/detached to/from different rb-trees. In order to
> prevent fancy bugs, initialize a VA's list node after it is
> removed from the list, so it pairs with VA's rb_node which
> is also initialized.
> 
> There is no functional change as a result of this patch.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 745e89eb6ca1..82771e555273 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -978,7 +978,7 @@ __unlink_va(struct vmap_area *va, struct rb_root *root, bool augment)
>  	else
>  		rb_erase(&va->rb_node, root);
>  
> -	list_del(&va->list);
> +	list_del_init(&va->list);

Don't object this change, while list_del poison members, which is also
not bad?

static inline void list_del(struct list_head *entry)                                     
{                                                                                        
        __list_del_entry(entry);                                                         
        entry->next = LIST_POISON1;                                                      
        entry->prev = LIST_POISON2;                                                      
}   


>  	RB_CLEAR_NODE(&va->rb_node);
>  }
>  
> -- 
> 2.30.2
> 
> 

