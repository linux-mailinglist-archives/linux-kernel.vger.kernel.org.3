Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56B65324D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiEXIEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiEXIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9289549C;
        Tue, 24 May 2022 01:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A0C615BB;
        Tue, 24 May 2022 08:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C674C34100;
        Tue, 24 May 2022 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653379480;
        bh=xY+BlQ/hkKZ+ByV7JuikIcr/QSDcYMpzUNbuRSjiL1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BRM14XhgWiKGMQWkvNoIT3iXdRuPDYPdTBl0K4v8pgPGNd4+7u8XObHKtfxHZ/QEI
         a+PXq61xsP47BqW/hR5vabzmet7rhMcoHAjoQ+oi824i++eCypwYJ0X8K2kJG3N74q
         Ug4cfbParqdNfYu57g3ChODAQiGHBRv0gXncDA/jWyfp/8q+3gX/K9yfw3lCJzyQ0M
         /VDLVQBphxwaMzwaoQwiZVfRrV6LiScAbR6YwGAp0OumlPdCqzwhShbOX8Px4KBWiS
         kBN863nMAioh0RhvYKW6zU76LY6tVtQ1AuO5ZVLEbHbvqzx9ka8ZX+LZdQ51xG0LP0
         1Z2HbxemW015Q==
Received: by mail-oi1-f182.google.com with SMTP id v9so15908431oie.5;
        Tue, 24 May 2022 01:04:40 -0700 (PDT)
X-Gm-Message-State: AOAM530AL/wo9MHLxXLI54I1j5K7jIh31lxPp2N9n4S2YCFET64wadNW
        IRp63+miWCh0RYqtgbr5POmVQUc5bBZtZAyxd6k=
X-Google-Smtp-Source: ABdhPJxWRVFHd81Y8Qy0y5ez2SEZN9ClH++9AXmB9OIM4dFNgLnIcklEciZfmLZvIOmsfWeCMwugqGYysgnRKS9zAQc=
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id
 k13-20020a0568080e8d00b00322bac02943mr1610679oil.126.1653379479738; Tue, 24
 May 2022 01:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220516101635.1082132-1-yoan.picchi@arm.com> <20220516101635.1082132-3-yoan.picchi@arm.com>
 <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com> <20220518165512.3e07c4b3@donnerap.cambridge.arm.com>
In-Reply-To: <20220518165512.3e07c4b3@donnerap.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 May 2022 10:04:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEF6KV=3CXhaRKygBs9hvun7=bKRua5NbWOrksaZBgtCQ@mail.gmail.com>
Message-ID: <CAMj1kXEF6KV=3CXhaRKygBs9hvun7=bKRua5NbWOrksaZBgtCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     yoan.picchi@arm.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        qat-linux <qat-linux@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 17:55, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Tue, 17 May 2022 10:11:09 +0200
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hi,
>
> > On Mon, 16 May 2022 at 12:16, <yoan.picchi@arm.com> wrote:
> > >
> > > From: Yoan Picchi <yoan.picchi@arm.com>
> > >
> > > This dependency looks outdated. After the previous patch, we have been able
> > > to use this driver to encrypt some data and to create working VF on arm64.
> > >
> > > Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
> >
> > Are you sure the driver is safe for non-coherent DMA as well?
>
> That depends on your definition of "sure".
> We indeed tested this only on a server with coherent PCIe.
>
> I skimmed through the driver, and it looks like to use the DMA API
> correctly:
> - I see dma_alloc_coherent() calls for DMA ring buffers.
> - There are dma_map_single()/dma_unmap_single() pairs in other parts.
> - Accesses to the BARs are capsuled via macros, using readl/writel.
> - Access the the SRAM BAR is also only done via those macros.
>
> I didn't go through the driver systematically, and of course the
> interesting parts are the ones you don't see easily, so I am eager to hear
> any other opinions on this topic.
>
> Ard, do you have anything special in mind? Is there something to look out
> for, specifically?
>

If it uses the DMA api consistently and correctly, and works as
expected when running under a SMMU, things are probably fine

> The few cards we have access to are in some server in the data centre, so
> I can't easily walk in with, say a RockPro64, and test this there.
>

I suppose this implies that you have tested with SMMUs enabled.

> >
> > > ---
> > >  drivers/crypto/qat/Kconfig | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/crypto/qat/Kconfig b/drivers/crypto/qat/Kconfig
> > > index 4b90c0f22b03..88df2cf4cac9 100644
> > > --- a/drivers/crypto/qat/Kconfig
> > > +++ b/drivers/crypto/qat/Kconfig
> > > @@ -17,7 +17,7 @@ config CRYPTO_DEV_QAT
> > >
> > >  config CRYPTO_DEV_QAT_DH895xCC
> > >         tristate "Support for Intel(R) DH895xCC"
> > > -       depends on X86 && PCI
> > > +       depends on PCI
> > >         select CRYPTO_DEV_QAT
> > >         help
> > >           Support for Intel(R) DH895xcc with Intel(R) QuickAssist Technology
> > > @@ -28,7 +28,7 @@ config CRYPTO_DEV_QAT_DH895xCC
> > >
> > >  config CRYPTO_DEV_QAT_C3XXX
> > >         tristate "Support for Intel(R) C3XXX"
> > > -       depends on X86 && PCI
> > > +       depends on PCI
> > >         select CRYPTO_DEV_QAT
> > >         help
> > >           Support for Intel(R) C3xxx with Intel(R) QuickAssist Technology
> > > @@ -39,7 +39,7 @@ config CRYPTO_DEV_QAT_C3XXX
> > >
> > >  config CRYPTO_DEV_QAT_C62X
> > >         tristate "Support for Intel(R) C62X"
> > > -       depends on X86 && PCI
> > > +       depends on PCI
> > >         select CRYPTO_DEV_QAT
> > >         help
> > >           Support for Intel(R) C62x with Intel(R) QuickAssist Technology
> > > @@ -50,7 +50,7 @@ config CRYPTO_DEV_QAT_C62X
> > >
> > >  config CRYPTO_DEV_QAT_4XXX
> > >         tristate "Support for Intel(R) QAT_4XXX"
> > > -       depends on X86 && PCI
> > > +       depends on PCI
> > >         select CRYPTO_DEV_QAT
> > >         help
> > >           Support for Intel(R) QuickAssist Technology QAT_4xxx
> > > @@ -61,7 +61,7 @@ config CRYPTO_DEV_QAT_4XXX
> > >
> > >  config CRYPTO_DEV_QAT_DH895xCCVF
> > >         tristate "Support for Intel(R) DH895xCC Virtual Function"
> > > -       depends on X86 && PCI
> > > +       depends on PCI
> > >         select PCI_IOV
> > >         select CRYPTO_DEV_QAT
> > >
> > > @@ -74,7 +74,7 @@ config CRYPTO_DEV_QAT_DH895xCCVF
> > >
> > >  config CRYPTO_DEV_QAT_C3XXXVF
> > >         tristate "Support for Intel(R) C3XXX Virtual Function"
> > > -       depends on X86 && PCI
> > > +       depends on PCI
> > >         select PCI_IOV
> > >         select CRYPTO_DEV_QAT
> > >         help
> > > @@ -86,7 +86,7 @@ config CRYPTO_DEV_QAT_C3XXXVF
> > >
> > >  config CRYPTO_DEV_QAT_C62XVF
> > >         tristate "Support for Intel(R) C62X Virtual Function"
> > > -       depends on X86 && PCI
> > > +       depends on PCI
> > >         select PCI_IOV
> > >         select CRYPTO_DEV_QAT
> > >         help
> > > --
> > > 2.25.1
> > >
>
