Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C2C4BEAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiBUTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:19:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiBUTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:18:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E85F88
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:18:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F068060AF7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413F3C340E9;
        Mon, 21 Feb 2022 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645471111;
        bh=2sDLYB0X8O/RTfzV5/sDXBGNxYZJDE61JCEhUArJiU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nx8X/euteCxCCeMwjIElZzmoNJQIX1DjPQm3Lhanf4Uto8RWz+h/q0fLf5jKjffZM
         x08km/e1fPMtdCFEhj24y7ykMjiKEponIkTjum4niqzGnPuZKsE2ApBpMjRY+3/f6u
         U7lMruJBAlT8IHg2h2gZfOUcOEXZ2qTwwb6nrWAJqhzHuz53TP93EKwAdWH2JlzUTw
         ZSZLi/y5CcbyJRyrn4ov7p1SS4mZF/2Rw3GvSF+suqH4tE9WqPL7FVSSsbL66M5Jod
         UWqitvSMo8ENVCOOmhJNujpDQdmBJpMUyzfo49bnieXXQ3vtk96wZefYqnyG2gj/oD
         055soTkyXKQwA==
Date:   Mon, 21 Feb 2022 11:18:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: unify early init crng load accounting
Message-ID: <YhPlhWAPokRMpSyt@sol.localdomain>
References: <20220221152456.2289150-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221152456.2289150-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:24:56PM +0100, Jason A. Donenfeld wrote:
> crng_fast_load() and crng_slow_load() have different semantics:
> 
> - crng_fast_load() xors and accounts with crng_init_cnt.
> - crng_slow_load() hashes and doesn't account.
> 
> However add_hwgenerator_randomness() can afford to hash (it's called
> from a kthread), and it should account. Additionally, ones that can
> afford to hash don't need to take a trylock but can take a normal lock.
> So, we combine these into one function, crng_pre_init_inject(), which
> allows us to control these in a uniform way. This will make it simpler
> later to simplify this all down when the time comes for that.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v1->v2:
> - cp -> input,
> - fix comment reference to old function,
> - fix brace style.
> 
>  drivers/char/random.c | 112 ++++++++++++++++++++++--------------------
>  1 file changed, 58 insertions(+), 54 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
