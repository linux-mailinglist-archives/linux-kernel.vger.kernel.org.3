Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852795875D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiHBDIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHBDH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B43C31DDB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659409620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zQia0Oassrqu4Y+65KjGvbcaoFf/cSiBHiey4HDVUY=;
        b=RAQl7y2lQwE9rTiv0xyuxOgLTBr0oGqsrKnnQV6shxp5LzFJljgIVU9ekMXTGPaBlM5ucL
        Rknsi4WeAxvwkuE9BY7gbrFgOymUXx0jlzHNMQUoAf/MNIKiy0rtsungcBlHaPF2rpB/rt
        yKuxp3P0OWeNnsR4Gz+ZCwNqPaeIZXY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-SiwiOuq3OiSEzAI25UpcQA-1; Mon, 01 Aug 2022 23:06:59 -0400
X-MC-Unique: SiwiOuq3OiSEzAI25UpcQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B33FD294EDCC;
        Tue,  2 Aug 2022 03:06:58 +0000 (UTC)
Received: from localhost (ovpn-13-104.pek2.redhat.com [10.72.13.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB6A32026D64;
        Tue,  2 Aug 2022 03:06:57 +0000 (UTC)
Date:   Tue, 2 Aug 2022 11:06:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Message-ID: <YuiUzodsyv3hZAgs@MiWiFi-R3L-srv>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707231550.1484-1-fmdefrancesco@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/22 at 01:15am, Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
> 
> With kmap_local_page(), the mappings are per thread, CPU local and not
> globally visible. Furthermore, the mappings can be acquired from any
> context (including interrupts).
> 
> Therefore, use kmap_local_page() in kexec_core.c because these mappings are
> per thread, CPU local, and not globally visible.
> 
> Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
> enabled.

Wondering what arch you tested with. 

This looks good, but may not benefit much. Say so because I doubt
how many 32bit systems are using kexec/kdump mechanism.

Anyway, 

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
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
> 2.36.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

