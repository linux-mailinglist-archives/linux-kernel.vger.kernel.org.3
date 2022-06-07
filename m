Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68D53F3CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiFGCGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiFGCFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:05:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D4BC6D6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:05:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHDG95Jvpz4xZ7;
        Tue,  7 Jun 2022 12:05:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1654567524;
        bh=8PBLOfNNVcxe/BchOfdldd1aRlQCoiHtBdRm4jougLQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=W1DZDLCw0u7bl+3KdOLO3E4JCzPchbpIy2zcqZPBay4042yh5i4ln0MRuWhSVJOz2
         2NQIfrMEG6mCS3D7pkm1LGyYEetCH5E+BXMC2ZinYQisMrh760p1W9D2oby2EJ4svT
         rU2MA1wyPZgnSUgVia4gzfTVQ1Mvz7nSTVPJXwPWMq1llrJ1XXP05ANpImpq6wQ5yQ
         Lh0JyAAMcC8WaWw4phBmpH4xvWZ25nLntkYEKfN1zsar9homM2jZ6wFG5h8jX9rxwO
         PSniNMuQSbyQE4kTCn0rSFx3K9c5w9+f0tbWdUkjL2eAZpj+Xlu9yn1f8j9FkuFoGR
         5Kr/n2q7FTVtA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: outside array bounds error on ppc64_defconfig, GCC 12.1.0
In-Reply-To: <YpbUcPrm61RLIiZF@debian.me>
References: <YpbUcPrm61RLIiZF@debian.me>
Date:   Tue, 07 Jun 2022 12:05:18 +1000
Message-ID: <87mtepns81.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:
> Hi,
>
> I'm trying to verify Drop ppc_inst_as_str() patch on [1] by performing
> ppc64_defconfig build with powerpc64-unknown-linux-gnu-gcc (GCC 12.1.0).
> The patch is applied on top of powerpc tree, next branch.

Yeah I see it too.

> I got outside array bounds error:
>
>   CC      arch/powerpc/kernel/dbell.o
> In function 'do_byte_reverse',
>     inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
>     inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
> arch/powerpc/lib/sstep.c:286:25: error: array subscript [3, 4] is outside array bounds of 'union <anonymous>[1]' [-Werror=array-bounds]
>   286 |                 up[0] = byterev_8(up[3]);
>       |                         ^~~~~~~~~~~~~~~~
>
> arch/owerpc/lib/sstep.c: In function 'emulate_loadstore':
> arch/powerpc/lib/sstep.c:708:11: note: at offset [24, 39] into object 'u' of size 16
>   708 |         } u;
>       |           ^
> In function 'do_byte_reverse',
>     inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
>     inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
> arch/powerpc/lib/sstep.c:287:23: error: array subscript [3, 4] is outside array bounds of 'union <anonymous>[1]' [-Werror=array-bounds]
>   287 |                 up[3] = tmp;
>       |                 ~~~~~~^~~~~

This happens because we have a generic byte reverse function
(do_byte_reverse()), that takes a size as a parameter. So it will
reverse 8, 16, 32 bytes etc.

In some cases the compiler can see that we're passing a pointer to
storage that is smaller than 32 bytes, but it isn't convinced that the
size parameter is also smaller than 32 bytes.

Which I think is reasonable, the code that sets the size is separate
from this code, so the compiler can't really deduce that it's safe.

I don't see a really simple fix. I tried clamping the size parameter to
do_byte_reverse() with max(), but that didn't work :/

cheers
