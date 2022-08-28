Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0535A3EEE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiH1Rlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiH1Rlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:41:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17BDFE9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 279ABB80B84
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 17:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98891C433C1;
        Sun, 28 Aug 2022 17:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661708498;
        bh=oWbacq76FiLZIfuBUsffJq7HQY/+kQwKoxWKLOvIweY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXZAU+Wy9SFqAjZJxRg6k8LSAoVRE3YdgjF/vMFnCwkXO12n80gFY5mjZKWKPVCVA
         zRwslSfMZr8BsoDOEtOrdYNhyHqML7MIgo0SNRCBsjBCV9NUgWOdMhMyh0sU2j7gbA
         SXVAhkKvHDYSxuen3IgJA0CZXCcL+vTDD41q63f1wo0OLUTFJO0xSeXsY8P8DBDIEO
         r8oeaHv5y9E6p/SgQMD9p5lILG3Y3RrDZfi6JMstUAnSZVkkpaiatOvYKSe49N9Um1
         WyuIzrNjTGJ82sUCoVfMhfRNeAWczzY3wZVA7e/xl5oksAvX3TxsOkZX0t27Ckg6gf
         UgVHabu3abC8Q==
Received: by pali.im (Postfix)
        id BDF7C7B3; Sun, 28 Aug 2022 19:41:35 +0200 (CEST)
Date:   Sun, 28 Aug 2022 19:41:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc/boot: Don't always pass -mcpu=powerpc when
 building 32-bit uImage
Message-ID: <20220828174135.rcql4uiunqbnn5gh@pali>
References: <20220820105200.30425-1-pali@kernel.org>
 <20220828095659.4061-1-pali@kernel.org>
 <e3cb2642-20e4-6c26-104d-329a04260946@csgroup.eu>
 <c8d657db-02da-7840-5b40-755e47277a2c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8d657db-02da-7840-5b40-755e47277a2c@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 August 2022 17:39:25 Christophe Leroy wrote:
> Le 28/08/2022 à 19:33, Christophe Leroy a écrit :
> > 
> > 
> > Le 28/08/2022 à 11:56, Pali Rohár a écrit :
> >> When CONFIG_TARGET_CPU is specified then pass its value to the compiler
> >> -mcpu option. This fixes following build error when building kernel with
> >> powerpc e500 SPE capable cross compilers:
> >>
> >>      BOOTAS  arch/powerpc/boot/crt0.o
> >>    powerpc-linux-gnuspe-gcc: error: unrecognized argument in option 
> >> ‘-mcpu=powerpc’
> >>    powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are: 
> >> 8540 8548 native
> >>    make[1]: *** [arch/powerpc/boot/Makefile:231: 
> >> arch/powerpc/boot/crt0.o] Error 1
> > 
> > corenet64_smp_defconfig :
> > 
> >    BOOTAS  arch/powerpc/boot/crt0.o
> > powerpc64-linux-gcc: error: missing argument to '-mcpu='
> > make[1]: *** [arch/powerpc/boot/Makefile:237 : arch/powerpc/boot/crt0.o] 
> > Erreur 1
> > make: *** [arch/powerpc/Makefile:253 : uImage] Erreur 2
> > 
> > 
> 
> Seems like in fact, E5500_CPU and E6500_CPU are not taken into account 
> in CONFIG_TARGET_CPU, and get special treatment directly in 
> arch/powerpc/Makefile.
> 
> This goes unnoticed because of CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += 
> $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> 
> I think we need to fix that prior to your patch.

It looks like that CONFIG_TARGET_CPU is broken.

  $ make ARCH=powerpc corenet64_smp_defconfig CROSS_COMPILE=powerpc64-linux-gnu-
  ...
  # configuration written to .config

  $ grep CONFIG_TARGET_CPU .config
  CONFIG_TARGET_CPU_BOOL=y

CONFIG_TARGET_CPU_BOOL is set but CONFIG_TARGET_CPU not!

> > Christophe
> > 
> > 
> >>
> >> Similar change was already introduced for the main powerpc Makefile in
> >> commit 446cda1b21d9 ("powerpc/32: Don't always pass -mcpu=powerpc to the
> >> compiler").
> >>
> >> Fixes: 40a75584e526 ("powerpc/boot: Build wrapper for an appropriate 
> >> CPU")
> >> Cc: stable@vger.kernel.org # 446cda1b21d9 ("powerpc/32: Don't always 
> >> pass -mcpu=powerpc to the compiler")
> >> Signed-off-by: Pali Rohár <pali@kernel.org>
> >> ---
> >>   arch/powerpc/boot/Makefile | 14 ++++++++++----
> >>   1 file changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> >> index a9cd2ea4a861..1957a3de7a1c 100644
> >> --- a/arch/powerpc/boot/Makefile
> >> +++ b/arch/powerpc/boot/Makefile
> >> @@ -38,13 +38,19 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes 
> >> -Wno-trigraphs \
> >>            $(LINUXINCLUDE)
> >>   ifdef CONFIG_PPC64_BOOT_WRAPPER
> >> -ifdef CONFIG_CPU_LITTLE_ENDIAN
> >> -BOOTCFLAGS    += -m64 -mcpu=powerpc64le
> >> +BOOTCFLAGS    += -m64
> >>   else
> >> -BOOTCFLAGS    += -m64 -mcpu=powerpc64
> >> +BOOTCFLAGS    += -m32
> >>   endif
> >> +
> >> +ifdef CONFIG_TARGET_CPU_BOOL
> >> +BOOTCFLAGS    += -mcpu=$(CONFIG_TARGET_CPU)
> >> +else ifdef CONFIG_PPC64_BOOT_WRAPPER
> >> +ifdef CONFIG_CPU_LITTLE_ENDIAN
> >> +BOOTCFLAGS    += -mcpu=powerpc64le
> >>   else
> >> -BOOTCFLAGS    += -m32 -mcpu=powerpc
> >> +BOOTCFLAGS    += -mcpu=powerpc64
> >> +endif
> >>   endif
> >>   BOOTCFLAGS    += -isystem $(shell $(BOOTCC) -print-file-name=include)
