Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019359AD4E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbiHTKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbiHTKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:55:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1B39AF94
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F6B4B8013A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 10:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB381C433D6;
        Sat, 20 Aug 2022 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660992913;
        bh=3N+NDI2cJKh99li5pLUDKXcxy68n6z1/LP/ToJrkZTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mN+Ksxc2YnQIljxsn1KYA946GXSecuBUHJZgu9vmtUcaRpOCEvidcVsRanc/EYlAZ
         zvSM4RhT6UxCWmLHN3BQE2dSwWHdV70BUZFY6uJ9F0g5l5VZ6+maBCkngsl5hVNyy+
         8KFe94cU9OjV/d57FF4HJ6X30Bn+phJPA861qYCidDPfhWpSdACNDvbwSmmNMkKyJl
         CcibQczNDY+20GaJlKgQUHd3xWgYHaLBZ1cEYiSriA4vRFjuiS00IwTq/Z7vPTPtFB
         HxidjPFAI1dgYmtaKjwAmf5fO/l5hDHTA6+UEFb3lIrVAloCNOI00S449zcXRoOAWV
         3LW0t29D6lvnQ==
Received: by pali.im (Postfix)
        id 3FEF75D0; Sat, 20 Aug 2022 12:55:10 +0200 (CEST)
Date:   Sat, 20 Aug 2022 12:55:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v1 2/5] powerpc/32: Don't always pass -mcpu=powerpc to
 the compiler
Message-ID: <20220820105510.psagglbbfyve53fc@pali>
References: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
 <d4df724691351531bf46d685d654689e5dfa0d74.1657549153.git.christophe.leroy@csgroup.eu>
 <20220818174634.6nkzcztzn6uqcrzg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818174634.6nkzcztzn6uqcrzg@pali>
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

On Thursday 18 August 2022 19:46:34 Pali Rohár wrote:
> On Monday 11 July 2022 16:19:30 Christophe Leroy wrote:
> > Since commit 4bf4f42a2feb ("powerpc/kbuild: Set default generic
> > machine type for 32-bit compile"), when building a 32 bits kernel
> > with a bi-arch version of GCC, or when building a book3s/32 kernel,
> > the option -mcpu=powerpc is passed to GCC at all time, relying on it
> > being eventually overriden by a subsequent -mcpu=xxxx.
> > 
> > But when building the same kernel with a 32 bits only version of GCC,
> > that is not done, relying on gcc being built with the expected default
> > CPU.
> > 
> > This logic has two problems. First, it is a bit fragile to rely on
> > whether the GCC version is bi-arch or not, because today we can have
> > bi-arch versions of GCC configured with a 32 bits default. Second,
> > there are some versions of GCC which don't support -mcpu=powerpc,
> > for instance for e500 SPE-only versions.
> > 
> > So, stop relying on this approximative logic and allow the user to
> > decide whether he/she wants to use the toolchain's default CPU or if
> > he/she wants to set one, and allow only possible CPUs based on the
> > selected target.
> 
> Hello! Exactly same issue is still in file arch/powerpc/boot/Makefile:
> 
>   ifdef CONFIG_PPC64_BOOT_WRAPPER
>   ifdef CONFIG_CPU_LITTLE_ENDIAN
>   BOOTCFLAGS	+= -m64 -mcpu=powerpc64le
>   else
>   BOOTCFLAGS	+= -m64 -mcpu=powerpc64
>   endif
>   else
>   BOOTCFLAGS	+= -m32 -mcpu=powerpc
>   endif
> 
> It cause compile error:
> 
>   make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnuspe- mpc85xx_smp_defconfig uImage
>   ...
>     BOOTAS  arch/powerpc/boot/crt0.o
>   powerpc-linux-gnuspe-gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
>   powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
>   make[1]: *** [arch/powerpc/boot/Makefile:231: arch/powerpc/boot/crt0.o] Error 1

Now I have sent patch for this issue:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220820105200.30425-1-pali@kernel.org/

> > Reported-by: Pali Rohár <pali@kernel.org>
> > Tested-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  arch/powerpc/Makefile                  | 26 +-------------------------
> >  arch/powerpc/platforms/Kconfig.cputype | 21 ++++++++++++++++++---
> >  2 files changed, 19 insertions(+), 28 deletions(-)
