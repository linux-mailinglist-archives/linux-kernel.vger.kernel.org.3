Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6730E50297C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353193AbiDOMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiDOMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:21:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D9EBF969
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C83BCE2C65
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15709C385A6;
        Fri, 15 Apr 2022 12:18:56 +0000 (UTC)
Date:   Fri, 15 Apr 2022 13:18:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YllirUEhaxCDaV3X@arm.com>
References: <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:05:21AM +0200, Ard Biesheuvel wrote:
> On Fri, 15 Apr 2022 at 09:52, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > On Fri, Apr 15, 2022 at 09:49:12AM +0200, Ard Biesheuvel wrote:
> > > I'm not sure I understand what would go wrong if that assumption no
> > > longer holds.
> >
> > It's very simple, we don't do anything to the pointer returned
> > by kmalloc before returning it as a tfm or other object with
> > an alignment of CRYPTO_MINALIGN.  IOW if kmalloc starts returning
> > pointers that are not aligned to CRYPTO_MINALIGN then we'd be
> > lying to the compiler.
> 
> I guess that should be fixable. GIven that this is about padding
> rather than alignment, we could do something like
> 
> struct crypto_request {
>   union {
>       struct {
>         ... fields ...
>       };
>       u8 __padding[ARCH_DMA_MINALIGN];
>    };
>     void __ctx[]  __align(CRYPTO_MINALIGN);
> };
> 
> And then hopefully, we can get rid of the padding once we fix drivers
> doing non-cache coherent inbound DMA into those structures.

But if we keep CRYPTO_MINALIGN as 128, don't we get the padding
automatically?

struct crypto_request {
	...
	void *__ctx[] CRYPTO_MINALIGN_ATTR;
};

__alignof__(struct crypto_request) == 128;
sizeof(struct crypto_request) == N * 128

The same alignment and size is true for a structure like:

struct crypto_alg {
	...
} CRYPTO_MINALIGN_ATTR;

Any kmalloc() of sizeof(the above structures) will return a pointer
aligned to 128, irrespective of what ARCH_KMALLOC_MINALIGN is.

The problem is if you have a structure without any alignment attribute
(just ABI default), making its sizeof() smaller than ARCH_DMA_MINALIGN.
In this case kmalloc() could return a pointer aligned to something
smaller. Is this the case in the crypto code today? I can see it uses
the right alignment annotations already, no need for kmalloc() hacks.

-- 
Catalin
