Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349AE4BD3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbiBUCij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:38:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiBUCii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:38:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A683E1EED3;
        Sun, 20 Feb 2022 18:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47B0461124;
        Mon, 21 Feb 2022 02:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8081BC340E8;
        Mon, 21 Feb 2022 02:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645411095;
        bh=dR9SzToMmoFqkyh1Vj1H8HzO4u+iPA3s8xWivFtFm3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJodiHhaUOQMMaZWp/ydZMJjun0OLrJEdbTYmfSW7Eso3aerQdP0x8gV5JgJfEXkb
         5HdccqbBXa0zbVfshLUwE+oxauzEFLqPyi7LFld9rf3Mm43TtQlHGTXqsG3PJ35teT
         UEZq+9XC+2/2q2bjILMT9ftoNtXKpYffD+mUhXQxK6T++c22eMFbba27B55U5nNt79
         uGxA5TiknqeHX7ar5/93cYJcXkW2fEs5soxKjT0//ydecr6uZFoAuzBsTdnp93JCN4
         /8rkfJbyf9zNEdBxNTay06+kkCsb8vGzoITUXy4aNJ+HiRpR0SeMume5ZVwVmhPRrR
         9rsm/L+ivbxYQ==
Date:   Sun, 20 Feb 2022 18:38:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, linux@dominikbrodowski.net
Subject: Re: [PATCH v2 2/9] random: get rid of secondary crngs
Message-ID: <YhL7FoLE6w3eMjoy@sol.localdomain>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:19:12AM +0100, Jason A. Donenfeld wrote:
> As the comment said, this is indeed a "hack". Since it was introduced,
> it's been a constant state machine nightmare, with lots of subtle early
> boot issues and a wildly complex set of machinery to keep everything in
> sync. Rather than continuing to play whack-a-mole with this approach,
> this commit simply removes it entirely. This commit is preparation for
> "random: use simpler fast key erasure flow on per-cpu keys" in this
> series, which introduces a simpler (and faster) mechanism to accomplish
> the same thing.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 225 ++++++++++--------------------------------
>  1 file changed, 53 insertions(+), 172 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
