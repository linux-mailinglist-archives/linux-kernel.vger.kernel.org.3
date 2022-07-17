Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99F577519
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 10:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGQIpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiGQIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 04:45:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF819013
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 01:45:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q9so12812298wrd.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ng6rzazS6Tk6UvbQ3R5jjWEIXMg8N4bQvPfxnlyfNbo=;
        b=CmxKx+nQvad3HTpNlJ+avnudMtN9Xm9fUthF9bwqnIyq4X2u5I1j5jJ291kh14HPOX
         hWcHS0gJKQyuWaTG8JR5BewIbjlvCzHQUf9ThjOi9vax59L8X7IOHcOnSUcUmO++MWMQ
         rw0hSi1NyV6t0l8nVrcpGoQs0DnW3cD58YkAc+YKINqm4+bqKGD3JyIxKM6E+FjkNO0L
         NAF04D/Rb9NJkS9CjbdJYHWw6uZT2ZXWJMiaHOHRGS76ccA+NqDeSftnSBQ6kojdeQeC
         RAXTnf7+jwyc1ff8/awsOdy71tRoHnTecbTPgwg3u+Oc46bithtxnCI30Q3QVbbAJrr9
         fMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ng6rzazS6Tk6UvbQ3R5jjWEIXMg8N4bQvPfxnlyfNbo=;
        b=OW7g5EvU4c9I7Tzwp9uBYIUFksZ5O8v9rlZk/+2y8e8ddgX1+DgZJcy7jegQhbnrBt
         ke3f8URI6CLu1sDir5MEsZpAfuiSReo3cY6Oh3d0ndcVh91D1jQbn3XBy7Bbx6YuJnWR
         ONbk7CSePgyQsT2hlS5BDWt+Sb93u00kbdJUv05Aipzqa8bZ8n8RU/271ZXN+GKd5nB1
         vfxugm7oqWi0zrqTlJBirKmYfWOb3kBxX1A2NJr3gx8TIxQFjXiYmzd7oi8NLSRwLK12
         k+sqQQhjxV2Y0DvhtFPU0Zw/W3MLmJx23euWnY3fVEaNC30Zuun/2X6idWNsfyNRfs22
         wsng==
X-Gm-Message-State: AJIora8rvhbiFG/jGXPmbvHsqSUnD+LINAGKLKc8n6iy+OsHaUV7adWz
        4dgDRASe8qVNoPvuSgEHf7c=
X-Google-Smtp-Source: AGRyM1tlcDXmc2ygbyHwkdkHRrUNbu0SA9UGzRD63/Giacky8V4oJwhQ/b+B6fBr0vh5CYemqnykiQ==
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id a8-20020a056000050800b0021d4105caf9mr19435437wrf.699.1658047500076;
        Sun, 17 Jul 2022 01:45:00 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id f2-20020a1c6a02000000b003a2e89d1fb5sm14360941wmc.42.2022.07.17.01.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 01:44:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] f2fs: Use memcpy_page() in f2fs_copy_page()
Date:   Sun, 17 Jul 2022 10:44:57 +0200
Message-ID: <4431767.LvFx2qVVIh@opensuse>
In-Reply-To: <YtOyWOKFN9ramUyb@infradead.org>
References: <20220716204353.22049-1-fmdefrancesco@gmail.com> <YtOyWOKFN9ramUyb@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 17 luglio 2022 08:55:20 CEST Christoph Hellwig wrote:
> On Sat, Jul 16, 2022 at 10:43:53PM +0200, Fabio M. De Francesco wrote:
> >  static inline void f2fs_copy_page(struct page *src, struct page *dst)
> >  {
> > -	char *src_kaddr = kmap(src);
> > -	char *dst_kaddr = kmap(dst);
> >  
> > -	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
> > -	kunmap(dst);
> > -	kunmap(src);
> > +	memcpy_page(dst, 0, src, 0, PAGE_SIZE);
> 
> Please remove f2fs_copy_page entirely and open code this in the only
> caller.
> 
I've changed the subject of the new patch, therefore we won't have a second 
version of this:

"f2fs: Delete f2fs_copy_page() and replace with memcpy_page()" is at
https://lore.kernel.org/lkml/20220717083613.3861-1-fmdefrancesco@gmail.com/

Thanks for your suggestion,

Fabio


