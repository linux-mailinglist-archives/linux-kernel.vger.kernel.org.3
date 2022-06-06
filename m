Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6182D53EAEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiFFOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiFFOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0849444A38
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654526595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hmegJDlciN/B3fxPivIljj+5ACoeX4tuyNcnTvSLxao=;
        b=aiz82xJCLJp+A8LWUnI4j4K586OWNSIytIhsB16pwMbxPw+ckRxU4m4ep5iFklm24x2f6k
        0F8rd/aI4dx9kt1g6FqeMAYj50WoetyoGKJwQ3WJEyHCUv94coryvca57lbcTfB+/eXDHQ
        nuXDOVxUQzm8Qx4wmICqh7mN9CEWHxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-_HnDUNqUPp-i31QtVv_EcQ-1; Mon, 06 Jun 2022 10:43:11 -0400
X-MC-Unique: _HnDUNqUPp-i31QtVv_EcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3224A101A54E;
        Mon,  6 Jun 2022 14:43:11 +0000 (UTC)
Received: from localhost (ovpn-14-4.pek2.redhat.com [10.72.14.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80B2E2166B29;
        Mon,  6 Jun 2022 14:43:10 +0000 (UTC)
Date:   Mon, 6 Jun 2022 22:43:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] mm/highmem: Delete memmove_page()
Message-ID: <Yp4SepU4T5FehMsy@MiWiFi-R3L-srv>
References: <20220606141533.555-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606141533.555-1-fmdefrancesco@gmail.com>
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

On 06/06/22 at 04:15pm, Fabio M. De Francesco wrote:
> Matthew Wilcox reported that, while he was looking at memmove_page(), he
> realized that it can't actually work.
> 
> The reasons are hidden in its implementation, which makes use of
> memmove() on logical addresses provided by kmap_local_page(). memmove()
> does the wrong thing when it tests "if (dest <= src)".
> 
> Therefore, delete memmove_page().
> 
> No need to change any other code because we have no call sites of
> memmove_page() across the whole kernel.

Nice clean up.
Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem.h | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 3af34de54330..fee9835e3793 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -336,19 +336,6 @@ static inline void memcpy_page(struct page *dst_page, size_t dst_off,
>  	kunmap_local(dst);
>  }
>  
> -static inline void memmove_page(struct page *dst_page, size_t dst_off,
> -			       struct page *src_page, size_t src_off,
> -			       size_t len)
> -{
> -	char *dst = kmap_local_page(dst_page);
> -	char *src = kmap_local_page(src_page);
> -
> -	VM_BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> -	memmove(dst + dst_off, src + src_off, len);
> -	kunmap_local(src);
> -	kunmap_local(dst);
> -}
> -
>  static inline void memset_page(struct page *page, size_t offset, int val,
>  			       size_t len)
>  {
> -- 
> 2.36.1
> 
> 

