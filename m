Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06872502682
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351310AbiDOIID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiDOIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A6A2046
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68FCA61F95
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1757C385AD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650009932;
        bh=riuuKXnoQlBRBV7zO25zHcF/JWwq7zfPNr5mu3m9+jI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tXi9Jj5fnDgYEJrim5xfcMUIa9y+5BF6p9ZqnM7Q/aJgxGpwJRTGeSeibe2Y5Ezn1
         teTDfS5nnAyKMU/ta+74JyWSeLIP6b0vZEqt5zWkyIVFKM3+0swjJv18a2cSQWQWqq
         IymLFV+D2iufYzMlVa94ag1HVsBOPhqflDvp4s7q4EBATTYae/zHKm9I0qr5DQXhq+
         O3gLobRWXRaenBCExS0LOcP8DoW7qndV8GXQIUI6o8VBWak5jLP/LfgiimF9nZx3dj
         ieTcO471WheCh1GtnDnM5PCMP6nnZ1RBHzqfHMvWEGdMx24LHCdlY8kPryIqMxlDej
         +TVsRzXWf2zbQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e2442907a1so7524265fac.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:05:32 -0700 (PDT)
X-Gm-Message-State: AOAM531C1pblVILATDEk+G1sy99aYEELZCX7N6XZ7gOco/tTypkCSZYQ
        lQv1ZgG7MKr9YcTAtlf8k2eLHZOl6beqm4S6+Ok=
X-Google-Smtp-Source: ABdhPJwa5+CpOCKoPK7GU76i17Qy9CqHOdE4RymA/6S6MbMw45+zBMAYYJTH6M4NHw/fG0dhmipO+89okOHPFS+WrVU=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr1000528oap.228.1650009931924; Fri, 15
 Apr 2022 01:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <Yk/8QExHlggU8KgC@gondor.apana.org.au> <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au> <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au> <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com> <YlkkGpVx8rhcsBot@gondor.apana.org.au>
In-Reply-To: <YlkkGpVx8rhcsBot@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 10:05:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
Message-ID: <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
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

On Fri, 15 Apr 2022 at 09:52, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Apr 15, 2022 at 09:49:12AM +0200, Ard Biesheuvel wrote:
> >
> > I'm not sure I understand what would go wrong if that assumption no
> > longer holds.
>
> It's very simple, we don't do anything to the pointer returned
> by kmalloc before returning it as a tfm or other object with
> an alignment of CRYPTO_MINALIGN.  IOW if kmalloc starts returning
> pointers that are not aligned to CRYPTO_MINALIGN then we'd be
> lying to the compiler.
>

I guess that should be fixable. GIven that this is about padding
rather than alignment, we could do something like

struct crypto_request {
  union {
      struct {
        ... fields ...
      };
      u8 __padding[ARCH_DMA_MINALIGN];
   };
    void __ctx[]  __align(CRYPTO_MINALIGN);
};

And then hopefully, we can get rid of the padding once we fix drivers
doing non-cache coherent inbound DMA into those structures.
