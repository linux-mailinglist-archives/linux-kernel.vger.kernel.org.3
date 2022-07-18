Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3F5782CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiGRMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiGRMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:53:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3012C2;
        Mon, 18 Jul 2022 05:53:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmhjM6Tyvz4xL4;
        Mon, 18 Jul 2022 22:53:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658148826;
        bh=SgPxyBJcHGr81rN/PCtKiWXwYtSKRO2w9sb5M0yS/pU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rYUSYTCmldp3zN6k/ysHQC4QOd4JlL88muNz4v08jJK1s2WGTd3Mzi3YvFcU0K1vn
         W9DjCRjYAUlAqCOsgnj9C2L03vYDPzdtzucwIqSf9LlRFHwnOxDjFTzYnRJ7sF7Qh7
         s7WWq+PLlyqwqYFgoflfRl2VvnXJyrMtwl/lsuIfyzK3l1gMB3Crb5m0jy6Mxv5+Dh
         aGLrf18lWzXpBPZggcYl8BALR0j3fUTopMtowWx4R5DdSKPEOSU5EIjA0QWTpE5Yrx
         TOB8RIY3sLW94KzeZkoH+eaXTCtIMN8zUbNlcSlD+ryvYxI0pWTlI+XB/pQMZmjzg0
         n4k9AuAcZSRYQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v5] random: remove CONFIG_ARCH_RANDOM
In-Reply-To: <20220708004032.733426-1-Jason@zx2c4.com>
References: <20220706143521.459565-1-Jason@zx2c4.com>
 <20220708004032.733426-1-Jason@zx2c4.com>
Date:   Mon, 18 Jul 2022 22:53:38 +1000
Message-ID: <877d4aeg4t.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> When RDRAND was introduced, there was much discussion on whether it
> should be trusted and how the kernel should handle that. Initially, two
> mechanisms cropped up, CONFIG_ARCH_RANDOM, a compile time switch, and
> "nordrand", a boot-time switch.
...
>
>  arch/arm/include/asm/archrandom.h             |  2 ++
>  arch/arm64/Kconfig                            |  8 ------
>  arch/arm64/include/asm/archrandom.h           | 10 --------
>  arch/arm64/kernel/cpufeature.c                |  2 --
>  arch/powerpc/Kconfig                          |  3 ---
>  arch/powerpc/include/asm/archrandom.h         |  3 ---
>  arch/powerpc/include/asm/machdep.h            |  2 --
>  arch/powerpc/platforms/microwatt/Kconfig      |  1 -
>  arch/powerpc/platforms/powernv/Kconfig        |  1 -
>  arch/powerpc/platforms/pseries/Kconfig        |  1 -

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
