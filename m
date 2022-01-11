Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6837248A616
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiAKDLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiAKDLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:11:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4395C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:11:16 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c3so15082633pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=zbUZ8MBTmVmuuh6nLO3oUSWnxXuwL880OdPfuGWzHYk=;
        b=cxfkFqPRjJsidUYoFqrkjQu+rytMjDJUVHRqWFdLhQu7zfbmc+PGsEdtTH6lq0LnJU
         f5llsTXt4jzLni4sIqAcUlN9VkfhJNiySYlWNNC80IBjoftWpG/WhY9heJDB24FqGmaG
         FAS3RDxvyPRGi8juK2nJRGYUBftDRSHQ+GD618Yb/syIM7tg4DpnVWnGwkVuVZpKHeMW
         kI7YgZVMdm3PbPuDtBH8+XvwzliKRslPcLotmZ3h2WyhJkvo/hZsHmLfpRfMPh1gQuLE
         p+xbSvu4WniS0b8Q0UD2Rao/OuI6yO+l3p3GlSi1Xvgm2a356mk5UVFvDeoRQJeHQm6J
         LT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=zbUZ8MBTmVmuuh6nLO3oUSWnxXuwL880OdPfuGWzHYk=;
        b=iYauQMkQS2nZ6Eyqdnq/PGmg2ncToPCtjHdL8evTrkfmSoqITxDi52AhFmrNQsUFVF
         FtnP7XusZFBbkZhUr7xgDkryqmaPGNMTFdBd0I3F6dfy3XEZ1/CmRHJy0CI3zpXoJDPT
         6ILvrKeBWnwndjllkEUyitkgZnGc13gZrPtTLpibu42wIs35nAlQaGsuJcJ2Zy0OXP74
         WmtaVtoUFA4EZNN1zCimqhguSpnL0YyyKG4FBpqFlmo2T0qsvOp2zOQrS8sl5xrc78ZV
         587CKlZnEno/Xb19JZpqTdwjXRZYz6bHQ5SpEAH6jkJdW347grXVWgu836XqkdfDECBP
         +08A==
X-Gm-Message-State: AOAM530B8VZJcWHJxQ4guHfAGLFwFCSQLFv7S69Pxq7mYnvSfnZxpJWv
        tmFEqi+bIR0T0WmgI6BJ27c=
X-Google-Smtp-Source: ABdhPJwvS1ggfWVk1+YTM2VQ1yaJh/hW9pOxZQQtZVk1N6qWAZQMXv//b71/0S/AB/keLx9+1yye6Q==
X-Received: by 2002:a63:7a52:: with SMTP id j18mr2377642pgn.319.1641870676336;
        Mon, 10 Jan 2022 19:11:16 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id g5sm8697284pfj.143.2022.01.10.19.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:11:16 -0800 (PST)
Date:   Tue, 11 Jan 2022 13:11:11 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/time: Fix build failure due to
 do_hard_irq_enable() on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <247e01e0e10f4dbc59b5ff89e81702eb1ee7641e.1641828571.git.christophe.leroy@csgroup.eu>
In-Reply-To: <247e01e0e10f4dbc59b5ff89e81702eb1ee7641e.1641828571.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1641870650.jvmi84hc0s.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of January 11, 2022 1:29 am:
> 	  CC      arch/powerpc/kernel/time.o
> 	In file included from <command-line>:
> 	./arch/powerpc/include/asm/hw_irq.h: In function 'do_hard_irq_enable':
> 	././include/linux/compiler_types.h:335:45: error: call to '__compiletime=
_assert_35' declared with attribute error: BUILD_BUG failed
> 	  335 |         _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
> 	      |                                             ^
> 	././include/linux/compiler_types.h:316:25: note: in definition of macro =
'__compiletime_assert'
> 	  316 |                         prefix ## suffix();                     =
        \
> 	      |                         ^~~~~~
> 	././include/linux/compiler_types.h:335:9: note: in expansion of macro '_=
compiletime_assert'
> 	  335 |         _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
> 	      |         ^~~~~~~~~~~~~~~~~~~
> 	./include/linux/build_bug.h:39:37: note: in expansion of macro 'compilet=
ime_assert'
> 	   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), =
msg)
> 	      |                                     ^~~~~~~~~~~~~~~~~~
> 	./include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BU=
G_ON_MSG'
> 	   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> 	      |                     ^~~~~~~~~~~~~~~~
> 	./arch/powerpc/include/asm/hw_irq.h:483:9: note: in expansion of macro '=
BUILD_BUG'
> 	  483 |         BUILD_BUG();
> 	      |         ^~~~~~~~~
>=20
> should_hard_irq_enable() returns false on PPC32 so this BUILD_BUG() shoul=
dn't trigger.
>=20
> Force inlining of should_hard_irq_enable()
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Fixes: 0faf20a1ad16 ("powerpc/64s/interrupt: Don't enable MSR[EE] in irq =
handlers unless perf is in use")
> Cc: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> ---
>  arch/powerpc/include/asm/hw_irq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index a58fb4aa6c81..674e5aaafcbd 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -473,7 +473,7 @@ static inline bool arch_irq_disabled_regs(struct pt_r=
egs *regs)
>  	return !(regs->msr & MSR_EE);
>  }
> =20
> -static inline bool should_hard_irq_enable(void)
> +static __always_inline bool should_hard_irq_enable(void)
>  {
>  	return false;
>  }
> --=20
> 2.33.1
>=20
