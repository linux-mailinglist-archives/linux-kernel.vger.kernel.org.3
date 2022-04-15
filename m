Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF145028EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352684AbiDOLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiDOLk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2162F5DE59
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEFE62291
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A58C385AC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650022708;
        bh=vXUC8IDY9bUnBt/qfk3ZWqIDk/HTdhBPloKaZakPo/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LhNhnbeJ41CGuuGk/t2WMCa+Vocx8kFsV/OMhSXrfjnJNiTMpRSf7klAwBiWfG80m
         03ATkfWE7BgUHVlFUa51uRWONW9q9krpd2K8t3FxW+y8agqkIoww7L4g3dWmdaAsqT
         qDrxd/4fHdSstYFfO3bz8+TmXHExM/h7KQLbdWdpBTwkcLx/XIjHwjpSk6lL5MJzfD
         wxSlinbSC3Pl0mxKF8sVF4uddfQayCLuLyFndV7PbuLKXs0aU1MpXA2nBCgEve1CYp
         Ty/1SoU9u134yuw7nJt3FdTk2p3FryH1pZNrV92lE+oXAtrq12g9rlklgG11gLAVwG
         xeE16waEt6r8w==
Received: by mail-ot1-f41.google.com with SMTP id g17-20020a9d6191000000b005e8d8583c36so5221465otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:38:27 -0700 (PDT)
X-Gm-Message-State: AOAM533JiXtBt4gU3tg45572aow06Cu8JKndck6+ayt3s/QCdibV4wbP
        WUbtQCahY5BcBnct7BIM0zdm0J5OErPcxHi7aAI=
X-Google-Smtp-Source: ABdhPJxbdPyhecm17U5r/LhiKDrO7HSSUFwbD9WNDKBQ8yyN8DJUXRbCwqgih5HaGzzy770gbFQdEBCHF2qQOkGDAO4=
X-Received: by 2002:a05:6830:2e7:b0:5b2:68c1:182a with SMTP id
 r7-20020a05683002e700b005b268c1182amr2485815ote.71.1650022707025; Fri, 15 Apr
 2022 04:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au> <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <Ylko07++4naWJ5LE@gondor.apana.org.au> <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
 <YllE+wWqP6F+1nwa@gondor.apana.org.au> <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au>
In-Reply-To: <YllM24eca/uxf9y7@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 13:38:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
Message-ID: <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 at 12:45, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Apr 15, 2022 at 12:22:27PM +0200, Ard Biesheuvel wrote:
> >
> > Subsequent objects are owned by the driver, and it is the
> > responsibility of the driver not to modify the fields while it is also
> > mapped for DMA (and we have had issues in the past where drivers
> > violated this rule). So as long as ARCH_KMALLOC_ALIGN guarantees
> > actual DMA minimum alignment for both the start and the end, we
> > shouldn't need any explicit padding at the end.
>
> I don't understand why this is guaranteed.  The driver context
> size is arbitrary so it could end in the middle of a cacheline.
> The slab allocator could well lay it out so that the next kmalloc
> object starts right after the end of the context, in which case
> they would share a cache-line.
>

If this is the case, things are already broken today. We never take
ARCH_DMA_MINALIGN into account when adding the driver ctx size to the
overall allocation size.

> The next kmalloc object could be (and in fact is likely to be)
> of the same type.
>
> Previously this wasn't possible because kmalloc guaranteed
> alignment.
>

Either it does or it doesn't. If kmalloc() guarantees the actual DMA
alignment at both ends, the situation you describe cannot occur, given
that the driver's slice of the request/TFM structure would be padded
up to actual DMA alignment, in spite of whether or not
ARCH_DMA_MINALIGN exceeds that. So it would never share a cacheline in
practice, even though they might live in the same 128 byte aligned
region on a system that has a minimum DMA alignment that is lower than
that.

If kmalloc() does not guarantee that the end of the buffer is aligned
to actual DMA alignment, things are already broken today.
