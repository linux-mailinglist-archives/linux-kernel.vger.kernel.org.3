Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA915A39A6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiH0TA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiH0TAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 15:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619B3F1DB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 12:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2959760EA0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 19:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF61C433D6;
        Sat, 27 Aug 2022 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661626816;
        bh=Fmh+O+8QhYgIVKJ91rXL8QN/MXsUrLnQAud1ATC34Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A63if4pOIrFe97/qAap2BlGwHW5Vr8Cm00gLVG8qx6Vx3GDCrNBhQc2jv5uPcHR6g
         LLaJBZ7ixffeUjV/NPb/UYizdCDA3QMbRrV5Vl+oKjdN8s0XZM+5SOeXrCeMuQxVuI
         SfiKA7QZXCAmpa5ty0vVhk6QP1P2vyR4mI+hpSpqcXhB6qFIOKSGg4YmH8xHMtig/Q
         fjxG5T2gR14j+RA/dCIp0XsuEr9yFl0oEKpqBg343/hmBMuO4oaO2iKyaF3WNLqZGs
         JKdsRxufN+C+EFNwTrX9F5C1WfQ3M3lWvVzSuz9Lx3nkg+b5EyGzR2aVo3r1q9G1Ko
         pVu5dsr65mEsw==
Received: by pali.im (Postfix)
        id 7F75FC7A; Sat, 27 Aug 2022 21:00:13 +0200 (CEST)
Date:   Sat, 27 Aug 2022 21:00:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc/boot: Don't always pass -mcpu=powerpc when
 building 32-bit uImage
Message-ID: <20220827190013.c3odakqxqnqgkzxm@pali>
References: <20220820105200.30425-1-pali@kernel.org>
 <20220827133900.16634-1-pali@kernel.org>
 <63f4bce4-7965-9bc6-2104-42e26acd0208@csgroup.eu>
 <20220827173610.7bdp7zychwu2u5i6@pali>
 <1da78077-a050-a391-a002-9e25eabc89d1@csgroup.eu>
 <20220827183608.ezljs2houkd32764@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220827183608.ezljs2houkd32764@pali>
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

On Saturday 27 August 2022 20:36:08 Pali Rohár wrote:
> On Saturday 27 August 2022 18:32:42 Christophe Leroy wrote:
> > Le 27/08/2022 à 19:36, Pali Rohár a écrit :
> > > On Saturday 27 August 2022 17:31:10 Christophe Leroy wrote:
> > >> Le 27/08/2022 à 15:39, Pali Rohár a écrit :
> > >>> For 32-bit uImage try to use CONFIG_TARGET_CPU option for -mcpu. This fixes
> > >>> following compiler error when building kernel with powerpc e500 SPE capable
> > >>> cross compilers:
> > >>>
> > >>>       BOOTAS  arch/powerpc/boot/crt0.o
> > >>>     powerpc-linux-gnuspe-gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
> > >>>     powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
> > >>>     make[1]: *** [arch/powerpc/boot/Makefile:231: arch/powerpc/boot/crt0.o] Error 1
> > >>>
> > >>> For 64-bit uImage and 64-bit kernels with 32-bit uImage wrapper there is no
> > >>> change.
> > >>>
> > >>> Similar change was already introduced for the main powerpc Makefile in
> > >>> commit 446cda1b21d9 ("powerpc/32: Don't always pass -mcpu=powerpc to the
> > >>> compiler").
> > >>>
> > >>> Fixes: 40a75584e526 ("powerpc/boot: Build wrapper for an appropriate CPU")
> > >>> Cc: stable@vger.kernel.org
> > >>> Signed-off-by: Pali Rohár <pali@kernel.org>
> > >>> ---
> > >>>    arch/powerpc/boot/Makefile | 8 ++++++++
> > >>>    1 file changed, 8 insertions(+)
> > >>>
> > >>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > >>> index a9cd2ea4a861..f56a5f90a5d8 100644
> > >>> --- a/arch/powerpc/boot/Makefile
> > >>> +++ b/arch/powerpc/boot/Makefile
> > >>> @@ -44,8 +44,16 @@ else
> > >>>    BOOTCFLAGS	+= -m64 -mcpu=powerpc64
> > >>>    endif
> > >>>    else
> > >>> +ifdef CONFIG_PPC32
> > >>> +ifdef CONFIG_TARGET_CPU_BOOL
> > >>> +BOOTCFLAGS	+= -m32 -mcpu=$(CONFIG_TARGET_CPU)
> > >>> +else
> > >>> +BOOTCFLAGS	+= -m32 -mcpu=powerpc
> > >>
> > >> You can't do that. You get here only if user has selected
> > >> TOOLCHAIN_DEFAULT_CPU, in which case you don't want to for -mcpu=powerpc.
> > > 
> > > So do I understand it correctly that in this branch I should omit -mcpu=powerpc?
> > 
> > Correct.
> 
> Ok, I will fix it in v3.
> 
> > > 
> > >> -mcpu=powerpc is set when user selects CONFIG_POWERPC_CPU, in which case
> > >> CONFIG_TARGET_CPU_BOOL is set as well.
> > >>
> > >>> +endif
> > >>> +else
> > >>>    BOOTCFLAGS	+= -m32 -mcpu=powerpc
> > >>
> > >> Same, for PPC64 I think you don't want that either, unless the
> > >> CONFIG_GENERIC_CPU has been selected in which case
> > >> CONFIG_TARGET_CPU_BOOL is not set.
> > >>
> > >> When CONFIG_TARGET_CPU_BOOL is set for PPC64 you also want
> > >> -mcpu=$(CONFIG_TARGET_CPU)
> > > 
> > > I understand that this branch is called for PPC64 build with 32-bit
> > > uImage wrapper. So in this case should not be used TARGET_CPU as it
> > > would be 64-bit and not 32-bit as requited for 32-bit uImage wrapper.
> > 
> > Why ?
> > 
> > -mcpu=e6500 -m32 works as far as I can see.
> 
> Hm... I did not know that. Ok, if you want I will put it into
> -m32 -mcpu=$(CONFIG_TARGET_CPU) branch too.

And when CONFIG_TARGET_CPU_BOOL is not set but CONFIG_PPC64_BOOT_WRAPPER
is, should be -mcpu=powerpc64le or -mcpu=powerpc64 still passed?

> > > 
> > > Anyway, in this change I'm touching only PPC32 build, so all PPC64 stay
> > > as it was before.
> > > 
> > >>>    endif
> > >>> +endif
> > >>>    
> > >>>    BOOTCFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
> > >>>    
