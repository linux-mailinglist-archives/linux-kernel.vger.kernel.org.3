Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179595099BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386096AbiDUHs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386464AbiDUHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:48:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8261CB29
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mpSnoa0Ptdj3sZDv+oxGPnwE6ZAfL1X74Yg2ESPwiQc=; b=Dn5qcoG/ZzIAUgk6cTqYbqwdtX
        Avw7vRdFRJ0mTg0bUsK+CZs3rvNhZwzK05CPovfiRdjzT2IPY5F/xkMFvEi3TxxPzgA0PWndKRaro
        TDX4TxT49DdA19r1AiPNNaBG+ylWbZ/bp7X1uUVv/y594i53QRs01NtsHlJnbmL4dX0KIa4bSU2D0
        J0gw74MLBPQgKovFmvso7KYxr5pAX05QzWEX05BK5JdXXDoudegJ0u7ZQMUKKBBprFGA5hej3Sx93
        MG+lEODfk+CkU37d5R+LIHy5X5+weF1rDa4fkmX9IQY1YvT7hlZ2MVyYQQI24eDsxevyBfLsaOgbS
        ic50dxhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhRUA-00C8dO-Ci; Thu, 21 Apr 2022 07:44:18 +0000
Date:   Thu, 21 Apr 2022 00:44:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YmELUguCXdxhK9ek@infradead.org>
References: <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
 <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au>
 <Yl2Vda/8S7qAvMjC@arm.com>
 <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com>
 <YmEFttLxGbyJx8LK@infradead.org>
 <CAK8P3a3MVZ=QGcU8DaZbc5eaAt_FvoEEnqLqTYa=+9w__VYEig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3MVZ=QGcU8DaZbc5eaAt_FvoEEnqLqTYa=+9w__VYEig@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:36:46AM +0200, Arnd Bergmann wrote:
> Does this work on all 32-bit architectures as well? I see that you added
> swiotlb for ARM LPASE systems in 2019, but I don't know if that has any
> additional requirements for the other 32-bit architectures that don't
> select SWIOTLB today.

We'll need to call swiotlb_init for all these cases, but there is no other
fundamental requirement.  We can probably do with a way smaller buffer
if bouncing is only needed for misaligned allocations.
