Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301B9580722
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiGYWLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiGYWK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:10:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B20FBE28;
        Mon, 25 Jul 2022 15:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8F08CE13E0;
        Mon, 25 Jul 2022 22:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC66FC341C6;
        Mon, 25 Jul 2022 22:10:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fmRZRPpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658787053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ck4Do4hW4KRXeZrl83P4IhLy7IseiDgWXPhc2XxmnOs=;
        b=fmRZRPpm+TPXNsKfKJk/d+1ttkal9Vjxu1ov5NQfRP+mObp68iR+a3E/VUn9HL1SfMHIWE
        411wL7S3EsepRsirTEVngc5PHHYTK1eAG1EjsDAsvJaSrKLFWPxPib4K2g61xR7h1RT0D4
        7vItzfEYcn5SxAPobreVicBKpNKqPgA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ecf57058 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Jul 2022 22:10:53 +0000 (UTC)
Date:   Tue, 26 Jul 2022 00:10:51 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] crypto: lib - create utils module and move
 __crypto_memneq into it
Message-ID: <Yt8U60p0istFehfU@zx2c4.com>
References: <20220725183636.97326-1-ebiggers@kernel.org>
 <20220725183636.97326-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220725183636.97326-2-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:36:34AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As requested at
> https://lore.kernel.org/r/YtEgzHuuMts0YBCz@gondor.apana.org.au, move
> __crypto_memneq into lib/crypto/ and put it under a new tristate.  The
> tristate is CRYPTO_LIB_UTILS, and it builds a module libcryptoutils.  As
> more crypto library utilities are being added, this creates a single
> place for them to go without cluttering up the main lib directory.
> 
> The module's main file will be lib/crypto/utils.c.  However, leave
> memneq.c as its own file because of its nonstandard license.

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
