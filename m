Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9668F5585DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiFWSFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiFWSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A7B85A6;
        Thu, 23 Jun 2022 10:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A17D61E48;
        Thu, 23 Jun 2022 17:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AC4C3411B;
        Thu, 23 Jun 2022 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656004641;
        bh=ECl0+thSGaC6aSTo4aDyPUB/qSChvQhdGO/voCXF0rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDCUMclpM1j1gNt6R5tv7+I6GS+Uen+mRM4eVYaL3jd1t98CZBGVgF5FUBEC+7UgL
         rc0ScSbWK5cIvvH+s9C4CwFPCteIXHLfYtz0CIQEe4WOarBKQ9qpGqTb2RHRhVhIeq
         oII0mlUrL8XXsxxRIPaEfrLk60a+jXmymeJQ07RKTlG/n8HzFlvNhagWNKBDny4Yen
         U4Bdd+j7QdoUNQRcTMxSnusu0QAGAtVuDPR7wYybD2WrTwBMXz2JpkDn33fFjBhnO8
         rEP8UgQkNPDebXQJfkG7yzfmdOKNsxnlsF2mFvAbg3YfTpzKOrLTUlmJxEqjGESkS1
         8Ox+pt32FSUow==
Date:   Thu, 23 Jun 2022 10:17:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/crypto: Select AEAD2 for GHASH_ARM64_CE
Message-ID: <YrSgH//ysOd/Qumo@sol.localdomain>
References: <20220622142557.144536-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622142557.144536-1-quic_qiancai@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:25:57AM -0400, Qian Cai wrote:
> Otherwise, we could fail to compile.
> 
> ld: arch/arm64/crypto/ghash-ce-glue.o: in function 'ghash_ce_mod_exit':
> ghash-ce-glue.c:(.exit.text+0x24): undefined reference to 'crypto_unregister_aead'
> ld: arch/arm64/crypto/ghash-ce-glue.o: in function 'ghash_ce_mod_init':
> ghash-ce-glue.c:(.init.text+0x34): undefined reference to 'crypto_register_aead'
> 
> Fixes: 37b6aab68fae ("crypto: arm64/ghash - drop PMULL based shash")

I don't see how the Fixes commit is related.  Hasn't this been a problem since
commit 537c1445ab0b, which added an AEAD algorithm to this module?

> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index 4391a463abd7..6b2ecc193bc0 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -71,6 +71,7 @@ config CRYPTO_GHASH_ARM64_CE
>  	select CRYPTO_HASH
>  	select CRYPTO_GF128MUL
>  	select CRYPTO_LIB_AES
> +	select CRYPTO_AEAD2

I don't think CRYPTO_AEAD2 is meant to be selected directly.  It should be
CRYPTO_AEAD instead.

- Eric
