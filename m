Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18E154AEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbiFNKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiFNKpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:45:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234E46649
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:45:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMlT5550Dz4xYC;
        Tue, 14 Jun 2022 20:45:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1655203529;
        bh=RBj66p9m4fPiE+NiL5b1xNhjr+ADnO+uqrgDmOY6ZfU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KJBgz7Bti+zcSg0e6LuxnE3Y5fRvZA76Y4/AtP0VgEmK7oAUFmGkI6+3GGZPGNy9f
         YPxzzLCr5nBrazEUeqTH2NDUL2+blZa+/+pis7e4Ai9fFUnn663h3hTCMlqt0+JWka
         1Ti6vNKngXZVyDw+ZPoC+aXcs4UnmEuHXI5SvDcr+DgHINxJpi83CKXyLp8Ztvt+lW
         TgtIhkmNKOc3pSTdt8ah4pBRRV5caZb1ROCRuR1fbdCfY7EamMhY11TXyyFmG5FpJR
         fsuwA0f3mlWzMjBQjhgtwZMxaV6h8QfXv0st6Q6sK5+pap3mPTLIOvZlj3vWsofwX/
         h59qHks79R3fw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Wang Wenhu <wenhu.wang@hotmail.com>, gregkh@linuxfoundation.org,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Wang Wenhu <wenhu.wang@hotmail.com>
Subject: Re: [PATCH 1/2] powerpc:mm: export symbol ioremap_coherent
In-Reply-To: <SG2PR01MB2951EBFD4C4EB2A2519FF4199FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
References: <20220609102855.272270-1-wenhu.wang@hotmail.com>
 <SG2PR01MB2951EBFD4C4EB2A2519FF4199FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
Date:   Tue, 14 Jun 2022 20:45:25 +1000
Message-ID: <8735g7cym2.fsf@mpe.ellerman.id.au>
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

Wang Wenhu <wenhu.wang@hotmail.com> writes:
> The function ioremap_coherent may be called by modules such as
> fsl_85xx_cache_sram. So export it for access in other modules.

ioremap_coherent() is powerpc specific, and only has one other caller,
I'd like to remove it.

Does ioremap_cache() work for you?

cheers

> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 4f12504fb405..08a00dacef0b 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -40,6 +40,7 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
>  		return iowa_ioremap(addr, size, prot, caller);
>  	return __ioremap_caller(addr, size, prot, caller);
>  }
> +EXPORT_SYMBOL(ioremap_coherent);
>  
>  void __iomem *ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
>  {
> -- 
> 2.25.1
