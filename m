Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87857843E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiGRNsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiGRNsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:48:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3E255BE;
        Mon, 18 Jul 2022 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=he4BsFEqlETpQMe0yQVdnX/HTL6ufCO0M/YAN+bslNU=; b=d1bPonhbieaRwnjlWIosd26sbt
        4eaqaKU7ZGwauPRt0tQTKkz3dQk22w2G67cJSDwS2ILMIv52NZkkdgKPJQ3tfu0ri9Ux+fSpxLK6E
        Tb3UNKjFZmOw8Y19GLoITRPuOf54w3UVeaeOgYym2PHAkHmlZVxdwL0kRsDblEype+2f2pdtzs4C2
        XSWzyZWPhIPcVfXaPP9fNM/5zmu5Qad8JePz6noKGSiOuASDo/b8+ct/ZjMSK8N7NKkI9caikM4fR
        yeip29miYKwy6bhGhb4Ra/P2+EPrmqMdNBOajMgNLbD5FNzIuF2qbSooIDtb31jTQ1hlw+1oHkknN
        lLqend1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDR6j-00Cj5t-My; Mon, 18 Jul 2022 13:48:21 +0000
Date:   Mon, 18 Jul 2022 14:48:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/3] s390/crash: use static swap buffer for
 copy_to_user_real()
Message-ID: <YtVkpRJ7jvLFuKs4@casper.infradead.org>
References: <cover.1658148067.git.agordeev@linux.ibm.com>
 <77d50b4a2359d1791835b6111edaa155eb11c5ea.1658148067.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d50b4a2359d1791835b6111edaa155eb11c5ea.1658148067.git.agordeev@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:32:40PM +0200, Alexander Gordeev wrote:
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -53,6 +53,7 @@ struct save_area {
>  };
>  
>  static LIST_HEAD(dump_save_areas);

I'd suggest you need a mutex here so that simultaneous calls to
copy_to_user_real() don't corrupt each others data.

> +static char memcpy_real_buf[PAGE_SIZE];
>  
>  /*
>   * Allocate a save area
> @@ -179,23 +180,18 @@ int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
>  static int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
>  {
>  	int offs = 0, size, rc;
> -	char *buf;
>  
> -	buf = (char *)__get_free_page(GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
>  	rc = -EFAULT;
>  	while (offs < count) {
>  		size = min(PAGE_SIZE, count - offs);
> -		if (memcpy_real(buf, src + offs, size))
> +		if (memcpy_real(memcpy_real_buf, src + offs, size))
>  			goto out;
> -		if (copy_to_user(dest + offs, buf, size))
> +		if (copy_to_user(dest + offs, memcpy_real_buf, size))
>  			goto out;
>  		offs += size;
>  	}
>  	rc = 0;
>  out:
> -	free_page((unsigned long)buf);
>  	return rc;
>  }
>  
> -- 
> 2.34.1
> 
