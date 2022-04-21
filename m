Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AED509A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386424AbiDUII4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiDUIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:08:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C311B78F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D9B61ABA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A98FC385AB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528361;
        bh=9MnyHMj4/WZWXBUrOQs4qeUaIaUlxdy8igZsS3lMkVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MIvk92Srxr23LX7TlLH90nQXY6T/havYMoWz5qtfT/UymbihSbaG+YUcaBK7o6qoN
         ncMEgsU0p12Mme6v+eLiYgWGS9GpFqHmYgS2hkoi/P1oQruLwiC8FPyZMGdXSDKGz4
         R3twXJr1noDPWn9GSzmx1c+SWKpEBr2o0jMTB7vOK4x1430MtOzsEGJ5WP2a6rTamD
         sEEytXiegjePrMi10SwomqSqZrNF2ZdWxnAhj+Y3pXajj/cj4saAUE8xplNgbAy+ER
         O9yLgO6SXeq1aZ0ijCdnanLFIWNl3NIneyKJeRnOdR1oNmU2+55T4i4YRUuzAJpH10
         vSMz3v5ZgHqmQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e5e433d66dso4647387fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:06:01 -0700 (PDT)
X-Gm-Message-State: AOAM531/6SeQkCLne6oRMerf8IqNntG5xT7cCuJ/0Von3ECJYl9QSsyM
        vmc9LVgUlh72su3/liXIZmVAUusinV5eLcAXTb0=
X-Google-Smtp-Source: ABdhPJzuKwwfoRfldur0eTFFvHflMSJoW3hPIFAXLb7ZszW8X7w95tURymH4a711BiVbokZ6QdpjBaOqWffm9M8yDDQ=
X-Received: by 2002:a05:6871:297:b0:e5:f100:602f with SMTP id
 i23-20020a056871029700b000e5f100602fmr3358921oae.126.1650528360636; Thu, 21
 Apr 2022 01:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <YlvK9iefUECy361O@gondor.apana.org.au> <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au> <YlvU6ou14okbAbgW@arm.com>
 <YlvWtc/dJ6luXzZf@gondor.apana.org.au> <YlxAo5BAy+ARlvqj@arm.com>
 <Yl0jPdfdUkaStDN5@gondor.apana.org.au> <Yl2Vda/8S7qAvMjC@arm.com>
 <CAMj1kXEGdPageO3tb2=eLnGAR9-nZtmTGXcGf5CiTQFC4JiXOg@mail.gmail.com>
 <CAK8P3a1+GqbO5Kgf70nmR8rQg5OaLBsFZJWaOLuS7JRqXb-ZNA@mail.gmail.com> <YmEFttLxGbyJx8LK@infradead.org>
In-Reply-To: <YmEFttLxGbyJx8LK@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Apr 2022 10:05:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFOn7F1bfwn_xDGvk3dKt8UwmPcpemzXds33eYHVCgR-Q@mail.gmail.com>
Message-ID: <CAMj1kXFOn7F1bfwn_xDGvk3dKt8UwmPcpemzXds33eYHVCgR-Q@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 at 09:20, Christoph Hellwig <hch@infradead.org> wrote:
>
> Btw, there is another option:  Most real systems already require having
> swiotlb to bounce buffer in some cases.  We could simply force bounce
> buffering in the dma mapping code for too small or not properly aligned
> transfers and just decrease the dma alignment.

Strongly agree. As I pointed out before, we'd only need to do this for
misaligned, non-cache coherent inbound DMA, and we'd only have to
worry about performance regressions, not data corruption issues. And
given the natural alignment of block I/O, and the fact that network
drivers typically allocate and map their own RX buffers (which means
they could reasonably be fixed if a performance bottleneck pops up), I
think the risk for showstopper performance regressions is likely to be
acceptable.
