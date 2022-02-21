Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E64BD45F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiBUDkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:40:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBUDkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:40:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF151331;
        Sun, 20 Feb 2022 19:40:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC65AB80DCD;
        Mon, 21 Feb 2022 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F633C340E9;
        Mon, 21 Feb 2022 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645414819;
        bh=mOvCX6u+abSiUuhsoaVypqdnne4NQ17bIT2BYtNcIcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmEib9tLjEKL1jLwoEJX0pIWeCdntkr7n9x3segpilyuR8R/PidvhHEopoAC0ghvO
         pbnde5MzWkegGtyw17cYdyBfrWQ6QHiFtRiTlOyRwAPfGQMETVk+vzVJKhVMw3xWQ4
         k4d//5nHt/wJaY/BAAcZYrUs6lYgG5NDLaZXBEvZZTUCGtEi+8KiCG3LmOE7aOX96s
         FNoEDmtK5zhVNdZPVSusj6bUX4CDTpEzWYjNap9z6axsdRBjwG4jtzuQQopNs/lEfR
         0ZLQc2RqG4E+SdtJkD7lSbcT/AdZjefrsEvaA3x1X9YHfEvvTC30PzQOHMAizhyiOr
         A0J3fEGYufKrw==
Date:   Sun, 20 Feb 2022 19:40:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, linux@dominikbrodowski.net
Subject: Re: [PATCH v2 8/9] random: use hash function for crng_slow_load()
Message-ID: <YhMJoYykeNTVpz7w@sol.localdomain>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-9-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-9-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:19:18AM +0100, Jason A. Donenfeld wrote:
> Since we have a hash function that's really fast, and the goal of
> crng_slow_load() is reportedly to "touch all of the crng's state", we
> can just hash the old state together with the new state and call it a
> day. This way we dont need to reason about another LFSR or worry about
> various attacks there. This code is only ever used at early boot and
> then never again.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 42 +++++++++++++++---------------------------
>  1 file changed, 15 insertions(+), 27 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
