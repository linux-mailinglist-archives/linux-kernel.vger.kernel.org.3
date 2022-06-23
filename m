Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238DA5588FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiFWTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiFWTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391F3EF20;
        Thu, 23 Jun 2022 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656011318; x=1687547318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J+82fiAkS6UDD5/pp26a92/IR26KYgUmTE+aTlC+9Go=;
  b=Iup2ACskJcE+IaasI8xLwa4Gxo4k23sb9E0QxGpw1ngbL3LeQpcym9lj
   pr66obmeZp4w0lJpw04M1AfK9eCuca6t2k7aUoMOr88H3IcpPDLwdrNbB
   iN//RTxfnJLkgNOvMZfoq/1nPxRwEHMD+kO0jJxkZX5ZLZdFaCxKs7rMA
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 Jun 2022 12:08:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 12:08:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 23 Jun 2022 12:08:35 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 23 Jun
 2022 12:08:34 -0700
Date:   Thu, 23 Jun 2022 15:08:32 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/crypto: Select AEAD2 for GHASH_ARM64_CE
Message-ID: <YrS6MIhv/ze4rbxy@qian>
References: <20220622142557.144536-1-quic_qiancai@quicinc.com>
 <YrSgH//ysOd/Qumo@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrSgH//ysOd/Qumo@sol.localdomain>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:17:19AM -0700, Eric Biggers wrote:
> On Wed, Jun 22, 2022 at 10:25:57AM -0400, Qian Cai wrote:
> > Otherwise, we could fail to compile.
> > 
> > ld: arch/arm64/crypto/ghash-ce-glue.o: in function 'ghash_ce_mod_exit':
> > ghash-ce-glue.c:(.exit.text+0x24): undefined reference to 'crypto_unregister_aead'
> > ld: arch/arm64/crypto/ghash-ce-glue.o: in function 'ghash_ce_mod_init':
> > ghash-ce-glue.c:(.init.text+0x34): undefined reference to 'crypto_register_aead'
> > 
> > Fixes: 37b6aab68fae ("crypto: arm64/ghash - drop PMULL based shash")
> 
> I don't see how the Fixes commit is related.  Hasn't this been a problem since
> commit 537c1445ab0b, which added an AEAD algorithm to this module?

Ah, you are probably right. crypto_unregister_aead and crypto_register_aead
are already there in the previous commit.

> 
> > diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> > index 4391a463abd7..6b2ecc193bc0 100644
> > --- a/arch/arm64/crypto/Kconfig
> > +++ b/arch/arm64/crypto/Kconfig
> > @@ -71,6 +71,7 @@ config CRYPTO_GHASH_ARM64_CE
> >  	select CRYPTO_HASH
> >  	select CRYPTO_GF128MUL
> >  	select CRYPTO_LIB_AES
> > +	select CRYPTO_AEAD2
> 
> I don't think CRYPTO_AEAD2 is meant to be selected directly.  It should be
> CRYPTO_AEAD instead.

I am not sure about that. I chose CRYPTO_AEAD2 because that is in the
Makefile.

obj-$(CONFIG_CRYPTO_AEAD2) += aead.o
