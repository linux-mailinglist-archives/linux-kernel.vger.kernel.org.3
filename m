Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC694AE541
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiBHXKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiBHXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:10:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4D9C061578;
        Tue,  8 Feb 2022 15:10:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F2DAB81CA2;
        Tue,  8 Feb 2022 23:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2211C004E1;
        Tue,  8 Feb 2022 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644361825;
        bh=eXZE4Fhy0NSmqy59jCoVylFL5+N7ZB6TJ6ioZ3AMh98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMrG0UH76hFrVZyqVuC1g0bc1wJdDTHn6qlqSFDATQOLuEOcubyQ9FcjEHFll4Llm
         t9xMsSDjcj6vM76PvcVWMSQcf+ksiX6Jo4iLkYocc/uq+zNs0G3l3ecbbP7QJI2nSY
         ofkUXo5c1pDQqyheIOHf7/yiVwDs9R8M+3YTIndmVuckm7q/1TPYTw4baQfpDsbOfQ
         4D0f3tVHkOxlkkc28z13LjR2DiE2hEfmdnlA9jZY1M+dUdjBCa09VqlO0TpKYH/vH5
         Si55l2YElK0+bwrBlj+oAWw+Nt7DRvDzI2w8NTs7pNT04cHJ9lKfE0ean7k4s8NYKI
         /PstGjj6WZfxQ==
Date:   Tue, 8 Feb 2022 15:10:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v1 4/7] random: ensure early RDSEED goes through mixer on
 init
Message-ID: <YgL4XzpTpvZ9Q0pb@sol.localdomain>
References: <20220208155335.378318-1-Jason@zx2c4.com>
 <20220208155335.378318-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208155335.378318-5-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:53:32PM +0100, Jason A. Donenfeld wrote:
> Continuing the reasoning of "random: use RDSEED instead of RDRAND in
> entropy extraction" from this series, at init time we also don't want to
> be xoring RDSEED directly into the crng. Instead it's safer to put it
> into our entropy collector and then re-extract it, so that it goes
> through a hash function with preimage resistance.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
