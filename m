Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8F579200
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiGSEea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiGSEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:34:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698225292;
        Mon, 18 Jul 2022 21:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EDBDB8196E;
        Tue, 19 Jul 2022 04:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222A9C341C6;
        Tue, 19 Jul 2022 04:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658205265;
        bh=lyI4/mHHLRca4HDvmJ2/d/xQZLB7kG482WO+gt5PO1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgLXcmygLsMRXrtNyRLPbQm8DuxwAqm6z9Ox8diyOI0kztyTFcr2JQDFtTcuCGCjf
         5FZ4Tyjz9OrM622UWg/m8pSoIKYJrMXqdQy3TFD1nmfQOdtCxEuw6EIBg5aLSX18tF
         I/0OATgg1m9o/e+5QOba/WGlP9TLsBR3PFi94HYoXd4nPljEOHn35+rFYGlDw9/LfO
         Q+ae6AQ6izsn0H21QPd/hxnlkQDUSzOgyXmOZ9jLufsY+lpX8/UymNd5ucKuMnpdbw
         ZI1fDyCL35POMmwqCn6wClOwmoY7Y59e4Z8B+paF/B/ArcihI4pmBDlIUBGkbrRpHB
         QNGUtkWD6fz4A==
Date:   Mon, 18 Jul 2022 21:34:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] crypto: lib - move crypto_simd_disabled_for_test
 into utils
Message-ID: <YtY0T4qASnYOIjIW@sol.localdomain>
References: <20220716062920.210381-1-ebiggers@kernel.org>
 <20220716062920.210381-4-ebiggers@kernel.org>
 <YtMEFyH8WyPS/vJB@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtMEFyH8WyPS/vJB@zx2c4.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 08:32:55PM +0200, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Fri, Jul 15, 2022 at 11:29:20PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Move the definition of crypto_simd_disabled_for_test into
> > lib/crypto/utils.c so that it can be accessed by library code.
> > 
> > This is needed when code that is shared between a traditional crypto API
> > implementation and a library implementation is built-in, but
> > CRYPTO_ALGAPI=m.  The x86 blake2s previously was an example of this
> > (https://lore.kernel.org/linux-crypto/20220517033630.1182-1-gaochao49@huawei.com/T/#u).
> > Although that case was resolved by removing the blake2s shash support,
> > this problem could easily come back in the future, so let's address it.
> 
> I'm not sure I see the reason in general for a utility library rather
> than doing these piecemeal like the rest of lib functions. Why is crypto
> special here? But in particular to this patch: nothing is actually using
> crypto_simd_disabled_for_test in lib/crypto, right? So is this
> necessary?

Well, this is what Herbert wanted:
https://lore.kernel.org/r/YtEgzHuuMts0YBCz@gondor.apana.org.au.  It's
subjective, but for now I think I prefer this approach too, since the utility
functions are so small and are widely used.  A whole module is overkill for just
a few lines of code.

The commit message answers your second and third questions.

- Eric
