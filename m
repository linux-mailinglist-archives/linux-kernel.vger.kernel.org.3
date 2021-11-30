Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2F462DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhK3Hvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:51:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234471AbhK3Hvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638258509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WF/k4TYUb23OKSPNxq7b+VZIkGdN1+576822KS46Fcg=;
        b=Rutm7EXgUQhkDze3xmywIiuaiAgGLdIcG4oOYQPTGtiKPkiHsNlpaHXQkBKICkZEzdFed9
        5g1gx/rfrkvkEQK5dNyTWvrFYxXQM1/qpVcUbaDmRsICnXxHkDTHvOIo02KjjGE9YYrseq
        XyjX/1YyhkvDgBo0eMu0fbBEVyf+SbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-c_NNSagHP6WIwC0tcl5SUQ-1; Tue, 30 Nov 2021 02:48:21 -0500
X-MC-Unique: c_NNSagHP6WIwC0tcl5SUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFFF91006AA6;
        Tue, 30 Nov 2021 07:48:19 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FBD760C0F;
        Tue, 30 Nov 2021 07:48:17 +0000 (UTC)
Message-ID: <9663b7f1584bc53cc4868a6ede5ef785b3380af6.camel@redhat.com>
Subject: Re: [BUG] hugetlbfs: Fix issue of preallocation of gigantic pages
 can't work
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Zhenguo Yao <yaozhenguo1@gmail.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 30 Nov 2021 09:48:16 +0200
In-Reply-To: <20211129133803.15653-1-yaozhenguo1@gmail.com>
References: <20211129133803.15653-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-29 at 21:38 +0800, Zhenguo Yao wrote:
> Preallocation of gigantic pages can't work bacause of commit:b5389086ad7b
> (hugetlbfs: extend the definition of hugepages parameter to support node
> allocation). When nid is NUMA_NO_NODE(-1), alloc_bootmem_huge_page will
> always return without doing allocation. Fix this by adding more check.
> 
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 60f9b6a9582e..6d1603387914 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2876,7 +2876,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	struct huge_bootmem_page *m = NULL; /* initialize for clang */
>  	int nr_nodes, node;
>  
> -	if (nid >= nr_online_nodes)
> +	if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
>  		return 0;
>  	/* do node specific alloc */
>  	if (nid != NUMA_NO_NODE) {

Tested, works fine.

Thanks!
Tested-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

