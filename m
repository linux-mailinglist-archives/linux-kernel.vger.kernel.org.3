Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2692F4FF60C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiDMLve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiDMLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A765AEE3;
        Wed, 13 Apr 2022 04:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E62B661DED;
        Wed, 13 Apr 2022 11:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68962C385A3;
        Wed, 13 Apr 2022 11:49:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bfKghglO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649850548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8Ex0PxSMkX6hLvtleAT2Su1yp40GVqczv/isAdXg5A=;
        b=bfKghglOXKd8bI5FupKt8r0GvzCdggBiAJl20u1AmZ0Jt8yh1RsaEkpS49+Zt06rAVWxf3
        NO2bU7iJMYLIgAmKhUZ1Xhama/JBzEZ/0Oy3M8eXJyB2zjVjGq9BqX7F863Ew6VVm8wuVV
        FKvh6oX4HU6XEoKjS4laHtOOgeR7JEU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 69785bfc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Apr 2022 11:49:08 +0000 (UTC)
Date:   Wed, 13 Apr 2022 13:48:53 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Will Deacon <will@kernel.org>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: arm64/sm4 - Fix wrong dependency of NEON/CE
 implementation
Message-ID: <Yla4pSKW+6I5jIfS@zx2c4.com>
References: <20220411031313.35449-1-tianjia.zhang@linux.alibaba.com>
 <20220413102209.GB1229@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220413102209.GB1229@willie-the-truck>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Apr 13, 2022 at 11:22:09AM +0100, Will Deacon wrote:
> On Mon, Apr 11, 2022 at 11:13:13AM +0800, Tianjia Zhang wrote:
> > Commit d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory")
> > moved the sm4 library implementation from the lib/crypto directory to
> > the crypto directory and configured the name as CRYPTO_SM4. The arm64
> > SM4 NEON/CE implementation depends on this and needs to be modified
> > uniformly.
> 
> d2825fa9365d doesn't appear in my tree -- is this something in linux-next?

This is in Herbert's tree for next:
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=d2825fa9365d

Jason
