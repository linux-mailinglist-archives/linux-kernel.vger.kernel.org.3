Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1453A587
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352301AbiFAMyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348543AbiFAMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:54:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCAB70349
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ugEdXtdPTz7l7vpumg4n6fVUSq1X4RC9jlklJg1z4yw=; b=dvg2T38wTK91QzKunvS1ZhpYsz
        nYopqQYOkSlqGxqxpyRCRjqcc2HS+2EmcnGRv4AeqQj1VkJxcThnmGoE+Uslfn7LZpfJOPKlUUnyR
        jKuJ4cIc4CiUMX8QKhLv5vayfYrn6nmt73DIf73TsPNr47GuunPRndUFiPkIFiHx3RrXTjRrXHYjD
        CKybdte42ObKCfhrfKPCjkjz5BXkpTzU2hippQ6dtYFBIQB9vEYbY99JecDNfxzlUHIeb+8nErAWB
        dpnbbNIzHRuX9QS05I5s2i72tcgFwFN9ThACS/JVu8yI4OrNWkUHcVHl4uITDHq+3M6e5HcZqkGBd
        Q466yiQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwNre-006IlO-LK; Wed, 01 Jun 2022 12:54:18 +0000
Date:   Wed, 1 Jun 2022 13:54:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/shmem: check return value of shmem_init_inodecache
Message-ID: <YpdhehYSyJFOj3Tq@casper.infradead.org>
References: <20220601124417.2872001-1-chenwandun@huawei.com>
 <20220601124417.2872001-2-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601124417.2872001-2-chenwandun@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:44:14PM +0800, Chen Wandun wrote:
> -static void shmem_init_inodecache(void)
> +static struct kmem_cache *shmem_init_inodecache(void)
>  {
>  	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
>  				sizeof(struct shmem_inode_info),
>  				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
> +
> +	return shmem_inode_cachep;
>  }
>  
>  static void shmem_destroy_inodecache(void)
> @@ -3924,7 +3926,10 @@ void __init shmem_init(void)
>  {
>  	int error;
>  
> -	shmem_init_inodecache();
> +	if (!shmem_init_inodecache()) {
> +		error = -ENOMEM;
> +		goto out2;
> +	}

better to return the errno from shmem_init_inodecache():

	error = shmem_init_inodecache();
	if (error)
		goto out2;
