Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF7F5808D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiGZAv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGZAvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F424976;
        Mon, 25 Jul 2022 17:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2C061349;
        Tue, 26 Jul 2022 00:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5E7C341C6;
        Tue, 26 Jul 2022 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658796682;
        bh=NLFzRaZSFroN3x3eXTNUEZ8NB31bA3KC4PRbcNi93mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rD99RVPaAFYi2cHLkD6Ukf2YBXaHmJ7zF0lpfdoQd/6YMHgqIN3vP7YRn3KNFfIRs
         JaKyTLLIKlEHPZfIUIhJqa0kcKDxKwDIvgjxImfplNC3iQnfL/EnqkbdX1KT2a4vSt
         DF8Sh1qpvatH5KHOxrnSpeEaJOm0WOpHr98ttHeRSPumTfd/vpJli7SgP+2Br3EAMQ
         5DNWzGGJAyomzQF+CpNG+cMUu/dWq4HzEcJvRmAcM2mxLijooFSuUqlcNyC8wAEBqb
         dJTOVMFMoXgqc9nq0zUD/d3MkoCl5wtTLKmgMAnDSZXiNOPY19i2KTvC30g0QQrbTc
         B6aTxKz3uDobQ==
Date:   Mon, 25 Jul 2022 17:51:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] crypto: lib - remove __HAVE_ARCH_CRYPTO_MEMNEQ
Message-ID: <Yt86iHqr8W96wL+8@sol.localdomain>
References: <20220725183636.97326-1-ebiggers@kernel.org>
 <20220725183636.97326-4-ebiggers@kernel.org>
 <Yt8UCsYkH3O6RnFd@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt8UCsYkH3O6RnFd@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:07:06AM +0200, Jason A. Donenfeld wrote:
> On Mon, Jul 25, 2022 at 11:36:36AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > No architecture actually defines this, so it's unneeded.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>  
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Aside: out of curiosity, I wonder what was originally intended with
> this, which magic arch-specific instructions were thought to be
> potentially of aid.

The original commit (6bf37e5aa90f) says:

	Similarly to kernel library string functions, leave an option for future
	even further optimized architecture specific assembler implementations.

But so far no one has bothered.  It's already optimized to use 'long' accesses,
so I wouldn't expect it to get much faster with assembly.

- Eric
