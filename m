Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18934BD472
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiBUD4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:56:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiBUD4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:56:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4EA51E66;
        Sun, 20 Feb 2022 19:56:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF84B6117F;
        Mon, 21 Feb 2022 03:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED799C340E9;
        Mon, 21 Feb 2022 03:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645415783;
        bh=69/a0arvmu8TKi1770aEyZ5ngS/fYz1wpW23AVdSecw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHHSmGH8kOAa4m6eN/UJ78oLYO5GeqBDDsbB/xESWWs5UeLq9FLKO+vkBF4Z+PBLj
         k3y02EOvU/Cg9ehVC9g/V0u0etlGRT2UkQhIvuB3rEOmS/eUXf24odU+djHJqA29Qw
         j8x8rWZMUma91Hw3LLlr8dWSintXniJnPChuui/AArfsxFfwpjKEAILaVvf3kNo7ZQ
         juXlhJmA5IXDXpU4FLfvR/l1MZ/f08ASYB3vXU6qoTArRojxMecF0P2iImX+/0KPs/
         i2k0Pwk3t/+IRsRFvsC22UqBMrSCcbCQkx0G1tz6aojw0zqQaKYo6OcSXqQxf1xWhA
         7vomD7kAVRR8Q==
Date:   Sun, 20 Feb 2022 19:56:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, linux@dominikbrodowski.net
Subject: Re: [PATCH v2 9/9] random: remove outdated INT_MAX >> 6 check in
 urandom_read()
Message-ID: <YhMNZQb6S+qV+NR6@sol.localdomain>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-10-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-10-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:19:19AM +0100, Jason A. Donenfeld wrote:
> In 79a8468747c5 ("random: check for increase of entropy_count because of
> signed conversion"), a number of checks were added around what values
> were passed to account(), because account() was doing fancy fixed point
> fractional arithmetic, and a user had some ability to pass large values
> directly into it. One of things in that commit was limiting those values
> to INT_MAX >> 6.
> 
> However, for several years now, urandom reads no longer touch entropy
> accounting, and so this check serves no purpose. The current flow is:
> 
> urandom_read_nowarn()-->get_random_bytes_user()-->chacha20_block()
> 
> We arrive at urandom_read_nowarn() in the first place either via
> ordinary fops, which limits reads to MAX_RW_COUNT, or via getrandom()
> which limits reads to INT_MAX.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
