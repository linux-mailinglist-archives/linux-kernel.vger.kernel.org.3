Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4342C46E2B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhLIGoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhLIGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:44:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534BBC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:40:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J8ktg48xXz4xhB;
        Thu,  9 Dec 2021 17:40:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639032029;
        bh=suZjxbWzZfiwEHkXF7PVcnVEK2S44YPaAlsYAqlSBBA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GGuZ7UcqMCRzxt11p1WpFVObvEmF7QF3q/jrxLxUc6xSnoo7r1EJRkoqP1vn8unY6
         vk7x0SjUtsMWVgxEegLSD5VvE9ZVlBVlLaw00vXtHyoyazgzpbwSjZnTZon8+G4xf6
         PEj+0jm1xquSXV4uVu283TUDCNW8xthP5oi77M2zTAFJ0nojo4zIaZdV+Aohe0Ccoc
         B0+hu9YJDrmbWYKuxfW36xqYW2PJT6hj38YjIqGG2ECCbWARwgLOH6iGd/5PuGeSE5
         4+66hZc0dkWIA3FSB5tHK6qqWTSkWCHe0LLnqpGbnbHVMCRk3Zt/Tr2/9xnrurM6Gy
         wPcbXvVFr7e4A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anders Roxell <anders.roxell@linaro.org>, arnd@arndb.de
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] powerpc: platforms: cell: pervasive: fix clang
 -Wimplicit-fallthrough
In-Reply-To: <20211207110228.698956-1-anders.roxell@linaro.org>
References: <20211207110228.698956-1-anders.roxell@linaro.org>
Date:   Thu, 09 Dec 2021 17:40:24 +1100
Message-ID: <87zgpamgbr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Roxell <anders.roxell@linaro.org> writes:
> Clang warns:
>
> arch/powerpc/platforms/cell/pervasive.c:81:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>         case SRR1_WAKEEE:
>         ^
> arch/powerpc/platforms/cell/pervasive.c:81:2: note: insert 'break;' to avoid fall-through
>         case SRR1_WAKEEE:
>         ^
>         break;
> 1 error generated.
>
> Clang is more pedantic than GCC, which does not warn when failing
> through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst.
> Add athe missing break to silence the warning.
>
> Fixes: 6e83985b0f6e ("powerpc/cbe: Do not process external or decremeter interrupts from sreset")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/powerpc/platforms/cell/pervasive.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
> index 5b9a7e9f144b..dff8d5e7ab82 100644
> --- a/arch/powerpc/platforms/cell/pervasive.c
> +++ b/arch/powerpc/platforms/cell/pervasive.c
> @@ -78,6 +78,7 @@ static int cbe_system_reset_exception(struct pt_regs *regs)
>  	switch (regs->msr & SRR1_WAKEMASK) {
>  	case SRR1_WAKEDEC:
>  		set_dec(1);
> +		break;
>  	case SRR1_WAKEEE:
>  		/*
>  		 * Handle these when interrupts get re-enabled and we take

Thanks. I have definitely fixed this somewhere before, but I guess I
never sent it upstream, or it's still lying in a git stash of mine.

cheers
