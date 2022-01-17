Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38BA490BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiAQP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiAQP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:56:16 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC43C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p27so47593617lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hLXVfGuqokAhjQPquljpv4IuCQa5SRFe/JWEcrZu/DE=;
        b=vWlPwu36tQDWXefh3AbPXuoJBEob07beXqKflgEp+7ZAnJW5ToHIDMHJIor8471x1c
         nFYXIH7cEZDVMG3Ad1Imes4RlH8Ydng8D3FkDW5MMRCK22hHEVThHKgMd85wVsb7GFYN
         NjF51iRPH0L/P/djgibOK7lcyHSKmyAdtxFeBBJf6FY8PPwF7Tw2bYnIWeB4Xuf5pF2j
         gac7TcyYTjXdsC0I9fClYQR/2Xm0R2RHuY/uCppEBkwPgNSHe4J3imjM2CYIZYS9qZe3
         9CkqPiTksIsEa0tVVl3iEHdCi5/WLw/yxczM5hZetsHNeD8jc+DfAsoK7XK+iNuiLe/v
         ECHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hLXVfGuqokAhjQPquljpv4IuCQa5SRFe/JWEcrZu/DE=;
        b=XEFo1qR8QwvYylHuOhzy/T7ezRcZ0II2FfukxZ+U4vYGlYTXti5AfGG3Lfp0AO8ap3
         zn/puFJ//4h7n2ynkCXlCS0PsEStH7ptu7Iuu6C54LqTDIzKblcmTCBGtGtJBxy+xwH3
         J0TOG60xPoNaDnFBUISFBpOvlqCQTaWOa9igNOed5MwT/7DgU6JtPavSzdtxFIvuvb22
         N8+PwppYOf3CICpZG0p1Vc+SiAMKAtpTlw8M91YT2EOSLyYlnesyAVIHIUeh92nld4Jo
         WSuNzi1tBfx9J4lV/WspIgX54uKhImDJqToRs+gdU0+4sa61YPXlrLsfiRAmtQzvA2Q0
         y+qg==
X-Gm-Message-State: AOAM531kJTF2j5sQ5nGD1q7yr1gvSl6GyraJEJXwxiB0W8eddQETxsKa
        yH8BXxM4dcdf16g8pvdlhQo8Dg==
X-Google-Smtp-Source: ABdhPJz7FbfdpZdmtC5Jx84Ckv5DAebrmkY0nZUOV+wJaKhApnBN6pH5FhbND8E1a+JvKqJk7BwvRw==
X-Received: by 2002:ac2:5597:: with SMTP id v23mr16906486lfg.477.1642434974035;
        Mon, 17 Jan 2022 07:56:14 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k19sm1425334lfu.176.2022.01.17.07.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:56:13 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 84A7810387E; Mon, 17 Jan 2022 18:56:41 +0300 (+03)
Date:   Mon, 17 Jan 2022 18:56:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/12] filemap: Use folio_put_refs() in
 filemap_free_folio()
Message-ID: <20220117155641.u5ysambg72nq2p6y@box.shutemov.name>
References: <20220116121822.1727633-1-willy@infradead.org>
 <20220116121822.1727633-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116121822.1727633-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 12:18:12PM +0000, Matthew Wilcox (Oracle) wrote:
> This shrinks filemap_free_folio() by 55 bytes in my .config; 24 bytes
> from removing the VM_BUG_ON_FOLIO() and 31 bytes from unifying the
> small/large folio paths.
> 
> We could just use folio_ref_sub() here since the caller should hold a
> reference (as the VM_BUG_ON_FOLIO() was asserting), but that's fragile.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 2fd9b2f24025..afc8f5ca85ac 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -231,17 +231,15 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
>  void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>  {
>  	void (*freepage)(struct page *);
> +	int refs = 1;
>  
>  	freepage = mapping->a_ops->freepage;
>  	if (freepage)
>  		freepage(&folio->page);
>  
> -	if (folio_test_large(folio) && !folio_test_hugetlb(folio)) {
> -		folio_ref_sub(folio, folio_nr_pages(folio));
> -		VM_BUG_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
> -	} else {
> -		folio_put(folio);
> -	}
> +	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> +		refs = folio_nr_pages(folio);

Isn't folio_test_large() check redundant? folio_nr_pages() would return 1
for non-large folio, wouldn't it?

> +	folio_put_refs(folio, refs);
>  }
>  
>  /**
> -- 
> 2.34.1
> 

-- 
 Kirill A. Shutemov
