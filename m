Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A1534C03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbiEZIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiEZIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB2266200;
        Thu, 26 May 2022 01:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 644E761AC2;
        Thu, 26 May 2022 08:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673B0C385A9;
        Thu, 26 May 2022 08:52:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JQopiloD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653555162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qnQE96J89gWW6Xt2bjqeE1yXmlwBq8cweI2v4GF1/zg=;
        b=JQopiloDSyeWAiJpxX7kNT2Ze82JEV8yaiSpugrkJWPiH+iVae6sn52dk+yoJsXAC8Z72d
        kpJbf2d3cEkXoPVlPFE+WE0NMSH4VU1/RoR64HAoMgqUsXRmBYJ+ma23RXwCnKD532RErI
        ffXvE/WwirovMbGwYv9B7f9Vrne51p8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7df06c13 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 26 May 2022 08:52:41 +0000 (UTC)
Date:   Thu, 26 May 2022 10:52:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>, gaochao <gaochao49@huawei.com>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: Fix build error when CRYPTO_BLAKE2S_X86=m
 && CRYPTO_ALGAPI2=m && CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
Message-ID: <Yo8/ygju0v7D7A1I@zx2c4.com>
References: <20220517033630.1182-1-gaochao49@huawei.com>
 <Yo8rUkE1/hxum6gt@sol.localdomain>
 <Yo85u63lYHQJCIh6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo85u63lYHQJCIh6@gondor.apana.org.au>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 04:26:35PM +0800, Herbert Xu wrote:
> On Thu, May 26, 2022 at 12:25:06AM -0700, Eric Biggers wrote:
> >
> > How about just making CRYPTO_MANAGER_EXTRA_TESTS depend on CRYPTO_ALGAPI=y?
> 
> That breaks my setups with ALGAPI=m.
> 
> > Or alternatively, move the crypto_simd_disabled_for_test variable into a file in
> > lib/crypto/.  But the other suggestion would be a bit simpler for now.
> 
> Yes please do that instead.  If we ever get some arch-independent
> file for SIMD then we could move it over there.

Actually, we were talking about getting rid of the blake2s shash before
anyway, because it has no purpose. I'll make that change and send a
series, which will fix the issue a different way.

Jason
