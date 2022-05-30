Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF4537892
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiE3J6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiE3J6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:58:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C669171D8D;
        Mon, 30 May 2022 02:58:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F34F113E;
        Mon, 30 May 2022 02:58:12 -0700 (PDT)
Received: from [10.57.82.204] (unknown [10.57.82.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FBD43F73D;
        Mon, 30 May 2022 02:58:10 -0700 (PDT)
Message-ID: <49eb2888-712e-7c81-313b-aec58e906778@foss.arm.com>
Date:   Mon, 30 May 2022 10:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To:     ardb@kernel.org
Cc:     andre.przywara@arm.com, davem@davemloft.net,
        giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, yoan.picchi@arm.com
References: <CAMj1kXEF6KV=3CXhaRKygBs9hvun7=bKRua5NbWOrksaZBgtCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
Reply-To: yoan.picchi@arm.com
Content-Language: en-CA
From:   Yoan Picchi <yoan.picchi@foss.arm.com>
In-Reply-To: <CAMj1kXEF6KV=3CXhaRKygBs9hvun7=bKRua5NbWOrksaZBgtCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > On Wed, 18 May 2022 at 17:55, Andre Przywara <andre.przywara@arm.com> 
wrote:
 > >
 > > On Tue, 17 May 2022 10:11:09 +0200
 > > Ard Biesheuvel <ardb@kernel.org> wrote:
 > >
 > > Hi,
 > >
 > > > On Mon, 16 May 2022 at 12:16, <yoan.picchi@arm.com> wrote:
 > > > >
 > > > > From: Yoan Picchi <yoan.picchi@arm.com>
 > > > >
 > > > > This dependency looks outdated. After the previous patch, we 
have been able
 > > > > to use this driver to encrypt some data and to create working 
VF on arm64.
 > > > >
 > > > > Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
 > > >
 > > > Are you sure the driver is safe for non-coherent DMA as well?
 > >
 > > That depends on your definition of "sure".
 > > We indeed tested this only on a server with coherent PCIe.
 > >
 > > I skimmed through the driver, and it looks like to use the DMA API
 > > correctly:
 > > - I see dma_alloc_coherent() calls for DMA ring buffers.
 > > - There are dma_map_single()/dma_unmap_single() pairs in other parts.
 > > - Accesses to the BARs are capsuled via macros, using readl/writel.
 > > - Access the the SRAM BAR is also only done via those macros.
 > >
 > > I didn't go through the driver systematically, and of course the
 > > interesting parts are the ones you don't see easily, so I am eager 
to hear
 > > any other opinions on this topic.
 > >
 > > Ard, do you have anything special in mind? Is there something to 
look out
 > > for, specifically?
 > >
 >
 > If it uses the DMA api consistently and correctly, and works as
 > expected when running under a SMMU, things are probably fine
 >
 > > The few cards we have access to are in some server in the data 
centre, so
 > > I can't easily walk in with, say a RockPro64, and test this there.
 > >
 >
 > I suppose this implies that you have tested with SMMUs enabled.

Sorry for the delay, I was away for a few days.
Actually, our previous attempts were with the iommu set to passthrough, 
but I
just tested without the passthrough and it works the same way.
 >
 > > >
 > > > > ---
 > > > >  drivers/crypto/qat/Kconfig | 14 +++++++-------
 > > > >  1 file changed, 7 insertions(+), 7 deletions(-)
 > > > >
 > > > > diff --git a/drivers/crypto/qat/Kconfig 
b/drivers/crypto/qat/Kconfig
 > > > > index 4b90c0f22b03..88df2cf4cac9 100644
 > > > > --- a/drivers/crypto/qat/Kconfig
 > > > > +++ b/drivers/crypto/qat/Kconfig
 > > > > @@ -17,7 +17,7 @@ config CRYPTO_DEV_QAT
 > > > >
 > > > >  config CRYPTO_DEV_QAT_DH895xCC
 > > > >         tristate "Support for Intel(R) DH895xCC"
 > > > > -       depends on X86 && PCI
 > > > > +       depends on PCI
 > > > >         select CRYPTO_DEV_QAT
 > > > >         help
 > > > >           Support for Intel(R) DH895xcc with Intel(R) 
QuickAssist Technology
 > > > > @@ -28,7 +28,7 @@ config CRYPTO_DEV_QAT_DH895xCC
 > > > >
 > > > >  config CRYPTO_DEV_QAT_C3XXX
 > > > >         tristate "Support for Intel(R) C3XXX"
 > > > > -       depends on X86 && PCI
 > > > > +       depends on PCI
 > > > >         select CRYPTO_DEV_QAT
 > > > >         help
 > > > >           Support for Intel(R) C3xxx with Intel(R) QuickAssist 
Technology
 > > > > @@ -39,7 +39,7 @@ config CRYPTO_DEV_QAT_C3XXX
 > > > >
 > > > >  config CRYPTO_DEV_QAT_C62X
 > > > >         tristate "Support for Intel(R) C62X"
 > > > > -       depends on X86 && PCI
 > > > > +       depends on PCI
 > > > >         select CRYPTO_DEV_QAT
 > > > >         help
 > > > >           Support for Intel(R) C62x with Intel(R) QuickAssist 
Technology
 > > > > @@ -50,7 +50,7 @@ config CRYPTO_DEV_QAT_C62X
 > > > >
 > > > >  config CRYPTO_DEV_QAT_4XXX
 > > > >         tristate "Support for Intel(R) QAT_4XXX"
 > > > > -       depends on X86 && PCI
 > > > > +       depends on PCI
 > > > >         select CRYPTO_DEV_QAT
 > > > >         help
 > > > >           Support for Intel(R) QuickAssist Technology QAT_4xxx
 > > > > @@ -61,7 +61,7 @@ config CRYPTO_DEV_QAT_4XXX
 > > > >
 > > > >  config CRYPTO_DEV_QAT_DH895xCCVF
 > > > >         tristate "Support for Intel(R) DH895xCC Virtual Function"
 > > > > -       depends on X86 && PCI
 > > > > +       depends on PCI
 > > > >         select PCI_IOV
 > > > >         select CRYPTO_DEV_QAT
 > > > >
 > > > > @@ -74,7 +74,7 @@ config CRYPTO_DEV_QAT_DH895xCCVF
 > > > >
 > > > >  config CRYPTO_DEV_QAT_C3XXXVF
 > > > >         tristate "Support for Intel(R) C3XXX Virtual Function"
 > > > > -       depends on X86 && PCI
 > > > > +       depends on PCI
 > > > >         select PCI_IOV
 > > > >         select CRYPTO_DEV_QAT
 > > > >         help
 > > > > @@ -86,7 +86,7 @@ config CRYPTO_DEV_QAT_C3XXXVF
 > > > >
 > > > >  config CRYPTO_DEV_QAT_C62XVF
 > > > >         tristate "Support for Intel(R) C62X Virtual Function"
 > > > > -       depends on X86 && PCI
 > > > > +       depends on PCI
 > > > >         select PCI_IOV
 > > > >         select CRYPTO_DEV_QAT
 > > > >         help
 > > > > --
 > > > > 2.25.1
 > > > >
 > >
