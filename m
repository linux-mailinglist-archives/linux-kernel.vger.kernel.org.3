Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D3580720
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiGYWJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbiGYWJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:09:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B092D24977;
        Mon, 25 Jul 2022 15:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 457B9B8112D;
        Mon, 25 Jul 2022 22:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615FDC341C6;
        Mon, 25 Jul 2022 22:09:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YVrZ/YqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658786975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyKyjpasoObicq75lmnDatOuwvx4rzcl6yoY85+FyRc=;
        b=YVrZ/YqFrT2BG7qeXdN01Zphrq6dC28tPLPXeINV/az+mPRmnQyuUQJ/iq0VSxqzpTDCuS
        Q1xj8kgoLOQeU4vIEihTn+YyczhSacsFqyNJW/XDmmLgzfcZk1u1hZLsMmYfgGY+yQ9fPl
        21yJcatjO2WQ7boqt3m3LnTkihqZ1oI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 801f7a7e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Jul 2022 22:09:35 +0000 (UTC)
Date:   Tue, 26 Jul 2022 00:09:33 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH v3 2/3] crypto: lib - move __crypto_xor into utils
Message-ID: <Yt8UnWCvoe8dKihc@zx2c4.com>
References: <20220725183636.97326-1-ebiggers@kernel.org>
 <20220725183636.97326-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220725183636.97326-3-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:36:35AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> CRYPTO_LIB_CHACHA depends on CRYPTO for __crypto_xor, defined in
> crypto/algapi.c.  This is a layering violation because the dependencies
> should only go in the other direction (crypto/ => lib/crypto/).  Also
> the correct dependency would be CRYPTO_ALGAPI, not CRYPTO.  Fix this by
> moving __crypto_xor into the utils module in lib/crypto/.
> 
> Note that CRYPTO_LIB_CHACHA_GENERIC selected XOR_BLOCKS, which is
> unrelated and unnecessary.  It was perhaps thought that XOR_BLOCKS was
> needed for __crypto_xor, but that's not the case.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

With one small question:

> --- /dev/null
> +++ b/lib/crypto/utils.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Crypto library utility functions
> + *
> + * Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>

Didn't Ard basically write the crypto_xor function in its current form?
I seem to remember some pretty hardcore refactoring he did a while back.

Jason
