Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EE58A51B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiHEDkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiHEDj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CFC35B7BD
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 20:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659670795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwqZIdkCCeZTZaiYZNxUCbYKyvxUe9kIL3vFtHSIkGU=;
        b=Y43LVLyBSnU4jTgfYSaXJtJWXrH5JU2OlkBnD9dAPw73sPbK9PK+aMuvtZe3BbKFlV147Q
        qSSeEglYmKW4SHHDGkQIswhd2r5MCwFXMeur1MrqC81hfkRC73M0v32I3U6HBlZTrWOr98
        jCpg3ycNybBEw1XPpRyZWYkDdktry8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-Hvwz2pLZO-SKHCb32aI0qw-1; Thu, 04 Aug 2022 23:39:49 -0400
X-MC-Unique: Hvwz2pLZO-SKHCb32aI0qw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5F978032F1;
        Fri,  5 Aug 2022 03:39:48 +0000 (UTC)
Received: from localhost (ovpn-12-174.pek2.redhat.com [10.72.12.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88749492C3B;
        Fri,  5 Aug 2022 03:39:47 +0000 (UTC)
Date:   Fri, 5 Aug 2022 11:39:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        akpm@linux-foundation.org
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3] kexec: Replace kmap() with kmap_local_page()
Message-ID: <YuyQ/cUBPGa9A1Jo@MiWiFi-R3L-srv>
References: <20220803160038.22322-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220803160038.22322-1-fmdefrancesco@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/22 at 06:00pm, Fabio M. De Francesco wrote:

Thanks for the log update. And Cc Andrew.

> kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and are still valid.
> 
> Since its use in kexec_core.c is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in kexec_core.c.
> 
> Tested on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v2->v3: Add more information in the commit message as requested by Baoquan
> He and forward two tags, respectively from Ira Weiny and Baoquan He (many
> thanks to them two!).
> 
> v1->v2: A sentence of the commit message contained an error due to a
> mistake in copy-pasting from a previous patch. Replace "aio.c" with
> "kexec_core.c".
> 
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4d34c78334ce..6f98274765d4 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -814,7 +814,7 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		if (result < 0)
>  			goto out;
>  
> -		ptr = kmap(page);
> +		ptr = kmap_local_page(page);
>  		/* Start with a clear page */
>  		clear_page(ptr);
>  		ptr += maddr & ~PAGE_MASK;
> @@ -827,7 +827,7 @@ static int kimage_load_normal_segment(struct kimage *image,
>  			memcpy(ptr, kbuf, uchunk);
>  		else
>  			result = copy_from_user(ptr, buf, uchunk);
> -		kunmap(page);
> +		kunmap_local(ptr);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
> @@ -878,7 +878,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			goto out;
>  		}
>  		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
> -		ptr = kmap(page);
> +		ptr = kmap_local_page(page);
>  		ptr += maddr & ~PAGE_MASK;
>  		mchunk = min_t(size_t, mbytes,
>  				PAGE_SIZE - (maddr & ~PAGE_MASK));
> @@ -894,7 +894,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		else
>  			result = copy_from_user(ptr, buf, uchunk);
>  		kexec_flush_icache_page(page);
> -		kunmap(page);
> +		kunmap_local(ptr);
>  		arch_kexec_pre_free_pages(page_address(page), 1);
>  		if (result) {
>  			result = -EFAULT;
> -- 
> 2.37.1
> 

