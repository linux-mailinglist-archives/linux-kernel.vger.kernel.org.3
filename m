Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5248570688
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiGKPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGKPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C340D5D582;
        Mon, 11 Jul 2022 08:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F6CD6159C;
        Mon, 11 Jul 2022 15:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542C2C34115;
        Mon, 11 Jul 2022 15:02:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M5QahTht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657551734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yEJrOrmLun4FqXV/vXKX3u/LT3WQApq9kkZ/uQvyyrs=;
        b=M5QahThtjnVZ7zpGpsc/+U9NToQMuGLMgzk8IIhCrwfrLJq1770lkCFLsYeuiK3Ofbl+fK
        ONQgwDvkxIe3lqVijbWtQvDElxSjcTA/WceXSuZ2Cr8gUzsqRkPPjRiywv2dOIDcKljeSX
        EHSEEg7Gg2ljUpzr/yZYgFLpO172Ox0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 62d5336a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 11 Jul 2022 15:02:14 +0000 (UTC)
Date:   Mon, 11 Jul 2022 17:02:09 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: xor - move __crypto_xor into lib/
Message-ID: <Ysw7cewDUYp1mgEU@zx2c4.com>
References: <20220709215453.262237-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220709215453.262237-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sat, Jul 09, 2022 at 02:54:53PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> CRYPTO_LIB_CHACHA depends on CRYPTO for __crypto_xor, defined in
> crypto/algapi.c.  This is a layering violation because the dependencies
> should only go in the other direction (crypto/ => lib/crypto/).  Also
> the correct dependency would be CRYPTO_ALGAPI, not CRYPTO.  Fix this by
> moving __crypto_xor into lib/xor.c, alongside lib/memneq.c where
> __crypto_memneq was recently moved.
> 
> Note that CRYPTO_LIB_CHACHA_GENERIC selected XOR_BLOCKS, which is
> unrelated and unnecessary.  It was perhaps thought that XOR_BLOCKS was
> needed for __crypto_xor, but that's not the case.

Oh thank goodness. Excellent! Indeed untangling this knot will be a
large improvement.

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Jason
