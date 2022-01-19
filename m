Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69D9493934
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353994AbiASLGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:06:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55807 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346901AbiASLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:06:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jf2rd34Tcz4y3t;
        Wed, 19 Jan 2022 22:06:25 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <247e01e0e10f4dbc59b5ff89e81702eb1ee7641e.1641828571.git.christophe.leroy@csgroup.eu>
References: <247e01e0e10f4dbc59b5ff89e81702eb1ee7641e.1641828571.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/time: Fix build failure due to do_hard_irq_enable() on PPC32
Message-Id: <164259036177.3588160.5245172703887799778.b4-ty@ellerman.id.au>
Date:   Wed, 19 Jan 2022 22:06:01 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 15:29:53 +0000, Christophe Leroy wrote:
> 	  CC      arch/powerpc/kernel/time.o
> 	In file included from <command-line>:
> 	./arch/powerpc/include/asm/hw_irq.h: In function 'do_hard_irq_enable':
> 	././include/linux/compiler_types.h:335:45: error: call to '__compiletime_assert_35' declared with attribute error: BUILD_BUG failed
> 	  335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	      |                                             ^
> 	././include/linux/compiler_types.h:316:25: note: in definition of macro '__compiletime_assert'
> 	  316 |                         prefix ## suffix();                             \
> 	      |                         ^~~~~~
> 	././include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
> 	  335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	      |         ^~~~~~~~~~~~~~~~~~~
> 	./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
> 	   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> 	      |                                     ^~~~~~~~~~~~~~~~~~
> 	./include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
> 	   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> 	      |                     ^~~~~~~~~~~~~~~~
> 	./arch/powerpc/include/asm/hw_irq.h:483:9: note: in expansion of macro 'BUILD_BUG'
> 	  483 |         BUILD_BUG();
> 	      |         ^~~~~~~~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/time: Fix build failure due to do_hard_irq_enable() on PPC32
      https://git.kernel.org/powerpc/c/87b9d74fb0be80054c729e8d6a119ca0955cedf3

cheers
