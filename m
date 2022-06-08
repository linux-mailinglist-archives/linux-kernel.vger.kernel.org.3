Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF75425C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiFHGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiFHFxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E8E02CB4F1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654660041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1W4hgx8Hu6HctQFGvInxvOPdJHknH/VauE9079NO9c=;
        b=UFOTTWDo/k76fAiYgdkpVK5X07NyP65X8TTr0zfZZzGYNIYxeex+1BTRQRtPtGIgFtzca0
        O6aRzqsKK2FIibmdgpVPFp7AgGunL9jWO5jGPFTX/ts/Vl8+zQwuZplZqIIWTACVXq0UWs
        AczlYtPIO0XO+2ZC9bClWCFFX2anbm4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-iuJJXqDKPlupan0skIUoTw-1; Tue, 07 Jun 2022 23:47:18 -0400
X-MC-Unique: iuJJXqDKPlupan0skIUoTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD09D1C0CE7A;
        Wed,  8 Jun 2022 03:47:17 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1F7F2166B26;
        Wed,  8 Jun 2022 03:47:16 +0000 (UTC)
Date:   Wed, 8 Jun 2022 11:47:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/5] mm/vmalloc: Extend __find_vmap_area() with one more
 argument
Message-ID: <YqAbwC/evlFgMXuc@MiWiFi-R3L-srv>
References: <20220607093449.3100-1-urezki@gmail.com>
 <20220607093449.3100-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093449.3100-5-urezki@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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
> __find_vmap_area() finds a "vmap_area" based on passed address.
> It scan the specific "vmap_area_root" rb-tree. Extend the function
> with one extra argument, so any tree can be specified where the
> search has to be done.
> 
> There is no functional change as a result of this patch.

LGTM,
Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 82771e555273..b60385101897 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -814,9 +814,9 @@ static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
>  	return va;
>  }
>  
> -static struct vmap_area *__find_vmap_area(unsigned long addr)
> +static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
>  {
> -	struct rb_node *n = vmap_area_root.rb_node;
> +	struct rb_node *n = root->rb_node;
>  
>  	addr = (unsigned long)kasan_reset_tag((void *)addr);
>  
> @@ -1840,7 +1840,7 @@ static struct vmap_area *find_vmap_area(unsigned long addr)
>  	struct vmap_area *va;
>  
>  	spin_lock(&vmap_area_lock);
> -	va = __find_vmap_area(addr);
> +	va = __find_vmap_area(addr, &vmap_area_root);
>  	spin_unlock(&vmap_area_lock);
>  
>  	return va;
> @@ -2582,7 +2582,7 @@ struct vm_struct *remove_vm_area(const void *addr)
>  	might_sleep();
>  
>  	spin_lock(&vmap_area_lock);
> -	va = __find_vmap_area((unsigned long)addr);
> +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
>  	if (va && va->vm) {
>  		struct vm_struct *vm = va->vm;
>  
> -- 
> 2.30.2
> 
> 

