Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C21535311
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiEZSBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiEZSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:01:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750582AC68;
        Thu, 26 May 2022 11:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 320D4B8210C;
        Thu, 26 May 2022 18:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF361C385A9;
        Thu, 26 May 2022 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653588095;
        bh=d5ypGyznvLK36nBsMgVlsQ0dlUUAR350qlCPdJGQD5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyh0X/e8V+zwQVgpwPJOgEryDaxWCAtc6B2VF6H/69jF9cNYE70zkBfcAtw9911BY
         FCBYOx+J2x5HZmbuJOqGtQiV3ggfvrYSARie5umdupxqEVAIiZs1WKzBNgEUo4WDj/
         FQ/p7p1wm74QbnItpoRQqaiARE+3Ytde7wW6AaowubTC9rkxYVHXdoqX17Bj59pOtb
         WZeQA+yFQDyICnLqVbbn0S+QIJFsPr/Jp8LpU7tEA/eqdZJGiTri9kixoftrjtKcIA
         wCiGMWqNB31YfnSy/5QXiYN49TfazTTYccdGFDh3eByv2cD+RnHqA/pFy6lfnTinPK
         6Krq+DN13KUCw==
Date:   Thu, 26 May 2022 11:01:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, gaochao <gaochao49@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH crypto] crypto: blake2s - remove shash module
Message-ID: <Yo/Afs61tFwnaOV8@sol.localdomain>
References: <20220526092026.207936-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526092026.207936-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 11:20:26AM +0200, Jason A. Donenfeld wrote:
> BLAKE2s has no use as an shash and no use is likely to ever come up.

I'm not sure about that.  Anyone who is already using shash (for supporting
multiple algorithms) and wants to add blake2s support would need it.  dm-verity,
dm-integrity, fs-verity, UBIFS authentication, IMA, btrfs checksums, etc.  A
couple of these are already using blake2b, even.  I guess you might as well
remove blake2s until someone explicitly says they want it, but I can easily see
it coming back later.

> Just remove all of this unnecessary plumbing. Removing this shash was
> something we talked about back when we were making BLAKE2s a built-in,
> but I simply never got around to doing it. So this completes that
> project.
> 
> This also helps fix a bug in which the lib code depends on
> crypto_simd_disabled_for_test, which is now unnecessary.
> 
> Cc: gaochao <gaochao49@huawei.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

More importantly, this is removing quite a bit of test coverage because the
extra self-tests in crypto/testmgr.c are more comprehensive than what
lib/crypto/blake2s-selftest.c does.  For example they test the case where the
input data is misaligned, as well as the case where the code is executed in a
context where SIMD instructions are unavailable.

In order for this to be acceptable, I think you'd need to update
blake2s-selftest.c to be more comprehensive.

- Eric
