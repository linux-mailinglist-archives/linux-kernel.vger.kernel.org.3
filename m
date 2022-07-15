Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9A5769DB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGOWXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiGOWXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:23:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D362A65
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:23:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bf13so5563487pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h08OBDtouOlnPaz6Mk89TkUqXNC6lVw4WMryRnoY4iQ=;
        b=SWBq670YGdUDUrz+LfGaVqhLNtXSduF+1kAy8tHbqCMHxzTK2rLblqfH6+CYEvdUam
         v/yPvYMRRAlLYRePmgUlEhwaZDQzzCUf0nqX9tCSngUrFJ3YHZC9ejmTonEQ50Z+I/Yj
         c1sewCP8LAbIU2jpaun7nKp+rgKHD72Lizf+bO4mumGPe2vWfA67JxK3kb+IEdYq8TNn
         pIdzdO2OTit8/qw1V54APG3u1c8H1kvrqDVs+q/aXt73IJUVDKz0ARo02W3lSYb3Qefq
         EDluaP4iCN+GLO9VxvShkAf0mAA5qQAoOdTV4B8ZwfWJRk5kK9g44irFj6vG73BckUH8
         N1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h08OBDtouOlnPaz6Mk89TkUqXNC6lVw4WMryRnoY4iQ=;
        b=M5sSGULnGSfPfv8rwY3oWgju1bN/QJw5PafwNFRpwAYXLYprXiKGuvQU32DJ6ubOGx
         4jOaHv+rnGXL3LQOsTjWplLxDYAmL3u8OQMIwlECKUgKcA2oG3jV3AbHL4o5zkXmJHze
         lInbtKhph67g/mVwspSDS36vwY1633iEfYTVS80YR9Z3gzJS0F8Gw1L1Z01PSt33kPxv
         nMPzm9ZeVpz5vCdCDU0kSe8A4/H9PlYbqrxKAeFFW5T2FzrzOpc2Cs2KxJlHb02sSEjl
         +abKpixeuXvjg6+45p/c5HESiTzKJNy963UE9389gCM0VZoI/Y7OQh60KXWOmL2taNPr
         FS1g==
X-Gm-Message-State: AJIora8zR1CuxWcMYeRpJ4Y5Hz/4JhI2cjniB/Sz2oDXTzNPCjsY0dqw
        4UHpmtW1x3GrecrcHA0rzR1unA==
X-Google-Smtp-Source: AGRyM1t7Ufq+16dtrPJCG7vL3sPupbfNcIcgSZ5v9myXTI8I39QsDiDTWJovZbADGjskDpoUBCWLQQ==
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id v8-20020a655688000000b003c21015988emr14079913pgs.280.1657923811299;
        Fri, 15 Jul 2022 15:23:31 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:e72f:c983:e093:d463])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016bf803341asm1972182plg.146.2022.07.15.15.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 15:23:30 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:23:25 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YtHo3Xu33jovwpFt@google.com>
References: <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <YllALIgZcQJ6asdA@arm.com>
 <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlxATW56ZoNtmxlk@arm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 05:29:01PM +0100, Catalin Marinas wrote:
> On Sun, Apr 17, 2022 at 04:43:33PM +0800, Herbert Xu wrote:
> > On Sun, Apr 17, 2022 at 09:38:40AM +0100, Catalin Marinas wrote:
> > > I don't think we need to do anything here. A structure like:
> > > 
> > > struct x {
> > > 	char y;
> > > 	char z[] CRYPTO_MINALIGN_ATTR;
> > > };
> > > 
> > > is already of size 128. Without CRYPTO_MINALIGN_ATTR, its size would be
> > > 1 but otherwise the whole structure inherits the alignment of its
> > > member and this translates into an aligned size.
> > 
> > No we should not lie to the compiler,
> 
> We won't if we ensure that a structure with sizeof() >= 128 is aligned
> to 128.
> 
Right. kmalloc() should return a 128 byte aligned pointer as long as
the size of the allocation is >= 128 bytes, and the kmalloc-192 cache
isn't present. So, the current behavior that crypto is relying on
wouldn't change, so I agree with Catalin that we wouldn't be lying to
the compiler if we move forward with getting rid of kmalloc-192.

FWIW, I did a comparison on my machine with and without kmalloc-192, and
the amount of memory usage that increased from allocations being redirected to
kmalloc-256 was about 0.4-0.5 MB, which doesn't seem too bad.

> > we have code elsewhere
> > that uses the alignment to compute the amount of extra padding
> > needed to create greater padding.  If CRYPTO_MINALIGN is misleading
> > then that calculation will fall apart.
I don't think it would be misleading. If all of your allocations
are >= CRYPTO_MINALIGN == ARCH_DMA_MINALIGN in size, and
kmalloc()--with kmalloc-192 removed--returns buffers that are aligned to a
power of 2, and are big enough to accomodate your allocation, then wouldn't
they always be CYRPTO_MINALIGN'ed, so your calculation would still be fine?

--Isaac
