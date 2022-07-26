Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB475808DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiGZBAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZBAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C217A92;
        Mon, 25 Jul 2022 18:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01D95B810A4;
        Tue, 26 Jul 2022 01:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEFCC341C6;
        Tue, 26 Jul 2022 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658797215;
        bh=2xklpD9zOkDaPX/6lcoq8t9QAqRhI7D956EnkKkQcPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlT//DjOSIFZ94KFBmwxgN/i0oxKfabFQlFwF5CINBZ1C03OWg+ecfUA2FEjHfhPc
         8ovGhrAq+bq2WU153Ku/jUKaqBDmrRjzsh1H2KsAgL9++JbXDLIuGmn9/RcZLts51q
         3xQJKDiB1D3yafgHLJeQ+OR5DqE39ujJ8t/RlKk3Ovw2VY02oQnEjK480TpHOtBi2n
         N4nEECKZN2YHSrInrClTa5HUiC5UnbNgLBUSa61mSee/b2DLB151/jxXMSCndxCIby
         F1PRUbH1kpIgaGPNXUc5VaF3zyqUEj1YfGtUGPhHeuoPpKEudDb9VNdqEpRDuphWmf
         x6PwiVroSD/cQ==
Date:   Mon, 25 Jul 2022 18:00:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH v3 2/3] crypto: lib - move __crypto_xor into utils
Message-ID: <Yt88nXvui0Q+5MQu@sol.localdomain>
References: <20220725183636.97326-1-ebiggers@kernel.org>
 <20220725183636.97326-3-ebiggers@kernel.org>
 <Yt8UnWCvoe8dKihc@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt8UnWCvoe8dKihc@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:09:33AM +0200, Jason A. Donenfeld wrote:
> On Mon, Jul 25, 2022 at 11:36:35AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > CRYPTO_LIB_CHACHA depends on CRYPTO for __crypto_xor, defined in
> > crypto/algapi.c.  This is a layering violation because the dependencies
> > should only go in the other direction (crypto/ => lib/crypto/).  Also
> > the correct dependency would be CRYPTO_ALGAPI, not CRYPTO.  Fix this by
> > moving __crypto_xor into the utils module in lib/crypto/.
> > 
> > Note that CRYPTO_LIB_CHACHA_GENERIC selected XOR_BLOCKS, which is
> > unrelated and unnecessary.  It was perhaps thought that XOR_BLOCKS was
> > needed for __crypto_xor, but that's not the case.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> With one small question:
> 
> > --- /dev/null
> > +++ b/lib/crypto/utils.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Crypto library utility functions
> > + *
> > + * Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
> 
> Didn't Ard basically write the crypto_xor function in its current form?
> I seem to remember some pretty hardcore refactoring he did a while back.
> 
> Jason

I think that's fair to say, based on git blame.  I just copied the copyright
statement from the top of crypto/algapi.c.

- Eric
