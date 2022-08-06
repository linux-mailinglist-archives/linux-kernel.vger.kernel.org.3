Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572BE58B405
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiHFGL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiHFGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:11:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8063205D2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:11:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M0BtG1xhbz4x1L;
        Sat,  6 Aug 2022 16:11:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659766278;
        bh=o16cnLqkT45HVNmCHzKMkKaK5D6KOmyqnKHR/jo9WQg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F0k4JJsf6dlADVbLTDunhkjECm2UunQBp1O2eD0YKpnsJjq3QgWETDKTJLh0EfGq/
         pAwauCOcVCU2cHYLNdMaMTTG4n4MZ1BLIfFCTkkY4xDyZ+eBAgwTu9IqazkgugLkZW
         CcB2YTIDVmUwys5cJQG7/lu5JLaxVhQx+aSL8Jm+a6jhNfV4/Pdb8H5qyBNMmJdqPR
         hmYax/Soa3t4Ljsd43aHpdWN0Tr34BDt5d0n51G3kEgVwrUlp3hIReR49PD5D5l7sD
         /6iAF3qX/lHB5F+RAdRzv0VaTNv+xCtarkboPGc92ZXQ+x5GNmENuNjKXDVCy6dDJ3
         DCO19qRHihlDg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
In-Reply-To: <20220805022940.1637978-1-yury.norov@gmail.com>
References: <20220805022940.1637978-1-yury.norov@gmail.com>
Date:   Sat, 06 Aug 2022 16:11:17 +1000
Message-ID: <87edxtaol6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request has a conflict with the random tree in some powerpc
code.

The random tree removed CONFIG_ARCH_RANDOM and changed the arguments and
names of the arch_get_random_xxx() calls, meanwhile the commit in the
bitmap tree moved our arch_get_random_seed_long() into a C file.

Yury Norov <yury.norov@gmail.com> writes:
> The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:
>
>   Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/norov/linux.git/ tags/bitmap-6.0-rc1
>
> for you to fetch changes up to 36d4b36b69590fed99356a4426c940a253a93800:
>
>   lib/nodemask: inline next_node_in() and node_random() (2022-08-01 08:13:21 -0700)
...
>  arch/powerpc/include/asm/archrandom.h              |   9 +-
>  arch/powerpc/kernel/setup-common.c                 |  12 +

There is a textual conflict in archrandom.h. But there's also a fixup
needed in setup-common.c.

Mark spotted it in linux-next but the resolution is not quite right, I
describe the correct result here:

  https://lore.kernel.org/all/87h72q9bgg.fsf@mpe.ellerman.id.au/T/#m068009a89d2412dd4ca14ac598a7d6b8288d4568

Or the end state is attached below.

cheers


==== arch/powerpc/kernel/setup-common.c ====
...

size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
{
	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
		return 1;

	return 0;
}
EXPORT_SYMBOL(arch_get_random_seed_longs);

...

==== arch/powerpc/include/asm/archrandom.h ====
/* SPDX-License-Identifier: GPL-2.0 */
#ifndef _ASM_POWERPC_ARCHRANDOM_H
#define _ASM_POWERPC_ARCHRANDOM_H

static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
{
	return 0;
}

size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs);

#ifdef CONFIG_PPC_POWERNV
int pnv_get_random_long(unsigned long *v);
#endif

#endif /* _ASM_POWERPC_ARCHRANDOM_H */
