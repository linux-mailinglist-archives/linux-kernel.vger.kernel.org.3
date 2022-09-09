Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD3F5B2E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIIFvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIIFvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:51:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CE8A1DD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:51:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MP4q84DQpz4xG8;
        Fri,  9 Sep 2022 15:51:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662702660;
        bh=vKyV6C6r1Vi5eKElWQb5QtdxDDd96qiCzWYAs2H4YUY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mJKWHof4CSqXZLOVipIvr6x6eGaaAEKie5acaBsV85c5/8Ifp6xJ/hAnT7gGUaulU
         QbxfpvYZ5YX9bdpKPUloKHGRjc7OYlOj6stC4FuRSdNsuwPn5wb3AVWs7KiMKyQvEi
         ffsFJAXDlQ/GvEOpdfDGlxP8E5Hf61AVI6Iz3ujFNETqS1x/AVhcgsgyDUKis910Dq
         SjVeJMBQUChE5YTBpv4j8QzNelOiExq9yYbxwXF0Y16qqGgVSBNBsrwkust69f4F5/
         HvY/yfdAnRC+9Tw9BqrdwFhbEGZj69ems6yaAkgWsCmw1JeGGFTEFvrpJcK5UOwdHd
         yote03Gma68dQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 02/19] powerpc/64e: Tie PPC_BOOK3E_64 to PPC_E500MC
In-Reply-To: <f2d30eb7fadcfd89f7ac3784cb0b4a4b47d47db1.1662658653.git.christophe.leroy@csgroup.eu>
References: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
 <f2d30eb7fadcfd89f7ac3784cb0b4a4b47d47db1.1662658653.git.christophe.leroy@csgroup.eu>
Date:   Fri, 09 Sep 2022 15:50:53 +1000
Message-ID: <87r10ldrk2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thanks for trying to clean up this tangled mess.

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> The only 64-bit Book3E CPUs we support is the e500mc.

AFAIK the e500mc is 32-bit?

We support e5500 and e6500 which are 64-bit Book3E.

They're derivatives of the e500mc AIUI.

So CONFIG_PPC_E500MC actually means e500mc *and later derivatives*.

You can see that with eg:

config SPE_POSSIBLE
	def_bool y
	depends on E500 && !PPC_E500MC

Because e500mc dropped SPE, and so therefore e5500 and e6500 don't have
it either.

And eg:

#ifdef CONFIG_PPC_E500MC
_GLOBAL(__setup_cpu_e6500)
	mflr	r6


> However our Kconfig allows configurating a kernel that has 64-bit
> Book3E support, but no e500mc support enabled. Such a kernel
> would never boot, it doesn't know about any CPUs.

That is true.

> To fix this, force e500mc to be selected whenever we are
> building a 64-bit Book3E kernel.

I think that's a reasonable fix, just it's important to differentiate
between CONFIG_PPC_E500MC (the symbol) and e500mc (the CPU).

> And add a test to detect futur situations where cpu_specs is empty.
                           future
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/cputable.c         | 2 ++
>  arch/powerpc/platforms/Kconfig.cputype | 2 ++
>  2 files changed, 4 insertions(+)
>
..
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 5185d942b455..19fd95a06352 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -108,6 +108,8 @@ config PPC_BOOK3S_64
>  config PPC_BOOK3E_64
>  	bool "Embedded processors"
>  	select PPC_FSL_BOOK3E
> +	select E500
> +	select PPC_E500MC
>  	select PPC_FPU # Make it a choice ?
>  	select PPC_SMP_MUXED_IPI
>  	select PPC_DOORBELL

I think that makes the select of PPC_E500MC below redundant:

config PPC_QEMU_E500
	bool "QEMU generic e500 platform"
	select DEFAULT_UIMAGE
	select E500
	select PPC_E500MC if PPC64


cheers
